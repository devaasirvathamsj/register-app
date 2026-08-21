[jenkins_master]
jenkins-master ansible_host=${jenkins_master_id}

[jenkins_agent]
jenkins-agent ansible_host=${jenkins_agent_id}

[sonarqube]
sonarqube-server ansible_host=${sonarqube_id}

[all:vars]
ansible_user=ubuntu
ansible_ssh_private_key_file=/home/deva/keys/jenkins_id_rsa
ansible_ssh_common_args='-o StrictHostKeyChecking=no -o ProxyCommand="aws ssm start-session --target %h --document-name AWS-StartSSHSession --parameters portNumber=%p"'