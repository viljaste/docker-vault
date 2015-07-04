class build::vault {
  require build::vault::packages
  require build::vault::supervisor

  bash_exec { 'mkdir -p /etc/vault': }
}
