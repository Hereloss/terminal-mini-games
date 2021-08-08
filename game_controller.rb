require_relative 'lib/maze/maze.rb'
require_relative 'lib/cocktail_roulette/cocktail_roulette.rb'
require_relative 'lib/grandparadox/Grandparadox.rb'
require_relative 'lib/guesser/guesser.rb'
require_relative 'lib/new_quest/New_Quest.rb'
require_relative 'lib/poker/Poker.rb'

class GameController

    def initialize
        puts "Welcome to the game!"
        @games = ["Maze", "Poker", "Guesser", "Grandparadox", "Quest", "Cocktail Roulette", "None of these"]
        choose_game()
    end

    def choose_game
        puts "Select the number of the game you'd like to play:"
        @games.each.with_index do |game, index|
            puts "#{index + 1}. #{game}"
        end
        game = gets.chomp.to_i
        case game
            when 1
                system("cls")
                Maze.new()
                system("cls")
                choose_game()
            when 2
                system("cls")
                puts "Poker isn't quite ready yet!"
                puts ""
                choose_game()
            when 3
                system("cls")
                Guesser.new()
                system("cls")
                choose_game()
            when 4
                system("cls")
                Grandparadox.new()
                system("cls")
                choose_game()
            when 5 
                system("cls")
                New_Quest.new()
                system("cls")
                choose_game()
            when 6 
                system("cls")
                CocktailRoulette.new()
                system("cls")
                choose_game()
            when 7
                system("cls")
                puts "No game? Boo! Bye then!"
                return
            end
        end

end