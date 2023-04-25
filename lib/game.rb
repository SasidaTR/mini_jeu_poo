class Game
  attr_accessor :human_player, :enemies

  def initialize(name)
    @human_player = HumanPlayer.new(name)
    @enemies = []
    puts "\nNombre d'ennemis ?"
    howmany = gets.chomp.to_i
    until howmany > 0 do
      puts "Choix invalide, veuillez saisir un choix valide."
      howmany = gets.chomp.to_i
    end
    howmany.times do |i|
      enemy = Player.new("Ennemi #{i+1}")
      @enemies << enemy
    end
  end

  def kill_player(player)
    @enemies.delete(player)
  end

  def is_still_ongoing?
    @human_player.life_points > 0 && !@enemies.empty?
  end

  def show_players
    puts @human_player.show_state
    puts "Il reste #{enemies.length} ennemi(s) en vie"
  end

  def menu
    puts "Quelle action veux-tu effectuer ?\n"
    puts "A - Chercher une meilleure arme"
    puts "S - Se soigner\n"
    puts "Attaquer un ennemi en vue :"
    @enemies.each_with_index do |enemy, i|
      puts "#{i} - #{enemy.show_state}"
    end
  end

  def menu_choice(choice)
    case choice
    when "a", "A"
      @human_player.search_weapon
    when "s", "S"
      @human_player.search_health_pack
    else
      index = choice.to_i
      if index < @enemies.length
        enemy = @enemies[index]
        @human_player.attacks(enemy)
        kill_player(enemy) if enemy.life_points <= 0
      else
        puts "Choix invalide, veuillez saisir un choix valide."
        choice = gets.chomp
        menu_choice(choice)
      end
    end
  end

  def enemies_attack
    puts "Les autres joueurs t'attaquent !" unless @enemies.empty?
    @enemies.each do |enemy|
      enemy.attacks(@human_player) if enemy.life_points > 0 && human_player.life_points > 0
    end
  end

  def end
    puts "La partie est finie"
    if @human_player.life_points > 0 && @enemies.empty?
      puts "BRAVO ! TU AS GAGNÉ !"
    else
      puts "Loser ! Tu as perdu !"
    end
  end
end