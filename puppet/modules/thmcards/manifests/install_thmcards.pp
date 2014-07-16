define install_thmcards (
) {
	# Install npm
	exec { "install npm":
	  command => "/usr/bin/apt-get install -q -y npm"
	}
	->
	exec { "install thmcards":
	  cwd => "/vagrant/thmcards",
	  command => "/usr/bin/npm install"
	}
	->
	exec { "create views":
	  cwd => "/vagrant/thmcards",
	  command => "/usr/bin/python createviews.py"
	}
	->
	exec { "default badges":
	  cwd => "/vagrant/thmcards",
	  command => "/usr/bin/curl -d @/vagrant/thmcards/couchviews/default_badges.design -X POST http://127.0.0.1:5984/thmcards/_bulk_docs -H \"Content-Type: application/json\"",
	}
}
