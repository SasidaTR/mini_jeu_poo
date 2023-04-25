require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

player1 = Player.new("José")
player2 = Player.new("Josiane")

def start(player1, player2)
  puts "\nVoici l'état de chaque joueur :" 
  puts "#{player1.name} a #{player1.life_points} points de vie."
  puts "#{player2.name} a #{player2.life_points} points de vie."
  puts "\nPassons à la phase d'attaque.\n"
end

def fight(player1, player2)
  while player1.life_points > 0 && player2.life_points > 0
    if rand(2) == 0
      puts "#{player1.name} commence !"
      player1.attacks(player2)
      if player2.life_points > 0
        player2.attacks(player1)
      end
    else rand(2) == 1
      puts "#{player2.name} commence !"
      player2.attacks(player1)
      if player1.life_points > 0
        player1.attacks(player2)
      end
    end
    start(player1, player2) if player1.life_points > 0 && player2.life_points > 0
  end
end

def perform(player1, player2)
  start(player1, player2)
  fight(player1, player2)
end

perform(player1, player2)