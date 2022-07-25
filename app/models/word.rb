class Word < ApplicationRecord
    serialize :defination
    serialize :example
    serialize :relationshipType

  
  after_initialize do |word|
    word.defination= [] if word.defination == nil
    word.example= [] if word.example == nil
    word.relationshipType= [] if word.relationshipType == nil
  end

  def self.check_api_count(what_we_need_to_show)
     begin
       if ((@key_details.count >= 500 && @user_subscription_plan == 1) ||  
           (@key_details.count >= 2000 && @user_subscription_plan == 2) || 
           (@key_details.count >= 10000 && @user_subscription_plan == 3))
           raise "Api limit reached"
       end
     rescue => exception
       return render plain: exception
     else 
       @key_details.count += 1
       @key_details.save
       if ( what_we_need_to_show == "word" )
        random_word = Word.find(rand(1..42))
        #render json: {word: word.word}
       return random_word.word 
       elsif ( what_we_need_to_show == "defination" )
         show_detail_from_word("defination")
       elsif (what_we_need_to_show == "example" )
         show_detail_from_word("example")
       elsif (what_we_need_to_show == "relation" )
         show_detail_from_word("getRelation")
       else
         return "something went wrong"
       end
     end
  end

  def self.show_detail_from_word(choice) #renders json according to the request by user
    begin
      word = Word.find_by(word:@word_in_params).example if choice == "example"
      word = Word.find_by(word:@word_in_params).defination if choice == "defination"
      word = Word.find_by(word:@word_in_params).relationshipType if choice == "getRelation"
    rescue => exception
      return
    else
      return word 
    end
  end

  def self.set_key_details
    @key_details = Key.find(@key_given_in_params);  
    key_user = @key_details.user_id  #user of this key
    @user_subscription_plan = User.find(key_user).subscription_choice
  end

  def self.set_key_from_params(key)
    @name_of_key = key
  end

  def self.authenticate_key
    begin
      @key_given_in_params = Key.find_by(name:@name_of_key).id
      return 
    rescue => exception
      return "invalid key"
    end
  end

  def self.set_word_from_params(word)
    @word_in_params = word
  end

  def self.print_result(choice,word)
    if choice == "word"
      value = {word: word}
    elsif choice == "example"
      value = {example: word}
    elsif choice == "defination"
      value = {defination: word}
    elsif choice == "relation"
      value = {relationshipType: word}
    else
      value = "something went wrong!"
    end
    return value
  end
end
