require 'fileutils'

module Buildpack::DSL::Recipes
  recipe :ruby do
    detect do |build_dir|
      Dir.chdir(build_dir) do
        File.exist?('Gemfile') && File.read('Gemfile').include?('ruby')
      end
    end

    compile do |build_dir|
      gem_file_path = File.join(build_dir, 'Gemfile')
      contents = File.read(gem_file_path)
      instance_eval(contents, gem_file_path.to_s, 1)

      download "https://pivotal-buildpacks.s3.amazonaws.com/ruby/binaries/cflinuxfs2/ruby-#{@ruby_version}.tgz",
        :to => "#{build_dir}/vendor/ruby"

      ENV['PATH'] = "#{build_dir}/vendor/ruby/bin:#{ENV['PATH']}"
      set_env PATH: '$HOME/vendor/ruby/bin:$PATH'
    end

    def ruby(ruby_version, *args)
      @ruby_version = ruby_version
    end

    # Reference: https://github.com/bundler/bundler/blob/4555248659223a5d52fef989c0c696ffac4d60ab/bin/bundle_ruby
    def source(*); end
    def gem(*);    end
    def group(*);  end
  end
end

