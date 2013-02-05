require 'spec_helper'

describe RuntimeerrorNotifier::Notifier do
  context '#for' do
    subject { RuntimeerrorNotifier::Notifier::RECIPIENTS }

    context 'no recipients' do
      before { RuntimeerrorNotifier::Notifier.for }
      it { should == [] }
    end

    context 'single email' do
      let(:email) { Faker::Internet.free_email }
      before { RuntimeerrorNotifier::Notifier.for(email) }
      after { RuntimeerrorNotifier::Notifier::RECIPIENTS = [] }
      it { should == [email] }
    end

    context 'multiple emails' do
      let(:bob_email) { Faker::Internet.email('bob') }
      let(:rob_email) { Faker::Internet.email('rob') }
      let(:dob_email) { Faker::Internet.email('dob') }
      before { RuntimeerrorNotifier::Notifier.for(bob_email, rob_email, dob_email) }
      after { RuntimeerrorNotifier::Notifier::RECIPIENTS = [] }
      it { should == [bob_email, rob_email, dob_email] }
    end

    context 'duplicate emails' do
      let(:bob_email) { Faker::Internet.email('bob') }
      let(:rob_email) { Faker::Internet.email('rob') }
      let(:dob_email) { Faker::Internet.email('dob') }
      before { RuntimeerrorNotifier::Notifier.for(bob_email, rob_email, dob_email, rob_email) }
      after { RuntimeerrorNotifier::Notifier::RECIPIENTS = [] }
      it { should == [bob_email, rob_email, dob_email] }
    end
  end

  context '#notification' do
    subject { RuntimeerrorNotifier::Notifier.notification(env, excp, opts) }
    let(:env) { { env: 'env' } }
    let(:opts) { {} }

    context 'original exception' do
      let(:excp) { Exception.new }
      let(:original_excp) { double('original exception') }

      before do
        excp.stub(:original_exception) { original_excp }
        original_excp.stub(:backtrace)
        original_excp.stub(:message)
        HTTParty.should_receive(:post)
      end

      it { expect { subject }.to_not raise_error }
    end

    context 'continued exception' do
      let(:excp) { Exception.new }
      let(:continued_excp) { double('continued exception') }

      before do
        excp.stub(:continued_exception) { continued_excp }
        continued_excp.stub(:backtrace)
        continued_excp.stub(:message)
        HTTParty.should_receive(:post)
      end

      it { expect { subject }.to_not raise_error }
    end

    context 'normal exception' do
      let(:excp) { Exception.new }

      before do
        HTTParty.should_receive(:post)
      end

      it { expect { subject }.to_not raise_error }
    end

    context 'ignored exception' do
      let(:excp) { Exception.new }

      before do
        RuntimeerrorNotifier::Notifier::IGNORED_EXCEPTIONS.push excp.class.name
        HTTParty.should_not_receive(:post)
      end

      it { expect { subject }.to_not raise_error }
    end
  end
end
