require "rails_helper"

RSpec.describe Game do
  describe "associations" do
    it { is_expected.to have_many(:bingo_cards).dependent(:destroy) }
  end

  describe "validations" do
    it { is_expected.to validate_inclusion_of(:status).in_array(%w[active finished]) }
  end

  describe "defaults" do
    subject(:game) { Game.create! }

    it "starts with no drawn numbers" do
      expect(game.drawn_numbers).to eq([])
    end

    it "starts with active status" do
      expect(game.status).to eq("active")
    end
  end

  describe "#remaining_numbers" do
    it "returns all 75 numbers when nothing drawn" do
      game = build(:game, drawn_numbers: [])
      expect(game.remaining_numbers).to eq((1..75).to_a)
    end

    it "excludes drawn numbers" do
      game = build(:game, drawn_numbers: [1, 16, 31])
      expect(game.remaining_numbers).not_to include(1, 16, 31)
      expect(game.remaining_numbers.size).to eq(72)
    end
  end

  describe "#ball_letter" do
    it "returns B for 1-15" do
      game = build(:game)
      expect(game.ball_letter(1)).to eq("B")
      expect(game.ball_letter(15)).to eq("B")
    end

    it "returns I for 16-30" do
      game = build(:game)
      expect(game.ball_letter(16)).to eq("I")
      expect(game.ball_letter(30)).to eq("I")
    end

    it "returns N for 31-45" do
      game = build(:game)
      expect(game.ball_letter(31)).to eq("N")
      expect(game.ball_letter(45)).to eq("N")
    end

    it "returns G for 46-60" do
      game = build(:game)
      expect(game.ball_letter(46)).to eq("G")
      expect(game.ball_letter(60)).to eq("G")
    end

    it "returns O for 61-75" do
      game = build(:game)
      expect(game.ball_letter(61)).to eq("O")
      expect(game.ball_letter(75)).to eq("O")
    end
  end

  describe "#draw_ball!" do
    it "adds a number to drawn_numbers" do
      game = create(:game)
      expect { game.draw_ball! }.to change { game.drawn_numbers.size }.by(1)
    end

    it "returns the drawn number" do
      game = create(:game)
      ball = game.draw_ball!
      expect(ball).to be_between(1, 75)
    end

    it "never draws the same number twice" do
      game = create(:game)
      75.times { game.draw_ball! }
      expect(game.drawn_numbers.uniq.size).to eq(75)
    end

    it "returns nil when all numbers are drawn" do
      game = create(:game, drawn_numbers: (1..75).to_a)
      expect(game.draw_ball!).to be_nil
    end

    it "marks the game finished when all numbers are drawn" do
      game = create(:game, drawn_numbers: (1..74).to_a)
      game.draw_ball!
      expect(game.status).to eq("finished")
    end
  end
end
