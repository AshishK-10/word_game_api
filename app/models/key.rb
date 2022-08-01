class Key < ApplicationRecord
  belongs_to:user
  validates :name, uniqueness: true
  def create_key(choice)
    if choice == 1
      max_keys = 5
    elsif choice == 2
      max_keys = 10
    else
      max_keys = 1000
    end
 end

  def self.new_key(keys_from_user,current_user)
   name_of_key = SecureRandom.alphanumeric(75)
   new_key = Key.new
   new_key.name = name_of_key
   new_key.count = 0
   new_key.user = current_user
   return new_key
 end
end