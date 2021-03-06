# == Class: openstack_gluster_swift
#
# Full description of class openstack_gluster_swift here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { openstack_gluster_swift:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Steve Huff <steve_huff@harvard.edu>
#
# === Copyright
#
# Copyright 2014 President and Fellows of Harvard College
#
class openstack_gluster_swift (
  $lvm_pv               = $openstack_gluster_swift::params::lvm_pv,
  $lvm_pv_blocksize     = $openstack_gluster_swift::params::lvm_pv_blocksize,
  $lvm_vg               = $openstack_gluster_swift::params::lvm_vg,
  $lvm_lv               = $openstack_gluster_swift::params::lvm_lv,
  $lvm_fstype           = $openstack_gluster_swift::params::lvm_fstype,
  $lvm_size             = $openstack_gluster_swift::params::lvm_size,
  $mountpoint           = $openstack_gluster_swift::params::mountpoint,
  $mount_options        = $openstack_gluster_swift::params::mount_options,
  $gluster_deps         = $openstack_gluster_swift::params::gluster_deps,
  $gluster_ip           = $openstack_gluster_swift::params::gluster_ip,
  $swift_package_name   = $openstack_gluster_swift::params::swift_package_name,
  $swift_package_source = $openstack_gluster_swift::params::swift_package_source,
  $swift_services       = $openstack_gluster_swift::params::swift_services,
  $swift_ip             = $openstack_gluster_swift::params::swift_ip,
) inherits openstack_gluster_swift::params {

  case $::osfamily {
    'RedHat': {}
    default: {
      fail("openstack_gluster_swift only runs on RedHat platforms, not '${::osfamily}'.")
    }
  }

  class { 'openstack_gluster_swift::volume':
    lvm_pv           => $openstack_gluster_swift::lvm_pv,
    lvm_pv_blocksize => $openstack_gluster_swift::lvm_pv_blocksize,
    lvm_vg           => $openstack_gluster_swift::lvm_vg,
    lvm_lv           => $openstack_gluster_swift::lvm_lv,
    lvm_fstype       => $openstack_gluster_swift::lvm_fstype,
    lvm_size         => $openstack_gluster_swift::lvm_size,
    mountpoint       => $openstack_gluster_swift::mountpoint,
    mount_options    => $openstack_gluster_swift::mount_options,
  } ->

  # configure yum repos
  class { 'openstack_repos':
    role => 'storage',
  } ->

  class { 'openstack_gluster_swift::gluster':
    mountpoint   => $openstack_gluster_swift::mountpoint,
    gluster_deps => $openstack_gluster_swift::gluster_deps,
    gluster_ip   => $openstack_gluster_swift::gluster_ip,
  } ->

  # install and start memcached
  class { 'memcached': } ->

  # install gluster_swift package
  # configure Swift
  # generate ring files
  # start Swift components
  class { 'openstack_gluster_swift::swift':
    swift_package_name   => $openstack_gluster_swift::swift_package_name,
    swift_package_source => $openstack_gluster_swift::swift_package_source,
    swift_services       => $openstack_gluster_swift::swift_services,
    swift_ip             => $openstack_gluster_swift::swift_ip,
    gluster_ip           => $openstack_gluster_swift::gluster_ip,
  }

}
