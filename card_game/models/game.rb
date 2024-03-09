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

  def initialize(deck:, manual_player:, another_player:, tableau_cards:, draw_cards:)
    @deck = deck
    @manual_player = manual_player
    @another_player = another_player
    @tableau_cards = tableau_cards #テーブルに出したカード
    @draw_cards = draw_cards #引き分けでたまったカード
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
  
      # プレイヤーが場にカードを出す
      @tableau_cards = []
      @tableau_cards << @manual_player.submitted_card
      @tableau_cards << @another_player.submitted_card

      if your_rank == another_rank
        puts '引き分けです。'
        # 引き分けだと場札がたまる
        @tableau_cards.each do |card|
          @draw_cards << card
        end
        next
      elsif your_rank > another_rank
        puts "今回は#{@manual_player.name}が勝ちました。"
        # プレイヤー1が場札をもらう
        @manual_player.get_cards(tableau_cards: @tableau_cards)

        # 引き分けでたまったカードがあればもらう
        if @draw_cards.size >= 1
          @manual_player.get_draw_cards(draw_cards: @draw_cards)
        end
        # 引き分けでたまったカードが空になる
        @draw_cards.clear

        puts "#{@manual_player.name}は#{@manual_player.hand.size}枚もっています。"
        puts "#{@another_player.name}は#{@another_player.hand.size}枚もっています。"

        if @another_player.hand.size == 0
          puts "#{@manual_player.name}が勝ちました。"
          puts "戦争を終了します。"
          break
        end
      else
        puts "今回は#{@another_player.name}が勝ちました。"
        # プレイヤー2が場札をもらう
        @another_player.get_cards(tableau_cards: @tableau_cards)

        # 引き分けでたまったカードがあればもらう
        if @draw_cards.size >= 1
          @another_player.get_draw_cards(draw_cards: @draw_cards)
        end

        puts "#{@manual_player.name}は#{@manual_player.hand.size}枚もっています。"
        puts "#{@another_player.name}は#{@another_player.hand.size}枚もっています。"

        # 引き分けでたまったカードが空になる
        @draw_cards.clear

        if @manual_player.hand.size == 0
          puts "#{@another_player.name}が勝ちました。"
          puts "戦争を終了します。"
          break
        end
      end
    end
  end

end