# Class:: openstack_gluster_swift::params
#
#
class openstack_gluster_swift::params {
  $gluster_deps = ['xfsprogs']
  $gluster_ip = $::ipaddress
  $lvm_pv = '/dev/sdb'
  $lvm_pv_blocksize = '512'
  $lvm_vg = 'vg_gluster'
  $lvm_lv = 'swift'
  $lvm_fstype = 'xfs'
  $mount_options = ['inode64','noatime','nodiratime']
  $mountpoint = '/mnt/swift'
} # Class:: openstack_gluster_swift::params
