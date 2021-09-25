class Stamp < ApplicationRecord
  belongs_to :user
  belongs_to :group
  belongs_to :group_message

  def stamp1_exists?
    
  end

  def stamp2_exists?
    
  end

  def stamp3_exists?
    
  end

end
