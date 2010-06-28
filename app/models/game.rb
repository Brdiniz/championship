class Game < ActiveRecord::Base
  belongs_to :round
  belongs_to :home, :class_name => "Equipe", :foreign_key => "home_id"
  belongs_to :visitant, :class_name => "Equipe", :foreign_key => "visitant_id"

  validate :save_home_visitant
  
  attr_accessor :home_name, :visitant_name
  
  validates_presence_of :round_id, :home_name, :visitant_name
  
  def save_home_visitant
    return false unless validate_equipe_game
    self.home = @home
    self.visitant = @visitant
    return true
  end
  
  def validate_equipe_game
    @home = Equipe.find_by_name(home_name)
    errors.add(:home_name, 'não existe') unless @home
    
    @visitant = Equipe.find_by_name(visitant_name)
    errors.add(:visitant_name, 'não existe') unless @visitant
    
    return errors.empty?
  end
end
