class KeysController < ApplicationController
    before_action :set_key, only: %i[ show edit update destroy]
    before_action :authenticate_user!, only: [:show,  :edit, :destroy,  :update,:index,:new]

    
    def index 
        @keys=Key.select(:id,:name,:count).group(:id,:name,:count).having("user_id=#{current_user.id}")
        @current=@keys.length.to_i
        @choice=0
        if current_user. subscription_choice.to_i==1
            @choice=5
        elsif current_user.subscription_choice.to_i == 2
            @choice=10
        else 
            @choice=1000 
        end     
    end

    def new 
       
       @name=SecureRandom.alphanumeric(50).to_s
       @keys=Key.select(:id,:name,:count).group(:id,:name,:count).having("user_id=#{current_user.id}")
       while @keys.exists?(['name LIKE ?', @name])
        @name= SecureRandom.alphanumeric(50)
       end
       @key=Key.new 
       @key.name=@name
       @key.count=0
       @key.user=current_user
        if @key.save
         redirect_to keys_path
        else
           render plain: @key.errors.full_messages
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
    # Use callbacks to share common setup or constraints between actions.
    def set_key
      @key = Key.find(params[:id])
    end

    #keys for the particular user
    def user_keys    
        @keys=Key.find(current_user.id)
    end
    # Only allow a list of trusted parameters through.
    def key_params
      params.require(:key).permit(:name, :username, :email,:subscription_choice)
    end

end
