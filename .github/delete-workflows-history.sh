#!/usr/bin/env bash

# Delete logs for a specific workflow and the date after which the history will be deleted
# Usage: delete-workflows-history.sh <repository> <workflow-name> <DAYS_THRESHOLD>

set -oe pipefail

REPOSITORY=$1
WORKFLOW_NAME=$2
DAYS_THRESHOLD=$3

# Validate arguments
if [[ -z "$REPOSITORY" ]]; then
  echo "Repository is required"
  exit 1
fi

if [[ -z "$WORKFLOW_NAME" ]]; then
  echo "Workflow name is required"
  exit 1
fi

# Colect of the list to delete history
echo "Getting completed runs older than $DAYS_THRESHOLD days for workflow $WORKFLOW_NAME in $REPOSITORY"
RUNS=$(
  gh api \
    -H "Accept: application/vnd.github+json" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    "/repos/$REPOSITORY/actions/workflows/$WORKFLOW_NAME/runs" \
    --paginate \
    --jq ".workflow_runs[] | select(.conclusion != \"\" and (.created_at | fromdateiso8601 | now - . > $DAYS_THRESHOLD * 24 * 60 * 60)) | .id"
)

# Delete logs for each run
echo "Found $(echo "$RUNS" | wc -l) completed runs older than $DAYS_THRESHOLD days for workflow $WORKFLOW_NAME"
for RUN in $RUNS; do
  echo "Deleting logs for run $RUN"
  gh api \
    --method DELETE \
    -H "Accept: application/vnd.github+json" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    "/repos/$REPOSITORY/actions/runs/$RUN" || echo "Failed to delete logs for run $RUN"

  # Sleep for 100ms to avoid rate limiting
  sleep 0.1
done
