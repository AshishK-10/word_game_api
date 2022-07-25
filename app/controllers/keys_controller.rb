class KeysController < ApplicationController
    before_action :set_key, only: %i[ show edit update destroy]
    before_action :keys_from_user, only: %i[ index new ]
    before_action :authenticate_user!, only: [:show,  :edit, :destroy,  :update,:index,:new]

  def index 
    @current_key_count = @keys_from_user.length.to_i
    @maximum_api_keys_user_can_make = 0  
    @maximum_api_keys_user_can_make = Key.get_max_api_keys(current_user.subscription_choice.to_i)
  end
   
  def new
    new_key = Key.new_key(@keys_from_user,current_user)
    if new_key.save
      redirect_to keys_path
    else
      render plain: new_key.errors.full_messages
    end 
  end

  def show 
  end

  def destroy 
    @key.destroy
    respond_to do |format|
    format.html { redirect_to keys_path, notice: "Key was successfully destroyed." }
    format.json { head :no_content }
    end
  end

  private
    def set_key
      @key = Key.find(params[:id])
    end

    def user_keys #keys for the particular user
      @keys = Key.find(current_user.id)
    end

    def keys_from_user
      @keys_from_user = Key.select(:id,:name,:count).group(:id,:name,:count).having("user_id=#{current_user.id}")
    end
end
