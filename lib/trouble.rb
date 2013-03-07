require 'bugsnag'

module Trouble
  extend self

  def notify(exception, metadata = nil)
    exception.set_backtrace(caller) unless exception.backtrace
    notify! exception, metadat
  end

  private

  def notify!
    if defined?(Bugsnag)
      Bugsnag.notify(exception, metadata)
    end
  end

end
