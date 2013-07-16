require 'spec_helper'
require 'base64'

describe InlineEncryption::CLI do

  let(:subject){ InlineEncryption::CLI.new }

  before :all do
    @default_key = OpenSSL::PKey::RSA.generate(2048)
    InlineEncryption.config[:key] = @default_key
  end

  it 'should encrypt' do
    InlineEncryption.should_receive(:encrypt).with('hello')

    subject.encrypt('hello')
  end

end
