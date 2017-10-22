class MultiuserIpsQuery
  def initialize(relation = IpUser.all)
    @relation = relation
  end

  def perform
    @relation
      .select('ip_users.ip, array_agg(users.login) AS logins')
      .joins('INNER JOIN users ON users.id = ip_users.user_id')
      .group('ip_users.ip')
      .having('COUNT(DISTINCT ip_users.user_id) > 1')
  end
end
