resource "tls_private_key" "jenkins_ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "jenkins_private_key" {
  content         = tls_private_key.jenkins_ssh.private_key_pem
  filename        = "${path.module}/../../ansible/files/jenkins_id_rsa"
  file_permission = "0600"

  provisioner "local-exec" {
    command = "mkdir -p ~/keys && cp ${self.filename} ~/keys/jenkins_id_rsa && chmod 600 ~/keys/jenkins_id_rsa"
  }
}



resource "local_file" "jenkins_public_key" {
  content         = tls_private_key.jenkins_ssh.public_key_openssh
  filename        = "${path.module}/../../ansible/files/jenkins_id_rsa.pub"
  file_permission = "0644"
}