class run::vault {
  if $backend == 'file' {
    bash_exec { 'mkdir -p /vault/data': }
  }

  file { '/etc/vault/vault.hcl':
    ensure => present,
    content => template('run/vault.hcl.erb')
  }
}
