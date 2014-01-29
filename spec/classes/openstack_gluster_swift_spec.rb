require 'spec_helper'

describe 'openstack_gluster_swift', :type => :class do
  describe 'on RedHat platform' do
    let(:facts) { { :osfamily => 'RedHat' } }

    describe 'with default params' do

      it { should compile.with_all_deps }

      it {
        should create_class('openstack_gluster_swift')
        should contain_class('openstack_gluster_swift::volume')
        should contain_class('openstack_gluster_swift::gluster')
      }

      it {
        should contain_class('openstack_repos')
      }

    end

  end

  describe 'on Debian platform' do
    let(:facts) { { :osfamily => 'Debian' } }

    it {
      expect { should raise_error(Puppet::Error, /only runs on RedHat/) }
    }

  end
end
