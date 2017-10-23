require 'rails_helper'

describe Forms::PostForm do
  it 'should validate presence of login' do
    expect(field_valid?(Forms::PostForm.new(login: ''), :login)).to be false
    expect(field_valid?(Forms::PostForm.new(login: 'login'), :login)).to be true
  end

  it 'should validate presence of title' do
    expect(field_valid?(Forms::PostForm.new(title: ''), :title)).to be false
    expect(field_valid?(Forms::PostForm.new(title: 'title'), :title)).to be true
  end

  it 'should validate presence of content' do
    expect(field_valid?(Forms::PostForm.new(content: ''), :content)).to be false
    expect(field_valid?(Forms::PostForm.new(content: 'content'), :content)).to be true
  end

  it 'should validate IP address' do
    expect(field_valid?(Forms::PostForm.new(ip: 'ssss'), :ip)).to be false
    expect(field_valid?(Forms::PostForm.new(ip: ''), :ip)).to be true
    expect(field_valid?(Forms::PostForm.new(ip: '192.168.0.2'), :ip)).to be true
  end

  it 'should set ip as nil if it is empty' do
    expect(Forms::PostForm.new(ip: '').ip).to be nil
  end

  private

  def field_valid?(post_form, field)
    post_form.validate
    post_form.errors.messages.keys.exclude?(field)
  end
end
