Vagrant.configure("2") do |config|
  config.vm.boot_timeout = 600
  # Define the master node
  config.vm.define "master" do |master|
    master.vm.box = "bento/ubuntu-22.04"
    master.vm.network "public_network", bridge: "Realtek PCIe FE Family Controller", type: "dhcp"
    master.vm.network "forwarded_port", guest: 22, host: 2222, id: "ssh"
    master.vm.hostname = "master"
    master.vm.provider "virtualbox" do |vb|
      vb.memory = "4048"
      vb.cpus = 2
    end
  end

  # Define the worker node
  config.vm.define "worker" do |worker|
    worker.vm.box = "bento/ubuntu-22.04"
    worker.vm.network "public_network", bridge: "Realtek PCIe FE Family Controller", type: "dhcp"
    worker.vm.network "forwarded_port", guest: 22, host: 2223, id: "ssh"
    worker.vm.hostname = "worker"
    worker.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
      vb.cpus = 1
    end
  end
end



