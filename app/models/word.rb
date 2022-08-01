class Word < ApplicationRecord
  serialize :defination
  serialize :example
  serialize :relationshipType

  after_initialize do |word|
    word.defination= [] if word.defination == nil
    word.example= [] if word.example == nil
    word.relationshipType= [] if word.relationshipType == nil
  end

  def self.set_word
    Word.find(rand(1..41))
  end

  def self.result(user_word)
    word = Word.find_by(word: user_word)
    word ? word : "error"
  end

end
