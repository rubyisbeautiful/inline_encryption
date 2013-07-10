module InlineEncryption

  module Base

    # @param [String] encryption target
    # @return [String] encrypted target
    def encrypt(data)
      config.check_required_variables

      encrypted = config.real_key.private_encrypt(data)
      converted = Base64.encode64(encrypted)
    end


    # @param [String] decryption target
    # @return [String] decrypted target
    def decrypt(data)
      config.check_required_variables

      converted = Base64.decode64(data)
      decrypted = config.real_key.public_key.public_decrypt(converted)
    end


    # @return [InlineEncryption::Config] the configuration instance
    def config
      @config ||= Config.new
    end

  end

end