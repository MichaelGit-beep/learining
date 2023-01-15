resource "aws_key_pair" "citadel-key" {
  key_name   = "citadel"
  public_key = file("/root/.ssh/id_rsa.pub")
}

resource "aws_instance" "web" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name = aws_key_pair.citadel-key.id
  user_data = <<EOF
#!/bin/bash
sudo yum update -y
sudo yum install nginx -y
sudo systemctl start nginx
  EOF
}