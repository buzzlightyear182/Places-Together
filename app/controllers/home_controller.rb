class HomeController < ApplicationController

  def welcome
    @search = Search.new
  end

end
