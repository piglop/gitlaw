class LawTextsController < ApplicationController
  load_and_authorize_resource

  before_filter do
    add_crumb t("navigation.law_texts"), law_texts_path
  end

  # GET /law_texts
  # GET /law_texts.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @law_texts }
    end
  end

  # GET /law_texts/1
  # GET /law_texts/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @law_text }
    end
  end

  # GET /law_texts/new
  # GET /law_texts/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @law_text }
    end
  end

  # GET /law_texts/1/edit
  def edit
  end

  # POST /law_texts
  # POST /law_texts.json
  def create
    respond_to do |format|
      if @law_text.save
        format.html { redirect_to @law_text, flash: {success: t("law_texts.created")} }
        format.json { render json: @law_text, status: :created, location: @law_text }
      else
        format.html { render action: "new" }
        format.json { render json: @law_text.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /law_texts/1
  # PATCH/PUT /law_texts/1.json
  def update
    respond_to do |format|
      if @law_text.update_attributes(params[:law_text])
        format.html { redirect_to @law_text, flash: {success: t("law_texts.updated")} }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @law_text.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /law_texts/1
  # DELETE /law_texts/1.json
  def destroy
    @law_text.destroy

    respond_to do |format|
      format.html { redirect_to law_texts_url }
      format.json { head :no_content }
    end
  end
end
