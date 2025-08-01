
data "aws_caller_identity" "current" {}
data "aws_ami" "latest_amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  # The filters narrow down the search to find the correct
  # Amazon Linux 2023 AMI for x86_64 architecture.
  filter {
    name   = "name"
    values = ["al2023-ami-2023*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

variable "company_name" {
  default = "acme"
}

variable "environment" {
  default = "dev"
}

locals {
  resource_prefix = {
    value = "${data.aws_caller_identity.current.account_id}-${var.company_name}-${var.environment}"
  }
}



variable "profile" {
  default = "default"
}

variable "region" {
  default = "us-west-2"
}

# The 'ami' variable is now simplified. It no longer needs a hardcoded
# default value. Instead, the AMI ID is referenced directly from the
# data source, ensuring all resources that use this AMI get the latest version.
variable "ami" {
  type        = "string"
  description = "The ID of the AMI to be used for instances."
  # The default value is set to the ID found by the data source.
  default     = data.aws_ami.latest_amazon_linux.id
}

variable "dbname" {
  type        = "string"
  description = "Name of the Database"
  default     = "db1"
}

variable "password" {
  type        = "string"
  description = "Database password"
  default     = "Aa1234321Bb"
}

variable "neptune-dbname" {
  type        = "string"
  description = "Name of the Neptune graph database"
  default     = "neptunedb1"
}
