class FortytwowordController < ApplicationController

    before_action :authenticate_user!



    def word 
        name=params[:id]
        begin
            @key=Key.find_by(name:name, user_id: current_user.id).id 
        rescue =>e 
            render plain: "invalid key!"
        else
            @get_api_count=check_api_count(@key)

            if ((@get_api_count >= 500 && current_user.subscription_choice == 1) ||  ( @get_api_count >= 2000 and current_user.subscription_choice == 2) || ( @get_api_count >= 10000 and current_user.subscription_choice == 3))
                render plain: "api limit reached, no more call available!"
            else

            @word=Word.find(rand(1..42))
            render json: {word:@word.word }
            end
        end
    end




    def example 
        name=params[:id]
        begin
            @key=Key.find_by(name:name, user_id: current_user.id).id 
        rescue =>e 
            render plain: "invalid key!"
        else
            @get_api_count=check_api_count(@key)
            if ((@get_api_count >= 500 && current_user.subscription_choice == 1) ||  ( @get_api_count >= 2000 and current_user.subscription_choice == 2) || ( @get_api_count >= 10000 and current_user.subscription_choice == 3))
                render plain: "api limit reached, no more call available!"
            else
            end
        end
    end 



    def getexample
        
        @word=params.require(:fortytwoword).permit(:word)
        @word=@word["word"]
        begin
             @get_word=Word.find_by(word:@word)
             raise Exception.new  "Word doesn't exist!" if !@get_word.example
        rescue =>e
        render plain: "invalid word!"
        else
        render json: {examples:@get_word.example}
        end
    end



    def defination
        name=params[:id]
        begin
            @key=Key.find_by(name:name, user_id: current_user.id).id 
        rescue =>e 
            render plain: "invalid key!"
        else
            @get_api_count=check_api_count(@key)
            if ((@get_api_count >= 500 && current_user.subscription_choice == 1) ||  ( @get_api_count >= 2000 and current_user.subscription_choice == 2) || ( @get_api_count >= 10000 and current_user.subscription_choice == 3))
                render plain: "api limit reached, no more call available!"
            else
            end
        end
    end




    def getdefination
        @word=params.require(:fortytwoword).permit(:word)
        @word=@word["word"]
        begin
            @get_word=Word.find_by(word:@word)
            raise Exception.new  "Word doesn't exist!" if !@get_word.defination
       rescue =>e
       render plain: "invalid word!"
       else
        @get_defination=Word.find_by(word:@word)
        render json: {Definitions:@get_defination.defination}
       end
    end



    def wordRelation
        name=params[:id]
        begin
            @key=Key.find_by(name:name, user_id: current_user.id).id 
        rescue =>e 
            render plain: "invalid key!"
        else
            @get_api_count=check_api_count(@key)
            if ((@get_api_count >= 500 && current_user.subscription_choice == 1) ||  ( @get_api_count >= 2000 and current_user.subscription_choice == 2) || ( @get_api_count >= 10000 and current_user.subscription_choice == 3))
                render plain: "api limit reached, no more call available!"
            else
            end
        end
    end



    def getWordRelation
        @word=params.require(:fortytwoword).permit(:word)
        @word=@word["word"]
        begin
            @get_word=Word.find_by(word:@word)
            raise Exception.new  "Word doesn't exist!" if !@get_word.relationshipType
       rescue =>e
       render plain: "invalid word!"
       else
        @get_relations=Word.find_by(word:@word)
        render json: {Relations:@get_relations.relationshipType}
       end
    end



   private

   
   def check_api_count(key)
            @current_key=Key.find(key)
            return @current_key.count if @current_key.count >= 500 && current_user.subscription_choice == 1
            return @current_key.count if @current_key.count >= 2000 && current_user.subscription_choice == 2
            return @current_key.count if @current_key.count >= 10000 && current_user.subscription_choice == 3
            @current_key.count+=1
            @current_key.save
            return @current_key.count
   end

end