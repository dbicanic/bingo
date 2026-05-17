class GamesController < ApplicationController
  def show
    if current_game.nil?
      redirect_to new_game_path and return
    end
    @bingo_cards = current_game.bingo_cards.order(:created_at)
  end

  def new
  end

  def create
    Game.destroy_all
    Game.create!
    redirect_to root_path
  end

  def draw
    return redirect_to root_path unless current_game

    @ball = current_game.draw_ball!
    @game = current_game

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace("drawn-ball",
            partial: "shared/ball_display",
            locals: { ball: @ball, game: @game }),
          turbo_stream.replace("drawn-history",
            partial: "shared/drawn_list",
            locals: { game: @game }),
          turbo_stream.replace("remaining-count",
            partial: "shared/remaining_count",
            locals: { game: @game }),
          *@game.bingo_cards.order(:created_at).map { |card|
            turbo_stream.replace("bingo-card-#{card.id}",
              partial: "shared/bingo_card",
              locals: { card: card, drawn_numbers: @game.drawn_numbers })
          }
        ]
      end
      format.html { redirect_to root_path }
    end
  end
end
