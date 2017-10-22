class IpAddressesController < ApplicationController
  def multiuser
    ips = IpUser.multiuser_ips.map{ |iu| { ip: iu.ip.to_s, logins: iu.logins } }
    render json: { ip_addresses: ips }
  end
end
