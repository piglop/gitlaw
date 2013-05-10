class ModificationsController < ApplicationController
  before_filter :require_user, only: [:new]
  load_and_authorize_resource
  
  include ApplicationHelper

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
    if params[:original_id].present?
      @modification.original = Text.accessible_by(current_ability).find(params[:original_id])
      @modification.text = params[:text] || @modification.original.try(:text)
    end
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
    @modification.user = current_user
    respond_to do |format|
      if @modification.save
        format.html { redirect_to expanded_modification_path(@modification), flash: {success: t("modifications.created")} }
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
