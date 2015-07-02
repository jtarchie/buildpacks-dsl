module Buildpack::DSL::Recipes
  recipe :rubygem do
    requires :ruby

    def ruby_version
      '1.9.1'
    end

    detect do |build_dir|
      File.exist?(File.join(build_dir, 'Gemfile')) && !which('gem').empty?
    end

    compile do |build_dir|
      ENV['GEM_PATH'] = "#{build_dir}/vendor/bundle/ruby/#{ruby_version}"
      ENV['GEM_HOME'] = "#{build_dir}/vendor/bundle/ruby/#{ruby_version}"
      ENV['PATH'] = [
        "#{build_dir}/bin",
        "#{build_dir}/vendor/bundle/bin",
        "#{build_dir}/vendor/bundle/ruby/#{ruby_version}/bin",
        ENV['PATH']
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
