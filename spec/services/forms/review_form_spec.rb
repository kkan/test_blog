require 'rails_helper'

describe Forms::ReviewForm do
  it 'should validate score between 1 and 5' do
    expect(field_valid?(Forms::ReviewForm.new(score: 1), :score)).to be true
    expect(field_valid?(Forms::ReviewForm.new(score: 4), :score)).to be true
    expect(field_valid?(Forms::ReviewForm.new(score: 0), :score)).to be false
    expect(field_valid?(Forms::ReviewForm.new(score: 'sss'), :score)).to be false
  end

  it 'should validate post_id presence' do
    expect(field_valid?(Forms::ReviewForm.new(post_id: 1), :post_id)).to be true
    expect(field_valid?(Forms::ReviewForm.new(post_id: ''), :post_id)).to be false
  end

  private

  def field_valid?(post_form, field)
    post_form.validate
    post_form.errors.messages.keys.exclude?(field)
  end
end
