require 'i18n'
require 'base64'
require 'inline_encryption/version'
require 'inline_encryption/config'
require 'inline_encryption/base'
require 'inline_encryption/errors'

module InlineEncryption
  extend InlineEncryption::Base

  unless @_i18n_initialized_for_ie
    locale_file = File.expand_path(File.join(File.dirname(__FILE__), '../config/locales.yml'))
    I18n.load_path << locale_file
    I18n.enforce_available_locales = false
    @_i18n_initialized_for_ie = true
  end


end
