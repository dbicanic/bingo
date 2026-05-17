require "rails_helper"

RSpec.describe "Games" do
  describe "GET /" do
    context "with no game" do
      it "redirects to create a new game" do
        get root_path
        expect(response).to redirect_to(new_game_path)
      end
    end

    context "with an existing game" do
      let!(:game) { create(:game) }

      it "returns 200" do
        get root_path
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "GET /game/new" do
    it "returns 200" do
      get new_game_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /game" do
    it "creates a new game and redirects to root" do
      expect { post game_path }.to change(Game, :count).by(1)
      expect(response).to redirect_to(root_path)
    end

    it "destroys any existing game" do
      create(:game)
      expect { post game_path }.to change(Game, :count).by(0)
    end
  end

  describe "POST /game/draw" do
    let!(:game) { create(:game) }

    it "draws a ball and redirects" do
      expect { post draw_game_path }.to change { game.reload.drawn_numbers.size }.by(1)
      expect(response).to redirect_to(root_path)
    end

    it "does nothing when all balls drawn" do
      game.update!(drawn_numbers: (1..75).to_a, status: "finished")
      expect { post draw_game_path }.not_to change { game.reload.drawn_numbers.size }
      expect(response).to redirect_to(root_path)
    end
  end
end
