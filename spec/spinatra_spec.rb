require 'spec_helper'

describe Spinatra  do
	

    describe "#new" do	
    	@spin = Spinatra.new
    	@spin.new("app")
	    it "takes one parameter and creates directory structure with root directory capitalized" do
	       File.directory?("../App").should eql true
	    end

	end

end