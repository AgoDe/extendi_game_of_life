class GameService
  attr_reader :generation, :rows, :cols, :matrix, :new_matrix

   def initialize(file_content)
    @lines = file_content.lines.map(&:chomp)
    parse_file
    create_next_generation_matrix
  end

  def parse_file
    @generation = @lines[0].scan(/\d+/).first.to_i
    @rows, @cols = @lines[1].split.map(&:to_i)
    @matrix = @lines[2..@rows+1].map { |line| line.chars }
  end

  def create_next_generation_matrix
    new_matrix = Array.new(@rows) { Array.new(@cols) }

    @rows.times do |i|
        @cols.times do |j|
            live_neighbors = 0

            (-1..1).each do |dx|
                (-1..1).each do |dy|
                    next if dx == 0 && dy == 0
                    ni, nj = i + dx, j + dy
                    if ni.between?(0, @rows - 1) && nj.between?(0, @cols - 1)
                        live_neighbors += 1 if @matrix[ni][nj] == '*'
                    end
                end
            end

            if @matrix[i][j] == '*'
                new_matrix[i][j] = (live_neighbors == 2 || live_neighbors == 3) ? '*' : '.'
            else
                new_matrix[i][j] = (live_neighbors == 3) ? '*' : '.'
            end
        end
    end

    @new_matrix = new_matrix

  end
end