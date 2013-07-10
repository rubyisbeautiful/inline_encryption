require 'thor'

module InlineEncryption

  class CLI < Thor

    class_option :config, :aliases => ["-c"], :type => :string

    def initialize(args = [], opts = [], config = {})
      super(args, opts, config)

      if options[:config] && File.exists?(options[:config])
        @options = YAML.load_file(options[:config]).symbolize_keys.merge(@options.symbolize_keys)
      end
    end


    desc "encrypt [DATA]", "encrypt stuff"
    def encrypt(data)
      load_enviroment(options[:require])

      puts InlineEncryption.encrypt(data)
    end



    protected


    def load_enviroment(file=nil)
      file ||= "."

      if File.directory?(file) && File.exists?(File.expand_path("#{file}/config/environment.rb"))
        require "rails"
        require File.expand_path("#{file}/config/environment.rb")
        if defined?(::Rails) && ::Rails.respond_to?(:application)
          # Rails 3
          # ::Rails.application.eager_load!
        end
      elsif File.file?(file)
        require File.expand_path(file)
      end
    end

  end

end