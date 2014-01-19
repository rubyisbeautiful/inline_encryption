module InlineEncryption

  module Base


    # @param [String] data encryption target
    # @return [String] encrypted target
    # @raise [EncryptionFailureError] couldn't encrypt the target
    def encrypt!(data)
      config.check_required_variables

      begin
        encrypted = config.real_key.private_encrypt(data)
        converted = Base64.encode64(encrypted)
      rescue => e
        err = EncryptionFailureError.exception I18n.t('target', data: data)
        raise err
      end
    end


    # @param [String] data encryption target
    # @return [String] encrypted target, or fail_text on error (default data)
    def encrypt(data, fail_text=nil)
      config.check_required_variables

      begin
        encrypt!(data)
      rescue EncryptionFailureError => e
        return fail_text.nil? ? data : fail_text.to_s
      end
    end


    # @param [String] data decryption target
    # @return [String] decrypted target
    # @raise [DecryptionFailureError] couldn't decrypt the target
    def decrypt!(data)
      config.check_required_variables

      begin
        converted = Base64.decode64(data)
        this_key = config.real_key.private? ? config.real_key.public_key : config.real_key
        decrypted = this_key.public_decrypt(converted)
      rescue => e
        err = DecryptionFailureError.exception I18n.t('encrypted', data)
        raise err
      end
    end


    # @param [String] data decryption target
    # @param [String] fail_text text to be returned in the case of a decryption failure
    # @return [String] decrypted target
    def decrypt(data, fail_text=nil)
      config.check_required_variables

      begin
        decrypt!(data)
      rescue DecryptionFailureError => e
        return fail_text.nil? ? data : fail_text.to_s
      end
    end


    # @return [InlineEncryption::Config] the configuration instance
    def config
      @config ||= Config.new
    end

  end

end