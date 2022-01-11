# frozen_string_literal: true

module InlineEncryption
  class MissingRequiredVariableError < StandardError; end
  class DecryptionFailureError < StandardError; end
  class EncryptionFailureError < StandardError; end
  class MisconfigurationError < StandardError; end
end
