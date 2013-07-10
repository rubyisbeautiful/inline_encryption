require 'hashie/extensions/indifferent_access'
require 'hashie/extensions/method_access'
require 'openssl'
require 'base64'

module InlineEncryption

  class Config < Hash
    include Hashie::Extensions::IndifferentAccess
    include Hashie::Extensions::MethodAccess

    def check_required_variables
      raise MissingRequiredVariable.new("missing variable: 'key'") unless self.has_key?(:key)
    end

    def real_key
      case self[:key]
        when NilClass
          nil
        when String
          if File.exists?(self[:key])
            OpenSSL::PKey::RSA.new(self[:key])
          else
            OpenSSL::PKey::RSA.new(self[:key])
          end
        when OpenSSL::PKey::RSA
          self[:key]
      end
    end
  end


end