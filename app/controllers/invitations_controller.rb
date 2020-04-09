class InvitationsController < ApplicationController
  before_action :set_invitation, only: [:show, :edit, :update, :destroy, :accept, :decline]
  before_action :check_password_token, only: %[accept decline]

  include UsersHelper
  # GET /invitations
  # GET /invitations.json
  def index
    @invitations = Invitation.all
  end

  # GET /invitations/1
  # GET /invitations/1.json
  def show
  end

  # GET /invitations/new
  def new
    @invitation = Invitation.new
  end

  # GET /invitations/1/edit
  def edit
  end

  # POST /invitations
  # POST /invitations.json
  def create
    if !recipients_params.nil?
      recipients_params.each do |key, value|
        user = User.find_by(email: value)
        if user
          @invitation = Invitation.new(invitation_params)
          @invitation.sender_id = current_user.id
          @invitation.recipient_id = user.id
          if @invitation.save
            respond_to do |format|
              format.html { redirect_to users_path, success: 'Invitation was successfully created.' }
              format.json { render :show, status: :created, location: invitation }
              format.js { flash[:success] = "The invitations have been sent" }
            end
          else

          end
        end
      end
    else
      respond_to do |format|
        format.html
        format.json
        format.js
      end
    end
  end

  # PATCH/PUT /invitations/1
  # PATCH/PUT /invitations/1.json
  def update
    respond_to do |format|
      if @invitation.update(invitation_params)
        format.html { redirect_to @invitation, success: 'Invitation was successfully updated.' }
        format.json { render :show, status: :ok, location: @invitation }
      else
        format.html { render :edit }
        format.json { render json: @invitation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invitations/1
  # DELETE /invitations/1.json
  def destroy
    @invitation.destroy
    respond_to do |format|
      format.html { redirect_to invitations_url, success: 'Invitation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def accept
    @recipient = @invitation.recipient
    @space = @invitation.sender.space
    if @invitation.safe? && @invitation.update(accepted: true) && update_user_space(@recipient, @space)
      respond_to do |format|
        format.html { 
          redirect_to my_space_path,
          success: "You successfully joined the new space" 
        }
      end
    else
      respond_to do |format|
        format.html { 
          redirect_to my_space_path,
          danger: "Unknown error" 
        }
      end
    end
  end

  def decline
    @recipient = @invitation.recipient
    @space = @invitation.sender.space
    if @invitation.safe? && @invitation.update(declined: true)
      respond_to do |format|
        format.html { 
          redirect_to my_space_path,
          success: "You successfully declined the invitation" 
        }
      end
    else
      respond_to do |format|
        format.html { 
          redirect_to my_space_path,
          danger: "Unknown error" 
        }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invitation
      @invitation = Invitation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def invitation_params
      params.require(:invitation).permit(:message)
    end

    def recipients_params
      params[:invitation][:recipients]
    end

    # def create(invitation)
    #   if invitation.save
        
    #   else

    #   end
    # end

    def check_password_token
      unless user_signed_in? && @invitation && @invitation.recipient == current_user && @invitation.safe? && @invitation.password_token == params[:password_token]
        redirect_to my_space_path,
        warning: "You're clever, but I'm more"
      end
    end
end
