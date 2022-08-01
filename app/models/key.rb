class Key < ApplicationRecord
  belongs_to:user
  validates :name, uniqueness: true
  before_create :new_key

  def self.get_keys(choice)
    {1=> 5, 2=> 10, 3=> 10000}[choice]
  end

  def new_key
    self.count = 0
    self.name = SecureRandom.alphanumeric(75)
  end

  def self.authenticate(user_key)
    key = Key.find_by(name: user_key)
    if key
      choice = {1=> 500, 2=>2000, 3=>10000}[key.user.subscription_choice]
      if (key.count >= 500 && choice == 1 || key.count >= 2000 && choice == 2 || key.count >= 10000 && choice == 3)
        false
      else
        key.count += 1
        key.save
      end
    else
      false
    end
  end

end