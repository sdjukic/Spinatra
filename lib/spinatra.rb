# Sinatra scaffolding gem
require 'thor'
require 'fileutils'
require 'yaml'

CONF_FILE = 'config/core.yaml'

class Spinatra < Thor 
  

  desc "new APP_NAME",  "Creates scaffold for modular Sinatra application."
  def new(name)
  	
   data = YAML.load_file(CONF_FILE)


    data["project_directories"].each { |dir| FileUtils.mkdir dir }
    
    FileUtils.cd("#{name.capitalize}")
    
    data['files'].each do |f|
      source_file = File.new("#{f}", 'w')
      case f
        when "#{name.capitalize}.rb" then
          data['main_file'].each { |line| source_file.write line }
        when "config.ru"
           data['config_ru'].each { |line| source_file.write line}
        when "Gemfile"
        	data['gems'].each { |line| source_file.write line}
        when "README.md"
        	data['readme'].each { |line| source_file.write line}
      end
    end  
    
  end

end

