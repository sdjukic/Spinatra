# Sinatra scaffolding gem
require 'thor'
require 'fileutils'


class Spinatra < Thor 
  

  desc "new APP_NAME",  "Creates scaffold for modular Sinatra application."
  def new(name)
  	files = ["#{name.capitalize}.rb",
  	         "Gemfile",
  	         "README.md",
  	         "config.ru"] 
    main_file = ["$:.unshift File.expand_path('../lib', __FILE__)\n",
                       "require 'sinatra/base'\n",
                       "\nclass #{name.capitalize} < Sinatra:Base\n",
                       "\nend"]
    gems = ["source 'https://rubygems.org'\n",
            "\ngem 'sinatra'",
            "\ngem 'rubocop'",
            "\ngem 'puma'\n",
            "\ngroup :test do",
            "\n  gem 'rack-test'",
            "\n  gem 'rspec'",
            "\nend"]
    readme = ["## #{name.capitalize}"]
    config_ru = ["require './#{name.capitalize}'\n",
                 "\nrun #{name.capitalize}.new"]
    project_directories = ["./#{name.capitalize}",
    	                   "./#{name.capitalize}/public", 
                           "./#{name.capitalize}/public/images",
                           "./#{name.capitalize}/public/javascripts",
                           "./#{name.capitalize}/public/stylesheets",
                           "./#{name.capitalize}/views"] 
   

    project_directories.each { |dir| FileUtils.mkdir dir }

    #main app file 
    files.each do |f|
      source_file = File.new("#{name.capitalize}/#{f}", 'w')
      case f
        when "#{name.capitalize}.rb" then
          main_file.each { |line| source_file.write line }
        when "config.ru"
           config_ru.each { |line| source_file.write line}
        when "Gemfile"
        	gems.each { |line| source_file.write line}
        when "README.md"
        	readme.each { |line| source_file.write line}
      end
    end  
    
  end

end

