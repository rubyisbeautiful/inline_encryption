module InlineEncryption

  class MissingRequiredVariableError < StandardError; end
  class DecryptionFailureError < StandardError; end
  class EncryptionFailureError < StandardError; end

end