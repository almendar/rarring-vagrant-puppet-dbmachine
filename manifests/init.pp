#-*- mode: ruby -*-

group { "puppet":
	ensure => "present",
}
  
File { owner => 0, group => 0, mode => 0644 }
  
file { '/etc/motd':
content => "Welcome to your Vagrant-built virtual machine!
		   Managed by Puppet.\n"
}

$standardSoftware = ['vim', 'openjdk-7-jdk','wget','git']
package { $standardSoftware:
	ensure => present,
}




exec { "couchbase-download":
  command => "wget http://packages.couchbase.com/releases/2.0.1/couchbase-server-community_x86_64_2.0.1.deb",
  cwd     => "/var/tmp",
  creates => "/var/tmp/couchbase-server-community_x86_64_2.0.1.deb",
  path    => ["/usr/bin", "/usr/sbin"]
}

package { "libssl0.9.8":
	ensure => present,

}

package { "couchbase-install":
    provider => dpkg,
    ensure => installed,
    source => "/var/tmp/couchbase-server-community_x86_64_2.0.1.deb"
  }
include postgresql::server

user { 'tomaszk':
      ensure     => present,
      uid        => '507',
      gid        => 'admin',
      shell      => '/bin/bash',
      home       => '/home/tomaszk',
      managehome => true,
    }

	
include postgresql::server


Package['libssl0.9.8'] -> Exec['couchbase-download'] -> Package['couchbase-install']


