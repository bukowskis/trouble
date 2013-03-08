module Trouble
  extend self

  def notify(exception, metadata = nil)
    exception.set_backtrace(caller) unless exception.backtrace
    notify! exception, metadata
  end

  # Takes anything that responds to "<<". Usually an IO object (via File.open), or a Logger.new instance.
  #
  def logger=(object)
    @logger = object
  end

  def logger
    @logger
  end

  private

  def notify!(exception, metadata)
    log(exception, metadata)            if logger
    Bugsnag.notify(exception, metadata) if defined?(Bugsnag)
  end

  def log(exception, metadata)
    rows = ['TROUBLE NOTIFICATION']
    rows << "   | Exception: #{exception.inspect}"
    rows << "   | Metadata:  #{metadata.inspect}"
    rows << "   \\ Location:  #{exception.backtrace.first}\n"
    logger << rows.join("\n")
  end

end
