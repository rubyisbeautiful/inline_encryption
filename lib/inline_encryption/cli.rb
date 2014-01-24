require 'thor'

module InlineEncryption

  class CLI < Thor

    def initialize(args=[], opts=[], config={})
      super(args, opts, config)
    end


    desc 'encrypt [DATA]', 'encrypt stuff'
    class_option :require, :aliases => ['-r'], :type => :string
    def encrypt(data)
      load_environment(options[:require]) if options[:require]

      puts InlineEncryption.encrypt(data)
    end



    protected


    def load_environment(file)
      require File.expand_path(file)
    end

  end

end