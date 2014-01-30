This module installs [gluster-swift](https://github.com/gluster/gluster-swift) according to the [Quick Start Guide](https://github.com/gluster/gluster-swift/blob/havana/doc/markdown/quick_start_guide.md) for Havana.  You will probably want to override the following parameters:

* **lvm_pv** - the physical volume (_e.g._ `/dev/sdb`) to be used for creating the XFS volume which will be exported as a GlusterFS volume
* **lvm_size** - the size of the volume (in theory `puppetlabs/lvm` should use all the extents available, in practice this sometimes generates errors)
* **gluster_ip**,**swift_ip** - in the event that you have a storage network for GlusterFS and an endpoint network for Swift, specify the appropriate interfaces as IP addresses

The defaults should work (on RHEL6) for everything else.

License
-------

Copyright 2014 President and Fellows of Harvard College

Contact
-------

HUIT Cloud Engineering
