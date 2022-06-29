provider "aws" {
  version = "~> 2.0"
  region = "us-east-1"
}

resource "aws_instance" "dev" {
  count = 3
  ami = "ami-052efd3df9dad4825"
  instance_type = "t2.micro"
  key_name = ""
  tags = {
    Name = "dev${count.index}"
  }
  vpc_security_group_ids = ["${aws_security_group.ssh-access.id}"]
}

resource "aws_security_group" "ssh-access" {
  name = "ssh-access"
  description = "ssh-access"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = [""]
  }
  tags = {
    Name = "ssh"  
  }
}
