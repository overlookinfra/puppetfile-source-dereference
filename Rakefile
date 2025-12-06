task :default do
  system("rake -T")
end

desc 'Update the Forge->Source module mappings'
task :update do
  require 'puppet_forge'
  require 'yaml'

  PuppetForge.user_agent = "PuppetfileSourceDereferencer/1.0.0"

  data = {}
  PuppetForge::Module.all.unpaginated.each do |mod|
    data[mod.slug] = mod.releases.first.metadata[:source]
  end

  File.write('data/cache.yaml', data.to_yaml)
end

