class BingoCard < ApplicationRecord
  belongs_to :game

  validates :grid, presence: true

  HEADERS = %w[B I N G O].freeze

  def all_numbers
    grid.flatten.compact
  end
end
