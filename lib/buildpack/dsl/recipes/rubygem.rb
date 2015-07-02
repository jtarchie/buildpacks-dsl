module Buildpack::DSL::Recipes
  recipe :rubygem do
    requires :ruby

    detect do |build_path|
      File.exist?(File.join(build_path, 'Gemfile')) && !which('gem').empty?
    end

    compile do |build_path|
      ENV['GEM_PATH'] = "#{build_path}/vendor/bundle/ruby/#{ruby_version}"
      ENV['GEM_HOME'] = "#{build_path}/vendor/bundle/ruby/#{ruby_version}"
      set_env PATH: [
        "#{build_dir}/bin",
        "#{build_dir}/vendor/bundle/bin",
        "#{build_dir}/vendor/bundle/ruby/#{ruby_version}/bin",
        '$PATH'
      ].join(':')

      set_env GEM_PATH: "$HOME/vendor/bundle/ruby/#{ruby_version}:$GEM_PATH"
      set_env PATH: [
        '$HOME/bin',
        '$HOME/vendor/bundle/bin',
        "$HOME/vendor/bundle/ruby/#{ruby_version}/bin",
        '$PATH'
      ].join(':')
    end
  end
end
