class Player
    attr_accessor :marker, :name
    def initialize(name)
        @name=name
        @marker=''
    end
end
class Cell
    attr_accessor :cell_display, :is_empty
    attr_reader :cell_number
    def initialize(cell_number)
        @cell_number=cell_number
        @cell_display=cell_number
        @is_empty=true
    end
end
def welcome
    p "Hi! Would you like to play a Tic-Tac-Toe game? Type 'Y' to play."
    answer=gets.gsub("\n","")
    answer=="Y" ? game : (p 'Maybe later then, bye.')
end
def game
    winner=''
    def make_cells(size)
        size=size.to_i
        cells=Array.new 
        i=0      
        while i<size*size do
            cells[i]=Cell.new(i+1)
            i+=1
        end
        cells
    end
    def make_board(cells)
        board="\n   Game Board\n"
        cells.each_with_index do |cell,index|
            size=Math.sqrt(cells.length)
            if cell.cell_number%size==1
                board+="\n    "
            end
            board+=" #{cell.cell_display}"
        end
        board+="\n "
    end
    def player_plays(player,cells)
        cell_to_mark=0
        while cell_to_mark<1 || cell_to_mark>9 || !cells[cell_to_mark-1].is_empty || !cell_to_mark.integer? do
            p "#{player.name}, on what cell between 1-9 would you like to place a #{player.marker}"
            cell_to_mark=gets.gsub("\n","").to_i
        end
        cells[cell_to_mark-1].cell_display=player.marker
        cells[cell_to_mark-1].is_empty=false
    end
    def play_round(cells,player,player_1,player_2)
        puts make_board(cells)
        player==player_1 ? player_plays(player_1,cells) : player_plays(player_2,cells)
        winner=''
    end
    first_time_asking=true
    player_1=''
    player_2=''
    while player_1=='' || first_time_asking==true do
        p "What's the name of the first player?"
        player_1=Player.new(gets.gsub("\n",""))
        first_time_asking=false
    end
    first_time_asking=true
    while player_1.marker=='' || first_time_asking==true do
        p "What letter would #{player_1.name} like to use as their marker?"
        player_1.marker=gets.gsub("\n","")
        first_time_asking=false
    end    
    first_time_asking=true
    while player_2=='' || first_time_asking==true do
        p "What's the name of the second player?"
        player_2=Player.new(gets.gsub("\n",""))
        first_time_asking=false
    end
    first_time_asking=true
    while player_2.marker=='' || player_2.marker==player_1.marker || first_time_asking==true do
        p "What letter would #{player_2.name} like to use as their marker?"
        player_2.marker=gets.gsub("\n","")
        first_time_asking=false
    end
    cells=make_cells(3)
    round=1
    player=player_1
    while round<10 && winner=='' do
        play_round(cells,player,player_1,player_2)
        if cells[0].cell_display==cells[1].cell_display && cells[1].cell_display==cells[2].cell_display ||
            cells[3].cell_display==cells[4].cell_display && cells[4].cell_display==cells[5].cell_display || 
            cells[6].cell_display==cells[7].cell_display && cells[7].cell_display==cells[8].cell_display || 
            cells[0].cell_display==cells[3].cell_display && cells[3].cell_display==cells[6].cell_display ||
            cells[1].cell_display==cells[4].cell_display && cells[4].cell_display==cells[7].cell_display ||
            cells[2].cell_display==cells[5].cell_display && cells[5].cell_display==cells[8].cell_display || 
            cells[0].cell_display==cells[4].cell_display && cells[4].cell_display==cells[8].cell_display || 
            cells[2].cell_display==cells[4].cell_display && cells[4].cell_display==cells[6].cell_display
            winner=player
        end
        player==player_1 ? player=player_2 : player=player_1
        round+=1
    end
    puts make_board(cells)+"\nWinner is #{winner.name}, CONGRATULATIONS!"
    puts "Do you wanna play again? Type 'Y' to play."
    answer=gets.gsub("\n","")
    answer=="Y" ? game : (p 'Maybe later then, bye.')
end
welcome
