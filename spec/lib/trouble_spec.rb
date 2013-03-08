require 'spec_helper'

TroubleTestException = Class.new(RuntimeError)

describe Trouble do

  let(:exception) { TroubleTestException.new('big problems') }
  let(:metadata)  { { details: 'mean bug'} }

  let(:trouble)   { Trouble }

  describe '.notify' do
    it 'logs the output' do
      trouble.logger.should_receive(:<<) do |string|
        string.should include('TROUBLE')
        string.should include('TroubleTestException')
        string.should include('big problems')
        string.should include('mean bug')
        string.should include('trouble_spec.rb')
      end
      trouble.notify exception, metadata
    end
  end

  context 'without backend' do
    describe '.notify' do
      it 'does not fail' do
        trouble.notify exception, metadata
      end
    end
  end

  context 'with Bugsnag as backend' do
    before do
      ensure_module :Bugsnag
      Bugsnag.stub!(:notify)
    end

    describe '.notify' do
      it 'uses Bugsnag as notification backend' do
        Bugsnag.should_receive(:notify).with(exception, metadata)
        trouble.notify exception, metadata
      end
    end

  end
end