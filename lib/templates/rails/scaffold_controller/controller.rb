class <%= controller_class_name %>Controller < ApplicationController
  respond_to :html

  before_filter :load_collection, :only => [:index]
  before_filter :load_object, except: [:index, :new, :create]

  def index
    respond_with @<%= plural_table_name %>
  end

  def show
    respond_with @<%= singular_table_name %>, location: @<%= singular_table_name %>
  end

  def new
    respond_with @<%= singular_table_name %> = <%= orm_class.build(class_name) %>
  end

  def edit
    @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
  end

  def create
    @<%= singular_table_name %> = <%= orm_class.build(class_name, "params[:#{singular_table_name}]") %>
    respond_to do |format|
      if @<%= orm_instance.save %>
        format.html { redirect_to(@<%= singular_table_name %>, notice: '<%= human_name %> was successfully created.') }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    respond_to do |format|
      if @<%= orm_instance.update_attributes("params[:#{singular_table_name}]") %>
        format.html { redirect_to(@<%= singular_table_name %>, :notice => '<%= human_name %> was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @<%= orm_instance.destroy %>

    respond_to do |format|
      format.html { redirect_to(<%= index_helper %>_url) }
    end
  end

private

  def load_collection
    @<%= plural_table_name %> = <%= orm_class.all(class_name) %>
  end

  def load_object
    @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
  end
end
