require 'spec_helper'
require 'base64'

describe InlineEncryption::Base do

  before :all do
    @default_key = OpenSSL::PKey::RSA.generate(2048)
  end

  before :each do
    InlineEncryption.config[:key] = @default_key
  end

  describe 'encrypt' do

    let(:str){ 'foo' }

    it 'should encrypt' do
      InlineEncryption.encrypt(str).should == Base64.encode64(@default_key.private_encrypt(str))
    end

    it 'should fail to encrpyt and return the target' do
      InlineEncryption.config[:key] = OpenSSL::PKey::RSA.generate(32)
      InlineEncryption.encrypt(str*2).should == str*2
    end

    it 'should fail to encrypt and return the fail_text' do
      InlineEncryption.config[:key] = OpenSSL::PKey::RSA.generate(32)
      InlineEncryption.encrypt(str*2, 'chunky').should == 'chunky'
    end

  end

  describe 'encrypt!' do
    let(:str){ 'foo' }

    it 'should encrypt' do
      InlineEncryption.encrypt!(str).should == Base64.encode64(@default_key.private_encrypt(str))
    end

    it 'should fail to encrpyt and raise' do
      InlineEncryption.config[:key] = OpenSSL::PKey::RSA.generate(32)
      expect{ InlineEncryption.encrypt!(str*2) }.to raise_error(InlineEncryption::EncryptionFailureError)
    end

  end

  describe 'decrypt' do

    before :all do
      @str = Base64.encode64(@default_key.private_encrypt('chunky'))
    end

    it 'should decrypt' do
      InlineEncryption.decrypt(@str).should == 'chunky'
    end

    it 'should fail to decrypt and return the target' do
      InlineEncryption.config[:key] = OpenSSL::PKey::RSA.generate(32)
      InlineEncryption.decrypt(@str).should == @str
    end

    it 'should fail to decrypt and return the fail_text' do
      InlineEncryption.config[:key] = OpenSSL::PKey::RSA.generate(32)
      InlineEncryption.decrypt(@str, 'chunky').should == 'chunky'
    end

  end

  describe 'decrypt!' do

    before :all do
      @str = Base64.encode64(@default_key.private_encrypt('chunky'))
    end

    it 'should decrypt' do
      InlineEncryption.decrypt!(@str).should == 'chunky'
    end

    it 'should fail to decrpyt and raise' do
      InlineEncryption.config[:key] = OpenSSL::PKey::RSA.generate(32)
      expect{ InlineEncryption.decrypt!(@str) }.to raise_error(InlineEncryption::DecryptionFailureError)
    end

  end

end

