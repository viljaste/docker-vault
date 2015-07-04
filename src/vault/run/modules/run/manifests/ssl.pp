class run::ssl {
  bash_exec { 'mkdir -p /vault/ssl': }

  bash_exec { 'mkdir -p /vault/ssl/private':
    require => Bash_exec['mkdir -p /vault/ssl']
  }

  bash_exec { 'mkdir -p /vault/ssl/certs':
    require => Bash_exec['mkdir -p /vault/ssl/private']
  }

  file { '/root/opensslCA.cnf':
    ensure => present,
    content => template('run/opensslCA.cnf.erb'),
    require => Bash_exec['mkdir -p /vault/ssl/certs']
  }

  bash_exec { 'openssl genrsa -out /vault/ssl/private/vaultCA.key 4096':
    timeout => 0,
    require => File['/root/opensslCA.cnf']
  }

  bash_exec { "openssl req -sha256 -x509 -new -days 3650 -extensions v3_ca -config /root/opensslCA.cnf -key /vault/ssl/private/vaultCA.key -out /vault/ssl/certs/vaultCA.crt":
    timeout => 0,
    require => Bash_exec['openssl genrsa -out /vault/ssl/private/vaultCA.key 4096']
  }

  bash_exec { 'openssl genrsa -out /vault/ssl/private/vault.key 4096':
    timeout => 0,
    require => Bash_exec["openssl req -sha256 -x509 -new -days 3650 -extensions v3_ca -config /root/opensslCA.cnf -key /vault/ssl/private/vaultCA.key -out /vault/ssl/certs/vaultCA.crt"]
  }

  file { '/root/openssl.cnf':
    ensure => present,
    content => template('run/openssl.cnf.erb'),
    require => Bash_exec['openssl genrsa -out /vault/ssl/private/vault.key 4096']
  }

  bash_exec { "openssl req -sha256 -new -config /root/openssl.cnf -key /vault/ssl/private/vault.key -out /vault/ssl/certs/vault.csr":
    timeout => 0,
    require => File['/root/openssl.cnf']
  }

  bash_exec { "openssl x509 -req -sha256 -CAcreateserial -days 3650 -extensions v3_req -extfile /root/opensslCA.cnf -in /vault/ssl/certs/vault.csr -CA /vault/ssl/certs/vaultCA.crt -CAkey /vault/ssl/private/vaultCA.key -out /vault/ssl/certs/vault.crt":
    timeout => 0,
    require => Bash_exec["openssl req -sha256 -new -config /root/openssl.cnf -key /vault/ssl/private/vault.key -out /vault/ssl/certs/vault.csr"]
  }
}
