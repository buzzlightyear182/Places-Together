class ReviewsController < ApplicationController

  before_action :authenticate_user!

  def new
    @search = Search.new
    @profile = Profile.find(params[:profile_id])
    @review = Review.new
    @reviewee = @profile.user
    @common_trips = Review.find_common_trip(current_user.id, params[:profile_id])
    @trip_names = @common_trips.values
  end

  def create
    @profile = Profile.find(params[:profile_id])
    review_params[:trip] = review_params[:trip].to_i
    @review = Review.create_review(review_params, current_user.id, params[:profile_id])
    if @review.save
      @profile.update_rating
      flash[:notice] = "Your review has been saved. Thank you!"
      redirect_to action:'show', controller:'profiles', id: @profile.id
    else
      flash[:alert] = @reviews.error.full_messages
      render 'new'
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating, :trip)
  end
end
