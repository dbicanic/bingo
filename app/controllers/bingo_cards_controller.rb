class BingoCardsController < ApplicationController
  def index
    @bingo_cards = current_game&.bingo_cards&.order(:created_at) || []
    render layout: "print"
  end

  def create
    game = current_game
    return redirect_to root_path unless game

    card_number = game.bingo_cards.count + 1
    grid = BingoCardGenerator.new.call
    @card = game.bingo_cards.create!(grid: grid, label: "Card ##{card_number}")

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.append("cards-container",
          partial: "shared/bingo_card",
          locals: { card: @card, drawn_numbers: game.drawn_numbers })
      end
      format.html { redirect_to root_path }
    end
  end
end
