$default_network_interface = `ip route | awk '/^default/ {printf "%s", $5; exit 0}'`

Vagrant.configure("2") do |config|

  # Set the base box to Ubuntu 24
  config.vm.box = "ubuntu/jammy64"

  # Set the hostname
  config.vm.hostname = "ElasticVPN"

  # Configure network settings
  config.vm.network "public_network", bridge: "#$default_network_interface"

  # Configure the virtual machine settings
  config.vm.provider "virtualbox" do |vb|
    vb.name = "ElasticVPN"
    vb.memory = "1024"
    vb.cpus = 1
  end

  config.vm.synced_folder "src", "/app/src/"

  # Provisioning script to install Docker and OpenVPN
  config.vm.provision "shell", inline: <<-SHELL
    cd /app/src/

    chmod +x ovpn_initpki
    chmod +x ovpn_client
    chmod +x ovpn_credentials
    chmod +x ovpn_install

    echo -n $(uuidgen) > key

    ./ovpn_install
  SHELL
end
