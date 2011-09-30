class HomeController < ApplicationController

  def index 
    render :text=>"hello world" , :layout=>false
  end

end
