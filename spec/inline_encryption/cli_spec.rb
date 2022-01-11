# frozen_string_literal: true

require 'spec_helper'
require 'base64'
require 'inline_encryption/cli'

def tmp_filename
  File.expand_path(File.join(File.dirname(__FILE__), '../../tmp/bar.rb'))
end

describe InlineEncryption::CLI do
  describe 'initialize' do
    let(:subject) { InlineEncryption::CLI.new }

    before :all do
      @default_key = OpenSSL::PKey::RSA.generate(2048)
      InlineEncryption.config[:key] = @default_key
    end

    it 'should encrypt' do
      expect(InlineEncryption).to receive(:encrypt).with('hello')

      subject.encrypt('hello')
    end

    it 'should require a file if passed' do
      subject = InlineEncryption::CLI.new(['foo'], ['-r', 'foo.rb'], {})

      expect(subject).to receive(:load_environment).with('foo.rb')

      subject.encrypt('foo')
    end
  end

  describe 'load_environment' do
    before :each do
      FileUtils.mkdir_p File.dirname(tmp_filename)
      File.open(tmp_filename, 'w') do |file|
        file.puts 'class FooForInlineEncryptionSpec; end'
      end
    end

    after :each do
      FileUtils.rm_f File.dirname(tmp_filename)
    end

    it 'should require the file' do
      subject.send(:load_environment, tmp_filename)
      expect { FooForInlineEncryptionSpec }.not_to raise_error
    end
  end
end
