provider "aws" {
  region     = "us-east-2"
  access_key = "********************"
  secret_key = "****************************************"
}

data "aws_vpcs" "defaultVPC" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_security_group" "Allow_Back_Traffic" {
  name        = "SGN_CCDM_Training_Back_Terraform"
  description = "Allow Acces To BackEnd Application"
  vpc_id      = sort(data.aws_vpcs.defaultVPC.ids)[0]

  ingress {
    description = "Access from same vpc public subnet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["172.31.0.0/20", "172.31.16.0/20", "172.31.32.0/20"]
  }

  ingress {
    description = "SSH From PSL Computer"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["181.143.53.170/32"]
  }

  ingress {
    description = "SSH From personal Computer"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["201.233.80.136/32"]
  }

  ingress {
    description = "Access To Back End Application"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    responsible = "cdavidm"
    project = "rampup"
  }
}

resource "aws_security_group" "Allow_Front_Traffic" {
  name        = "SGN_CCDM_Training_Front_Terraform"
  description = "Allow Acces To FrontEnd Application"
  vpc_id      = sort(data.aws_vpcs.defaultVPC.ids)[0]

  ingress {
    description = "Access from same vpc public subnet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["172.31.0.0/20", "172.31.16.0/20", "172.31.32.0/20"]
  }

  ingress {
    description = "SSH From PSL Computer"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["181.143.53.170/32"]
  }

  ingress {
    description = "SSH From personal Computer"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["201.233.80.136/32"]
  }

  ingress {
    description = "Access To Front End Application"
    from_port   = 3030
    to_port     = 3030
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Access To Front End Application"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    responsible = "cdavidm"
    project = "rampup"
  }
}

resource "aws_security_group" "Allow_DB_Traffic" {
  name        = "SGN_CCDM_Training_DB_Terraform"
  description = "Allow Acces To DB Application"
  vpc_id      = sort(data.aws_vpcs.defaultVPC.ids)[0]

  ingress {
    description = "Access from same vpc to db"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["172.31.0.0/16"]
  }

  ingress {
    description = "db access From PSL Computer"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["181.143.53.170/32"]
  }

  ingress {
    description = "db access From personal Computer"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["201.233.80.136/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    responsible = "cdavidm"
    project = "rampup"
  }
}

data "aws_subnet_ids" "default_subnet" {
  vpc_id = sort(data.aws_vpcs.defaultVPC.ids)[0]
  tags = {
    Name = "Default subnet for*"
  }
}

output "vpc" {
    value = sort(data.aws_vpcs.defaultVPC.ids)[0]
}

output "securityGroupBack" {
    value = "${aws_security_group.Allow_Back_Traffic.id}"
}

output "securityGroupFront" {
    value = "${aws_security_group.Allow_Front_Traffic.id}"
}

output "securityGroupDB" {
    value = "${aws_security_group.Allow_DB_Traffic.id}"
}

output "subnets" {
    value = "${data.aws_subnet_ids.default_subnet.ids}"
}
