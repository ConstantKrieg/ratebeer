class MembershipsController < ApplicationController
  before_action :set_membership, only: [:show, :edit, :update, :destroy]

  # GET /memberships
  # GET /memberships.json
  def index
    @memberships = Membership.all
  end

  # GET /memberships/1
  # GET /memberships/1.json
  def show
  end

  # GET /memberships/new
  def new
    @membership = Membership.new
    @beer_clubs = BeerClub.all.reject{|club| current_user.in? club.members}
  end

  # GET /memberships/1/edit
  def edit
  end

  # POST /memberships
  # POST /memberships.json
  def create
    @membership = Membership.new(membership_params)
    @membership.user_id = current_user.id
    beer_club = BeerClub.find(@membership.beer_club_id)
    @membership.confirmed = false

    respond_to do |format|
      if @membership.save
        current_user.memberships << @membership
        format.html { redirect_to  beer_club_path(@membership.beer_club_id), notice: 'Welcome!' }
      else
        @beer_clubs = BeerClub.all
        render :new
      end
    end
  end

  # PATCH/PUT /memberships/1
  # PATCH/PUT /memberships/1.json
  def update
    respond_to do |format|
      if @membership.update(membership_params)
        format.html { redirect_to @membership, notice: 'Membership was successfully updated.' }
        format.json { render :show, status: :ok, location: @membership }
      else
        @beer_clubs = BeerClub.all
        render :new
      end
    end
  end


  def toggle_confirmed
    membership = Membership.find(params[:id])
    membership.confirmed = true
    membership.save
    redirect_to :back
  end  

  # DELETE /memberships/1
  # DELETE /memberships/1.json
  def destroy
    @membership.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Membership was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_membership
      @membership = Membership.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def membership_params
      params.require(:membership).permit(:user_id, :beer_club_id)
    end
end
