data "aws_ami" "amazon-linux-2" {
  most_recent = true

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }


  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }

  owners = ["amazon"]

}

resource "aws_instance" "jenkins-docker" {
  ami             = data.aws_ami.amazon-linux-2.id
  instance_type   = var.ec2-instance_type
  security_groups = [aws_security_group.jenkins-sg.name]
  key_name        = var.key_name
  provisioner "remote-exec" {
    inline = [
      "sudo amazon-linux-extras install epel -y",
      "sudo yum update -y",
      "sudo yum install docker git -y",
      "sudo service docker start",
      "sudo systemctl enable docker",
      "sudo groupadd docker",
      "sudo usermod -a -G bahaa docker",
      "sudo usermod -aG docker $${USER}",
      "sudo chmod 777 /var/run/docker.sock",
      "git clone https://github.com/balamood2/jenkis-docker.git",
      "cd jenkis-docker",
      "sh ./install.sh",
    ]
  }
  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file("~/aws-keys/bahaa.pem")
  }
  tags = {
    "Name" = "Jenkins-docker"
  }
}