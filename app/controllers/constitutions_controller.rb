class ConstitutionsController < ApplicationController
  before_filter :require_user, only: [:new]
  load_and_authorize_resource

  before_filter do
    add_crumb t("navigation.constitutions"), constitutions_path
  end

  # GET /constitutions
  # GET /constitutions.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @constitutions }
    end
  end

  # GET /constitutions/1
  # GET /constitutions/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @constitution }
    end
  end

  # GET /constitutions/new
  # GET /constitutions/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @constitution }
    end
  end

  # GET /constitutions/1/edit
  def edit
  end

  # POST /constitutions
  # POST /constitutions.json
  def create
    respond_to do |format|
      if @constitution.save
        format.html { redirect_to @constitution, flash: {success: t("constitutions.created")} }
        format.json { render json: @constitution, status: :created, location: @constitution }
      else
        format.html { render action: "new" }
        format.json { render json: @constitution.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /constitutions/1
  # PATCH/PUT /constitutions/1.json
  def update
    respond_to do |format|
      if @constitution.update_attributes(params[:constitution])
        format.html { redirect_to @constitution, flash: {success: t("constitutions.updated")} }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @constitution.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /constitutions/1
  # DELETE /constitutions/1.json
  def destroy
    @constitution.destroy

    respond_to do |format|
      format.html { redirect_to constitutions_url }
      format.json { head :no_content }
    end
  end
end
