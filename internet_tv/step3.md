よく見られているエピソードを知りたいです。エピソード視聴数トップ3のエピソードタイトルと視聴数を取得してください
SELECT title, views FROM episodes ORDER BY views DESC LIMIT 3;

よく見られているエピソードの番組情報やシーズン情報も合わせて知りたいです。エピソード視聴数トップ3の番組タイトル、シーズン数、エピソード数、エピソードタイトル、視聴数を取得してください

内部結合を2回使います。
episodesテーブルにseasonsテーブルを結合し、さらにprogramsテーブルを結合します。
結合には外部キーを使用します。

select programs.title, season, episode, episodes.title, views
from episodes
join seasons
on episodes.season_id = seasons.season_id
join programs
on seasons.program_id = programs.program_id
ORDER BY views DESC 
LIMIT 3;

本日の番組表を表示するために、本日、どのチャンネルの、何時から、何の番組が放送されるのかを知りたいです。本日放送される全ての番組に対して、チャンネル名、放送開始時刻(日付+時間)、放送終了時刻、シーズン数、エピソード数、エピソードタイトル、エピソード詳細を取得してください。なお、番組の開始時刻が本日のものを本日方法される番組とみなすものとします

現状、放送開始時刻をTIME型"16:26:00"の形式で保存しているので、このままだと「番組の開始時刻が本日のもの」を取得できません。
データ型をDATETIME型'2019-10-04 15:25:07'に変更します。
ALTER TABLE episodes MODIFY COLUMN date DATETIME;

すでに入れてある17のレコードを正しい日付+開始時刻に修正します。
UPDATE episodes SET start_time = "2024-03-01 17:00:00" WHERE episode_id = 1;
UPDATE episodes SET start_time = "2024-03-08 17:00:00" WHERE episode_id = 2;
UPDATE episodes SET start_time = "2024-03-15 17:00:00" WHERE episode_id = 3;
UPDATE episodes SET start_time = "2024-03-22 17:00:00" WHERE episode_id = 4;
UPDATE episodes SET start_time = "2024-03-29 17:00:00" WHERE episode_id = 5;
UPDATE episodes SET start_time = "2024-04-05 17:00:00" WHERE episode_id = 6;
UPDATE episodes SET start_time = "2024-04-12 17:00:00" WHERE episode_id = 7;
UPDATE episodes SET start_time = "2024-02-24 00:00:00" WHERE episode_id = 9;
UPDATE episodes SET start_time = "2024-03-01 22:35:00" WHERE episode_id = 10;
UPDATE episodes SET start_time = "2024-03-01 23:00:00" WHERE episode_id = 11;
UPDATE episodes SET start_time = "2024-03-01 23:30:00" WHERE episode_id = 12;
UPDATE episodes SET start_time = "2024-03-02 00:30:00" WHERE episode_id = 14;
UPDATE episodes SET start_time = "2024-03-02 16:00:00" WHERE episode_id = 15;
UPDATE episodes SET start_time = "2024-03-02 17:00:00" WHERE episode_id = 16;
UPDATE episodes SET start_time = "2024-03-02 18:00:00" WHERE episode_id = 17;

すでに入れてある17のレコードを正しい日付+終了時刻に修正します。
UPDATE episodes SET end_time = "2024-03-01 18:05:00" WHERE episode_id = 1;
UPDATE episodes SET end_time = "2024-03-08 18:00:00" WHERE episode_id = 2;
UPDATE episodes SET end_time = "2024-03-15 18:00:00" WHERE episode_id = 3;
UPDATE episodes SET end_time = "2024-03-22 18:00:00" WHERE episode_id = 4;
UPDATE episodes SET end_time = "2024-03-29 18:00:00" WHERE episode_id = 5;
UPDATE episodes SET end_time = "2024-04-05 18:00:00" WHERE episode_id = 6;
UPDATE episodes SET end_time = "2024-04-12 18:30:00" WHERE episode_id = 7;
UPDATE episodes SET end_time = "2024-02-24 00:30:00" WHERE episode_id = 9;
UPDATE episodes SET end_time = "2024-03-01 23:00:00" WHERE episode_id = 10;
UPDATE episodes SET end_time = "2024-03-01 23:30:00" WHERE episode_id = 11;
UPDATE episodes SET end_time = "2024-03-02 00:00:00" WHERE episode_id = 12;
UPDATE episodes SET end_time = "2024-03-02 17:00:00" WHERE episode_id = 15;
UPDATE episodes SET end_time = "2024-03-02 18:00:00" WHERE episode_id = 16;
UPDATE episodes SET end_time = "2024-03-02 19:00:00" WHERE episode_id = 17;


genresテーブルからサッカー、恋愛番組、韓流・華流、将棋、麻雀、格闘を削除します。
DELETE FROM channels WHERE channel_id = 3;
DELETE FROM channels WHERE channel_id = 5;
DELETE FROM channels WHERE channel_id = 9;
DELETE FROM channels WHERE channel_id = 10;
DELETE FROM channels WHERE channel_id = 11;
DELETE FROM channels WHERE channel_id = 12;

誤ってchannelsテーブルから削除してしまったので、削除したチャンネルを追加します。
INSERT INTO channels(channel_id, channel) VALUES(3, "バラエティ1");
INSERT INTO channels(channel_id, channel) VALUES(5, "ニュース");
INSERT INTO channels(channel_id, channel) VALUES(10, "スポーツ");

genresテーブルからサッカー、恋愛番組、韓流・華流、将棋、麻雀、格闘を削除します。
DELETE FROM genres WHERE genre_id = 3;
DELETE FROM genres WHERE genre_id = 5;
DELETE FROM genres WHERE genre_id = 9;
DELETE FROM genres WHERE genre_id = 10;
DELETE FROM genres WHERE genre_id = 11;
DELETE FROM genres WHERE genre_id = 12;


孤独のグルメのデータを入れていきます。
INSERT INTO programs(program_id, title, genre_id, channel_id, description) VALUES(5, "孤独のグルメ", 7, 2, "ただ料理のうんちくを述べるのではなく、ひたすらに主人公の食事シーンと心理描写をつづり、ドキュメンタリーのように淡々とストーリーが流れていく原作人気マンガ、「孤独のグルメ」を実写化。");

INSERT INTO seasons(season_id, program_id, season) VALUES(5, 5, 10);

INSERT INTO episodes(episode_id, season_id, title, epi_desc, time, date, views, start_time, end_time, episode) VALUES(18, 5, "第2話 東京都港区白金台のルンダンとナシゴレン", "白金台のプラネタリウムバー。店長の細田(山崎まさよし)が熱心に星空を解説している中、日頃の疲れから睡魔と必死に戦っていた五郎(松重豊)だったが敗北、寝てしまう。", 30, "2024-03-02", 19000, "2024-03-02 20:15", "2024-03-02 20:57", 2);


本日の番組表を表示するために、本日、どのチャンネルの、何時から、何の番組が放送されるのかを知りたいです。本日放送される全ての番組に対して、チャンネル名、放送開始時刻(日付+時間)、放送終了時刻、シーズン数、エピソード数、エピソードタイトル、エピソード詳細を取得してください。なお、番組の開始時刻が本日のものを本日方法される番組とみなすものとします

これでチャンネル名以外は取得できます。
select programs.title, season, start_time, end_time, season, episode, episodes.title, epi_desc
from episodes
join seasons
on episodes.season_id = seasons.season_id
join programs
on seasons.program_id = programs.program_id
WHERE start_time BETWEEN "2024-03-02 00:00:00" AND "2024-03-02 23:59:59";

あとチャンネル名だけ取得できればいいですね。
channelsテーブルはprogramsテーブルの親なので、さっきのにchannelsテーブルを結合すれば取得できそうです。
select channel, programs.title, season, start_time, end_time, season, episode, episodes.title, epi_desc
from episodes
join seasons
on episodes.season_id = seasons.season_id
join programs
on seasons.program_id = programs.program_id
join channels
on programs.channel_id = channels.channel_id 
WHERE start_time BETWEEN "2024-03-02 00:00:00" AND "2024-03-02 23:59:59";

ドラマというチャンネルがあったとして、ドラマのチャンネルの番組表を表示するために、本日から一週間分、何日の何時から何の番組が放送されるのかを知りたいです。ドラマのチャンネルに対して、放送開始時刻、放送終了時刻、シーズン数、エピソード数、エピソードタイトル、エピソード詳細を本日から一週間分取得してください

まだ数日分しかデータを入れていないので、少なくとも1日1つ、1週間分のデータを入れます。

3/3 ABEMAニュース会見 済
3/4 ASO飯塚チャレンジドゴルフトーナメント 済
3/5 しくじり先生SP 済
3/6 かまいたちの笑賭け 済
3/7 孤独のグルメ 済
3/8 トリック 済
3/9 アンデッドアンラック 済
3/10 インカレ水泳2023 済


ABEMAニュース会見のデータを入れていきます。
INSERT INTO programs(program_id, title, genre_id, channel_id, description) VALUES(6, "ABEMAニュース会見", 8, 5, "日本初「会見チャンネル」。注目の記者会見や政府の会見からスポーツ・芸能関連の会見まで。日本に限らず世界の注目会見をリアルタイムに。");

ABEMAニュース会見は単発エピソードなので、シーズンとエピソードが表示されないようにします。
現状では、seasonsテーブルのseasonカラムとepisodesカラムのepisodeカラムにNOT NULL制約をかけているので、それを外します。

ALTER TABLE seasons MODIFY COLUMN season BIGINT;
ALTER TABLE episodes MODIFY COLUMN episode BIGINT;

これでseasonsテーブルとepisodesテーブルにNULLを入れることができます。

INSERT INTO seasons(season_id, program_id, season) VALUES(6, 6, NULL);

INSERT INTO episodes(episode_id, season_id, title, epi_desc, time, date, views, start_time, end_time, episode) VALUES(19, 6, "注目会見を逃さず生配信。最新ニュースも常時更新。", "日本初「会見チャンネル」。注目の記者会見や政府の会見からスポーツ・芸能関連の会見まで。日本に限らず世界の注目会見をリアルタイムに。", 60, "2024-03-03", 0, "2024-03-03 16:00", "2024-03-03 17:00", NULL);

ASO飯塚チャレンジドゴルフトーナメントのデータを入れます。
INSERT INTO programs(program_id, title, genre_id, channel_id, description) VALUES(7, "ASO飯塚チャレンジドゴルフトーナメント", 2, 10, "2022年よりジャパンゴルフツアーの新規トーナメントとして「ASO飯塚チャレンジドゴルフトーナメント」が開催されることとなりました。");

INSERT INTO seasons(season_id, program_id, season) VALUES(7, 7, NULL);

INSERT INTO episodes(episode_id, season_id, title, epi_desc, time, date, views, start_time, end_time, episode) VALUES(20, 7, "ASO飯塚チャレンジドゴルフトーナメント最終日(2023.6.11)", "本大会は「株式会社麻生」主催、日本ゴルフツアー機構(JGTO)の共催で、6月8日(木)から4日間で開催いたします。", 475, "2024-03-03", 0, "2024-03-04 19:05", "2024-03-05 03:00", NULL);

しくじり先生のデータを入れます。
INSERT INTO programs(program_id, title, genre_id, channel_id, description) VALUES(8, "しくじり先生", 4, 3, "過去のしくじりから学ぶ反面教師バラエティ番組！！");

INSERT INTO seasons(season_id, program_id, season) VALUES(8, 8, NULL);

INSERT INTO episodes(episode_id, season_id, title, epi_desc, time, date, views, start_time, end_time, episode) VALUES(21, 8, "しくじり先生SP パチスロサミーのしくじりを狩野英孝が熱血授業‼", "過去に大きな失敗を体験した“しくじり先生”が生徒たちにしくじった経験を教える反面教師バラエティ番組「しくじり先生」！今回も“しくじり先生”による熱血授業を開講します！。", 54, "2024-03-05", 0, "2024-03-05 13:00", "2024-03-05 13:54", NULL);


かまいたちの笑賭けのデータを入れます。
INSERT INTO programs(program_id, title, genre_id, channel_id, description) VALUES(9, "かまいたちの笑賭け", 4, 3, "山内の不倫ゴシップで大混乱!?芸人の激ヤバゴシップ連発に凍りつく…着実に大金を稼ぎ出すかまいたち！どこまで金は増えていくのか！");

INSERT INTO seasons(season_id, program_id, season) VALUES(9, 9, 1);

INSERT INTO episodes(episode_id, season_id, title, epi_desc, time, date, views, start_time, end_time, episode) VALUES(22, 9, "かまいたちの笑賭け #3~4", "現在所持金300万円オーバー！さらに増やしてカジノでビッグドリームを掴み取れ！強力な助っ人も増えさらにパワーアップした笑賭けメンバー！大旋風は巻き起こるのか!?", 92, "2024-03-06", 0, "2024-03-06 05:34", "2024-03-06 07:06", 3);


孤独のグルメのデータを入れます。
INSERT INTO episodes(episode_id, season_id, title, epi_desc, time, date, views, start_time, end_time, episode) VALUES(23, 5, "孤独のグルメ S10 第7話", "渋谷区「笹塚」。ゴルフのティーチングプロである石井隆史(飯塚悟志)の依頼でオーダーメイドのゴルフバッグの商談をしに来た五郎(松重豊)。レッスン生たちの指導に夢中な石井は、商談中にも生徒たちが気になり全く話が進まない。", 35, "2024-03-07", 0, "2024-03-07 08:40", "2024-03-07 09:15", 7);

トリックのデータを入れます。
INSERT INTO programs(program_id, title, genre_id, channel_id, description) VALUES(10, "トリック", 7, 2, "売れない奇術師・山田奈緒子は、ある日、若手物理学者・上田次郎が雑誌に掲載した、霊能力者たちへの挑戦状に出会う。");

INSERT INTO seasons(season_id, program_id, season) VALUES(10, 10, 1);

INSERT INTO episodes(episode_id, season_id, title, epi_desc, time, date, views, start_time, end_time, episode) VALUES(24, 10, "トリック(2000年) 第3話", "奈緒子(仲間由紀恵)は青木(河原さぶ)の家で霧島澄子(菅井きん)の肖像を発見。青木は信者?", 60, "2024-03-08", 0, "2024-03-08 15:50", "2024-03-08 16:50", 3);

アンデッドアンラックのデータを入れていきます。
INSERT INTO programs(program_id, title, genre_id, channel_id, description) VALUES(11, "アンデッドアンラック", 1, 6, "これは、二人が最高の死を見つけるお話。");

INSERT INTO seasons(season_id, program_id, season) VALUES(11, 11, 1);

INSERT INTO episodes(episode_id, season_id, title, epi_desc, time, date, views, start_time, end_time, episode) VALUES(25, 11, "アンデッドアンラック #22", "触れた者に不幸な事故をもたらす“不運”、アンラックの力をもつ少女・出雲風子。その特異な体質から一度は死を覚悟した風子の前に絶対に死ねない“不死”の体を持つアンデッドの男が現れる。", 30, "2024-03-09", 0, "2024-03-09 03:10", "2024-03-09 03:40", 22);


インカレ水泳のデータを入れていきます。
INSERT INTO programs(program_id, title, genre_id, channel_id, description) VALUES(12, "インカレ水泳", 2, 10, "「世界水泳福岡2023」を経てパリ五輪メダル候補の、学生トップスイマーが集結。");

INSERT INTO seasons(season_id, program_id, season) VALUES(12, 12, 1);

INSERT INTO episodes(episode_id, season_id, title, epi_desc, time, date, views, start_time, end_time, episode) VALUES(26, 12, "インカレ水泳2023 2日目(2023/09/01)", "注目選手は、東京五輪で銀メダリストとなった本多灯(日大4年)。パリ五輪で金メダルを狙う21歳が、本命種目の200mバタフライで自己ベストを更新し、チームを3連覇に導けるか!?", 230, "2024-03-10", 0, "2024-03-10 07:20", "2024-03-10 11:10", 2);


ドラマのチャンネルという指定があったので、ドラマのデータを5つ入れる。


孤独のグルメのデータを入れます。
INSERT INTO episodes(episode_id, season_id, title, epi_desc, time, date, views, start_time, end_time, episode) VALUES(27, 5, "孤独のグルメ S10 第5話", "のどかな田園風景が広がる千葉県柏市。依頼人である吉川将吾(中田圭祐)の案内でこの地を訪れ、吉川の祖母(加藤美智子)の希望でインテリアや雑貨を提案しに来た五郎(松重豊)。", 42, "2024-03-05", 0, "2024-03-05 20:15", "2024-03-05 20:57", 5);

打ち上げ花火、下から見るか？横から見るか？のデータを入れていきます。
INSERT INTO programs(program_id, title, genre_id, channel_id, description) VALUES(13, "打ち上げ花火、下から見るか？横から見るか？", 7, 2, "「両親の離婚で転校することが決まっていたなずな（奥菜恵）は、プールで競った勝者と駆け落ちすることを企てる。少年少女の選択が異なる結末へ。");

INSERT INTO seasons(season_id, program_id, season) VALUES(13, 13, NULL);

INSERT INTO episodes(episode_id, season_id, title, epi_desc, time, date, views, start_time, end_time, episode) VALUES(28, 13, "打ち上げ花火、下から見るか？横から見るか？", "小学生の典道と祐介たち男子5人は、花火を横から見ると丸いのか、平べったいのかという素朴な疑問を抱き、花火大会の夜、その答えを確かめるべく町のはずれにある灯台に行くことを計画する。", 65, "2024-03-09", 0, "2024-03-09 12:00", "2024-03-09 13:05", NULL);

特命係長只野仁のデータを入れます。
INSERT INTO programs(program_id, title, genre_id, channel_id, description) VALUES(14, "特命係長 只野仁", 7, 2, "只野仁。大手広告代理店の窓際係長。しかし、それは表の顔にすぎない。彼には会長直属の特命係長として、さまざまなトラブルを解決するという、もう一つの顔があった・・・。。");

INSERT INTO seasons(season_id, program_id, season) VALUES(14, 14, 1);

INSERT INTO episodes(episode_id, season_id, title, epi_desc, time, date, views, start_time, end_time, episode) VALUES(29, 14, "特命係長 只野仁(2007) 第3話", "電王堂の大手クライアントである城山製菓の二代目社長・健志(徳重聡)が、仕事そっちのけで秘書のルミ(荒井美恵子)と遊びまくっているらしい。おかげで今、城山製菓は分裂の危機だという。", 55, "2024-03-10", 0, "2024-03-10 04:00", "2024-03-10 04:55", 3);



ドラマというチャンネルがあったとして、ドラマのチャンネルの番組表を表示するために、本日から一週間分、何日の何時から何の番組が放送されるのかを知りたいです。ドラマのチャンネルに対して、放送開始時刻、放送終了時刻、シーズン数、エピソード数、エピソードタイトル、エピソード詳細を本日から一週間分取得してください

SELECT start_time, end_time, season, episode, episodes.title, epi_desc
FROM episodes
JOIN seasons
ON episodes.season_id = seasons.season_id
JOIN programs
ON seasons.program_id = programs.program_id
join channels
ON programs.channel_id = channels.channel_id 
WHERE (programs.channel_id = 1 OR programs.channel_id = 2)
AND start_time BETWEEN "2024-03-03 00:00:00" AND "2024-03-09 23:59:59"
ORDER BY start_time ASC;


(advanced) 直近一週間で最も見られた番組が知りたいです。直近一週間に放送された番組の中で、エピソード視聴数合計トップ2の番組に対して、番組タイトル、視聴数を取得してください

SELECT programs.title, SUM(views) 
FROM episodes
JOIN seasons
ON episodes.season_id = seasons.season_id
JOIN programs
ON seasons.program_id = programs.program_id
WHERE start_time BETWEEN "2024-02-25 00:00:00" AND "2024-03-02 23:59:59"
GROUP BY programs.program_id
ORDER BY SUM(views) DESC
LIMIT 2;

(advanced) ジャンルごとの番組の視聴数ランキングを知りたいです。番組の視聴数ランキングはエピソードの平均視聴数ランキングとします。ジャンルごとに視聴数トップの番組に対して、ジャンル名、番組タイトル、エピソード平均視聴数を取得してください。

第1段階：番組ごとのに合計視聴数を表示

SELECT genre, programs.title, SUM(views)
FROM episodes
JOIN seasons
ON episodes.season_id = seasons.season_id
JOIN programs
ON seasons.program_id = programs.program_id
JOIN genres
ON programs.genre_id = genres.genre_id
GROUP BY programs.program_id;

第2段階：番組ごとのエピソード平均視聴数を表示
SELECT genre, programs.title, AVG(views)
FROM episodes
JOIN seasons
ON episodes.season_id = seasons.season_id
JOIN programs
ON seasons.program_id = programs.program_id
JOIN genres
ON programs.genre_id = genres.genre_id
GROUP BY programs.program_id;


第3段階：ジャンルごとの最多平均視聴数を表示

SELECT genre_id, genre, MAX(average_views)
FROM (
  SELECT programs.genre_id, genre, programs.title, AVG(views) AS average_views
  FROM episodes
  JOIN seasons
  ON episodes.season_id = seasons.season_id
  JOIN programs
  ON seasons.program_id = programs.program_id
  join genres
  ON programs.genre_id = genres.genre_id
  GROUP BY programs.program_id
) AS average_views_per_program
GROUP BY genre_id;

第4段階：ジャンルごとに合計視聴数がトップの番組タイトルを表示（全部表示される）

SELECT programs.genre_id, genre, programs.title, average
FROM (
  SELECT genre_id, genre, MAX(average_views) AS average
  FROM (
    SELECT programs.genre_id, genre, programs.title, AVG(views) AS average_views
    FROM episodes
    JOIN seasons
    ON episodes.season_id = seasons.season_id
    JOIN programs
    ON seasons.program_id = programs.program_id
    join genres
    ON programs.genre_id = genres.genre_id
    GROUP BY programs.program_id
  ) AS average_views_per_program
  GROUP BY genre_id
) AS most_viewed_programs_per_genre
JOIN programs
ON most_viewed_programs_per_genre.genre_id = programs.genre_id;


第5段階：
SELECT most_views_per_genre.genre_id, most_views_per_genre.genre, title, most_views_per_genre.average_views
FROM (
  SELECT programs.genre_id, genre, programs.title, AVG(views) AS average_views
  FROM episodes
  JOIN seasons
  ON episodes.season_id = seasons.season_id
  JOIN programs
  ON seasons.program_id = programs.program_id
  JOIN genres
  ON programs.genre_id = genres.genre_id
  GROUP BY programs.program_id
) AS average_views_per_genre
JOIN (
  SELECT genre_id, genre, MAX(average_views) AS average_views
  FROM (
    SELECT programs.genre_id, genre, programs.title, AVG(views) AS average_views
    FROM episodes
    JOIN seasons
    ON episodes.season_id = seasons.season_id
    JOIN programs
    ON seasons.program_id = programs.program_id
    JOIN genres
    ON programs.genre_id = genres.genre_id
    GROUP BY programs.program_id
  ) table1
  GROUP BY genre_id
) AS most_views_per_genre
ON most_views_per_genre.genre_id = average_views_per_genre.genre_id AND most_views_per_genre.average_views = average_views_per_genre.average_views
ORDER BY most_views_per_genre.genre_id;






