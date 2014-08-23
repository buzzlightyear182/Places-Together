require 'pry'
require 'simple_form'
class ReviewsController < ApplicationController

  def new
    @profile = Profile.find(params[:profile_id])
    @review = Review.new
    @reviewee = User.find(@profile.id)
    @common_trips = Review.find_common_trip(current_user.id, params[:profile_id])
  end

  def create
    puts params
    binding.pry
    @profile = Profile.find(params[:profile_id])
    @review = Review.new
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating, :trip)
  end
end

{"utf8"=>"✓",
 "authenticity_token"=>"Uj9WIbSZGxHvqg3SIZlT50gkelLb8ku21fQi6CSYrqk=",
 "review"=>{"trip"=>"Trek in Bilbao", "content"=>"", "rating"=>"10"},
 "button"=>"",
 "action"=>"create",
 "controller"=>"reviews",
 "profile_id"=>"3"}
