# frozen_string_literal: true

module Decidim
  module EventCalendar
    module Event
      @models = [
        Decidim::Meetings::Meeting.joins(:component)
                                  .where.not('decidim_components.published_at': nil)
                                  .published.where(private_meeting: false),
        Decidim::ParticipatoryProcessStep.joins(:participatory_process)
                                         .where.not('decidim_participatory_processes.published_at': nil),
        Decidim::Debates::Debate.joins(:component)
                                .where.not('decidim_components.published_at': nil),
        Decidim::EventCalendar::ExternalEvent
      ]

      @models = @models << Decidim::Consultation if defined? Decidim::Consultation

      def self.all(current_organization)
        events = []
        @models.collect do |model|
          model
            .all
            .map { |obj| events << present(obj) if obj.organization == current_organization && present(obj).start }
        end
        events
      end

      def self.present(obj)
        Decidim::EventCalendar::EventPresenter.new(obj)
      end

      def self.calendar(event)
        subtitle = translated_attribute(event.subtitle) unless event.subtitle.empty?
        title = translated_attribute(event.full_title)
        title = "#{title} - #{subtitle}" unless subtitle.blank?

        {
          title: title,
          start: (event.start.strftime("%FT%R") unless event.start.nil?),
          end: finish_date(event),
          color: event.color,
          url: event.link,
          resourceId: event.type,
          allDay: event.all_day?,
          subtitle: subtitle,
          description: translated_attribute(event.description)
        }.compact
      end

      def self.finish_date(event)
        finish = event.finish

        return if finish.nil?

        finish += 1.day if event.all_day?

        finish.strftime("%FT%R")
      end

      def self.gantt(event)
        {
          id: event.full_id,
          text: "#{translated_attribute(event.full_title)} - #{translated_attribute(event.subtitle)}",
          start: "#{event.start.strftime("%F")}T23:00".to_datetime,
          end: "#{event.finish.strftime("%F")}T23:00".to_datetime,
          parent: event.parent,
          percent: progress_gantt(event),
          links: [{
            target: event.target,
            type: "FS"
          }]
        }
      end

      def self.progress_gantt(event)
        today = Date.today
        start_date = event.start_date
        end_date = event.end_date

        return 0 if today < start_date
        return 0.9 if today == end_date
        return 1 if today > end_date

        total_days = (end_date - start_date).to_f
        days_performed = (today - start_date).to_f
        (days_performed / total_days).to_f.round(2)
      end

      # TODO: Reuse from decidim-core/lib/decidim/translatable_attributes.rb
      def self.translated_attribute(attribute, given_organization = nil)
        return "" if attribute.nil?
        return attribute unless attribute.is_a?(Hash)

        attribute = attribute.dup.stringify_keys
        given_organization ||= try(:current_organization)
        given_organization ||= try(:organization)
        organization_locale = given_organization.try(:default_locale)

        attribute[I18n.locale.to_s].presence ||
          machine_translation_value(attribute, given_organization) ||
          attribute[organization_locale].presence ||
          attribute[attribute.keys.first].presence ||
          ""
      end

      def self.machine_translation_value(attribute, organization)
        return unless organization
        return unless organization.enable_machine_translations?

        attribute.dig("machine_translations", I18n.locale.to_s).presence if must_render_translation?(organization)
      end
    end
  end
end
