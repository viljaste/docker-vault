class run::vault {
  file { '/etc/vault/vault.hcl':
    ensure => present,
    content => template('run/vault.hcl.erb')
  }
}
