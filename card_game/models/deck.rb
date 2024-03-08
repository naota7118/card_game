class Deck
  # cardは以下のような配列で構成される
  # ex.[['ハート', 'A'], ['ハート', '2'], ['ハート', '3'], ... , ['クラブ', 'K']]
  CARD_SUITS = %w[ハート ダイヤ スペード クラブ]
  CARD_MARKS = %w[A 2 3 4 5 6 7 8 9 10 J Q K]

  def initialize
    @cards = CARD_SUITS.product(CARD_MARKS)
  end

  # カードを分ける
  def separate_cards
    @cards.shuffle!.group_by.with_index{|a,i| i % 2 == 0 }
  end
end