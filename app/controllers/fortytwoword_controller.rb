class FortytwowordController < ApplicationController
  before_action :set_key_from_params, only: [:word, :example, :defination,:wordRelation]
  before_action :set_word_from_params, only: [:example, :defination,:wordRelation]
  before_action :autheticate_key, only: [:word, :example, :defination,:wordRelation]
  before_action :set_key_details, only: [:word, :example, :defination,:wordRelation]

  def word
    result=Word.check_api_count("word")
    print_result("word",result)
  end

def example
  result=Word.check_api_count("example")
  print_result("example",result)
end

def defination
  result=Word.check_api_count("defination")
  print_result("defination",result)
end

  def wordRelation
    result=Word.check_api_count("relation")
    print_result("relation",result)
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

  def print_result(choice,word)
    if word
      result = Word.print_result(choice,word)
      render json: result
    else
      render plain: "invalid word"
    end
  end
end