class StatutsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_statut, only: %i[ show edit update destroy ]

  # GET /statuts or /statuts.json
  def index
    @statuts = Statut.all
  end

  # GET /statuts/1 or /statuts/1.json
  def show
  end

  # GET /statuts/new
  def new
    @statut = Statut.new
  end

  # GET /statuts/1/edit
  def edit
  end

  # POST /statuts or /statuts.json
  def create
    @statut = current_user.statuts.build(statut_params)

    respond_to do |format|
      if @statut.save
        format.html { redirect_to statut_url(@statut), notice: "Statut was successfully created." }
        format.json { render :show, status: :created, location: @statut }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @statut.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /statuts/1 or /statuts/1.json
  def update
    respond_to do |format|
      if @statut.update(statut_params)
        format.html { redirect_to statut_url(@statut), notice: "Statut was successfully updated." }
        format.json { render :show, status: :ok, location: @statut }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @statut.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /statuts/1 or /statuts/1.json
  def destroy
    @statut.destroy

    respond_to do |format|
      format.html { redirect_to statuts_url, notice: "Statut was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_statut
      @statut = Statut.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def statut_params
      params.require(:statut).permit(:title, :slug, :user_id)
    end
end
