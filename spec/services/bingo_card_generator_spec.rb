require "rails_helper"

RSpec.describe BingoCardGenerator do
  subject(:grid) { described_class.new.call }

  it "returns a 5x5 grid" do
    expect(grid.length).to eq(5)
    expect(grid).to all(have_attributes(length: 5))
  end

  it "places nil at the center (N column, row 2)" do
    expect(grid[2][2]).to be_nil
  end

  it "puts B numbers (1-15) in column 0" do
    expect(grid[0].compact).to all(be_between(1, 15))
  end

  it "puts I numbers (16-30) in column 1" do
    expect(grid[1].compact).to all(be_between(16, 30))
  end

  it "puts N numbers (31-45) in column 2" do
    expect(grid[2].compact).to all(be_between(31, 45))
  end

  it "puts G numbers (46-60) in column 3" do
    expect(grid[3].compact).to all(be_between(46, 60))
  end

  it "puts O numbers (61-75) in column 4" do
    expect(grid[4].compact).to all(be_between(61, 75))
  end

  it "has no duplicate numbers within any column" do
    grid.each do |col|
      numbers = col.compact
      expect(numbers.uniq).to eq(numbers)
    end
  end

  it "has 24 numbers total (25 cells minus FREE)" do
    expect(grid.flatten.compact.size).to eq(24)
  end
end
