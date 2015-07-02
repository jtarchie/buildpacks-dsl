module Buildpack::DSL::Recipes
  recipe :bundler do
    requires :rubygem

    detect { File.exist? 'Gemfile' }

    compile do
      run('gem install bundler')
      run('bundle install -j4 --without development:test --path vendor/bundle --binstubs vendor/bundle/bin')
    end
  end
end
