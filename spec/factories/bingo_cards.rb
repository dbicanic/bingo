FactoryBot.define do
  factory :bingo_card do
    association :game
    grid do
      g = [
        (1..15).to_a.sample(5),
        (16..30).to_a.sample(5),
        (31..45).to_a.sample(5),
        (46..60).to_a.sample(5),
        (61..75).to_a.sample(5)
      ]
      g[2][2] = nil
      g
    end
    label { "Card #1" }
  end
end
