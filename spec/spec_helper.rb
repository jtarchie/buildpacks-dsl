$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'buildpack/dsl'

RSpec.configure do
  def run(cmd)
    `docker exec test-buildpack bash -c '#{cmd}'`.tap do |output|
      puts output if ENV['DEBUG']
    end
  end

  def bprun(cmd)
    run "source /tmp/fixtures/ruby/.profile.d/*.sh && #{cmd}"
  end

  def compile_buildpack(fixture_name)
    %x{
      docker rm -f test-buildpack || true
      docker run -dit \
        --name test-buildpack \
        -v `pwd`:/buildpack:ro \
        -w /buildpack \
        -e HOME="/tmp/fixtures/#{fixture_name}" \
        -u www-data \
        cloudfoundry/cflinuxfs2 bash
    }
    run('cp -R /buildpack/spec/fixtures /tmp/fixtures')
    @output = run("/buildpack/bin/compile /tmp/fixtures/#{fixture_name} /tmp/cache")
  end
end
