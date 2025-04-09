# frozen_string_literal: true

require "decidim/dev/common_rake"

def install_module(path)
  Dir.chdir(path) do
    system("bundle exec rake decidim_calendar:install:migrations")
    system("bundle exec rake db:migrate")
  end
end

def override_webpacker_config_files(path)
  Dir.chdir(path) do
    system("bundle exec rake decidim_calendar:webpacker:install")
  end
end

def seed_db(path)
  Dir.chdir(path) do
    system("bundle exec rake db:seed")
  end
end

def change_test_cache_classes(path)
  test_config_path = "#{path}/config/environments/test.rb"
  text = File.read(test_config_path)
  new_contents = text.gsub(/config.cache_classes = true/, "config.cache_classes = false")
  File.open(test_config_path, "w") { |file| file << new_contents }
end

def recreate_db_without_assets_precompile(path)
  soft_rails_commands = %w(db:environment:set db:drop)
  rails_commands = %w(db:create db:migrate db:test:prepare)

  Dir.chdir(path) do
    soft_rails_commands.each { |command| system("bin/rails", command, err: File::NULL) }
    rails_commands.each { |command| abort unless system("bin/rails", command) }
  end
end

desc "Generates a dummy app for testing"
task :test_app do
  ENV["RAILS_ENV"] = "test"
  test_app_path = "spec/decidim_dummy_app"

  generate_decidim_app(
    test_app_path,
    "--app_name",
    "#{base_app_name}_test_app",
    "--path",
    ".",
    "--skip_gemfile",
    "--skip_spring",
    "--demo",
    "--force_ssl",
    "false",
    "--locales",
    "en,ca,es"
  )

  change_test_cache_classes(test_app_path)
  recreate_db_without_assets_precompile(test_app_path)
  install_module(test_app_path)
  override_webpacker_config_files(test_app_path)
end

desc "Generates a development app"
task :development_app do
  Bundler.with_original_env do
    generate_decidim_app(
      "development_app",
      "--app_name",
      "#{base_app_name}_development_app",
      "--path",
      "..",
      "--recreate_db",
      "--demo"
    )
  end

  install_module("development_app")
  seed_db("development_app")
  override_webpacker_config_files("development_app")
end

# Run both by default
task default: [:spec]
