require 'spec_helper'

describe RuntimeerrorNotifier::Tracker do
  context '#call' do
    subject       { tracker.call(env) }
    let(:app)     { double('app') }
    let(:opts)    { {opt: 'opt'} }
    let(:env)     { {env: 'env'} }
    let(:tracker) { RuntimeerrorNotifier::Tracker.new(app, opts)}

    context 'when there are no exceptions' do
      before do
        app.should_receive(:call).with(env)
      end

      it 'should call app with the environment variables' do
        subject
      end
    end

    context 'when there are exceptions' do
      let(:excp) { Exception.new('spec exception') }

      before do
        app.should_receive(:call).with(env).and_raise(excp)
        RuntimeerrorNotifier::Notifier.should_receive(:notification).with(env, excp, opts)
      end

      it 'should call notification with the exception and environment variables' do
        expect { subject }.to raise_error(excp)
      end
    end
  end
end
