require 'rails_helper'
describe Creators::PostCreator do
  self.use_transactional_tests = false

  let(:post_form){ Forms::PostForm.new(login: 'my login', title: 'title',content: 'content sample', ip: '192.168.0.4') }
  let(:invalid_post_form){ Forms::PostForm.new(login: 'my login', title: 'title',content: 'content', ip: 'aaaa') }

  after{ User.destroy_all }
  after(:all){ self.use_transactional_tests = true }

  it 'should add user' do
    expect{ Creators::PostCreator.new(post_form).process }.to change{ User.count }.from(0).to(1)
  end

  it 'should add post' do
    expect{ Creators::PostCreator.new(post_form).process }.to change{ Post.count }.from(0).to(1)
  end

  it 'should add ip_user' do
    expect{ Creators::PostCreator.new(post_form).process }.to change{ IpUser.count }.from(0).to(1)
  end

  it 'should not add ip_user when empty ip' do
    pf = Forms::PostForm.new(login: 'my login', title: 'title',content: 'content sample')
    expect{ Creators::PostCreator.new(pf).process }.to_not change{ IpUser.count }
  end

  it 'use existed user' do
    User.create(login: 'test login')
    pf = Forms::PostForm.new(login: 'test login', title: 'title',content: 'content sample', ip: '192.168.0.4')
    expect{ Creators::PostCreator.new(pf).process }.to_not change{ User.count }
  end

  it 'creates nothing when invalid form' do
    expect{ Creators::PostCreator.new(invalid_post_form).process }.to_not change{ Post.count }
    expect{ Creators::PostCreator.new(invalid_post_form).process }.to_not change{ User.count }
  end

  it 'return errors when post_form invalid' do
    expect(Creators::PostCreator.new(invalid_post_form).process.errors.first).to include('invalid IP')
  end
end

