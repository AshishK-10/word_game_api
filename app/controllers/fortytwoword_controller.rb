class FortytwowordController < ApplicationController
  before_action :set_key_from_params, only: [:word, :example, :defination,:wordRelation]
  before_action :set_word_from_params, only: [:example, :defination,:wordRelation]
  before_action :autheticate_key, only: [:word, :example, :defination,:wordRelation]
  before_action :set_key_details, only: [:word, :example, :defination,:wordRelation]
  # for word: /fortytwoword/word?api_key={}
  # for word example: /fortytwoword/word/example?api_key={}
  # for word defination: /fortytwoword/word/defination?api_key={}
  # for word relation: /fortytwoword/word/relation?api_key={}

def word #used to find the word json 
    result=Word.check_api_count("word") 
    print_result("word",result)
end

def example  #used to get the examples of a particular word
    result=Word.check_api_count("example") 
    print_result("example",result)
end 

def defination # gets the word defination
    result=Word.check_api_count("defination") 
    print_result("defination",result)
end

def wordRelation #gets the word relations i.e antonyms and synonyms
    result=Word.check_api_count("relation") 
    print_result("relation",result)
end
    
def show #this show method handles the case when page doesn't exist
  render file: Rails.public_path.join('404.html'), status: :not_found, layout: false
end

private
  
  def set_key_from_params
    Word.set_key_from_params(params[:api_key])
  end

  def set_word_from_params 
    Word.set_word_from_params(params[:word])
  end

  def autheticate_key
    result = Word.authenticate_key
    render plain: result if result
  end

  def set_key_details
    Word.set_key_details
  end

  def print_result(choice,word) #word remains nill when no such word exists
    if word 
      result = Word.print_result(choice,word)
      render json: result 
    else
      render plain: "invalid word"
    end
  end
end