class Player
  attr_accessor :name, :life_points
  
  def initialize(name)
    @name = name
    @life_points = 10
  end
  
  def show_state
    if @life_points <= 0
      return "#{@name} : inerte."
    else
      return "#{@name} : #{@life_points} points de vie."
    end
  end
  
  def gets_damage(damage_received)
    @life_points -= damage_received
    if @life_points <= 0
      puts "\n#{@name} a été tué !"
    end
  end
  
  def attacks(player_attacked)
    damage_inflicted = compute_damage
    puts "#{name} attaque #{player_attacked.name} et inflige #{damage_inflicted} points de dommages."
    player_attacked.gets_damage(damage_inflicted)
  end
  
  def compute_damage
    return rand(1..6)
  end
end


class HumanPlayer < Player
  attr_accessor :weapon_level

  def initialize(name)
    super(name)
    @life_points = 100
    @weapon_level = 1
  end

  def show_state
    puts "\n#{@name} a #{@life_points} points de vie et une arme de niveau #{@weapon_level}."
  end

  def compute_damage
    rand(1..6) * @weapon_level
  end

  def search_weapon
    new_weapon_level = rand(1..6)
    puts "\nTu as trouvé une arme de niveau #{new_weapon_level}."
    if new_weapon_level > @weapon_level
      puts "Youhou ! elle est meilleure que ton arme actuelle : tu la prends."
      @weapon_level = new_weapon_level
    else
      puts "M@*#$... elle n'est pas mieux que ton arme actuelle..."
    end
  end

  def search_health_pack
    health_pack = rand(1..6)
    if health_pack == 1
      puts "\nTu n'as rien trouvé... "
    elsif health_pack >= 2 && health_pack <= 5
      puts "\nBravo, tu as trouvé un pack de +50 points de vie !"
      if @life_points + 50 > 100
        @life_points = 100
      else
        @life_points = @life_points + 50
      end
    else
      puts "\nWaow, tu as trouvé un pack de +80 points de vie !"
      if @life_points + 80 > 100
        @life_points = 100
      else
        @life_points = @life_points + 80
      end
    end
  end
end