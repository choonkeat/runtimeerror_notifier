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
end
