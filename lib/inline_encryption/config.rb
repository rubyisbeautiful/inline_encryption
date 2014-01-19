require 'hashie/extensions/indifferent_access'
require 'hashie/extensions/method_access'
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
      raise MissingRequiredVariableError.new(I18n.t('error.missing_key')) unless self.has_key?(:key)
    end


    # @return [OpenSSL::PKey::RSA] the OpenSSL key instance
    def real_key
      case self[:key]
        when NilClass
          nil
        when String
          if File.exists?(self[:key])
            OpenSSL::PKey::RSA.new(File.read(self[:key]))
          else
            OpenSSL::PKey::RSA.new(self[:key])
          end
        when OpenSSL::PKey::RSA
          self[:key]
      end
    end
  end


end