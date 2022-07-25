class Key < ApplicationRecord
    belongs_to:user

    def self.get_max_api_keys(choice)
      if choice.to_i == 1
        maximum_api_keys_user_can_make = 5
      elsif choice.to_i == 2
        maximum_api_keys_user_can_make = 10
      else 
       maximum_api_keys_user_can_make = 1000 
      end     
      return maximum_api_keys_user_can_make
    end
    
    def self.new_key(keys_from_user,current_user)
      name_of_key = SecureRandom.alphanumeric(50)
      #this below loop makes sure same key is not generated again for same user
      while keys_from_user.exists?(['name LIKE ?', name_of_key])
        name_of_key = SecureRandom.alphanumeric(50)
      end
      new_key = Key.new 
      new_key.name = name_of_key
      new_key.count = 0
      new_key.user = current_user
      return new_key
    end


end