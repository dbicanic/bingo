require "rails_helper"

RSpec.describe BingoCard do
  describe "associations" do
    it { is_expected.to belong_to(:game) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:grid) }
  end

  describe "#all_numbers" do
    it "returns all non-nil numbers on the card" do
      grid = [
        [1, 2, 3, 4, 5],
        [16, 17, 18, 19, 20],
        [31, 32, nil, 33, 34],
        [46, 47, 48, 49, 50],
        [61, 62, 63, 64, 65]
      ]
      card = build(:bingo_card, grid: grid)
      expect(card.all_numbers).not_to include(nil)
      expect(card.all_numbers.size).to eq(24)
    end
  end
end
