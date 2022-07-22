class FortytwowordController < ApplicationController
  
    before_action :set_key_from_id, only: [:word, :example, :defination, :destroy, :wordRelation]
    before_action :set_key_from_id, only: [:word, :example, :defination, :destroy, :wordRelation]


    #used to find the word json 
    def word 
       begin
          @key = Key.find_by(name:@name_of_key).id 
        rescue => exception 
            render plain: "invalid key!"
        else
          @key_details = Key.find(@key);  
          @key_user = @key_details.user_id  #user of this key

          #subscription taken by the user is stored in @user_subscription_plan variable

          @user_subscription_plan = User.find(@key_user).subscription_choice

          #function returns and check the api call limit

          @get_api_count = check_api_count(@key_details.count,@user_subscription_plan) 
          if ((@get_api_count >= 500 && @user_subscription_plan == 1) ||  ( @get_api_count >= 2000 and @user_subscription_plan == 2) || ( @get_api_count >= 10000 and @user_subscription_plan == 3))
            render plain: "api limit reached, no more call available!"
          else
            @key_details.count = @get_api_count
            @key_details.save
            @word=Word.find(rand(1..42))    #find random words
            render json: {word:@word.word } 
         end
        end
    end



    #used to get the examples of a particular word
    def example 
      @word = params[:word]
       #return render json: "#{word},#{@name_of_key} "
        begin
          @key = Key.find_by(name:@name_of_key, user_id: current_user.id).id #autheticate the key in db
        rescue => exception 
          render plain: "invalid key!"
        else
          @key_details = Key.find(@key);
          @key_user = @key_details.user_id
          @user_subscription_plan = User.find(@key_user).subscription_choice

          @get_api_count = check_api_count(@key_details.count,@user_subscription_plan) 

          if ((@get_api_count >= 500 && @user_subscription_plan == 1) ||  ( @get_api_count >= 2000 and @user_subscription_plan == 2) || ( @get_api_count >= 10000 and @user_subscription_plan == 3))
                render plain: "api limit reached, no more call available!"
         else
          @key_details.count = @get_api_count
          @key_details.save
          @get_word = Word.find_by(word:@word)
          render json: {example: @get_word.example}
         end
        end
    end 


    # gets the word defination
    def defination
      @word = params[:word]
       begin
        @key = Key.find_by(name:@name_of_key, user_id: current_user.id).id 
       rescue => exception
        render plain: "invalid key!"
        else
          @key_details = Key.find(@key);
          @key_user = @key_details.user_id
          @user_subscription_plan = User.find(@key_user).subscription_choice
          @get_api_count = check_api_count(@key_details.count,@user_subscription_plan) 

             #checks the api limit according to the api subscription

            if ((@get_api_count >= 500 && @user_subscription_plan == 1) ||  ( @get_api_count >= 2000 and @user_subscription_plan == 2) || ( @get_api_count >= 10000 and @user_subscription_plan == 3))
                render plain: "api limit reached, no more call available!"
            else
              @key_details.count = @get_api_count
              @key_details.save
              @get_word = Word.find_by(word:@word)
              render json: {defination: @get_word.defination}
            end
        end
    end



  #gets the word relations i.e antonyms and synonyms
    def wordRelation
      @word = params[:word]
        begin
          @key = Key.find_by(name:@name_of_key, user_id: current_user.id).id 
        rescue =>e 
          render plain: "invalid key!"
        else
          @key_details = Key.find(@key);
          @key_user = @key_details.user_id
          @user_subscription_plan = User.find(@key_user).subscription_choice
          @get_api_count = check_api_count(@key_details.count,@user_subscription_plan)
            if ((@get_api_count >= 500 && @user_subscription_plan == 1) ||  ( @get_api_count >= 2000 and @user_subscription_plan == 2) || ( @get_api_count >= 10000 and @user_subscription_plan == 3))
                render plain: "api limit reached, no more call available!"
            else
              @key_details.count = @get_api_count
              @key_details.save
              @get_word = Word.find_by(word:@word)
              render json: {defination: @get_word.relationshipType}
            end
        end
    end



    #this show method handles the case when page doesn't exist
    def show
      render file: Rails.public_path.join('404.html'), status: :not_found, layout: false
      end
      def index
        render file: Rails.public_path.join('404.html'), status: :not_found, layout: false
        end


   private

   #checks the api count and updated them according to users subscription
   def check_api_count(api_key_count,current_user_subscription_plan)
     return api_key_count if api_key_count >= 500 && current_user_subscription_plan == 1
     return api_key_count if api_key_count >= 2000 && current_user_subscription_plan == 2
     return api_key_count if api_key_count >= 10000 && current_user_subscription_plan == 3
     api_key_count+=1
     return api_key_count
   end

   def set_key_from_id  #sets the name of the key
    @name_of_key = params[:api_key]
   end

end