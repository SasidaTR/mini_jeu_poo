require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

puts "Ton prénom ?"
name = gets.chomp
game = Game.new(name)

# Boucle principale du jeu
while game.is_still_ongoing?
  game.show_players
  game.menu
  choice = gets.chomp
  game.menu_choice(choice)
  game.enemies_attack
end

# Affiche le résultat de la partie
game.end