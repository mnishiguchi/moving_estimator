require 'rubygems'
require 'execjs'

module CoffeeReact
  Error            = ExecJS::Error
  EngineError      = ExecJS::RuntimeError
  CompilationError = ExecJS::ProgramError

  module Source
    def self.path
      @path ||= File.expand_path('../coffee-react-transform.js', File.dirname(__FILE__))
    end

    def self.path=(path)
      @contents = @context = nil
      @path = path
    end

    def self.contents
      @contents ||= File.read(path)
    end

    def self.context
      @context ||= ExecJS.compile(contents)
    end
  end

  class << self
    def engine
    end

    def engine=(engine)
    end

    def transform(script, options = {})
      script = script.read if script.respond_to?(:read)

      Source.context.call("coffeeReactTransform", script, options)
    end
  end
end
