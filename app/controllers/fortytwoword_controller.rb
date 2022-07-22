class FortytwowordController < ApplicationController
  
    before_action :set_key_from_id, only: [:word, :example, :defination, :destroy, :wordRelation]
    before_action :set_key_from_id, only: [:word, :example, :defination, :destroy, :wordRelation]


    #used to find the word json 
    def word 
       begin
          @key = Key.find_by(name:@name_of_key).id 
        rescue => e 
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
         end
        end
    end 


    #post method to get the word example
    def getexample
        @word = params.require(:fortytwoword).permit(:word)  #permits the word to be searched
        @word = @word["word"]
        begin
             @get_word = Word.find_by(word:@word) #checks if word exists in db
             raise Exception.new  "Word doesn't exist!" if !@get_word.example
        rescue => exception
        render plain: "invalid word!"
        else
        render json: {examples:@get_word.example}
        end
    end


    # gets the word defination
    def defination
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
            end
        end
    end



   #post methos to get the word's defination
    def getdefination
        @word = params.require(:fortytwoword).permit(:word) #permits the word
        @word = @word["word"]
        begin
            @get_word = Word.find_by(word:@word)
            raise Exception.new  "Word doesn't exist!" if !@get_word.defination
       rescue => exception
       render plain: "invalid word!"
       else
        @get_defination = Word.find_by(word:@word)
        render json: {Definitions:@get_defination.defination}
       end
    end


  #gets the word relations i.e antonyms and synonyms
    def wordRelation
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
            end
        end
    end


#post method to get the relations of the word
    def getWordRelation
      @word = params.require(:fortytwoword).permit(:word)
      @word = @word["word"]
      begin
        @get_word = Word.find_by(word:@word)
          raise Exception.new  "Word doesn't exist!" if !@get_word.relationshipType
      rescue =>exception
       render plain: "invalid word!"
      else
        @get_relations=Word.find_by(word:@word)
        render json: {Relations:@get_relations.relationshipType}
       end
    end


    #this show method handles the case when page doesn't exist
    def show

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
    @name_of_key = params[:id]
   end

   
   

end