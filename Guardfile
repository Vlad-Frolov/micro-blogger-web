# frozen_string_literal: true

# A sample Guardfile
# More info at https://github.com/guard/guard#readme

## Uncomment and set this to only include directories you want to watch
# directories %w(app lib config test spec features) \
#  .select{|d| Dir.exists?(d) ? d : UI.warning("Directory #{d} does not exist")}

## Note: if you are using the `directories` clause above and you are not
## watching the project directory ('.'), then you will want to move
## the Guardfile to a watched dir and symlink it back, e.g.
#
#  $ mkdir config
#  $ mv Guardfile config/
#  $ ln -s config/Guardfile .
#
# and, you'll have to watch "config/Guardfile" instead of "Guardfile"

@modified_times ||= {}
def check_time file
  mtime = File.mtime(file)

  return if @modified_times[file] == mtime

  @modified_times[file] = mtime
  yield file
end

guard :minitest, spring: "bin/rails test", all_after_pass: true do
  watch(%r{^app/(.+)\.rb$}) { |m| ["test/#{m[1]}", "test/#{m[1]}_test.rb"] }
  watch(%r{^app/controllers/(admin|application)_controller\.rb$}) { 'test/controllers' }
  watch(%r{^app/controllers/(.+)_controller\.rb$}) { |m| "test/integration/#{m[1]}_test.rb" }
  watch(%r{^app/views/(.+)_mailer/.+}) { |m| "test/mailers/#{m[1]}_mailer_test.rb" }
  watch(%r{^lib/(.+)\.rb$}) { |m| "test/lib/#{m[1]}_test.rb" }
  watch(%r{^test/test_helper\.rb$}) { 'test' }
  watch(%r{^test/.+_test\.rb$})

  # run controller/integration test when touching the router, jbuilder, or erb files
  watch(%r{^app/views/((?!_mailer).)*([^/]+)\.erb$}) { ["test/controllers", "test/integration"] }
  watch(%r{^app/views/((?!_mailer).)*([^/]+)\.jbuilder$}) { ["test/controllers", "test/integration"] }
  watch(%r{^config/routes.rb}) { ["test/controllers", "test/integration"] }

  # run mailers/integration test when touching mailer erb files
  watch(%r{^app/views/(.*_mailer/)?([^/]+)\.erb$}) { ["test/mailers", "test/integration"] }
end

guard :rubocop, cli: %w[-DSa] do
  watch(/.rubocop.yml/)
  watch(/.+\.rb$/)
  watch(/Rakefile/)
  watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
end

guard :shell, all_on_start: true do
  # ESLint
  # watch %r{app/assets/javascripts/*/.*} do |file|
  #   system %(echo "ESLint:\033[32m #{file[0]}\033[0m")
  #   system %(./node_modules/eslint/bin/eslint.js #{file[0]})
  # end

  # sass-lint
  watch %r{app/assets/stylesheets/*/.*scss$} do |match|
    check_time(match[0]) do |file|
      system %(echo "sass-lint:\033[32m #{file}\033[0m")
      system %(sass-lint --cache --config .sass-lint.yml '#{file}' --verbose --no-exit)
    end
  end
end

# guard 'brakeman', run_on_start: true, quiet: true do
#   ## Lets not watch files for brakeman, just scan on guard start, and full runs.
#   #
#   # watch(%r{^app/.+\.(erb|haml|rhtml|rb)$})
#   # watch(%r{^config/.+\.rb$})
#   # watch(%r{^lib/.+\.rb$})
#   # watch('Gemfile')
# end

guard 'spring', bundler: true do
  watch('Gemfile.lock')
  watch(%r{^config/})
  watch(%r{^spec/(support|factories)/})
  watch(%r{^spec/factory.rb})
end
