class InterestsController < ApplicationController
  respond_to :html

  before_filter :load_collection, :only => [:index]
  before_filter :load_object, except: [:index, :new, :create]

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
    @interest = Interest.new(params[:interest])
    respond_to do |format|
      if @interest.save
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

private

  def load_collection
    @interests = Interest.all
  end

  def load_object
    @interest = Interest.find(params[:id])
  end
end
