# Class:: openstack_gluster_swift::gluster
#
#
class openstack_gluster_swift::gluster (
  $gluster_deps = $openstack_gluster_swift::params::gluster_deps,
  $gluster_ip   = $openstack_gluster_swift::params::gluster_ip,
  $lvm_lv       = $openstack_gluster_swift::params::lvm_lv,
  $mountpoint   = $openstack_gluster_swift::params::mountpoint,
) inherits openstack_gluster_swift::params {

  $gluster_volume = "${openstack_gluster_swift::gluster::mountpoint}/brick"

  package { $openstack_gluster_swift::gluster::gluster_deps:
    ensure => 'present',
  } ->

  # install Gluster
  class { 'glusterfs::server': } ->

  # create and start Gluster volume
  glusterfs::volume { $openstack_gluster_swift::gluster::lvm_lv:
    create_options => "${openstack_gluster_swift::gluster::gluster_ip}:${openstack_gluster_swift::gluster::gluster_volume}",
  }

} # Class:: openstack_gluster_swift::gluster
