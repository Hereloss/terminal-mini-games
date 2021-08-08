class Guesser
  def initialize
    @num_guesses = 0
    @random_num = nil
  end

  def guess
    generate_num() if first_round()
    puts "Guess!"
    number = gets.chomp.to_i
    guess_correct = check_guess(number)

    if guess_correct
      @num_guesses = 0
      @random_num = nil
      return "Correct"
    else
      guess_again(number)
    end
  end

  private

  def first_round
    @num_guesses == 0
  end

  def generate_num
    @random_num = (rand*100).floor
    puts "I'm ready"
  end

  def check_guess(number)
    if number == @random_num
      return true
    end
    
    false
  end

  def is_higher?(number)
    if number > @random_num
      return true
    end

    false
  end

  def guess_again(number)
    puts "Guess again!"

    if is_higher?(number)
      puts "Too High!"
    else
      puts "Too Low!"
    end

    @num_guesses += 1
    return guess()
  end
end