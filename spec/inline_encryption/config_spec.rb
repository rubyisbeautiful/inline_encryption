require 'spec_helper'

describe InlineEncryption::Config do

  describe 'check_required_values' do
    let(:subject){ InlineEncryption::Config.new }

    it "should raise if 'key' is not set" do
      expect{ subject.check_required_variables }.to raise_error(InlineEncryption::MissingRequiredVariableError)
    end

    it "should not raise if 'key' is set" do
      subject[:key] = 'foo'
      expect{ subject.check_required_variables }.to_not raise_error(InlineEncryption::MissingRequiredVariableError)
    end

  end


  describe 'real_key' do
    let(:subject){ InlineEncryption::Config.new }

    it 'should return nil if key is NilClass' do
      subject[:key] = nil

      subject.real_key.should == nil
    end

    it 'should return the key value if key is an OpenSSL::PKey::RSA key' do
      key = OpenSSL::PKey::RSA.new(128)
      subject[:key] = key

      subject.real_key.should == key
    end

    it 'should return an OpenSSL::PKey::RSA key from the given String' do
      temp_key = OpenSSL::PKey::RSA.generate(32)
      key = temp_key.to_s
      subject[:key] = key

      subject.real_key.to_s.should == temp_key.to_s
      subject.real_key.should be_an_instance_of OpenSSL::PKey::RSA
    end

    it 'should load the contents of the given file if exists and use as key' do
      temp_key = OpenSSL::PKey::RSA.generate(32)
      key = 'foo'
      subject[:key] = key
      File.stub(:exists?).with('foo').and_return(true)
      File.stub(:read).with('foo').and_return(temp_key.to_s)

      subject.real_key.to_s.should == temp_key.to_s
      subject.real_key.should be_an_instance_of OpenSSL::PKey::RSA
    end
  end


end