require 'trouble/configuration'
require 'trouble/middleware'

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
    notify_error_service(exception, metadata)
    log_in_logger(exception, metadata)
    increment_metric
  end

  # Public: Log the error in the logger and track as metric.
  #
  # exception - An instance of an Exception
  # metadata - An Hash with arbitrary additional information (optional)
  #
  # Examples
  #
  #   Trouble.log RuntimeError.new
  #   Trouble.log RuntimeError.new, some_idea_why_it_happened: "I don't know, but try this and that."
  #
  # Returns nothing.
  #
  def self.log(exception, metadata = nil)
    exception.set_backtrace(caller) unless exception.backtrace
    log_in_logger(exception, metadata)
    increment_metric
  end

  private

  # Internal: Dispatch the Exception to the backend(s).
  #
  def self.notify_error_service(exception, metadata)
    return unless defined? Bugsnag
    Bugsnag.notify(exception) do |report|
      report.metadata = metadata
    end
  end

  # Internal: track exceptions metric
  #
  def self.increment_metric
    Meter.increment('exceptions') if defined?(Meter)
  end

  # Internal: Log to the current Logger.
  #
  def self.log_in_logger(exception, metadata)
    config.logger.error("TROUBLE LOG #{exception.inspect} at #{exception.backtrace.first} with metadata #{metadata.inspect}") if config.logger
  end

end
