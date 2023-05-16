class LearnsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_learn, only: %i[ show edit update destroy ]
  before_action :set_levels, :set_materials
  # GET /learns or /learns.json
  def index
    @learns = Learn.all
  end

  # GET /learns/1 or /learns/1.json
  def show
  end

  # GET /learns/new
  def new
    @learn = Learn.new
  end

  # GET /learns/1/edit
  def edit
  end

  # POST /learns or /learns.json
  def create
    @learn = current_user.learns.build(learn_params)

    respond_to do |format|
      if @learn.save
        format.html { redirect_to learn_url(@learn), notice: "Learn was successfully created." }
        format.json { render :show, status: :created, location: @learn }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @learn.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /learns/1 or /learns/1.json
  def update
    respond_to do |format|
      if @learn.update(learn_params)
        format.html { redirect_to learn_url(@learn), notice: "Learn was successfully updated." }
        format.json { render :show, status: :ok, location: @learn }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @learn.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /learns/1 or /learns/1.json
  def destroy
    @learn.destroy

    respond_to do |format|
      format.html { redirect_to learns_url, notice: "Learn was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_learn
      @learn = Learn.friendly.find(params[:id])
    end

    def set_materials
      @materials = Material.all
    end
    def set_levels
      @levels = Level.all
    end

    # Only allow a list of trusted parameters through.
    def learn_params
      params.require(:learn).permit(:title, :content, :level_name, :material_name, :slug, :user_id)
    end
end
