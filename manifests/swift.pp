# Class:: openstack_gluster_swift::swift
#
#
class openstack_gluster_swift::swift (
  $swift_package_name   = $openstack_gluster_swift::params::swift_package_name,
  $swift_package_source = $openstack_gluster_swift::params::swift_package_source,
  $swift_services       = $openstack_gluster_swift::params::swift_services,
  $swift_ip             = $openstack_gluster_swift::params::swift_ip,
  $gluster_ip           = $openstack_gluster_swift::params::gluster_ip,
  $lvm_lv               = $openstack_gluster_swift::params::lvm_lv,
) inherits openstack_gluster_swift::params {

  # install gluster-swift package
  package { $openstack_gluster_swift::swift::swift_package_name:
    ensure   => 'present',
    provider => 'yum',
    source   => $openstack_gluster_swift::swift::swift_package_source,
  }

  # configure gluster-swift
  File {
    ensure    => 'present',
    require   => Package[$openstack_gluster_swift::swift::swift_package_name],
    subscribe => Package[$openstack_gluster_swift::swift::swift_package_name],
    before    => Exec['gluster-swift-gen-builders'],
    notify    => Exec['gluster-swift-gen-builders'],
    owner     => 'root',
    group     => 'root',
    mode      => '0640',
  }

  file { '/etc/swift/account-server.conf':
    content => template('openstack_gluster_swift/etc/swift/account-server.conf.erb'),
  }

  file { '/etc/swift/container-server.conf':
    content => template('openstack_gluster_swift/etc/swift/container-server.conf.erb'),
  }

  file { '/etc/swift/object-server.conf':
    content => template('openstack_gluster_swift/etc/swift/object-server.conf.erb'),
  }

  file { '/etc/swift/swift.conf':
    content => template('openstack_gluster_swift/etc/swift/swift.conf.erb'),
  }

  file { '/etc/swift/fs.conf':
    content => template('openstack_gluster_swift/etc/swift/fs.conf.erb'),
  }

  # create ring files
  exec { 'gluster-swift-gen-builders':
    command     => "/usr/bin/gluster-swift-gen-builders ${openstack_gluster_swift::swift::lvm_lv}",
    cwd         => '/etc/swift',
    refreshonly => true,
    logoutput   => 'on_failure',
  } ~>

  # start services
  service { $openstack_gluster_swift::swift::swift_services:
    ensure     => 'running',
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }

} # Class:: openstack_gluster_swift::swift
