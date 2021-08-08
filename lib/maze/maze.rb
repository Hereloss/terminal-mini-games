require_relative 'generator'

class Maze
    def initialize
        maze_gen = Generator.new()
        maze = maze_gen.maze
        location = [maze_gen.height - 1, maze_gen.width - 2]
        @moves = -1
        maze_time(maze,location)
    end

    def maze_time(maze,location)
        system("cls")
        puts "Time to Solve the maze! Please type Up, Down, Left or Right to solve the maze!"
        @moves += 1
        puts "Total Moves: #{@moves}"
        maze[location[0]][location[1]] = "X"
        maze.each do |arr|
            p arr
        end
        maze[location[0]][location[1]] = 0
        direction = gets.chomp.downcase
        if direction == "left"
            left_move(maze,location)

         elsif direction. == "right"
            right_move(maze,location)

         elsif direction == "up"
            up_move(maze,location)

         elsif direction == "down"
            down_move(maze,location)

         else
            puts "That's not a direction!"
            maze_time(maze,location)
         end
    end

    def left_move(maze,location)
        first = location[0]
        second = location [1] - 1
        if maze[first][second] == 0 && location[1] != 0
            puts "You move left!"
            location[1] -= 1
            p location
            if location == [0, 1]
                puts "You solved it!"
                puts "Victory! Total Moves: #{@moves}"
                return "Done!"
            else
               maze_time(maze,location)

            end 
        else 
            puts "There's a Wall in the way!"
            maze_time(maze,location)
        end
    end

    def right_move(maze,location)
        first = location[0]
        second = location [1] + 1
        if maze[first][second] == 0 && location[1] != 4
            puts "You move right!"
            location[1] += 1
            p location
            if location == [0, 1]
                puts "You solved it!"
                puts "Victory! Total Moves: #{@moves}"
                return "Done!"
            else
               maze_time(maze,location)
            end 
        else 
            puts "There's a Wall in the way!"
            maze_time(maze,location)
        end
    end

    def up_move(maze,location)
        first = location[0] - 1
        second = location [1]
        if maze[first][second] == 0 && location[0] != 0
            puts "You move up!"
            location[0] -= 1
            p location
            if location == [0, 1]
                puts "You solved it!"
                puts "Victory! Total Moves: #{@moves}"
                return "Done!"
            else
               maze_time(maze,location)
            end 
        else 
            puts "There's a Wall in the way!"
            maze_time(maze,location)
        end
    end

    def down_move(maze,location)
        first = location[0] + 1
        second = location [1] 
        if location[0] != 6
            if maze[first][second] == 0
               puts "You move down!"
               location[0] += 1
               p location
               if location == [0, 1]
                puts "You solved it!"
                puts "Victory! Total Moves: #{@moves}"
                return "Done!"
            else
               maze_time(maze,location)
            end 
            else
                puts "There's a Wall in the way!"
                maze_time(maze,location)
            end
        else 
            puts "There's a Wall in the way!"
            maze_time(maze,location)
        end
    end
end
    
