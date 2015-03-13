# Sinatra scaffolding gem
require 'thor'
require 'fileutils'
#require 'yaml'


class Spinatra < Thor 
  

  desc "new APP_NAME",  "Creates scaffold for modular Sinatra application."
  def new(name)
  	
    data = {
      "project_directories" => ["#{name.capitalize}",
                                "#{name.capitalize}/public",
                                "#{name.capitalize}/public/images",
                                "#{name.capitalize}/public/javascripts",
                                "#{name.capitalize}/public/stylesheets",
                                "#{name.capitalize}/views"], 
    
      "files" =>  ["#{name.capitalize}.rb",
                   "Gemfile",
                   "README.md",
                   "config.ru",
                   "views/layout.slim"],

      "#{name.capitalize}.rb" => ["$:.unshift File.expand_path('../lib', __FILE__)\n",
                                  "\nrequire 'sinatra/base'\n",
                                  "require 'slim'\n",
                                  "\nclass #{name.capitalize} < Sinatra:Base\n",
                                  "\nend"],

      "Gemfile" => ["source 'https://rubygems.org'\n",
                    "\ngem 'sinatra'",
                    "\ngem 'rubocop'",
                    "\ngem 'slim'",
                    "\ngem 'puma'\n",
                    "\ngroup :test do",
                    "\n  gem 'rack-test'",
                    "\n  gem 'rspec'",
                    "\nend"],

      "README.md" => ["## #{name.capitalize}"],

      "config.ru" => ["require './#{name.capitalize}'\n",
                      "\nrun #{name.capitalize}.new"],

      "views/layout.slim" => ["doctype html\n",
                              "html\n",
                              "\nhead\n",
                              "    title #{name.capitalize} App\n",
                              "\nbody",
                              "\n    == yield"]
  }

    #data = YAML.load_file(CONF_FILE)

   
    data["project_directories"].each do |dir| 
      unless File.directory?(dir)
        puts "Creating directory \e[32m #{dir} \e[0m" if FileUtils.mkdir(dir) 
      else
        puts "Skipped creating \e[31m #{dir} \e[0m"
      end
    end
    
    FileUtils.cd("#{name.capitalize}")
    
    data['files'].each do |f|
      unless File.exist?(f)
        source_file = File.new("#{f}", 'w')
        if source_file
          puts "Creating file \e[32m #{f} \e[0m"   
        end
        if data["#{f}"]
          data["#{f}"].each { |line| source_file.write line }
        end
      else
        puts "Skipped creating \e[31m #{f} \e[0m"    
      end
    end
  end

end

