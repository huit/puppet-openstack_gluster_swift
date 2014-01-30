# Class:: openstack_gluster_swift::params
#
#
class openstack_gluster_swift::params {
  $gluster_deps         = ['xfsprogs']
  $gluster_ip           = $::ipaddress
  $lvm_fstype           = 'xfs'
  $lvm_lv               = 'swift'
  $lvm_pv               = '/dev/sdb'
  $lvm_pv_blocksize     = '512'
  $lvm_size             = undef
  $lvm_vg               = 'vg_gluster'
  $mount_options        = ['inode64','noatime','nodiratime']
  $mountpoint           = '/mnt/swift'
  $swift_ip             = $::ipaddress
  $swift_package_name   = 'glusterfs-openstack-swift'
  $swift_package_source = 'https://launchpad.net/gluster-swift/havana/1.10.0-2/+download/glusterfs-openstack-swift-1.10.0-2.5.el6.noarch.rpm'
  $swift_services       = ['openstack-swift-proxy','openstack-swift-account','openstack-swift-container','openstack-swift-object']
} # Class:: openstack_gluster_swift::params
