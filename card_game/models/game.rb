class Game
  attr_accessor :tableau_cards
  # スコアに関する定数
  CARD_MARK_SCORE_MAP = {
    '2' => 2,
    '3' => 3,
    '4' => 4,
    '5' => 5,
    '6' => 6,
    '7' => 7,
    '8' => 8,
    '9' => 9,
    '10' => 10,
    'J' => 11,
    'Q' => 12,
    'K' => 13,
    'A' => 14
  }

  # プレイヤーに関する定数
  MIN_PLAYER_COUNT = 2
  MAX_PLAYER_COUNT = 5

  def initialize(deck:, manual_player:, another_player:, tableau_cards:)
    @deck = deck
    @manual_player = manual_player
    @another_player = another_player
    @tableau_cards = tableau_cards #場札
  end

  def start
    puts "戦争を開始します。"
    # 親がカードを26枚ずつ配る
    [@manual_player, @another_player].each do |player|
      if player.is_dealer == true
        player.distribute(deck: @deck, players: [@manual_player, @another_player])
      end
    end
    puts "カードが配られました。"
  end

  def advance_players_turn
    loop do
      puts "戦争！"
      @manual_player.submit_card
      @another_player.submit_card
      
      # 操作者の出したカードのマークを変数に入れる
      your_mark = @manual_player.submitted_card[1]
      # スコアマップを参照して数値に変換
      your_rank = CARD_MARK_SCORE_MAP[your_mark]
  
      another_mark =  @another_player.submitted_card[1]
      another_rank = CARD_MARK_SCORE_MAP[another_mark]
  
      # 場札を配列で格納
      @tableau_cards = [@manual_player.submitted_card, @another_player.submitted_card]
  
      if your_rank == another_rank
        puts '引き分けです。'
        next
      elsif your_rank > another_rank
        puts 'プレイヤー1が勝ちました。'
        # プレイヤー1が場札をもらう
        @manual_player.get_cards(tableau_cards: @tableau_cards)
        puts "戦争を終了します。"
        break
      else
        puts 'プレイヤー2が勝ちました。'
        # プレイヤー2が場札をもらう
        @another_player.get_cards(tableau_cards: @tableau_cards)
        puts "戦争を終了します。"
        break
      end
    end
  end

end