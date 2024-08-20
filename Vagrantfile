# Vagrantfile to create an Ubuntu 24 server with Docker installed

Vagrant.configure("2") do |config|
  
    # Set the base box to Ubuntu 24
    config.vm.box = "ubuntu/jammy64"
  
    # Set the hostname
    config.vm.hostname = "ubuntu24-docker"
  
    # Configure network settings
    config.vm.network "private_network", type: "dhcp"
  
    # Configure the virtual machine settings
    config.vm.provider "virtualbox" do |vb|
      vb.name = "Ubuntu24-Docker"
      vb.memory = "2048"
      vb.cpus = 2
    end
  
    # Provisioning script to install Docker
    config.vm.provision "shell", inline: <<-SHELL
      # Update and install necessary packages
      sudo apt-get update
      sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
      
      # Add Docker GPG key
      curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
      
      # Add Docker repository
      echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
      
      # Update the package database with Docker packages from the newly added repo
      sudo apt-get update
      
      # Install Docker
      sudo apt-get install -y docker-ce docker-ce-cli containerd.io
  
      # Add the vagrant user to the docker group
      sudo usermod -aG docker vagrant
  
      # Enable Docker service
      sudo systemctl enable docker
      sudo systemctl start docker
    SHELL
  end
  