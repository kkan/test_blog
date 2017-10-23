require 'rails_helper'
describe Creators::ReviewCreator do
  self.use_transactional_tests = false

  let(:post){ Post.create(rating: 3.0, reviews_count: 1, scores_sum: 3, user: User.create) }
  let(:review_form){ Forms::ReviewForm.new(post_id: post.id, score: 4) }

  before{ Creators::ReviewCreator.new(review_form).process }

  after{ User.destroy_all }
  after(:all){ self.use_transactional_tests = true }

  it 'should update score at post when adding review' do
    expect(post.reload.rating).to eql(3.5)
    expect(post.reload.reviews_count).to eql(2)
    expect(post.reload.scores_sum).to eql(7)
    self.use_transactional_tests = true
  end

  it 'should add review to database' do
    expect(post.reviews.reload.size).to eql(1)
  end

  it 'should return result with errors when failing' do
    review_form_2 = Forms::ReviewForm.new(post_id: 123, score: 4)
    expect(Creators::ReviewCreator.new(review_form_2).process.errors.first).to include("Couldn't find")
  end
end

