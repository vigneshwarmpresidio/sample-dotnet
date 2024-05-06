#!/bin/bash

# Usage: ./deploy_ecs.sh <CLUSTER_NAME> <SERVICE_NAME> <NEW_IMAGE_NAME>

set -oe pipefail

# Variables
CLUSTER_NAME=$1
SERVICE_NAME=$2
NEW_IMAGE_NAME=$3

# Check if the service exists
service_exists=$(aws ecs describe-services --cluster $CLUSTER_NAME --services $SERVICE_NAME --query "services[?serviceName=='$SERVICE_NAME']")

if [ "$service_exists" == "[]" ]; then
  echo "Service '$SERVICE_NAME' does not exist in cluster '$CLUSTER_NAME'."
  exit 1
fi

# Get the current task definition ARN
original_task_def_arn=$(aws ecs describe-services --cluster $CLUSTER_NAME --services $SERVICE_NAME --query "services[0].taskDefinition" --output text)

# Get the actual task definition JSON
original_task_def=$(aws ecs describe-task-definition --task-definition $original_task_def_arn --query "taskDefinition" --output json)

# Create new definition with updated image name
new_task_def=$(echo $original_task_def | jq --arg IMAGE "$NEW_IMAGE_NAME" '.containerDefinitions[0].image=$IMAGE | del(.taskDefinitionArn) | del(.revision)')

# Delete unwanted parameters from the task definition
new_task_def=$(echo $new_task_def | jq 'del(.taskDefinitionArn) | del(.revision) | del(.status) | del(.requiresAttributes) | del(.compatibilities) | del(.registeredAt) | del(.registeredBy)')

# Create new task definition and save its ARN
new_task_def_arn=$(aws ecs register-task-definition --cli-input-json "$new_task_def" --query "taskDefinition.taskDefinitionArn" --output text)

# Update the service to use the new task definition
updated_service=$(aws ecs update-service --cluster $CLUSTER_NAME --service $SERVICE_NAME --task-definition $new_task_def_arn)
updated_service_arn=$(echo $updated_service | jq -r '.service.serviceArn')

echo "'$SERVICE_NAME' has been updated:"
echo "    New image: '$NEW_IMAGE_NAME'"
echo "    New task definition: '$new_task_def_arn'"
echo "    Updated service: '$updated_service_arn'"

# Need to allow errors here since we need to handle the case where the service fails to stabilize
set +e

# Wait for the service to stabilize
echo "Waiting for service to stabilize..."
aws ecs wait services-stable --cluster $CLUSTER_NAME --services $SERVICE_NAME

# Check if the service is stable
service_stable=$(aws ecs describe-services --cluster $CLUSTER_NAME --services $SERVICE_NAME --query "services[0].deployments[?status=='PRIMARY'].taskDefinition" --output text)

if [ "$service_stable" != "$new_task_def_arn" ]; then
  echo "Service failed to stabilize! Rolling back to previous task definition..."

  # If the service is not stable, revert to the old task definition
  rolledback_service=$(aws ecs update-service --cluster $CLUSTER_NAME --service $SERVICE_NAME --task-definition $original_task_def_arn)
  rolledback_service_arn=$(echo $rolledback_service | jq -r '.service.serviceArn')
  echo "Could not stabilize with new image. Rolled back service to: '$rolledback_service_arn'"
  exit 1
fi

echo "Service updated successfully with new image."
