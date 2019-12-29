resource "aws_key_pair" "ec2key" {
  key_name   = "publicKey"
  public_key = file(var.public_key_path)
}

resource "aws_instance" "jenkins" {
  ami                    = "ami-04242e05c1ebface0"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.test_sg.id]
  key_name               = aws_key_pair.ec2key.key_name
  ##user_data              = file(var.install_script)
  user_data = <<-EOF
              #!/bin/bash
	      sudo wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
              sudo echo deb https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list
              sudo apt-get update -y
              sudo apt-get install ansible -y
              sudo apt-get install jenkins -y
              sudo systemctl start jenkins
              EOF

  tags = {
    Name = "jenkins-master"
  }
}

resource "aws_instance" "example-server" {
  ami                    = "ami-04242e05c1ebface0"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private_subnet.id
  vpc_security_group_ids = [aws_security_group.test_sg.id]
  key_name               = aws_key_pair.ec2key.key_name

  tags = {
    Name = "exampl-server"
  }
}

