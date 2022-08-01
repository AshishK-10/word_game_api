class FortytwowordController < ApplicationController
  before_action :authenticate_key
  before_action :load_word, only: [:example, :defination, :wordRelation]
  before_action :result, only: [:example, :defination, :wordRelation]

  def word
    render json: {word: Word.set_word.word}
  end

  def example
    render json: {example: @result.example}
  end

  def defination
    render json: {definations: @result.defination}
  end

  def wordRelation
    render json: {relationshipType: @result.relationshipType}
  end

  private

  def authenticate_key
    render plain: "invalid key" if !Key.authenticate(params[:api_key])
  end

  def load_word
    @word = params[:word]
  end

  def result
    @result = Word.result(@word)
    render plain: "invalid word" if @result == "error"
  end

end
