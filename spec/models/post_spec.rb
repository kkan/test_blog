require 'rails_helper'

describe Post do
  let(:user){ User.create }
  it 'should properly add score' do
    post = Post.new(reviews_count: 1, scores_sum: 4, rating: 4.0)

    post.add_score(5)

    expect(post.reviews_count).to eql(2)
    expect(post.scores_sum).to eql(9)
    expect(post.rating).to eql(4.5)
  end

  it 'should return top n posts' do
    [4.5, 5.0, 3.1, nil, 3.2].each{ |i| create_post(i) }

    expect(Post.top(3).map(&:rating)).to match_array([5.0, 4.5, 3.2])
    expect(Post.top(5).map(&:rating)).to match_array([5.0, 4.5, 3.2, 3.1, nil])
    expect(Post.top.map(&:rating)).to match_array([5.0, 4.5, 3.2, 3.1, nil])
  end

  private

  def create_post(rating = nil)
    Post.create(rating: rating, user: user)
  end
end
