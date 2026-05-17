class Game < ApplicationRecord
  has_many :bingo_cards, dependent: :destroy

  validates :status, inclusion: { in: %w[active finished] }

  def remaining_numbers
    (1..75).to_a - drawn_numbers
  end

  def ball_letter(number)
    case number
    when 1..15  then "B"
    when 16..30 then "I"
    when 31..45 then "N"
    when 46..60 then "G"
    when 61..75 then "O"
    end
  end

  def draw_ball!
    remaining = remaining_numbers
    return nil if remaining.empty?

    ball = remaining.sample
    self.drawn_numbers = drawn_numbers + [ball]
    self.status = "finished" if remaining_numbers.empty?
    save!
    ball
  end
end
