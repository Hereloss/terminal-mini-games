class Poker

    def initialize
        h_deck = [[2,"h"],[3,"h"],[4,"h"],[5,"h"],[6,"h"],[7,"h"],[8,"h"],[9,"h"],[10,"h"],["J","h"],["Q","h"],["K","h"],["A","h"]]
        c_deck = [[2,"c"],[3,"c"],[4,"c"],[5,"c"],[6,"c"],[7,"c"],[8,"c"],[9,"c"],[10,"c"],["J","c"],["Q","c"],["K","c"],["A","c"]]
        d_deck = [[2,"d"],[3,"d"],[4,"d"],[5,"d"],[6,"d"],[7,"d"],[8,"d"],[9,"d"],[10,"d"],["J","d"],["Q","d"],["K","d"],["A","d"]]
        s_deck = [[2,"s"],[3,"s"],[4,"s"],[5,"s"],[6,"s"],[7,"s"],[8,"s"],[9,"s"],[10,"s"],["J","s"],["Q","s"],["K","s"],["A","s"]]
        full_deck = [h_deck,s_deck,c_deck,d_deck]
        @score = 0
        @players = {player_1_s => 0, player_2_s => 0, player_1_m => 10000, player_2_m => 10000}
        @player = 1
        deal(h_deck,c_deck,d_deck,s_deck,full_deck)
    end

    def deal(h_deck,c_deck,d_deck,s_deck,full_deck)
        puts "Player #{@player}'s go!"
        my_hand = []
        5.times do
            random = rand(4)
            suit = full_deck[random]
            suit_shuffle = suit.shuffle
            card = suit_shuffle[0]
            my_hand << card
            card = []
        end
        game(my_hand,h_deck,c_deck,d_deck,s_deck,full_deck)
    end

    def game(my_hand,h_deck,c_deck,d_deck,s_deck,full_deck)
        print my_hand
        puts ""
        i = 1
        3.times do
            puts "Round #{i}!"
            puts "How many cards do you want to change?"
            change = gets.chomp.to_i
            change.times do
                puts "Which card position would you like to change?"
                position = gets.chomp.to_i
                my_hand.delete_at(position - 1)
                random = rand(4)
                suit = full_deck[random]
                suit_shuffle = suit.shuffle
                card = suit_shuffle[0]
                my_hand << card
                card = []
                print my_hand
                puts ""
            end
            print my_hand
            puts ""
            i += 1
        end
        winner(my_hand)
    end

    def winner(my_hand)
        order = [2,3,4,5,6,7,8,9,10,"J","Q","K","A"]
        if my_hand[0][1] == my_hand [1][1] && my_hand[0][1] == my_hand [2][1] && my_hand[0][1] == my_hand [3][1] && my_hand[0][1] == my_hand [4][1]
            flush(my_hand)
        else
            straight = [my_hand[0][0],my_hand[1][0],my_hand[2][0],my_hand[3][0],my_hand[4][0]]
            new_straight = straight.sort_by { |e| order.index(e) }
            p new_straight
            first = new_straight[0]
            start = order.find_index(first)
            ideal_straight = order[start..(start+4)]
            if ideal_straight.length < 5
                gain = 5 - ideal_straight.length
                i = 1
                gain.times do
                    ideal_straight.unshift[order[start.to_i - i]]
                    i += 1
                end
            else
            end
            p ideal_straight
            if ideal_straight == new_straight
                straight(my_hand,new_straight)
            else
                pairs(my_hand,new_straight)
            end
        end
    end

    def flush(my_hand)
        p "flush!"
        straight = [my_hand[0][0],my_hand[1][0],my_hand[2][0],my_hand[3][0],my_hand[4][0]]
        new_straight = straight.sort_by { |e| order.index(e) }
        p new_straight
        first = new_straight[0]
        start = order.find_index(first)
        ideal_straight = order[start..(start+4)]
        if ideal_straight.length < 5
            gain = 5 - ideal_straight.length
            i = 1
            gain.times do
                ideal_straight.unshift[order[start.to_i - i]]
                i += 1
            end
        end
        p ideal_straight
        if ideal_straight == new_straight
            straight_flush(my_hand,new_straight)
        else
            temp_score = 0
            new_straight.each do |ele|
                royal = ["J","Q","K","A"]
                if royal.include? ele
                    position = royal.find_index(ele)
                    temp_score += (position + 11)
                else
                    @score += ele
                end
            end
            @score += temp_score * 10000000
        end
        puts "Your score is #{@score}!"
    end
    
    def straight(my_hand,new_straight)
        p "straight!"
        @score += new_straight[0] * 1000000
        puts "Your score is #{@score}!"
    end

    def pairs(my_hand,new_straight)
        p "pairs!"
        if new_straight[0] == new_straight[3] || new_straight[1] == new_straight[4]
            kind4(my_hand,new_straight)
        elsif new_straight[0] == new_straight[2] || new_straight[1] == new_straight[3] || new_straight[2] == new_straight[4]
            kind3(my_hand,new_straight)
        elsif new_straight.uniq.length == 5
            high_card(my_hand,new_straight)
        elsif new_straight.uniq.length == 4
            pair(my_hand,new_straight)
        else
            solos = new_straight.select{ |e| new_straight.count(e) > 1 }
            solos_n = solos.uniq
            solos_n.each do |ele|
                royal = ["J","Q","K","A"]
                if royal.include? ele
                    position = royal.find_index(ele)
                    @score = (position + 11) * 100
                else
                    @score += ele * 100
                end
            end
            puts "Your score is #{@score}!"
        end
    end

    def straight_flush(my_hand,new_straight)
        p "straight flush!"
        @score += new_straight[0] * 100000000
        puts "Your score is #{@score}!"
    end

    def high_card(my_hand,new_straight)
        p "high card!"
        royal = ["J","Q","K","A"]
        h_card = new_straight[4]
        if royal.include? h_card
            position = royal.find_index(h_card)
            p position
            @score += (position + 11)
        else
            @score += new_straight[4]
        end
        puts "Your score is #{@score}!"
        name = "player_#{player}_s"
    end

    def pair(my_hand,new_straight)
        print "one pair!"
        solos = new_straight.detect{ |e| new_straight.count(e) > 1 }
        royal = ["J","Q","K","A"]
        if royal.include? solos
            position = royal.find_index(solos)
            @score += (position + 11) * 10
        else
            @score += solos * 10
        end
        puts "Your score is #{@score}!"
    end

    def kind4(my_hand,new_straight)
        print "4 of a kind!"
        royal = ["J","Q","K","A"]
        if royal.include? new_straight[2]
            position = royal.find_index(new_straight[2])
            @score += (position + 11) * 10000
        else
            @score += new_straight[2] * 10000
        end
        puts "Your score is #{@score}!"
    end

    def full_house(my_hand,new_straight)
        print "full house!"
        royal = ["J","Q","K","A"]
        if royal.include? new_straight[2]
            position = royal.find_index(new_straight[2])
            @score += (position + 11) * 100000
        else
            @score += new_straight[2] * 100000
        end
        if new_straight[2] == new_straight [1]
            if royal.include? new_straight[3]
                position = royal.find_index(new_straight[3])
                @score += (position + 11) * 100000
            else
                @score += new_straight[3] * 100000
            end
        else
            if royal.include? new_straight[1]
                position = royal.find_index(new_straight[1])
                @score += (position + 11) * 100000
            else
                @score += new_straight[1] * 100000
            end
        end
        puts "Your score is #{@score}!"
    end

    def kind3(my_hand,new_straight)
        puts "3 of a kind!"
        full_h = new_straight.uniq
        if full_h.length == 2
            full_house(my_hand,new_straight)
        else
        royal = ["J","Q","K","A"]
        if royal.include? new_straight[2]
            position = royal.find_index(new_straight[2])
            @score += (position + 11) * 1000
        else
            @score += new_straight[2] * 1000
        end
        puts "Your score is #{@score}!"
        end 
    end


end