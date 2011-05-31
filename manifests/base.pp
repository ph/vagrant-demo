class apt {
  exec { "apt-get update":
    command => "/usr/bin/apt-get update && touch /tmp/apt.update",
    onlyif => "/bin/sh -c '[ ! -f /tmp/apt.update ] || /usr/bin/find /etc/apt -cnewer /tmp/apt.update | /bin/grep . > /dev/null'",
  }
}

class rabbitmq {
  include apt
  
  package { "rabbitmq-server":
    ensure => present,
    require => Class["apt"]
  }

  service { "rabbitmq":
    ensure  => running,
    require => Package["rabbitmq-server"],
  }
}


class mysqlserver {
  include apt

  package { "mysql-server":
    ensure  => present,
    require => Class["apt"]
  }

  service { "mysqld":
    ensure  => running,
    require => Package["mysql-server"],
  }
}


include mysqlserver
include rabbitmq
