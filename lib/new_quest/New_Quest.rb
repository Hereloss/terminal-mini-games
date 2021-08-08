# require './UserClass'

class New_Quest
    def initialize
        puts "Welcome to Cantor!"
        puts "Your Jorney is about to Begin!"
        # @user = User.new()
        @gold = 0
        @health = 0
        @inventory = ''
        @dead = 0
        @inn_entry = false
    end

    def Start
        puts "What is your name?"
        name = gets.chomp
        puts "Welcome #{name}!"
        @gold = 20
        @health = 100
        @inventory = []
        puts "You have #{@gold} gold and #{@health}health!"
        puts "You have just arrived in the town. North, East or West?"
        first_choice()
    end

    def first_choice()
        direction = gets.chomp.downcase
        case direction
        when 'west'
            west_walk()
            # if @user.isNotDead?
            if @dead != 1
                first_choice()
            end
        when 'east'
            east_walk()
            if @dead !=1
                first_choice()
            end
        when 'north'
            north_walk()
            if @dead !=1 && @inn_entry != 1
                first_choice()
            else
                return "You're dead!"
            end
        else
            puts "That's not a Valid Direction!"
            first_choice()
        end
    end

    def west_walk()
        puts "You walk west. You come upon a Market stall. What do you say?"
        speech = gets.chomp
        puts "You say #{speech}. The Stall holder says 'The sword is 10. Do you want it?'"
        speech_2 = gets.chomp
        if speech_2 == 'Yes'
            @gold = @gold - 10
            puts "You get a Sword!"
            @inventory ='Sword'
            puts "You walk back the way you came. North, East or West?"
            west_direction = 1
        end
        if speech_2 == 'No'
            puts "Suit yourself!"
            puts "You walk back the way you came. North, East or West?"
            west_direction = 1
        end
        if west_direction !=1
            west_walk()
        end
    end

    def east_walk
        puts "Suddenly, a Bandit Attacks! Do you attack?"
        attack = gets.chomp
        if attack == 'Yes'
            if @inventory == 'Sword'
                puts "You attack with your sword and are victorious!"
                puts "You walk back the way you came. North, East or West?"
                sword = 1
            end
            if sword !=1
                puts "You have no sword! You punch, but get injured!"
                @health = @health - 50
                if @health < 0
                    puts "You're dead!"
                    dead()
                end
                puts "Your health is #{@health}. You limp back the way you came. North, East or West?"
            end 
            attack_complete = 1
        end

        if attack == 'No'
            puts "You run away! You get slightly injured!"
            @health = @health - 10
            puts "Your health is #{@health}. You limp back the way you came. North, East or West?"
            attack_complete = 1
        end
        if attack_complete !=1
            east_walk()
        end
    end

    def north_walk()
        puts "You walk North, and come to the Inn. The Innkeeper looks at you. 'Well?'"
        speech_3 = gets.chomp
        puts "Oh really? Well, a room is 10 Gold. Can you pay?"
        speech_inn = gets.chomp
        @inn_entry = 0
        if speech_inn == 'Yes'
            if @gold > 9
                puts "Very well. Come in!"
                puts "You walk into the Inn."
                @gold = @gold - 10
                @inn_entry = 1
                inn()
            end
            if @gold < 10
                puts "No you can't! Guards!"
                puts "You try to run, but the Guards surround and kill you!"
                return dead()
            end
            inn_talk = 1
        end

        if speech_inn == 'No'
            puts "I thought as much! Go away!"
            puts "You walk back the way you came. North, East or West?"
            inn_talk = 1
        end

        if inn_talk != 1
            puts "What?"
            puts "Try again!"
            north_walk()
        end
    end

    def inn()
        puts "You relax at the Inn. Congratulations! You did it!"
        quest_two()
    end

    def dead()
        @dead = 1
        return "You were killed! Try again!"
    end

    def quest_two()
        puts "You wake up rested the next day."
        puts "You leave the Inn. Do you want to Busk, go to Church or the Stadium?"
        second_choice()
    end

    def second_choice()
        place = gets.chomp
        if place == 'Busk'
            busk_walk()
            place_number = 1
            if dead !=1
                second_choice()
            end
            
        end
    
        if place == 'Stadium'
            stadium_walk()
            place_number = 1
            if dead !=1
                second_choice()
            end
            
        end
    
        if place == 'Church'
            church_walk()
            place_number = 1
            if dead !=1
                second_choice() 
            end
        end
        if place_number !=1
            puts "That's not a Valid Direction!"
            second_choice()
        end
    end

    def busk_walk()
         puts "You pull out your lute and begin to play.Do you play a Happy, Sad or Angry song?"
         song_genre = gets.chomp
         song = 0
        if song_genre == 'Happy'
            puts "People clap and cheer to the song! You get 10 Gold!"
            puts "You return to the Inn. Do you want to Busk, go to Church or the Stadium?"
             @gold = @gold + 10
            song = 1
            end
         if song_genre == 'Sad'
             puts "People boo the song and you get hit with Fruit! You lost 10 Health!"
             puts "You return to the Inn. Do you want to Busk, go to Church or the Stadium?"
             @health = @health -10
             song = 1
        end
        if song_genre == 'Angry'
             puts "An agent comes up to you.'Buddy, you shouldn't play that here. Come with me to the Stadium!'"
            stadium_walk()
            song = 1
        end
        if song !=1
            puts "That's not an option!"
            busk_walk()
        end
    end

    def church_walk()
        puts "You walk into the Church. A Priest approaches. 'What is the matter, my son?'"
        response = gets.chomp
        puts "#{response}? I see. Do you want to Confess, Ignore this or Pray?"
        response_2 = gets.chomp
        if response_2 == "Confess"
            puts "...I see. You're a monster. I will put you down."
            puts "The Priest leaps up and fights you!"
            if @inventory == 'Sword'
                puts "You draw your sword and slice through the Priest! However, you then flee from the rest of the congregation!"
                church = 1
            end
            if @inventory == ''
                puts "The Priest cuts your throat and you bleed out on the floor!"
                dead()
            end
        end
        if response_2 == "Ignore" or response_2 == "Ignore this"
            puts "The Priest sighs and walks away. You finish praying and leave"
            puts "You return to the Inn. Do you want to Busk, go to Church or the Stadium?"
            church = 1
        end
        if response_2 == 'Pray'
            puts "The Priests nods. 'Now, please, the prayer fee.' You pay 5 gold and leave"
            puts "You return to the Inn. Do you want to Busk, go to Church or the Stadium?"
            @gold = @gold - 5
            church = 1
        end
        if church != 1
            puts "The Priest looks at you. 'Please leave and come back in - we'll try that again...'"
            church_walk()
        end
    end

    def stadium_walk()
        puts "You walk up to the Stadium. You hear cheering as you walk up to it."
        puts "A man looks at you. 'Here to enter?'"
        entry_1 = gets.chomp
        if entry_1 == 'Yes'
            puts "Ok, get on in there!"
            stadium_fight()
            stadium = 1
        end
        if entry_1 == 'No'
            puts "Ok, well tickets are 25. Pay up."
            if @gold > 25
                puts "Very well. Come in!"
                puts "You walk into the Stadium and enjoy a great show! You then return to the Inn"
                @gold = @gold - 25
                stadium = 1
            end
            if @gold < 24
                puts "You can't pay? Guards!"
                puts "You try to run, but the Guards surround and kill you!"
                dead()
            end
        end
        if stadium != 1
            puts "No answer? Well, come back in a few then..."
            stadium_walk()
        end
    end
    

    def stadium_fight()
        puts "You enter the ring. A man walks up to you. 'Do you want a new weapon?'"
        puts "He continues 'We have a Iron Sword for 15, Axe for 20 or Mega-Dagger for 30. Which would you like?"
        puts "Please select: Iron Sword, Axe, Mega-Dagger, None"
        weapon = gets.chomp
        if weapon == 'Iron Sword'
            inventory = 'Iron Sword'
            weapon_choice = 1
            puts "You collect an Iron Sword. Your first opponent is unarmed. Attack or Defend?"
            attack = gets.chomp
            if attack == 'Attack'
                puts "You defeat them easily!"
                opponent_1 = 1
            end
            if attack == 'Defend'
                puts "You defend and win - but take some damage!"
                @health = @health - 10
                opponent_1 =1
            end
            if opponent_1 !=1
                puts "You do nothing! You win - but just!"
                @health = @health - 50
            end
                puts "Your second opponent has a strong sword. Attack or Defend?"
                attack_2 = gets.chomp
            if attack_2 == 'Attack'
                puts "You defeat them - but lose some health!"
                @health = @health - 10
                opponent_2 = 1
            end
            if attack_2 == 'Defend'
                puts "You defend, and they fall over! You win flawlessly"
                opponent_2 =1
            end
            if opponent_2 !=1
                puts "You do nothing! You lose and die!"
                dead()
            end
            puts "Your final opponent has full armour and a battleaxe. Attack or Defend?"
            attack_3 = gets.chomp
            if attack_3 == 'Attack'
                puts "You try - but lose and die!"
                dead()
            end
            if attack_3 == 'Defend'
                puts "You defend, and they take pity and spare your life!"
                @health = 5
                opponent_3 =1
            end
            if opponent_3 !=1
                puts "You do nothing! You lose and die!"
                dead()
            end
            puts "You lose - but just about survive! You go back to the Inn."
            inventory == 'Sword'
            second_choice()
        end
        if weapon == 'Axe'
            inventory = 'Axe'
            weapon_choice = 1
            win = 0
            puts "You collect an Axe. Your first opponent is unarmed. Attack or Defend?"
            attack = gets.chomp
            if attack == 'Attack'
                puts "You defeat them easily!"
                opponent_1 = 1
            end
            if attack == 'Defend'
                puts "You defend and win - but take some damage!"
                @health = @health - 5
                opponent_1 =1
            end
            if opponent_1 !=1
                puts "You do nothing! You win - but just!"
                @health = @health - 30
            end
            puts "Your second opponent has a strong sword. Attack or Defend?"
            attack_2 = gets.chomp
            if attack_2 == 'Attack'
                puts "You defeat them - but lose some health!"
                @health = @health - 10
                opponent_2 = 1
            end
            if attack_2 == 'Defend'
                puts "You defend, and they fall over! You win flawlessly"
                opponent_2 =1
            end
            if opponent_2 !=1
                puts "You do nothing! You lose and die!"
                dead()
            end
            puts "Your final opponent has full armour and a battleaxe. Attack or Defend?"
            attack_3 = gets.chomp
            if attack_3 == 'Attack'
                puts "You manage to get a lucky blow, and win the tornament!"
                opponent_3 = 1
                win = 1
            end
            if attack_3 == 'Defend'
                puts "You defend, and they take pity and spare your life!"
                @health = 5
                opponent_3 =1
            end
            if opponent_3 !=1
                puts "You do nothing! You lose and die!"
                dead()
            end
            if win != 1
                puts "You lose - but just about survive! You go back to the Inn."
                second_choice()
            end
            if win == 1
                puts "You win the prize pot of 150 gold! You proceed to go to the gate to leave town."
                @gold = @gold + 150
            end
        end
        
        if weapon == 'Mega-Dagger'
            weapon_choice = 1
            inventory = 'Mega-Dagger'
            puts "You collect a Mega-Dagger. Your first opponent is unarmed. Attack or Defend?"
            attack = gets.chomp
            if attack == 'Attack'
                puts "You defeat them easily!"
                opponent_1 = 1
            end
            if attack == 'Defend'
                puts "You defend and win!"
                opponent_1 =1
            end
            if opponent_1 !=1
                puts "You do nothing! You win easily!"
            end
            puts "Your second opponent has a strong sword. Attack or Defend?"
            attack_2 = gets.chomp
            if attack_2 == 'Attack'
                puts "You draw your dagger - and accidentally kill yourself!"
                dead()
            end
            if attack_2 == 'Defend'
                puts "You defend, and your dagger breaks and they kill you!"
                dead()
            end
            if opponent_2 !=1
                puts "You do nothing! You lose and die!"
                dead()
            end
        end
        if weapon == 'None'
            weapon_choice = 1
            puts "You collect.. Nothing? Your first opponent is unarmed. Attack or Defend?"
            attack = gets.chomp
            if attack == 'Attack'
                puts "You are beaten almost to death - but live!"
                second_choice()
            end
            if attack == 'Defend'
                puts "You defend and die!"
                dead()
            end
            if opponent_1 !=1
                puts "You do nothing! You are killed easily!"
                dead()
            end
        end
        if weapon_choice !=1
        puts "Umm...maybe try that again?"
        stadium_fight()
        end
    end
end

