resource "aws_instance" "test-server" {
  ami = "ami-0522ab6e1ddcc7055"
  instance_type = "t2.micro"
  key_name = "Vrushu12"
  vpc_security_group_ids = ["sg-02e5e959755d42ea3"]
  connection {
     type = "ssh"
     user = "ubuntu"
     private_key = file("./Vrushu12.pem")
     host = self.public_ip
     }
  provisioner "remote-exec" {
     inline = ["echo 'wait to start the instance' "]
  }
  tags = {
     Name = "test-server"
     }
  provisioner "local-exec" {
     command = "echo ${aws_instance.test-server.public_ip} > inventory"
     }
  provisioner "local-exec" {
     command = "ansible-playbook /var/lib/jenkins/workspace/Banking-Project/terraform-files/ansibleplaybook.yml"
     }
  }
