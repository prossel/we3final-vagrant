class tomcat7 (
	$tomcat_admin_user = "thmcards",
	$tomcat_admin_pass = "thmcards",
	$tomcat_server_id = "thmcards"
) {
	user { "tomcat":
		ensure => "present"
	}
	group { "tomcat":
		ensure => "present"
	}

	file { "/home/vagrant/.m2":
		ensure => "directory",
		require => Package["maven"],
		owner => "vagrant",
		group => "vagrant"
	}

	file { "/home/vagrant/.m2/settings.xml":
		content => template("tomcat7/settings.xml.erb"),
		require => [ Package["maven"], File["/home/vagrant/.m2"] ],
		owner => "vagrant",
		group => "vagrant"
	}
}
