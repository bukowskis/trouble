require 'bugsnag'

module Bukowskis
  module Trouble
    extend self

    def notify(exception, metadata = nil)
      exception.set_backtrace(caller) unless exception.backtrace
      Bugsnag.notify(exception, metadata)
    end

  end
end
