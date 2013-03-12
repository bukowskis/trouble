require 'trouble/configuration'

# A generic wrapper to report errors and Exceptions.
#
module Trouble

  # Public: Notify the developers about an Exception
  #
  # exception - An instance of an Exception
  # metadata - An Hash with arbitrary additional information (optional)
  #
  # Examples
  #
  #   Trouble.notify RuntimeError.new
  #   Trouble.notify RuntimeError.new, some_idea_why_it_happened: "I don't know, but try this and that."
  #
  # Returns nothing.
  #
  def self.notify(exception, metadata = nil)
    exception.set_backtrace(caller) unless exception.backtrace
    notify! exception, metadata
  end

  private

  # Internal: Dispatch the Exception to the backend(s).
  #
  def self.notify!(exception, metadata)
    log(exception, metadata)            if config.logger
    Bugsnag.notify(exception, metadata) if defined?(Bugsnag)
  end

  # Internal: Log to the current Logger.
  #
  def self.log(exception, metadata)
    rows = ['TROUBLE NOTIFICATION']
    rows << "   | Exception: #{exception.inspect}"
    rows << "   | Metadata:  #{metadata.inspect}"
    rows << "   \\ Location:  #{exception.backtrace.first}\n"
    config.logger.error rows.join("\n")
  end

end
