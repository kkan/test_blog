class IpAddressesController < ApplicationController
  def multiuser
    ips = MultiuserIpsQuery.new.perform.map{ |iu| { ip: iu.ip.to_s, logins: iu.logins } }
    render json: { ip_addresses: ips }
  end
end
