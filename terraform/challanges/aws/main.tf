resource "aws_key_pair" "citadel-key" {
  key_name   = var.key_name
  public_key = file("/root/terraform-challenges/project-citadel/.ssh/ec2-connect-key.pub")
}

resource "aws_eip" "eip_citadel" {
  vpc      = true
  provisioner "local-exec" {
    command = "echo ${aws_eip.eip_citadel.public_dns} > /root/citadel_public_dns.txt"
  }
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.web.id
  allocation_id = aws_eip.eip_citadel.id
}

resource "aws_instance" "web" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key
  user_data     = file("${path.module}/install-nginx.sh")
}