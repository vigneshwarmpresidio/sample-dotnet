# PROJECT TEMPLATE NOTES

## Post-Initialization Steps

- In order to enable deployments to the target AWS accounts, the GitHub repository must be granted access via OIDC. This
currently requires an IT ticket to be submitted, including details about the source GitHub repository and the target AWS
accounts.

- The list of supported deployments must be configured in the deployments.json file (see the 'ops' directory).

- Update any references to the deployment IDs that were defined in the deployments.json file (eg, in the GitHub
workflow files).

- After initializing the repository, remove this section from this README and be sure to update the rest below.


* * *

# MMX API Adapter

Service that provides a MMX-compatible API for interacting with pre-existing SLI endpoint devices.

## Team

This repository is owned and maintained by the [**Account Services**](https://sorenson.atlassian.net/wiki/spaces/C/overview#The-Team) team.


## Getting Started

### Prerequisites

The following software should be installed before attempting to build or deploy the project:

- [.NET 8 SDK](https://dotnet.microsoft.com/en-us/download/dotnet/8.0)
- Docker
- [Pre-commit](https://pre-commit.com/#install) (optional but recommended)

### Installation

After cloning the repository, you should enable the pre-commit hooks by running the following command from the root of
the repository:

```bash
pre-commit install
```

This performs a number of validation steps on each commit to ensure that the code is linted and formatted correctly, etc. If you do not wish to use pre-commit, you can skip this step. However, skipping the pre-commit hooks may result in your commits being rejected by the CI/CD pipeline.

The pre-commit hooks can also be run manually by running the following command from the root of the repository:

```bash
pre-commit run --all-files
```

This is a good way to check your changes before pushing them to the remote repository if you decide not to install the pre-commit hooks.


## Building Instructions

(Provide instructions for building the project. Examples below)

Building the project is as simple as running the following command from the root of the repository:

```bash
dotnet build
```

Running the project is equally simple:

```bash
dotnet run
```

## Deployment Instructions

(Provide instructions for deploying the project. Examples below)

Deployment of the project is implemented through GitHub Actions.

This project is following a trunk-based development model:

- The `main` branch is the mainline branch. It should always be deployable. All commits to this branch will be automatically built, tested, and deployed to the `QA` environment.

- Feature branches should be created by branching off of `main` in the following format: `feature/JIRA1234-<feature-description>`. All commits to these branches will be automatically built and tested, then optionally deployed to the `dev` environment. Deployments are manual and must be triggered by a user so that existing deployments are not automatically overwritten.

- Release branches should be created by branching off of `main` in the following format: `release/<version>`. All commits to these branches will be automatically built and tested. Deployments to the `prod` environment are manual and must be triggered/approved by a user.

The infrastructure for the project is also managed within this repository and deployed through GitHub Actions along with the application. See the 'ops' directory for more information.

## Monitoring Instructions

(Describe how to monitor the performance and health of the deployed project. Include any links to dashboards, Splunk, Dataset, etc.)
