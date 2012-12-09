#! /usr/bin/env ruby
require 'spec_helper'
require 'tempfile'


describe Puppet::Type.type(:cryptvol).provider(:cryptsetup) do

  let(:resource) do
    Puppet::Type.type(:cryptvol).new(
      :name     => 'secretfs', 
      :provider => provider
    )
  end

  let(:provider) { described_class.new(:name => 'secretfs') }

  describe '#create' do
    it "should run cryptsetup with system when :key is NOT a file" do
      resource[:key] = 'meh'
      resource[:device] = '/dev/loop0'
      resource[:mapper] = 'secretfs'
      provider.expects(:system).with("echo -n 'meh' | cryptsetup luksOpen /dev/loop0 secretfs")
      provider.create
    end
  end
end
