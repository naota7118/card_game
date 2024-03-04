# プレイヤーを用意
class Player
  def initialize(name, card)
    @name = name
    @count = card
  end
  def name
    @name
  end
  def count
    @count
  end
end

puts 'プレイヤーの人数を入力してください(2〜5)：'
input_number = gets.to_i

name_array = []
for i in 1..input_number
  puts "プレイヤー#{i}の名前を入力してください："
  name = gets.chomp
  name_array << name
end

# トランプを配る
numbers = (1..52).to_a

people = 52 / input_number

cards = []
numbers.each_slice(people) do |x|
  # 均等に配る
  cards << x
end

# 余りが出た場合、余りを配る
if cards[-1].length < cards[-2].length
  cards[-1].each_with_index do |x, i|
    cards[i] << x
  end
  cards.pop
end

# 人数分のプレイヤーを用意
array = []
name_index = input_number - 1
for i in 0..name_index do
  hash = {}
  player = Player.new(name_array[i], 0)
  # プレイヤーとカード枚数をハッシュの形で保存
  hash[:name] = player.name
  hash[:count] = player.count
  array.push(hash)
end

# プレイヤーごとにトランプ枚数をハッシュの:countキーに保存
ary = []
array.each do |hash|
  ary.push(hash[:count])
end

# 52枚のカードをほぼ均等に各プレイヤーの:countキーに保存
cards.each_with_index do |card, i|
  array[i][:count] = card.length
  ary[i] = card.length
end

puts "戦争を開始します。"
puts "カードが配られました。"

while !ary.include?(0)
  puts "戦争！"

  # 1回ごとのプレイヤーの出したカードの階級を保存するための箱
  values = []

  for i in 1..input_number
    marks = ["スペード", "ハート", "ダイヤ", "クラブ"]
    ranks = ["A", "K", "Q", "J", 10, 9, 8, 7, 6, 5, 4, 3, 2]
    # ランダムでトランプの記号を取得
    mark = marks.sample
    # ランダムでトランプの階級を取得
    rank = ranks.sample
    puts "#{name_array[i - 1]}のカードは#{mark}の#{rank}です。"
    
    # 大小比較でのエラーを避けるため文字列を数値に置き換える
    if rank == "A"
      rank = 14
    elsif rank == "K"
      rank = 13
    elsif rank == "Q"
      rank = 12
    elsif rank == "J"
      rank = 11
    end

    hash = {}
    # プレイヤーとカードの階級をハッシュの形で保存
    name_array.each_with_index do |name, i|
      hash[:name] = name_array[i - 1]
    end
    hash[:count] = rank
    values.push(hash)

    # 階級が高い順に並び替える
    values.sort_by! do |hash|
      hash[:count]
    end
    values.reverse!

  end

  # 2番目以降の値を配列に入れて、順番にinclude?で先頭の数値と同じのがないか確認する
  value_box = []
  values.each_with_index do |value, index|
    if index >= 1
      value_box << value[:count]
    end
  end
  
  # 先頭の値(最大値)と同じ値があればやり直す
  
  if value_box.include?(values[0][:count])
    puts "引き分けです。"

    # 最初の引き分けの場合/リセットされた後
    if @draw.nil?
      @draw = 0
      @draw += 1
    elsif @draw >= 1
      # 2回目以降の引き分けの場合
      @draw += 1
    end
  else
    # やり直し回数がゼロの場合、勝利者は人数分の枚数がもらえる
    if @draw.nil?
      puts "#{values[0][:name]}が勝ちました。#{values[0][:name]}はカードを#{input_number - 1}枚もらいました。"

      # 勝敗により枚数が増減する
      array_box = []
      input_number.times do
        score_box = {} 
        array_box.push(score_box)
      end

      
      array_box.each_with_index do |x, i|
        x[:name] = "#{name_array[i]}"
        # 初期値を設定
        x[:count] = 0
      end
      
      array_box.each do |x|
        # 勝者は枚数が増える
        if x[:name] == values[0][:name]
          x[:count] = input_number - 1
        else # 敗者は枚数が減る
          x[:count] -= 1
        end
      end

      array.each_with_index do |x, i|
        if x[:name] == array_box[i][:name]
          x[:count] += array_box[i][:count]
        end
      end

      array.each do |hash|
        ary.push(hash[:count])
      end

    else
      # やり直しを経て勝利した場合
      # 勝者は(やり直し回数+1)×(人数-1)がもらえる枚数がもらえる
      reward = (@draw + 1) * (input_number - 1)
      values[0][:count] += reward

      puts "#{values[0][:name]}が勝ちました。#{values[0][:name]}はカードを#{(@draw + 1) * input_number}枚もらいました。"

      # 勝敗により枚数が増減する
      array_box = []
      input_number.times do
        score_box = {} 
        array_box.push(score_box)
      end
      
      array_box.each_with_index do |x, i|
        x[:name] = name_array[i - 1]
        # 初期値を設定
        x[:count] = 0
      end

      array_box.each do |x|
        # 勝者は枚数が増える
        if x[:name] == values[0][:name]
          x[:count] = reward
        else # 敗者は枚数が減る
          x[:count] -= (@draw + 1)
        end
      end
      
      array.each_with_index do |x, i|
        if x[:name] == array_box[i][:name]
          x[:count] += array_box[i][:count]
        end
      end

      array.each do |hash|
        ary.push(hash[:count])
      end

      # やり直し回数カウントをリセット
      @draw = nil

    end
  end
  
  # カード枚数が負の数になる人が出たら終了
  check = []
  array.each do |result|
    if result[:count] <= 0
      check << result[:count]
    end
  end
  break if check.any?

end

# カードの枚数が多い順に並び替える
array.sort_by! do |result|
  result[:count]
end
array.reverse!


# 手札が無くなった人を保存する配列
zero = []
# 手札がなくなった人が2人以上の場合を想定
array.each_with_index do |player, i|
  # 最後の人の場合は実行しない
  if i != (input_number - 1)
    # 手札がなくなった人が2人以上の場合
    if player[:count] == array[-1][:count]
      zero.push(player[:name])
    end
  end
end

# 結果を保存する配列の最後尾の人を手札が無くなった人の配列に追加
zero.push(array[-1][:name])
# 手札が無くなった人を表示

zero.each do |player|
  print "#{player}の手札がなくなりました。"
  puts ""
end

array.each_with_index do |player, i|
  print "#{player[:name]}の手札の枚数は#{player[:count]}枚です。"
  puts ""
end

# カード枚数によって順位をつける
array.each_with_index do |player, i|

  player[:ranking] = 1
  if i < input_number - 1
    if i != 0
      # 1つ前の人とカード枚数が同じ場合
      if array[i][:count] == array[i - 1][:count]
        # 1つ前の人の順位と同じになる
        array[i][:ranking] = array[i - 1][:ranking]
        print "#{player[:name]}が#{player[:ranking]}位、"
      # 1つ前の人よりカード枚数が少ない場合
      elsif array[i][:count] != array[i - 1][:count]
        # 自分より枚数が多い人の数をカウントする
        num = array.count do |x|
          x[:count] > array[i][:count]
        end
        array[i][:ranking] = num + 1

        print "#{player[:name]}が#{player[:ranking]}位、"
      end
    else
      print "#{player[:name]}が#{player[:ranking]}位、"
    end
  else
    if array[i][:count] == array[i - 1][:count]
      array[i][:ranking] = array[i - 1][:ranking]
      puts "#{player[:name]}が#{player[:ranking]}位です。"
    elsif array[i][:count] != array[i - 1][:count]
      # 自分より枚数が多い人の数をカウントする
      num = array.count do |x|
        x[:count] > array[i][:count]
      end
      array[i][:ranking] = num + 1

      puts "#{player[:name]}が#{player[:ranking]}位です。"
    end
  end
  
end

puts "戦争を終了します。"