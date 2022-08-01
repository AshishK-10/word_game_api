class KeysController < ApplicationController
  before_action :authenticate_user!, only: [:show, :destroy, :index, :new]
  before_action :set_key, only: [:show, :destroy]
  before_action :user_keys, only: [:index, :show]

  def index
    @key_count = @user_keys.length
    @max_keys = Key.get_keys(current_user.subscription_choice)
  end

  def new
    new_key = current_user.keys.new
    if new_key.save
      redirect_to keys_path
    else
      render plain: new_key.errors.full_messages
    end
  end

  def show; end

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

  def user_keys
    @user_keys = current_user.keys
  end
end