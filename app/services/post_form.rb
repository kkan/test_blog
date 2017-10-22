class PostForm < FormObject
  attr_reader :title, :content, :login, :ip

  validates :title, :content, :login, presence: true
  validate :ip_address_format

  def initialize(params)
    @title = params[:title]
    @content = params[:content]
    @login = params[:login]
    @ip = params[:ip].presence
  end

  private

  def ip_address_format
    return if ip.nil?
    errors.add(:ip, 'invalid IP address') unless ip_address_valid?
  end

  def ip_address_valid?
    IPAddr.new(ip)
    true
  rescue IPAddr::InvalidAddressError
    false
  end
end
