class BingoCardGenerator
  COLUMN_RANGES = [
    (1..15).to_a,
    (16..30).to_a,
    (31..45).to_a,
    (46..60).to_a,
    (61..75).to_a
  ].freeze

  def call
    grid = COLUMN_RANGES.map { |range| range.sample(5) }
    grid[2][2] = nil
    grid
  end
end
