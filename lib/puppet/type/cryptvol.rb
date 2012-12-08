Puppet::Type.newtype(:cryptvol) do
  @doc = "Manage unlocking an encrypted volume."

  ensurable

  newparam(:device, :namevar=>true) do
    desc "Full path to the device to unlock"
    newvalues(/^\S+$/)
  end

  newparam(:mapper) do
    desc "Device mapper name"
    newvalues(/^\w+$/)
  end

  newparam(:key) do
    desc "Key used to unlock the device"
  end
end
