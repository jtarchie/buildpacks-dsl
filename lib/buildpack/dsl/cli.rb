require 'thor'
require 'buildpack/dsl'

module Buildpack
  module DSL
    class CLI < Thor
      desc 'detect BUILD_DIR', 'detect buildpacks to use on app'
      def detect(build_dir)
        found_recipes = Recipes.all.select{|r| r.detect? build_dir }
        if found_recipes.empty?
          exit 1
        else
          puts "Found Recipes: #{found_recipes.collect(&:name).join(', ')}"
          exit 0
        end
      end
    end
  end
end
