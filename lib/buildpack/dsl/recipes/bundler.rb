module Buildpack::DSL::Recipes
  recipe :bundler do
    requires :rubygem

    detect do |build_dir|
      File.exist? File.join(build_dir, 'Gemfile')
    end

    compile do |build_dir|
      Dir.chdir(build_dir) do
        run('gem install bundler --no-ri --no-rdoc')
        run('bundle install -j4 --deployment --without development:test --path vendor/bundle --binstubs vendor/bundle/bin')
      end
    end
  end
end
