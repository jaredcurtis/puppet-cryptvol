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

describe Puppet::Type.type(:cryptvol), "when validating attributes" do
  [:device, :mapper, :key ].each do |param|
    it "should have a #{param} parameter" do
      Puppet::Type.type(:cryptvol).attrtype(param).should == :param
    end
  end

  [:ensure].each do |param|
    it "should have a #{param} property" do
      Puppet::Type.type(:cryptvol).attrtype(param).should == :property
    end
  end
end

describe Puppet::Type.type(:cryptvol), "when validating values" do
  it "should support :present as a value to :ensure" do
    Puppet::Type.type(:cryptvol).new(:name => "secretfs", :ensure => :present)
  end

  it "should support :absent as a value to :ensure" do
    Puppet::Type.type(:cryptvol).new(:name => "secretfs", :ensure => :absent)
  end

  it "should support /dev/meh as a value to :device" do
    Puppet::Type.type(:cryptvol).new(:name => "secretfs", :device => "/dev/meh")
  end

  it "should support foo as a value to :mapper" do
    Puppet::Type.type(:cryptvol).new(:name => "secretfs", :mapper => "foo")
  end

  it "should error when /dev/invalid is used as a value to :mapper" do
      expect { Puppet::Type.type(:cryptvol).new(:name => "secretfs", :mapper => "/dev/invalid") }.to raise_error(Puppet::Error)
      #Puppet::Type.type(:cryptvol).new(:name => "secretfs", :mapper => "/dev/invalid")
  end

  it "should support foobar as a value to :key" do
    Puppet::Type.type(:cryptvol).new(:name => "secretfs", :key => "foobar")
  end
end
