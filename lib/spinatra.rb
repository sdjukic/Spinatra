# Sinatra scaffolding gem
require 'thor'
require 'fileutils'
#require 'yaml'


class Spinatra < Thor 
  

  desc "new APP_NAME",  "Creates scaffold for modular Sinatra application."
  def new(name)
  	
    data = {"project_directories" => ["#{name.capitalize}",
                  "#{name.capitalize}/public",
                  "#{name.capitalize}/public/images",
                  "#{name.capitalize}/public/javascripts",
                  "#{name.capitalize}/public/stylesheets",
                  "#{name.capitalize}/views"], 
    
    "files" =>  ["#{name.capitalize}.rb",
                 "Gemfile",
                 "README.md",
                 "config.ru"],

    "#{name.capitalize}" => ["$:.unshift File.expand_path('../lib', __FILE__)\n",
                    "require 'sinatra/base'\n",
                    "\nclass #{name.capitalize} < Sinatra:Base\n",
                    "\nend"],

    "Gemfile" => ["source 'https://rubygems.org'\n",
               "\ngem 'sinatra'",
               "\ngem 'rubocop'",
               "\ngem 'puma'\n",
               "\ngroup :test do",
               "\n  gem 'rack-test'",
               "\n  gem 'rspec'",
               "\nend"],

    "README.md" => ["## #{name.capitalize}"],

    "config.ru" => ["require './#{name.capitalize}'\n",
                    "\nrun #{name.capitalize}.new"]}

    #data = YAML.load_file(CONF_FILE)

   
    data["project_directories"].each do |dir| 
      unless File.directory?(dir)
        FileUtils.mkdir(dir) 
      end
    end
    
    FileUtils.cd("#{name.capitalize}")
    
    data['files'].each do |f|
      unless File.exist?(f)
        source_file = File.new("#{f}", 'w')
        if data["#{f}"]
          data["#{f}"].each { |line| source_file.write line }
        end  
      end
    end
  end

end

