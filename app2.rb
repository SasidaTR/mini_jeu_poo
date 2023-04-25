require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

puts "------------------------------------------------"
puts "|Bienvenue sur ILS VEULENT TOUS MA POO !      |"
puts "|Le but du jeu est d'être le dernier survivant !|"
puts "-------------------------------------------------"

puts "\nQuel est ton nom ?"
user_name = gets.chomp
user = HumanPlayer.new(user_name)

player1 = Player.new("José")
player2 = Player.new("Josiane")

enemies = [player1, player2]

while user.life_points > 0 && (player1.life_points > 0 || player2.life_points > 0)
  puts user.show_state
  puts "Quelle action veux-tu effectuer ?"
  puts "A - Chercher une meilleure arme"
  puts "S - Chercher à se soigner"

  puts "\nAttaquer un joueur en vue :"
  puts "0 - #{player1.show_state}"
  puts "1 - #{player2.show_state}"
  choice = gets.chomp
  while choice != "a" && choice != "A" && choice != "s" && choice != "S" && choice != "0" && choice != "1"
    puts "Cette action n'existe pas, veuillez en choisir une autre :"
    choice = gets.chomp
  end
  case choice
  when "a", "A"
    user.search_weapon
  when "s", "S"
    user.search_health_pack
  when "0"
    user.attacks(player1)
  when "1"
    user.attacks(player2)
  end
  if player1.life_points > 0 || player2.life_points > 0
    puts "\nLes autres joueurs t'attaquent !\n"
  end
  enemies.each do |enemy|
    if enemy.life_points > 0
      enemy.attacks(user)
    end
  end
end

puts "La partie est finie"
if user.life_points > 0
  puts "BRAVO ! TU AS GAGNÉ !"
else
  puts "Loser ! Tu as perdu !"
end