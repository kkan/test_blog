require 'rails_helper'

describe MultiuserIpsQuery do
  it 'should properly select IPs' do
    create_ip_users

    expect(perform_and_aggregate_query).to match_array(grouped_ips_and_user_logins)
  end

  private

  def create_ip_users
    user1 = User.create(login: 'login 1')
    user2 = User.create(login: 'login 2')
    IpUser.create(ip: '192.168.0.1', user: user1)
    IpUser.create(ip: '192.168.0.1', user: user2)
    IpUser.create(ip: '192.168.0.2', user: user2)
  end

  def perform_and_aggregate_query
    MultiuserIpsQuery.new.perform.map{ |iu| [iu.ip.to_s, iu.logins] }
  end

  def grouped_ips_and_user_logins
    [
      ['192.168.0.1', ['login 1', 'login 2']]
    ]
  end
end
