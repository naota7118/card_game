require_relative 'deck.rb'
require_relative 'game.rb'

class Player
  attr_accessor :name, :hand, :score, :is_dealer, :submitted_card

  def initialize(name: '', is_dealer: false)
    @name = name
    @hand = []
    @count = 26
    @is_dealer = is_dealer
  end

  # カードを分ける
  def distribute(deck:, players:)
    deck.separate_cards.each.with_index do |(key, value), i|
      players[i].hand.concat(value)
    end
  end

  def submit_card
    puts "#{name}のカードは#{hand.first[0]}の#{hand.first[1]}です。"
    @submitted_card = hand.first
    # 場に出す先頭の要素を削除
    hand.shift(1)
  end

  # 場札をもらう
  def get_cards(tableau_cards:)
    hand.concat(tableau_cards)
  end


  def calculate_score
    # score =  Game::CARD_MARK_SCORE_MAP
    # p score
  end
end