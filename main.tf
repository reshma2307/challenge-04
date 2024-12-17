resource "aws_instance" "c8" {
  ami           = "ami-049788618f07e189d"  
  instance_type = "t2.micro"
  key_name      = "ansible"  
  
  tags = {
    Name = "c8.local"
  }

  user_data = <<-EOF
    #!/bin/bash
    sudo hostnamectl set-hostname c8.local
  EOF
}

resource "aws_instance" "u21" {
  ami           = "ami-0dc44556af6f78a7b"  
  instance_type = "t2.micro"
  key_name      = "ansible"  
  
  tags = {
    Name = "u21.local"
  }

  user_data = <<-EOF
    #!/bin/bash
    sudo hostnamectl set-hostname u21.local
  EOF
}

output "c8_private_ip" {
  value = aws_instance.c8.private_ip
}

output "u21_private_ip" {
  value = aws_instance.u21.private_ip
}

resource "local_file" "ansible_inventory" {
  content = <<EOT
[frontend]
${aws_instance.c8.private_ip} ansible_host=${aws_instance.c8.private_ip} ansible_user=ec2-user

[backend]
${aws_instance.u21.private_ip} ansible_host=${aws_instance.u21.private_ip} ansible_user=ubuntu
EOT
  filename = "ansible/hosts"
