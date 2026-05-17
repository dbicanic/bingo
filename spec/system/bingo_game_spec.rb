require "rails_helper"

RSpec.describe "Bingo game flow", type: :system do
  before do
    driven_by :rack_test
  end

  it "starts a new game, adds cards, draws balls, and resets" do
    # No game yet — redirects to new game page
    visit root_path
    expect(page).to have_button("Start New Game")

    click_button "Start New Game"
    expect(page).to have_content("Cards (0)")

    # Add two cards
    click_button "Add Card"
    expect(page).to have_content("Cards (1)")

    click_button "Add Card"
    expect(page).to have_content("Cards (2)")

    # Draw a ball
    click_button "Draw Ball"
    game = Game.last
    expect(game.drawn_numbers.size).to eq(1)

    # Verify ball appears in drawn history
    ball = game.drawn_numbers.first
    expect(page).to have_content(ball.to_s)

    # Print page loads
    visit bingo_cards_path
    expect(page).to have_content("Card #1")
    expect(page).to have_content("Card #2")

    # Reset — new game
    visit root_path
    click_button "New Game"
    expect(Game.count).to eq(1)
    expect(Game.last.drawn_numbers).to eq([])
    expect(page).to have_content("Cards (0)")
  end

  it "shows game over message when all balls are drawn" do
    game = create(:game, drawn_numbers: (1..74).to_a)
    visit root_path
    click_button "Draw Ball"
    expect(page).to have_content("Game over")
    expect(Game.last.status).to eq("finished")
  end
end
