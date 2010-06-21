class Championship < ActiveRecord::Base
  has_and_belongs_to_many :equipes, :join_table => :equipes_championships
  validates_presence_of :name
    
  attr_accessor :equipe_name
  
  def associate_equipe
    return false unless validate_equipe
    equipes << @e
    return true
  end
  
  def validate_equipe
    errors.add_on_blank(:equipe_name, 'é um campo obrigatório')
	  @e = Equipe.find_by_name(equipe_name)
  	errors.add(:equipe_name, 'não existe') unless @e
  	errors.add(:equipe_name, 'já está associado') if @e && self.equipes.include?(@e)
	  
	  return errors.empty?
	end
end
