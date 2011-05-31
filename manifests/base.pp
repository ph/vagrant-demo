class rabbitmq {
  package { "rabbitmq-server":
    ensure => present
  }

  service { "rabbitmq":
    ensure  => running,
    require => Package["rabbitmq-server"],
  }
}


class mysqlserver {
  package { "mysql-server":
    ensure => present
  }

  service { "mysqld":
    ensure  => running,
    require => Package["mysql-server"],
  }
}

include rabbitmq
include mysqlserver

