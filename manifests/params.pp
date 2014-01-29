# Class:: openstack_gluster_swift::params
#
#
class openstack_gluster_swift::params {
  $lvm_pv = '/dev/sdb'
  $lvm_pv_blocksize = '512'
  $lvm_vg = 'vg_gluster'
  $lvm_lv = 'swift'
  $lvm_fstype = 'xfs'
  $mount_options = ['inode64','noatime','nodiratime']
} # Class:: openstack_gluster_swift::params
