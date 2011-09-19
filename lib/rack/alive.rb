require "rack/alive/version"

module Rack
  class Alive
    # Your code goes here...

    def initialize(app, conditional_block = nil)
      @app, @path, @conditional_block = app, "/alive", conditional_block
    end

    def call(env)
      if @path == env['PATH_INFO']
        alive?(env)
      else
        @app.call(env)
      end
    end

    protected

      def alive_response(sucess)
        if sucess
          [200, {'Content-Type' => 'text/plain'}, "true"]
        else
          [500, {'Content-Type' => 'text/plain'}, "false"]
        end
      end

      def alive?(env)
        is_alive = @conditional_block.respond_to?(:call) ? @conditional_block.call(env) : true
        alive_response(is_alive)
      rescue
        alive_response(false)
      end

  end
end
