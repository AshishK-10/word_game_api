class Word < ApplicationRecord
    serialize :defination
    serialize :example
    serialize :relationshipType

  
  after_initialize do |word|
    word.defination= [] if word.defination == nil
    word.example= [] if word.example == nil
    word.relationshipType= [] if word.relationshipType == nil
    
  end
end