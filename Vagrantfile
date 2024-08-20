$default_network_interface = `ip route | awk '/^default/ {printf "%s", $5; exit 0}'`

Vagrant.configure("2") do |config|
  
  # Set the base box to Ubuntu 24
  config.vm.box = "ubuntu/jammy64"
  
  # Set the hostname
  config.vm.hostname = "ubuntu24-elastic"
  
  # Configure network settings
  config.vm.network "public_network", bridge: "#$default_network_interface"
  
  # Configure the virtual machine settings
  config.vm.provider "virtualbox" do |vb|
    vb.name = "Ubuntu24-elastic"
    vb.memory = "2048"
    vb.cpus = 1
  end
  
  # Provisioning script to install Docker and OpenVPN
  config.vm.provision "shell", inline: <<-SHELL
    # Update and install necessary packages
    sudo apt-get update
    sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common expect
    
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

    # Pull the OpenVPN image
    docker pull kylemanna/openvpn

    # Create a Docker volume for OpenVPN data
    docker volume create --name ovpn-data

    # Generate the OpenVPN configuration
    docker run -v ovpn-data:/etc/openvpn --rm kylemanna/openvpn ovpn_genconfig -u tcp://localhost:53504

    # Create an expect script to automate ovpn_initpki
    cat << 'EOF' > /home/vagrant/ovpn_initpki
#!/usr/bin/expect -f

set timeout -1

# Run the OpenVPN PKI initialization command
spawn docker run -v ovpn-data:/etc/openvpn --rm -it kylemanna/openvpn ovpn_initpki

expect "Enter New CA Key Passphrase:"
send "1234\r"

expect "Re-Enter New CA Key Passphrase:"
send "1234\r"

expect "Common Name (eg: your user, host, or server name)"
send "\r"

expect "Enter pass phrase for /etc/openvpn/pki/private/ca.key:"
send "1234\r"

expect "Enter pass phrase for /etc/openvpn/pki/private/ca.key:"
send "1234\r"

expect eof
EOF

    # Create an expect script to automate users creation
    cat << 'EOF' > /home/vagrant/ovpn_client
#!/usr/bin/expect -f

set timeout -1
set username [lindex $argv 0]

# Run the OpenVPN Build Client command
spawn docker run -v ovpn-data:/etc/openvpn --rm -it kylemanna/openvpn easyrsa build-client-full $username nopass

expect "Enter pass phrase for /etc/openvpn/pki/private/ca.key:"
send "1234\r"

expect eof
EOF

    # Create an expect script to automate credentials
    cat << 'EOF' > /home/vagrant/ovpn_credentials
#!/usr/bin/bash

docker run -v ovpn-data:/etc/openvpn --rm kylemanna/openvpn ovpn_getclient $1
EOF

    # Make the scripts executable
    chmod +x /home/vagrant/ovpn_initpki
    chmod +x /home/vagrant/ovpn_client
    chmod +x /home/vagrant/ovpn_credentials

    # Run the expect script to initialize the OpenVPN PKI
    /home/vagrant/ovpn_initpki

    # Start the OpenVPN server
    docker run -v ovpn-data:/etc/openvpn -d -p 53504:1194/tcp --name ovpn-server --cap-add=NET_ADMIN kylemanna/openvpn
  SHELL
end
