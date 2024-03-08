# require "#{File.dirname(__FILE__)}/models/player.rb"
require_relative 'models/player.rb'
require_relative 'models/deck.rb'
require_relative 'models/game.rb'

# 2人のプレイヤー作成する
you = Player.new(name: "プレイヤー1") 
another = Player.new(name: "プレイヤー2") 

# どちらかが親になる
[you, another].sample.is_dealer = true

game = Game.new(
  deck: Deck.new,
  manual_player: you,
  another_player: another,
  tableau_cards:[]
)

game.start

game.advance_players_turn

# game.judge

