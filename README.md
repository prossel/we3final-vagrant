# THMcard Vagrant

This Vagrant configuration will provision a Debian development box with all tools required for THMcard.

## Goal

THMcard developers should not need to install any tools in order to get THMcard up and running. Ideally, the only thing needed is an IDE. All other tools as well as the required workflows shall be handled by the Vagrant box.

## Getting Started

This repository comes with several Git submodules. These can be automatically checked out while cloning by providing the `--recursive` flag:

	git clone --recursive https://github.com/prossel/we3final-vagrant.git

Alternatively, initialize and update the submodules after cloning:

	git submodule update --init --recursive

## Basic Usage

Start the machine with the following command:

	$ vagrant up dev

This will create a completely configured VM. Running this the first time will download and install all required packages. Depending on your internet connection this operation will take some time. Once the machine is up and running, you can connect with:

	$ vagrant ssh

Then, in order to start THMcard, type:

	% ./start.sh

This will build and start THMcard. You can now visit http://localhost:8080/index.html in your browser.

Finally, if you want to stop THMcard, use this command:

	% ./stop.sh

### Testing for production

The machine's default environment is for development. If you are happy with your changes in development mode, you may wish to test them in a more realistic environment. For creating a production-like environment, type:

	$ vagrant up production

All commands remain the same, e.g., use `./start.sh` on the machine. But make sure you append the word `production` to all vagrant commands.

*Note:* In contrast to the development machine all changes have to be manually redeployed to Tomcat in the production environment. To do this, run `mvn tomcat7:deploy` in the `THMcard-war` directory.

## THMcard repositories

After the first boot of your VM, you will find the following repositories inside this project's root folder:

- THMcard
- THMcard-setuptool

The THMcard repositories are connected to your host machine via shared folders. This means you can use your local IDE of choice to work on the code, while the complete build process is handled by the Vagrant VM.

## Setting up your Git

You may want to change the Git remotes because the default `origin` is set to a read-only URL. It is preferred to keep the current `origin` repository as a means to stay in sync with the other THMcard developers. This is usually called the "upstream." Hence, you may want to rename `origin` to `upstream`:

	$ git remote rename origin upstream
	$ git remote add origin <your repository>

Don't forget to set your `master` branch to the new remote:

	$ git fetch origin
	$ git branch -u origin/master

## Ports

The following ports are used on the host machine:

### Development

- 8080 (Web)
- 10443 (socket.io)
- 5984 (CouchDB)

### Production

- 8081 (Web)
- 10444 (socket.io)
- 5985 (CouchDB)

## Using the GUI

If you wish to use the window manager [Xfce](http://www.xfce.org), you first need to shutdown your machine in case it is currently running. Use `vagrant halt` for this purpose. Then, edit the `Vagrantfile` and activate the GUI option:

	config.vm.provider "virtualbox" do |vb|
		vb.gui = true
	end

Once you restart the VM, log in with Vagrant's default credentials: user and password are both `vagrant`. Finally, the GUI is started by entering:

	startx

## Contributing

Please refer to the [CONTRIBUTING.md](CONTRIBUTING.md) document.

## Troubleshooting

### I'm missing some files.

If files like `start.sh` are missing, it is most likely that the provisioning has failed. Run `vagrant provision` which will make sure all packages and scripts are present. Also, you could just destroy the machine (`vagrant destroy`) to return to a blank slate.

### Script `start.sh` never returns.

The first time this script runs it will take quite some time because Maven has to download a lot of dependencies. To see if an error occurs, run `./start.sh -v` which displays Ant's and Maven's verbose outputs.

## Is it any good?

Yes.

## Credits

THMcard is powered by THM - Technische Hochschule Mittelhessen - University of Applied Sciences.
