require 'spec_helper'

describe Rack::Alive do

  describe "VERSION" do
    it 'should be defined' do
      defined?(::Rack::Alive::VERSION)
    end

    it 'should be a valid version string (e.g. "0.0.1", or "0.0.1.rc1")' do
      valid_version_string = /^\d+\.\d+\.\d+/
      Rack::Alive::VERSION.must_match valid_version_string
    end
  end

  describe "Middleware" do
    before do
      @app = lambda { |env| [200, {'Content-Type' => 'text/plain'}, ""] }
    end

    describe "Minimal setup: No custom conditions" do
      it 'should be alive' do
        request = Rack::MockRequest.env_for("/alive?")
        response = Rack::Alive.new(@app).call(request)
        status(response).must_equal 200
        body(response).must_equal "true"
      end
    end

    describe "Advanced setup: Using custom alive? conditions" do
      it 'should not be alive if block conditions are false' do
        request = Rack::MockRequest.env_for("/alive?")
        response = Rack::Alive.new(@app, proc {
          false
        }).call(request)
        status(response).must_equal 500
        body(response).must_equal "false"
      end

      it 'should not be alive if block conditions raise error' do
        request = Rack::MockRequest.env_for("/alive?")
        response = Rack::Alive.new(@app, proc {
          raise "SHIT - WHERE ARE ALL THE HORSES???!!! *drama-queen scream*"
        }).call(request)
        status(response).must_equal 500
        body(response).must_equal "false"
      end

      it 'should be alive if block conditions are true' do
        request = Rack::MockRequest.env_for("/alive?")
        response = Rack::Alive.new(@app, proc {
          true
        }).call(request)
        status(response).must_equal 200
        body(response).must_equal "true"
      end
    end
  end

  private

    def status(response)
      response[0]
    end

    def headers(response)
      response[1]
    end

    def body(response)
      response[2]
    end

end