# frozen_string_literal: true

require "spec_helper"

module Decidim
  module EventCalendar
    describe ExternalEvent do
      subject { event }

      let(:event) { build(:external_event) }

      it { is_expected.to be_valid }

      it "has an author" do
        expect(subject.author).to be_present
      end

      context "without title" do
        let(:event) { build(:external_event, title: nil) }

        it { is_expected.not_to be_valid }
      end

      context "when start_at is after start_at" do
        let(:event) { build(:external_event, start_at: Time.now, end_at: Time.now - 2.days) }

        it { is_expected.not_to be_valid }
      end
    end
  end
end
