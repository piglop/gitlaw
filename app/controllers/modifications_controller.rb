class ModificationsController < ApplicationController
  load_and_authorize_resource

  before_filter do
    add_crumb t("navigation.modifications"), modifications_path
  end

  # GET /modifications
  # GET /modifications.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @modifications }
    end
  end

  # GET /modifications/1
  # GET /modifications/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @modification }
    end
  end

  # GET /modifications/new
  # GET /modifications/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @modification }
    end
  end

  # GET /modifications/1/edit
  def edit
  end

  # POST /modifications
  # POST /modifications.json
  def create
    respond_to do |format|
      if @modification.save
        format.html { redirect_to @modification, flash: {success: t("modifications.created")} }
        format.json { render json: @modification, status: :created, location: @modification }
      else
        format.html { render action: "new" }
        format.json { render json: @modification.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /modifications/1
  # PATCH/PUT /modifications/1.json
  def update
    respond_to do |format|
      if @modification.update_attributes(params[:modification])
        format.html { redirect_to @modification, flash: {success: t("modifications.updated")} }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @modification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /modifications/1
  # DELETE /modifications/1.json
  def destroy
    @modification.destroy

    respond_to do |format|
      format.html { redirect_to modifications_url }
      format.json { head :no_content }
    end
  end
end
