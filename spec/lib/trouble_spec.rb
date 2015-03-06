require 'spec_helper'

TroubleTestException = Class.new(RuntimeError)

describe Trouble do

  let(:exception) { TroubleTestException.new('big problems') }
  let(:metadata)  { { details: 'mean bug'} }
  let(:logger)    { mock(:logger) }

  let(:trouble)   { Trouble }

  describe '.notify' do
    it 'does not cause any Exceptions if there is no Backend' do
      trouble.notify(exception, metadata)
    end

    context 'with a Logger' do
      before do
        trouble.config.logger = mock(:logger)
      end

      it 'logs the output' do
        trouble.config.logger.should_receive(:error) do |string|
          string.should include('TROUBLE')
          string.should include('TroubleTestException')
          string.should include('big problems')
          string.should include('mean bug')
          string.should include('trouble_spec.rb')
        end
        trouble.notify exception, metadata
      end
    end

    context 'with Bugsnag' do
      before do
        ensure_module :Bugsnag
        Bugsnag.stub!(:notify)
      end

      it 'uses Bugsnag as notification backend' do
        Bugsnag.should_receive(:notify).with(exception, metadata)
        trouble.notify exception, metadata
      end
    end
  end

  describe '.log' do

    it 'does not notify the error service' do
      Bugsnag.should_not_receive(:notify)
      trouble.log exception, metadata.merge(notify_error_service: false)
    end

    it 'increments the metric' do
      trouble.should_receive(:increment_metric)
      trouble.log exception, metadata.merge(notify_error_service: false)
    end

    it 'logs with the configured logger' do
      trouble.config.logger = logger
      trouble.config.logger.should_receive(:error)
      trouble.log exception, metadata.merge(notify_error_service: false)
    end
  end

  describe '.config' do
    before do
      Trouble.reset!
    end

    it 'is an STDOUT logger' do
      Logger.should_receive(:new).with(STDOUT).and_return logger
      trouble.config.logger.should be logger
    end

    context 'with Rails' do
      before do
        ensure_module :Rails
        Rails.stub!(:logger).and_return(logger)
      end

      it 'is the Rails logger' do
        trouble.config.logger.should be Rails.logger
      end
    end
  end

end
