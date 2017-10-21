class PostForm
  include ActiveModel::Validations

  attr_reader :title, :content, :login, :ip

  validates :title, :content, :login, :ip, presence: true

  def initialize(params)
    @title = params[:title]
    @content = params[:content]
    @login = params[:login]
    @ip = params[:ip]
  end
end
