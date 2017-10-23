class PostsGeneratorips_number

  def initialize(posts_number: 1000, logins_number: 100, ips_number: 50)
    @posts_number = posts_number
    @logins_number = logins_number
    @ips_number = ips_number
  end

  def generate
    posts_number.times do |i|
      PostCreator.new(PostForm.new(post_params)).process
      puts_log(i)
    end
  end

  private

  def post_params
    {
      login: logins.sample,
      ip: ips.sample,
      title: Faker::Lorem.sentence,
      content: Faker::Lorem.paragraph(15, true, 30)
    }
  end

  def logins
    @logins ||= logins_number.times.map{ Faker::Internet.unique.user_name }
  end

  def ips
    @ips ||= ips_number.times.map{ Faker::Internet.unique.public_ip_v4_address }
  end

  def puts_log(i)
    puts "#{i + 1} posts added" if ((i + 1) % 1000).zero?
  end
end

class ReviewsGenerator
  attr_reader :rated_posts_number, :reviews_per_post

  def initialize(rated_posts_number: 500, reviews_per_post: (1..100))
    @rated_posts_number = rated_posts_number
    @reviews_per_post = reviews_per_post
  end

  def generate
    posts_ids.each_with_index do |post_id, i|
      rand(reviews_per_post).times do
        ReviewCreator.new(ReviewForm.new(review_params(post_id))).process
      end
      puts_log(i)
    end
  end

  private

  def posts_ids
    @posts_ids ||= Post.order('random()').limit(rated_posts_number).pluck(:id)
  end

  def review_params(post_id)
    { score: rand(1..5), post_id: post_id }
  end

  def puts_log(i)
    puts "reviews added to #{i + 1} posts" if ((i + 1) % 20).zero?
  end
end

PostsGenerator.new(posts_number: 200_000).generate
ReviewsGenerator.new(rated_posts_number: 2000).generate
