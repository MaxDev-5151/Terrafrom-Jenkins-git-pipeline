# Configure the AWS provider
provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

# Create a key pair for SSH access
resource "aws_key_pair" "my_key_pair" {
  public_key = <<EOF
your_public_key_here
EOF
  key_name   = "max123" # Replace with your desired key name
}

# Create a security group to allow SSH access
resource "aws_security_group" "allow_ssh" {
  name = "my-ec2-security-group"
  description = "Security group for SSH access"

  ingress {
    from_port = 22
    to_port   = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH from anywhere (adjust for security)
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol = "-1" # Allow all outbound traffic
  }
}

# Create the EC2 instance
resource "aws_instance" "my_ec2_instance" {
  ami           = "ami-04b70fa74e45c3917"  # Replace with your desired AMI ID
  instance_type = "t2.micro"

  # Associate the key pair
  key_name   = aws_key_pair.my_key_pair.key_name

  # Associate the security group
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  # Configure root EBS volume
  root_block_device {
    volume_type = "gp2"
    volume_size = 10 # Size in Gibibytes
  }

  tags = {
    Name = "My EC2 Instance"
  }
}
