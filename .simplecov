# frozen_string_literal: true

SimpleCov.start do
  root ENV["ENGINE_ROOT"]

  add_filter "lib/decidim/event_calendar/version.rb"
  add_filter "/spec"
end

SimpleCov.command_name ENV["COMMAND_NAME"] || File.basename(Dir.pwd)

SimpleCov.merge_timeout 1800

if ENV["CI"]
  require "simplecov-cobertura"
  SimpleCov.formatter = SimpleCov::Formatter::CoberturaFormatter
end
