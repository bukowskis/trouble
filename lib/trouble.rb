module Trouble
  extend self

  def notify(exception, metadata = nil)
    exception.set_backtrace(caller) unless exception.backtrace
    notify! exception, metadata
  end

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
    log! rows.join("\n")
  end

  def log!(string)
    if logger.respond_to?(:<<)
      logger << string
    elsif logger.respond_to?(:write)
      logger.write string
    elseif logger.respond_to?(:error)
      logger.error string
    end
  end

end
