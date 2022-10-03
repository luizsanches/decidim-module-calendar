# frozen_string_literal: true

require "rails"
require "decidim/core"
require "active_support/all"

module Decidim
  module EventCalendar
    class Engine < ::Rails::Engine
      isolate_namespace Decidim::EventCalendar

      routes do
        namespace :calendar do
          get "/", action: :index, as: :index
          get "/events", action: :events, as: :events
          get "/gantt", action: :gantt, as: :gantt
          get "/gantt/tasks", action: :gantt_tasks, as: :gantt_tasks
          get "/ical", action: :ical, as: :ical
        end
      end

      initializer "decidim_calendar.menu" do
        Decidim.menu :menu do |menu|
          menu.add_item :event_calendar,
                        I18n.t("menu.calendar", scope: "decidim.event_calendar"),
                        decidim_calendar.calendar_index_path,
                        position: 6.0,
                        active: :inclusive
        end
      end

      initializer "decidim_calendar.webpacker.assets_path" do
        Decidim.register_assets_path File.expand_path("app/packs", root)
      end
    end

    def self.all
      []
    end

    def self.table_name
      "calendars"
    end
  end
end
