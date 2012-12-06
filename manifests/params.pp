class cryptvol::params {
  case $::operatingsystem {
    'centos', 'redhat', 'fedora', 'scientific', 'oel' : {
      $pkg = 'cryptsetup-luks'
    }
    default: {
      fail("The ${module_name} module is not support on ${::operatingsystem}")
    }
  }
}
