class build::vault::supervisor {
  file { '/etc/supervisor/conf.d/vault.conf':
    ensure => present,
    source => 'puppet:///modules/build/etc/supervisor/conf.d/vault.conf',
    mode => 644
  }
}
