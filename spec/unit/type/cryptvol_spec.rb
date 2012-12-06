#! /usr/bin/env ruby
require 'spec_helper'

describe Puppet::Type.type(:cryptvol) do
  it "should have a not have a default value for :ensure" do
    cryptvol = Puppet::Type.type(:cryptvol).new(:name => "secretfs")
    cryptvol.should(:ensure).should be_nil
  end

  it "should have :device as the only keyattribute" do
    Puppet::Type.type(:cryptvol).key_attributes.should == [:device]
  end
end
