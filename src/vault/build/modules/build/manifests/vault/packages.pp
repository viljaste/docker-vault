class build::vault::packages {
  file { '/tmp/vault_0.1.2_linux_amd64.zip':
    ensure => present,
    source => 'puppet:///modules/build/tmp/vault_0.1.2_linux_amd64.zip'
  }

  bash_exec { 'cd /tmp && unzip vault_0.1.2_linux_amd64.zip':
    require => File['/tmp/vault_0.1.2_linux_amd64.zip']
  }

  bash_exec { 'mv /tmp/vault /usr/local/bin/vault':
    require => Bash_exec['cd /tmp && unzip vault_0.1.2_linux_amd64.zip']
  }
}
