require 'puppetfile-source-dereference'
require "puppetfile-resolver"
require "puppetfile-resolver/puppetfile/parser/r10k_eval"
require 'puppet_forge'
require 'yaml'
require 'open-uri'

class PuppetfileSourceDereference
  attr_accessor :source, :output, :dryrun, :mapping

  def initialize(options = {})
    [:source, :output, :dryrun, :mapping,].each do |key|
      send("#{key}=", options[key])
    end

    @output = File.open(@output, 'w+') if @output.is_a? String
  end

  def resolve
    puppetfile = PuppetfileResolver::Puppetfile::Parser::R10KEval.parse(File.read(@source))
    mapping    = YAML.load(URI.open(@mapping).read)

    unless puppetfile.valid?
      logger.error("Puppetfile source is not valid")
      puppetfile.validation_errors.each { |err| logger.error(err) }
      return false
    end

    File.open(@output, 'w') do |output|
      puppetfile.modules.each do |mod|
        if mod.module_type == :git
          output.write <<~EOF
            mod '#{mod.title}',
              :git => '#{mod.remote}',
              :ref => '#{mod.ref}'
          EOF
        elsif mapping.include? mod.title
          source = mapping[mod.title]

          if mod.version.is_a? String
            output.write <<~EOF
              mod '#{mod.title}',
                :git => '#{source}',
                :ref => '#{mod.version.delete_prefix('=')}'  # check the source repo and fix this ref
            EOF
          else
            output.write <<~EOF
            mod '#{mod.title}',
              :git => '#{source}'
            EOF
          end
        else
          output.write "mod '#{mod.title}', #{version}  # unmapped entry!\n"
        end
      end
    end
  end

end
