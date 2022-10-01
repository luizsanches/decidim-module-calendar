# frozen_string_literal: true

module Decidim
  module EventCalendar
    class OrganizationCalendar < Decidim::Query
      def initialize(organization)
        @organization = organization
      end

      def query
        Decidim::Assembly.where(organization: @organization)
      end
    end
  end
end
