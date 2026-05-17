require "rails_helper"

RSpec.describe "BingoCards" do
  let!(:game) { create(:game) }

  describe "POST /bingo_cards" do
    it "creates a new bingo card for the current game" do
      expect { post bingo_cards_path }.to change(BingoCard, :count).by(1)
      expect(BingoCard.last.game).to eq(game)
      expect(response).to redirect_to(root_path)
    end

    it "numbers the card sequentially" do
      post bingo_cards_path
      expect(BingoCard.last.label).to eq("Card #1")
      post bingo_cards_path
      expect(BingoCard.last.label).to eq("Card #2")
    end
  end

  describe "GET /bingo_cards" do
    before { create_list(:bingo_card, 3, game: game) }

    it "returns 200" do
      get bingo_cards_path
      expect(response).to have_http_status(:ok)
    end
  end
end
