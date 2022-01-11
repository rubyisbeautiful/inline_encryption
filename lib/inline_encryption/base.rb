# frozen_string_literal: true

require 'base64'

module InlineEncryption
  # Base module including core functionality
  module Base
    # @param [String] data encryption target
    # @return [String] encrypted target
    # @raise [EncryptionFailureError] couldn't encrypt the target
    def encrypt!(data)
      config.check_required_variables

      begin
        encrypted = config.real_key.public_encrypt(data)
        Base64.encode64(encrypted)
      rescue StandardError
        err = EncryptionFailureError.exception I18n.t('target', data: data)
        raise err
      end
    end

    # @param [String] data encryption target
    # @return [String] encrypted target, or fail_text on error (default data)
    def encrypt(data, fail_text = nil)
      config.check_required_variables

      begin
        encrypt!(data)
      rescue EncryptionFailureError
        fail_text.nil? ? data : fail_text.to_s
      end
    end

    # @param [String] data decryption target
    # @return [String] decrypted target
    # @raise [DecryptionFailureError] couldn't decrypt the target
    def decrypt!(data)
      config.check_required_variables
      raise MisconfigurationError, I18n.t('error.pub_key_decrypt') unless config.real_key.private?

      begin
        converted = Base64.decode64(data)
        config.real_key.private_decrypt(converted)
      rescue StandardError
        err = DecryptionFailureError.exception I18n.t('encrypted', data: data)
        raise err
      end
    end

    # @param [String] data decryption target
    # @param [String] fail_text text to be returned in the case of a decryption failure
    # @return [String] decrypted target
    def decrypt(data, fail_text = nil)
      config.check_required_variables

      begin
        decrypt!(data)
      rescue DecryptionFailureError
        fail_text.nil? ? data : fail_text.to_s
      end
    end

    # @return [InlineEncryption::Config] the configuration instance
    def config
      @config ||= Config.new
    end
  end
end
