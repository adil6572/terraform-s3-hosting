# Terraform Amazon S3 Static Website Hosting

This project demonstrates how to host a static website on Amazon S3 using Terraform.

## Table of Contents

1. [Overview](#overview)
2. [Prerequisites](#prerequisites)
3. [Installation](#installation)
4. [Usage](#usage)
5. [Configuration](#configuration)
6. [License](#license)
7. [Authors](#authors)
8. [Acknowledgements](#acknowledgements)

## Overview

This project provides Terraform configurations to deploy a static website to Amazon S3. It sets up the S3 bucket, configures it for website hosting, and uploads the website files.

## Prerequisites

Before you begin, ensure you have the following prerequisites:

- [Terraform](https://www.terraform.io/downloads.html) installed on your local machine.
- An AWS account with appropriate permissions to create resources such as S3 buckets.
- AWS CLI configured with access key and secret key.

## Installation

To install and deploy the project, follow these steps:

1. Clone the repository to your local machine:

   ```bash
   git clone https://github.com/adil6572/terraform_s3_hosting

   ```

2. Change into the project directory:

   ```bash
   cd terraform_s3_hosting
   ```

3. Initialize Terraform:
   ```bash
   terraform init
   ```

## Configuration

### Variables

The project uses the following variables defined in `variables.tf`:

- `bucket_name`: The name of the S3 bucket to host the website.

### File Structure

The project directory structure is as follows:

```
terraform_s3_hosting/
├── output.tf
├── provider.tf
├── s3.tf
├── s3.tfvars
└── variables.tf
├── Web
```

Change the website files in `web` folder you want to host:

## Usage

To deploy the static website to Amazon S3, follow these steps:

1. Configure your AWS credentials using AWS CLI if you haven't already:

   ```bash
   aws configure
   ```

2. Review and adjust the `s3.tfvars` file with your desired configurations.

3. Apply the Terraform configuration to create the infrastructure:
   ```bash
   terraform apply -var-file=s3.tfvars
   ```

## License

This project is licensed under the [MIT License](LICENSE).

## Authors

- [Aadil Shaikh](https://github.com/adil6572)

## Acknowledgements

- Special thanks to the [Terraform](https://www.terraform.io/) community for their excellent documentation and resources.
