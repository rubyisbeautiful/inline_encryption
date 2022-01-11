# frozen_string_literal: true

require 'spec_helper'

describe InlineEncryption::Config do
  describe 'check_required_values' do
    let(:subject) { InlineEncryption::Config.new }

    it "should raise if 'key' is not set" do
      expect { subject.check_required_variables }.to raise_error(InlineEncryption::MissingRequiredVariableError)
    end

    it "should not raise if 'key' is set" do
      subject[:key] = 'foo'
      expect { subject.check_required_variables }.not_to raise_error
    end
  end

  describe 'real_key' do
    let(:subject) { InlineEncryption::Config.new }

    it 'should return nil if key is NilClass' do
      subject[:key] = nil

      expect(subject.real_key).to be_nil
    end

    it 'should return the key value if key is an OpenSSL::PKey::RSA key' do
      key = OpenSSL::PKey::RSA.new(512)
      subject[:key] = key

      expect(subject.real_key).to eq(key)
    end

    it 'should return an OpenSSL::PKey::RSA key from the given String' do
      temp_key = OpenSSL::PKey::RSA.generate(512)
      key = temp_key.to_s
      subject[:key] = key

      expect(subject.real_key.to_s).to eq(temp_key.to_s)
      expect(subject.real_key).to be_an_instance_of OpenSSL::PKey::RSA
    end

    it 'should load the contents of the given file if exists and use as key' do
      temp_key = OpenSSL::PKey::RSA.generate(512)
      key = 'foo'
      subject[:key] = key
      allow(File).to receive(:exists?).with('foo').and_return(true)
      allow(File).to receive(:read).with('foo').and_return(temp_key.to_s)

      expect(subject.real_key.to_s).to eq(temp_key.to_s)
      expect(subject.real_key).to be_an_instance_of OpenSSL::PKey::RSA
    end
  end
end
