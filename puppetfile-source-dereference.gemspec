$:.unshift File.expand_path("../lib", __FILE__)
require 'date'
require 'puppetfile-source-dereference/version'

Gem::Specification.new do |s|
  s.name              = "puppetfile-source-dereference"
  s.version           = PuppetfileSourceDereference::VERSION
  s.date              = Date.today.to_s
  s.summary           = "Replaces forge references in a Puppetfile with the git source."
  s.homepage          = "https://github.com/overlookinfra/puppetfile-source-dereference/"
  s.email             = "binford2k@overlookinfratech.com"
  s.authors           = ["Ben Ford"]
  s.license           = "GPL-3.0"
  s.require_path      = "lib"
  s.executables       = %w( puppetfile-source-dereference )
  s.files             = %w( README.md LICENSE )
  s.files            += Dir.glob("lib/**/*")
  s.files            += Dir.glob("bin/**/*")
  s.add_dependency      'puppetfile-resolver', '~> 0.5.0'

  s.description       = <<-desc
    This will replace all Forge entries in a Puppetfile with git sources if the
    pubished module has `source` defined.
  desc
end
