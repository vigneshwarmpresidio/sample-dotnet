# PROJECT TEMPLATE NOTES

This repository is a template for creating new projects. It is intended to be used as a starting point for new projects.

This template contains references to the fictional team named 'AccountServices' and a fictional project that it owns called
'MmxApiAdapter'. These references should be replaced with the actual team and project names.

To use this template, first clone it to a new repository with the name of the project:

```bash
git clone git@github.com:sorenson-eng/arc-blueprints.git <RepositoryName>
```

Then run the initialization script, which will customize the template for the new project and initialize the Git
repository:

```bash
cd <RepositoryName>
./blueprint/init_repo.sh <TeamName> <ProjectName>  # eg: ./blueprint/init_repo.sh AccountServices CoolService
```

## Post-Initialization Steps

- In order to enable deployments to the target AWS accounts, the GitHub repository must be granted access via OIDC. This
currently requires an IT ticket to be submitted, including details about the source GitHub repository and the target AWS
accounts.

- The GitHub repository must be configured with the GPR authentication token in order to access the GitHub Packages.
This is a repository-level secret and must be named GPR_AUTH_TOKEN.

- The list of supported deployments must be configured in the deployments.json file (see the 'ops' directory).

- Update any references to the deployment IDs that were defined in the deployments.json file (eg, in the GitHub
workflow files).

- After initializing the repository, remove this section from this README and be sure to update the rest below.


* * *

# ProjectName

(Insert high-level description of project here)

## Team

(Add team information here. Examples below)

EXAMPLE: This repository is owned and maintained by the [**Relay**](https://sorenson.atlassian.net/wiki/spaces/R/pages/102924467/The+Team) team.

EXAMPLE: This repository is owned and maintained by the [**Account Services**](https://sorenson.atlassian.net/wiki/spaces/C/overview#The-Team) team.

EXAMPLE: This repository is owned and maintained by the [**Communications**](https://sorenson.atlassian.net/wiki/spaces/CI/pages/12451842/The+Team)


## Getting Started

### Prerequisites

(Provide any prerequisite setup steps that are required to get the local environment configured. Examples below)

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
