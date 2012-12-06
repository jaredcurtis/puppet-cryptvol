require 'puppet'
Puppet::Type.type(:cryptvol).provide(:cryptsetup) do

  commands :cryptsetup => 'cryptsetup'
  defaultfor :kernel  => :linux

  def create
    if File.exists?(@resource[:key])
      self.debug "Unlocking with key file"
      cryptsetup('luksOpen', "--key-file", "#{@resource[:key]}", "#{@resource[:device]}", "#{@resource[:mapper]}")
    else
      self.debug "Unlocking with passphrase"
      system "echo -n '#{@resource[:key]}' | cryptsetup luksOpen #{@resource[:device]} #{@resource[:mapper]}"
    end
  end

  def destroy
    self.debug "Shutting down luks volume"
    cryptsetup('luksClose', "#{@resource[:mapper]}")
  end

  def exists?
    begin
      luksinfo = cryptsetup('status', "#{@resource[:mapper]}")
    rescue Exception => e
      self.debug e.message
      self.debug e.backtrace
      return false
    end

    luksinfo case 
      when /.* is active/
        self.debug "Luks volume is active"
        return true
      when /.* is inactive/
        self.debug "Luks volume is not started"
        return false
      else
        self.debug "Unexpected case"
        return false
    end
  end
end
