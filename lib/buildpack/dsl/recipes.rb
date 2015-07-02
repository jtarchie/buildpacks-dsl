require 'fileutils'

module Buildpack
  module DSL
    module Recipes
      Recipe = Struct.new(:name) do
        def which(command)
          `which #{command}`
        end

        def run(command)
          puts `#{command}`
        end

        def set_env(env = {})
          @environment ||= {}
          @environment.merge!(env)
        end

        def detect(&block)
          @detect = block
        end

        def detect?(build_dir)
          instance_exec build_dir, &@detect
        end

        def compile(&block)
          @compile = block
        end

        def compile!(build_dir)
          instance_exec build_dir, &@compile
          write_env build_dir
        end

        def requires(*names)
          @dependencies ||= []
          @dependencies += names
        end

        def dependencies
          @dependencies || []
        end

        private

        def write_env(build_dir)
          return unless @environment

          Dir.chdir(build_dir) do
            FileUtils.mkdir_p('.profile.d')
            File.write('.profile.d/000_setup.sh', @environment.collect do |key, value|
              "export #{key}=#{value}"
            end.join("\n"))
          end
        end
      end

      def self.recipe(name, &block)
        recipe = Recipe.new(name)
        recipe.instance_eval &block
        @recipes ||= []
        @recipes << recipe
        recipe
      end

      def self.all
        @recipes ||= []
      end
    end
  end
end

Dir[File.join(File.dirname(__FILE__), 'recipes', '**', '*.rb')].each do |recipe|
  require recipe
end
