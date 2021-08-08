class Cocktail_Roulette
    def initialize
        puts "Welcome to Cocktail Roulette!"
        @spirits = []
        @liquors = []
        @mixers = []
        @doom = []
        @spirit_drink = []
        @liquor_drink = []
        @mixer_drink = []
        @doom_drink = []
        @past_drinks = []
        setup()
    end

    def setup()
        puts "How many Spirits do you have?"
        @spirit_number = gets.chomp.to_i
        puts "How many Liquors do you have?"
        @liquors_number = gets.chomp.to_i
        puts "How many mixers do you have?"
        @mixers_number = gets.chomp.to_i
        puts "Do you want any Doom shots?"
        doom_wheel = gets.chomp.downcase

        case doom_wheel 
            when "y" 
                puts "How many Doom shots do you have?"
                @doom_number = gets.chomp.to_i
            when "yes"
                puts "How many Doom shots do you have?"
                @doom_number = gets.chomp.to_i
            else
                @doom_number = 0
        end
        name_shots()
    end

    def name_shots()
        @spirit_number.times do |int|
            puts "#{int+1}. Name your next spirit:" 
            shot = gets.chomp
            @spirits << shot
            puts "Current spirits:#{@spirits}"
        end
        name_liquors()
    end

    def name_liquors()
        @liquors_number.times do |int|
            puts "#{int+1}. Name your next liquor:" 
            shot = gets.chomp
            @liquors << shot
            puts "Current liquors:#{@liquors}"
        end
        name_mixers()
    end

    def name_mixers()
        @mixers_number.times do |int|
            puts "#{int+1}. Name your next mixer:" 
            shot = gets.chomp
            @mixers << shot
            puts "Current mixers:#{@mixers}"
        
        end
        case @doom_number
        when  0
            spin_it()
        else
            name_doom()
        end
    end

    def name_doom()
        @doom_number.times do |int|
            puts "#{int+1}. Name your next Doom Shot:" 
            shot = gets.chomp
            @doom << shot
            puts "Current Doom Shots:#{@doom}"
        end
        spin_it()
    end

    def spin_it()
        puts "Time to Spin the Wheel! How many Shots do you want?" 
        @spirit_spins = gets.chomp.to_i
        puts "How many Liquors do you want?" 
        @liquor_spins = gets.chomp.to_i
        puts " How many Mixers do you want?" 
        @mixer_spins = gets.chomp.to_i
        if @doom_number !=0
            puts "How many Doom Shots do you want?" 
            @doom_spins = gets.chomp.to_i
        end
        puts "Type 'Spin' for one Spin, or 'Spin All' to get all the Spins!"
        spin_amount = gets.chomp.downcase
        case spin_amount
        when "spin"
           spin_slow()
        when "spin all"
           spin_fast()
        when "spinall"
           spin_fast()
        else
           puts "That's not a Valid Input!"
           spin_it()
        end
    end

    def spin_slow()
        puts "Type to Spin!"
        puts "Your Shots are..."
        @spirit_spins.times do |int|
            place_holder = gets.chomp
            @random_num = (rand*(@spirit_number.to_i)).floor 
            shot_chosen = @spirits[@random_num]
            puts "#{shot_chosen}!"
            @spirit_drink << shot_chosen
        end
        puts "#{@spirit_drink}!"
        puts "Your Liquors are..."
        @liquor_spins.times do |int|
            place_holder = gets.chomp
            @random_num = (rand*(@liquors_number.to_i)).floor
            liquor_chosen = @liquors[@random_num]
            puts "#{liquor_chosen}!"
            @liquor_drink << liquor_chosen
        end
        puts "#{@liquor_drink}!"
        puts "Your Mixers are..."
        @mixer_spins.times do |int|
            place_holder = gets.chomp
            @random_num = (rand*(@mixers_number.to_i)).floor
            mixer_chosen = @mixers[@random_num]
            puts "#{mixer_chosen}!"
            @mixer_drink << mixer_chosen
        end
        puts "#{@mixer_drink}!"
        case @doom_number 
        when 0 
            puts "Your full drink is:"
            full_drink = {spirits: @spirit_drink, liquor: @liquor_drink, mixer: @mixer_drink}
            puts "#{full_drink}"
            puts "Enjoy!"
        else
            puts "Your Doom Shots are..."
            @doom_spins.times do |int|
                place_holder = gets.chomp
                @random_num = (rand*(@doom_number.to_i)).floor
                doom_chosen = @doom[@random_num]
                puts "#{doom_chosen}!"
                @doom_drink << doom_chosen
            end
            puts "Your full drink is:"
            full_drink = {spirits: @spirit_drink, liquor: @liquor_drink, mixer: @mixer_drink, doom: @doom_drink}
            puts "#{full_drink}"
            puts "Enjoy!"
        end
        @past_drinks << full_drink
        spin_again()
    end
    def spin_fast()
        puts "Your Shots are..."
        @spirit_spins.times do |int|
            @random_num = (rand*(@spirit_number.to_i)).floor 
            shot_chosen = @spirits[@random_num]
            puts "#{shot_chosen}!"
            @spirit_drink << shot_chosen
        end
        puts "#{@spirit_drink}!"
        puts "Your Liquors are..."
        @liquor_spins.times do |int|
            @random_num = (rand*(@liquors_number.to_i)).floor
            liquor_chosen = @liquors[@random_num]
            puts "#{liquor_chosen}!"
            @liquor_drink << liquor_chosen
        end
        puts "#{@liquor_drink}!"
        puts "Your Mixers are..."
        @mixer_spins.times do |int|
            @random_num = (rand*(@mixers_number.to_i)).floor
            mixer_chosen = @mixers[@random_num]
            puts "#{mixer_chosen}!"
            @mixer_drink << mixer_chosen
        end
        puts "#{@mixer_drink}!"
        case @doom_number 
        when 0 
            puts "Your full drink is:"
            full_drink = {spirits: @spirit_drink, liquor: @liquor_drink, mixer: @mixer_drink}
            puts "#{full_drink}"
            puts "Enjoy!"
        else
            puts "Your Doom Shots are..."
            @doom_spins.times do |int|
                @random_num = (rand*(@doom_number.to_i)).floor
                doom_chosen = @doom[@random_num]
                puts "#{doom_chosen}!"
                @doom_drink << doom_chosen
            end
            puts "Your full drink is:"
            full_drink = {spirits: @spirit_drink, liquor: @liquor_drink, mixer: @mixer_drink, doom: @doom_drink}
            puts "#{full_drink}"
            puts "Enjoy!"
            puts full_drink
        end
        @past_drinks << full_drink
        spin_again()
    end
    

    def spin_again()
        puts "Past Drinks: #{@past_drinks}"
        puts "Spin Again?"
        another_go = gets.chomp.downcase
        if another_go == "yes" || another_go == "y"
            @spirit_drink = []
            @liquor_drink = []
            @mixer_drink = []
            @doom_drink = []
            full_drink = []
            @spirit_spins = 0
            @liquor_spins = 0
            @mixer_spins = 0
            @doom_spins = 0
            spin_it()
        else
            puts "Thanks for playing! Goodbye!"
        end
    end   
end