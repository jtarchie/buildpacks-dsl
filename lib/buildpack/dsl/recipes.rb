module Buildpack
  module DSL
    module Recipes
      BlockWrapper = Struct.new(:block) do
        def which(command)
          `which #{command}`
        end

        def call(*args)
          instance_exec *args, &block
        end
      end

      Recipe = Struct.new(:name) do
        def detect(&block)
          @detect = BlockWrapper.new block
        end

        def detect?(build_dir)
          @detect.call(build_dir)
        end

        def compile(&block)
          @compile = BlockWrapper.new block
        end

        def requires(*names)
        end
      end

      def self.recipe(name, &block)
        recipe = Class.new(Recipe).new(name)
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
