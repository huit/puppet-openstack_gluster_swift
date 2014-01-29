# Class:: openstack_gluster_swift::volume
#
#
class openstack_gluster_swift::volume (
  $lvm_pv           = $openstack_gluster_swift::params::lvm_pv,
  $lvm_pv_blocksize = $openstack_gluster_swift::params::lvm_pv_blocksize,
  $lvm_vg           = $openstack_gluster_swift::params::lvm_vg,
  $lvm_lv           = $openstack_gluster_swift::params::lvm_lv,
  $lvm_fstype       = $openstack_gluster_swift::params::lvm_fstype,
  $mountpoint       = $openstack_gluster_swift::params::mountpoint,
  $mount_options    = $openstack_gluster_swift::params::mount_options,
) inherits openstack_gluster_swift::params {

  $gluster_device = "/dev/${openstack_gluster_swift::volume::lvm_vg}/${openstack_gluster_swift::volume::lvm_lv}"

  # create XFS volume
  physical_volume { $openstack_gluster_swift::volume::lvm_pv:
    ensure => 'present',
  } ->

  volume_group { $openstack_gluster_swift::volume::lvm_vg:
    ensure           => 'present',
    physical_volumes => $openstack_gluster_swift::volume::lvm_pv,
  } ->

  logical_volume { $openstack_gluster_swift::volume::lvm_lv:
    ensure       => 'present',
    volume_group => $openstack_gluster_swift::volume::lvm_vg,
    size         => undef,
  } ->

  filesystem { $openstack_gluster_swift::volume::gluster_device:
    ensure  => 'present',
    fs_type => $openstack_gluster_swift::volume::lvm_fstype,
    options => "-i size=${openstack_gluster_swift::volume::lvm_pv_blocksize}",
  } ->

  # mount XFS volume
  file { $openstack_gluster_swift::volume::mountpoint:
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  } ->

  mounttab { $openstack_gluster_swift::volume::mountpoint:
    ensure  => 'present',
    device  => $openstack_gluster_swift::volume::gluster_device,
    options => $openstack_gluster_swift::volume::mount_options,
    pass    => 0,
    dump    => 0,
  } ->

  mountpoint { $openstack_gluster_swift::volume::mountpoint:
    ensure   => 'present',
    options  => $openstack_gluster_swift::volume::mount_options,
    remounts => true,
  }

} # Class:: openstack_gluster_swift::volume
