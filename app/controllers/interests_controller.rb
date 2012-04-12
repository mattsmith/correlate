class InterestsController < ApplicationController
  respond_to :html

  def index
    @interests = current_user.interests if user_signed_in?
  end

  def create
    @interest = Interest.find_by_name(params[:interest][:name]) || Interest.new(params[:interest])
    respond_to do |format|
      if @interest.save
        current_user.user_interests.create(interest: @interest) unless current_user.interests.include?(@interest)
        format.html { redirect_to(root_url, notice: 'Interests added, now update your matches.') }
      else
        format.html { redirect_to(root_url, notice: 'There was error, please try again.') }
      end
    end
  end

  def update
    @interest = Interest.find(params[:id])
    respond_to do |format|
      if @interest.update_attributes(params[:interest])
        format.html { redirect_to(@interest, :notice => 'Interest was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def correlate

    Related.correlate

    redirect_to root_url, notice: "Your matches have been updated."
  end

end
