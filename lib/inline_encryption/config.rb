# frozen_string_literal: true

require 'hashie/extensions/ruby_version_check'
require 'hashie/extensions/indifferent_access'
require 'hashie/extensions/method_access'
require 'hashie/extensions/dash/indifferent_access'
require 'hashie/dash'
require 'openssl'

module InlineEncryption
  # known configuration variables
  # key - a String containing the private key, a filename pointing to the private key, or an OpenSSL::PKey::RSA
  class Config < Hash
    include Hashie::Extensions::IndifferentAccess
    include Hashie::Extensions::MethodAccess

    # checks required, currently only the 'key'
    # @raises [InlineEncryption::MissingRequiredVariableError] raise on a missing variable
    def check_required_variables
      raise MissingRequiredVariableError, I18n.t('error.missing_key') unless key?(:key)
    end

    # @return [OpenSSL::PKey::RSA] the OpenSSL key instance
    def real_key
      case self[:key]
      when NilClass
        nil
      when String
        load_or_use_key(self[:key])
      when OpenSSL::PKey::RSA
        self[:key]
      end
    end

    private

    # @return OpenSSL::PKey::RSA
    def load_or_use_key(str)
      if File.exist?(str)
        OpenSSL::PKey::RSA.new(File.read(str))
      else
        OpenSSL::PKey::RSA.new(str)
      end
    end
  end
end
