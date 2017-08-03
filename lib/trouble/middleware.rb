module Trouble
  class Middleware

    def initialize(app)
      @app = app
    end

    def call(env)
      # calling env.dup here prevents bad things from happening
     request = Rack::Request.new(env.dup)
     # calling request.params is sufficient to trigger the "invalid %-encoding" error
     # see https://github.com/rack/rack/issues/337#issuecomment-46453404
     request.params
     @app.call(env)

    rescue ArgumentError => exception
      raise unless exception.message.include?('invalid %-encoding')
      return [400, {}, ['']]

    rescue ActionController::BadRequest
      return [400, {}, ['']]

    rescue => exception
      ::Trouble.config.logger.fatal [$!.class, $!.message, $!.backtrace[2..5]].join("\n")
      ::Trouble.notify exception
      raise
    end

  end
end
