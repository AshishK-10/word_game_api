class FortytwowordController < ApplicationController
    #add the api  counter
    
    def word 
        name=params[:id]
        begin
            @key=Key.find_by(name:name, user_id: current_user.id).id 
        rescue =>e 
            render plain: "invalid key!"
        else
            @current_key=Key.find(@key)
            @current_key.count+=1
            @current_key.save
            @word=Word.find(rand(1..42))
            render json: {word:@word.word }
        end
    end

    def example 
        name=params[:id]
        begin
            @key=Key.find_by(name:name, user_id: current_user.id).id 
        rescue =>e 
            render plain: "invalid key!"
        else
            @current_key=Key.find(@key)
            @current_key.count+=1
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
            @current_key=Key.find(@key)
            @current_key.count+=1
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
            @current_key=Key.find(@key)
            @current_key.count+=1
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

end