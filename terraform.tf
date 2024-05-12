provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0e001c9271cf7f3b9" 
  tags = {
    Name = "example-instance"
  }
}
