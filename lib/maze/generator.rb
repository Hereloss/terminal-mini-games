class Generator

    attr_reader :width, :height, :maze
    def initialize
        puts "What height is the maze?"
        @height = gets.chomp.to_i
        puts "What width is the maze?"
        @width = gets.chomp.to_i
        @maze = []
        temp_row = []
        maze_gene(height,width,maze)
    end

    def maze_gene(height,width,maze)
        temp_height = 0
        temp_width = 0
        height.times do
            temp_row = []
            width.times do
                random = rand(4)
                if random == 0
                    temp_row << 0
                else
                    temp_row << 1
                end
            end
            maze << temp_row
        end
        current_loc = [height - 1, width - 1]
        maze[current_loc[0]][current_loc[1]] = 0
        snake(current_loc,maze,width,height)
    end
        

    def snake(current_loc,maze,width,height)
        until current_loc == [0,1]
            random = rand(4)
            tall = current_loc[0]
            side = current_loc[1]
            if random == 0 && side != 0
                maze[tall][side - 1] = 0
                current_loc = [tall, side - 1]
            elsif random == 1 && side != width - 1
                maze[tall][side + 1] = 0
                current_loc = [tall , side + 1]
            elsif random == 2 && tall != 0
                maze[tall - 1][side] = 0
                current_loc = [tall - 1, side]
            elsif random == 3 && tall != height - 1
                maze[tall+ 1][side] = 0
                current_loc = [tall + 1, side]
            end
        end

        count = 0

        maze.each do |arr|
            arr.each do |ele|
                count += ele
            end
        end
        if count < (width * height) / 2
            maze.clear
            maze_gene(height,width,maze)
        else
            maze.each do |arr|
                p arr
            end
            return maze
        end
    end
end