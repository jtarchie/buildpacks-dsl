module Buildpack::DSL::Recipes
  recipe :ruby do
    detect do |build_dir|
      !which('ruby').empty?
    end

    compile { puts 'You have Ruby installed on the rootfs' }
  end
end

