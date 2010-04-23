
class Attack

  def execute(attacker, defender)
    damage = attacker.hit(defender)
    attacker.owner.add_message "#{attacker.name} hit #{defender.name} for #{damage} damage"
    defender.get_damage(damage)    
  end

end