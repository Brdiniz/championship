class Equipe < ActiveRecord::Base
  has_many :players, :dependent => :destroy
  
  validates_presence_of :name
  validates_uniqueness_of :name
  has_and_belongs_to_many :groups, :join_table => :equipes_groups
  
  
  def <=>(other)
    self.name <=> other.name
  end
end
