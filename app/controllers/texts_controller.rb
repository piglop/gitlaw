class TextsController < ApplicationController
  before_filter :require_user, only: [:new]
  load_and_authorize_resource

  include ApplicationHelper
  
  # GET /texts
  # GET /texts.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @texts }
    end
  end

  # GET /texts/1
  # GET /texts/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @text }
    end
  end

  # GET /texts/new
  # GET /texts/new.json
  def new
    if params[:base_id]
      @base = Text.accessible_by(current_ability).find(params[:base_id])
      raise "Base not found" unless @base
      @text.assign_attributes @base.attributes.select { |name, value| Text.accessible_attributes.include?(name) }
      @text.base_id = @base.id
    end
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @text }
    end
  end

  # GET /texts/1/edit
  def edit
  end

  # POST /texts
  # POST /texts.json
  def create
    respond_to do |format|
      if @text.save
        format.html { redirect_to expanded_modification_path(@text.modifications.first), flash: {success: t("texts.created")} }
        format.json { render json: @text, status: :created, location: @text }
      else
        format.html { render action: "new" }
        format.json { render json: @text.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /texts/1
  # PATCH/PUT /texts/1.json
  def update
    respond_to do |format|
      if @text.update_attributes(params[:text])
        format.html { redirect_to @text, flash: {success: t("texts.updated")} }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @text.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /texts/1
  # DELETE /texts/1.json
  def destroy
    @text.destroy

    respond_to do |format|
      format.html { redirect_to texts_url }
      format.json { head :no_content }
    end
  end
end
