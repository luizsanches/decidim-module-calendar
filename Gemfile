# frozen_string_literal: true

source "https://rubygems.org"

ruby RUBY_VERSION

DECIDIM_VERSION = "0.27.1"

gem "decidim", DECIDIM_VERSION
gem "decidim-calendar", path: "."
gem "decidim-consultations", DECIDIM_VERSION

gem "puma", ">= 5.5"
gem "uglifier", "~> 4.1"

group :development, :test do
  gem "bootsnap"
  gem "byebug", "~> 11.0", platform: :mri

  gem "decidim-dev", DECIDIM_VERSION
end

group :development do
  gem "faker", "~> 2.19"
  gem "letter_opener_web", "~> 1.3"
  gem "listen", "~> 3.1"
  gem "spring", "~> 2.0"
  gem "spring-watcher-listen", "~> 2.0"
  gem "sqlite3"
  gem "web-console", "~> 3.5"
end

group :test do
  gem "simplecov", require: false
  gem "simplecov-cobertura", require: false
end
