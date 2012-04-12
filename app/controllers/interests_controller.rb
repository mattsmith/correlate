class InterestsController < ApplicationController
  respond_to :html

  before_filter :load_collection, :only => [:index]
  before_filter :load_object, except: [:index, :new, :create, :correlate]

  def index
    respond_with @interests
  end

  def show
    respond_with @interest, location: @interest
  end

  def new
    respond_with @interest = Interest.new
  end

  def edit
    @interest = Interest.find(params[:id])
  end

  def create
    @interest = Interest.find_by_name(params[:interest][:name]) || Interest.new(params[:interest])
    respond_to do |format|
      if @interest.save
        current_user.user_interests.create(interest: @interest) unless current_user.interests.include?(@interest)
        format.html { redirect_to(@interest, notice: 'Interest was successfully created.') }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    respond_to do |format|
      if @interest.update_attributes(params[:interest])
        format.html { redirect_to(@interest, :notice => 'Interest was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @interest.destroy

    respond_to do |format|
      format.html { redirect_to(interests_url) }
    end
  end

  def correlate

    # Reset all the correlations for related pairs
    Related.destroy_all

    User.all.each do |user1|
      # Get the next user to pair with
      user2 = user1.next

      if user2
        # Get the intersection (similar) and union (total) of the users interests
        logger.debug similar_interests = user1.interests.map(&:id) & user2.interests.map(&:id)
        logger.debug total_interests = user1.interests.map(&:id) | user2.interests.map(&:id)

        # Calulate the correlation
        logger.debug jaccard_correlation = (similar_interests.count.to_f/total_interests.count.to_f).round(3)

        # Store the results for each user
        user1.related.create(count: similar_interests.count, correlation: jaccard_correlation, paired: user2)
        user2.related.create(count: similar_interests.count, correlation: jaccard_correlation, paired: user1)
      end

    end
    redirect_to root_url, notice: "Your matches have been updated."
  end

private

  def load_collection
    @interests = Interest.all
  end

  def load_object
    @interest = Interest.find(params[:id])
  end
end
