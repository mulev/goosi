require_relative '../spec_helper'

describe 'Toplevel request handling' do
  before do
    @sample = File.read('spec/request/fixtures/sample_request.json')
  end

  it 'should build request object from JSON' do
    Goosi::Request.build(@sample).must_be_instance_of Goosi::Request
  end

  it 'should build request object from Hash' do
    hash = Oj.load(@sample, symbol_keys: true)
    Goosi::Request.build(hash).must_be_instance_of Goosi::Request
  end

  it 'should raise ArgumentError in case of invalid request' do
    true # TODO: implement it
  end

  it 'should read user information from request' do
    req = Goosi::Request.build(@sample)
    req.user.must_be_instance_of Goosi::User
    req.user.id.wont_be_nil
  end
end
