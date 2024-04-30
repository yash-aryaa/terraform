**# terraform**
terraform basic project
**Step 1: Install Terraform**
Visit the Terraform website and download the appropriate version for your operating system.
Follow the installation instructions provided for your operating system.
**Step 2: Set Up Your AWS Account**
If you haven't already, sign up for an AWS account at AWS Console.
Create an IAM user with programmatic access and assign appropriate permissions (e.g., AdministratorAccess) for Terraform to manage AWS resources.
**Step 3: Configure AWS Credentials**
Generate access keys for the IAM user created in the previous step.
Set up AWS credentials on your local machine using the AWS CLI or by exporting environment variables (AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY).
**Step 4: Define Terraform Configuration**
Create a new directory for your Terraform project.
Inside the directory, create a file named main.tf (or any filename with .tf extension) and define your Terraform configuration.
Define resources such as VPC, subnets, internet gateway, load balancer, EC2 instances, and S3 bucket using Terraform configuration language.
**Step 5: Initialize Terraform**
Open a terminal or command prompt.
Navigate to the directory where your Terraform configuration file (main.tf) is located.
Run terraform init to initialize the Terraform project. This will download necessary plugins and modules.
**Step 6: Plan Infrastructure Changes**
After initializing, run terraform plan. This command analyzes your Terraform configuration and generates an execution plan.
Review the plan to ensure that Terraform will create, update, or delete resources as expected.
**Step 7: Apply Changes**
Once you're satisfied with the plan, execute terraform apply to apply the changes to your AWS account.
Terraform will prompt for confirmation before making any changes. Type yes to proceed.
Terraform will provision the infrastructure according to the configuration defined in your main.tf file.
**Step 8: Verify Deployment**
After Terraform applies the changes successfully, verify that the resources are provisioned correctly in your AWS account.
Access the deployed web application using the provided endpoint or IP address.
Test the functionality of the application to ensure it's working as expected.
**Step 9: Clean Up (Optional)**
To remove the resources provisioned by Terraform, run terraform destroy.
Confirm the destruction of resources by typing yes when prompted.
Terraform will remove all resources created by the configuration, leaving your AWS account in its initial state.
