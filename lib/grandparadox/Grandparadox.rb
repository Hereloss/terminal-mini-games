class Grandparadox

    def initialize
        @alive_grandpa = 11
        @turn = 0
        @grandpas = {0 => 130, 10 => 150, 20 => 200, 30 => 150, 40 => 130, 50 => 120, 60 => 100, 70 => 80, 80 => 70, 90 => 50, 100 => 30}
        @counters = 8
        puts "How the game works: The Murderer is trying to kill Grandad, and the Savior is trying to save him!"
        puts "Either send damage or saving energy back through time to either save or kill Grandad!"
        puts "If 20 Year old Grandad dies, Murderers Win! If 10 Turns pass without death, Saviors win and the Time Police arrest you!"
        puts "Good luck, and have fun!"
        turns()
    end

    def turns()
        @turn += 1
        murder_turn()
        savior_turn()
    end

    def murder_turn()
        murder_count = Hash.new(0)
        counters_used = 0
        puts @grandpas
        puts "Turn #{@turn}! Please state the first Grandpa's age you'd like to attack!"
        puts "#{counters_used} counters used!"
        age = gets.chomp.to_i
        if age % 10 != 0 || age > 100
            puts "That's not a valid age!"
            murder_turn()
        else
            if @grandpas[age] == "Dead" || @grandpas[age] == nil
                puts "That grandpa is already dead!"
                murder_turn()
            else
        puts "Please state the number of damage counters you'd like to put on this Grandpa:"
        counters_u = gets.chomp.to_i
        if counters_u + counters_used.to_i < @counters.to_i + 1
            murder_count[age] += counters_u
        else
            puts "You don't have that many counters!"
            murder_turn()
        end
        counters_used = counters_u + counters_used
        if counters_used.to_i < @counters
            murder_second_put(counters_used,murder_count)
        else
            puts "\e[2J"
            puts "Muderer's turn over!"
            @turn_murder = murder_count
        end
    end
    end
    end

    def murder_second_put(counters_used,murder_count)
        puts "Please state the next Grandpa's age you'd like to attack!"
        puts "#{counters_used} counters used!"
        puts murder_count
        age = gets.chomp.to_i
        if age % 10 != 0 || age > 100
            puts "That's not a valid age!"
            murder_second_put(counters_used,murder_count)
        else
            if @grandpas[age] == "Dead" || @grandpas[age] == nil
                puts "That grandpa is already dead!"
                murder_second_put(counters_used,murder_count)
            else
            puts "Please state the number of damage counters you'd like to put on this Grandpa:"
            counters_u = gets.chomp.to_i
            if counters_u + counters_used.to_i < @counters.to_i + 1
                murder_count[age] += counters_u
            else
                puts "You don't have that many counters!"
                murder_second_put(counters_used,murder_count)
            end
            counters_used = counters_u + counters_used
            if counters_used < @counters
                murder_second_put(counters_used,murder_count)
            else
                puts "\e[2J"
                puts "Muderer's turn over!"
                @turn_murder = murder_count
            end
        end
        end
    end

    def savior_turn()
        saving_count = Hash.new(0)
        counters_used = 0
        puts "Turn #{@turn}! Please state the first Grandpa's age you'd like to Defend!"
        puts "#{counters_used} counters used!"
        age = gets.chomp.to_i
        if age % 10 != 0 || age > 100
            puts "That's not a valid age!"
            savior_turn()
        else
            if @grandpas[age] == "Dead" || @grandpas[age] == nil
                puts "That grandpa is already dead!"
                savior_turn()
            else
        puts "Please state the number of Saving counters you'd like to put on this Grandpa:"
        counters_u = gets.chomp.to_i
        if counters_u + counters_used.to_i < @counters.to_i + 1
            saving_count[age] += counters_u
        else
            puts "You don't have that many counters!"
            savior_turn()
        end
        counters_used = counters_u + counters_used
        if counters_used.to_i < @counters
            savior_second_put(counters_used,saving_count)
        else
            puts "\e[2J"
            puts "Saviors's turn over!"
            @turn_savior = saving_count
            end_turn()
        end
    end
    end
    end

    def savior_second_put(counters_used,saving_count)
        puts "Please state the next Grandpa's age you'd like to defend!"
        puts "#{counters_used} counters used!"
        puts saving_count
        age = gets.chomp.to_i
        if age % 10 != 0 || age > 100
            puts "That's not a valid age!"
            savior_second_put(counters_used,saving_count)
        else
            if @grandpas[age] == "Dead" || @grandpas[age] == nil
                puts "That grandpa is already dead!"
                savior_second_put(counters_used,saving_count)
            else
            puts "Please state the number of saving counters you'd like to put on this Grandpa:"
            counters_u = gets.chomp.to_i
            if counters_u + counters_used.to_i < @counters.to_i + 1
                saving_count[age] += counters_u
            else
                puts "You don't have that many counters!"
                savior_second_put(counters_used,saving_count)
            end
            counters_used = counters_u + counters_used
            if counters_used < @counters
                savior_second_put(counters_used,saving_count)
            else
                puts "\e[2J"
                puts "Saviors's turn over!"
                @turn_savior = saving_count
                end_turn()
            end
        end
        end
    end

    def end_turn()
        @oldest_dead = 110
        @turn_savior.each do |k,v|
        if @turn_murder[k] == 0
            @turn_savior[k] = 0
        end
        end
        @new_damage = Hash.new(0)
        @new_damage = @turn_murder.merge(@turn_savior) { |k, v1, v2| v1 - v2 }
        @new_damage.select! {|k,v| v > 0}
        puts @new_damage
        @grandpas = @grandpas.merge(@new_damage) { |k, v1, v2| v1 - (v2 * 10) }
        @grandpas.each do |k,v|
            if v != "Dead" && 0 > v.to_i 
                puts "Grandpa #{k} is dead!"
                @grandpas[k] = "Dead"
                @oldest_dead = k
                if k == 20 || k == 10 || k == 0
                    puts "Murderers Win!"
                    murder_win()
                else
                @alive_grandpa -= 1
                @counters += 1
                end
            else
            end
        end
        if @oldest_dead != 110
            @grandpas.each do |k,v|
                if @oldest_dead < k
                    @grandpas[k] = "Dead"
                    puts "Grandpa #{k} is dead!"
                else
                end
            end
            @oldest_dead = 110
        end
        puts "20 Year old Grandpa still Lives!"
        if @turn == 10
            puts "\e[2J"
            puts "The Time Police caught you! Saviors Win!"
            savior_win()
        end
        turns()
    end

    def savior_win()
        puts "Saviors won this game. Play again?"
        input_new = gets.chomp
        if input_new == "y" || input_new.downcase == "yes"
            new_game()
        else
            return "Thank you for playing! Goodbye!"
        end
    end

    def murder_win()
        puts "Murderers won this game. Play again?"
        input_new = gets.chomp
        if input_new == "y" || input_new.downcase == "yes"
            new_game()
        else
            return "Thank you for playing! Goodbye!"
        end
    end

    def new_game()
        @alive_grandpa = 11
        @turn = 0
        @grandpas = {0 => 130, 10 => 150, 20 => 200, 30 => 150, 40 => 130, 50 => 120, 60 => 100, 70 => 80, 80 => 70, 90 => 50, 100 => 30}
        @counters = 8
        puts "New game time!"
        turns()
    end
end