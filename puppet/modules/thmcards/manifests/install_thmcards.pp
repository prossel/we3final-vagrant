define install_thmcards (
) {
	# Install npm
	exec { "install npm":
	  command => "/usr/bin/apt-get install -q -y npm"
	}
	exec { "install thmcards":
	  cwd => "/vagrant/thmcards",
	  command => "/usr/bin/npm install"
	}
	exec { "create views":
	  cwd => "/vagrant/thmcards",
	  command => "/usr/bin/python createviews.py"
	}
	# exec { "run app.js":
	#   path => "/vagrant/thmcards",
	#   command => "/usr/bin/nodejs app.js"
	# }
}
