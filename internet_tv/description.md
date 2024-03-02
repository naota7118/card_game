
MySQLにログインします。

データベースを作成します。
CREATE DATABASE internet_tv;

データベースに移動します。
USE internet_tv;

番組テーブルを作成します。
テーブル名はprogramsです。


まずIDカラムとタイトルカラムだけで作成します。
CREATE TABLE programs (
  id BIGINT AUTO_INCREMENT,
  title VARCHAR(255), 
  PRIMARY KEY (id)
);

テーブルが正しく作れているか確認します。
SHOW COLUMNS FROM programs;

番組名カラムにNOT NULL制約がかかってなかったので追加します。
ALTER TABLE programs MODIFY COLUMN title VARCHAR(255) NOT NULL;

カラムに放送日、開始時刻、終了時刻、動画時間、視聴数を追加します。
ALTER TABLE programs ADD COLUMN onair_date DATE NOT NULL;
ALTER TABLE programs ADD COLUMN start_time TIME NOT NULL;
ALTER TABLE programs ADD COLUMN end_time TIME NOT NULL;
ALTER TABLE programs ADD COLUMN minutes BIGINT NOT NULL;
ALTER TABLE programs ADD COLUMN views BIGINT NOT NULL;


番組テーブルを作成します。
テーブル名はgenresです。

CREATE TABLE genres (
  id BIGINT AUTO_INCREMENT,
  genre VARCHAR(255) NOT NULL, 
  PRIMARY KEY (id)
);

番組テーブルのジャンルIDカラムがジャンルカラムのIDを参照するように外部キー制約を設定します。
ALTER TABLE programs ADD FOREIGN KEY fk_genre(genre_id) REFERENCES genres(id);

チャンネルテーブルを作成します。
テーブル名はchannelsです。

CREATE TABLE channels (
  id BIGINT AUTO_INCREMENT,
  channel VARCHAR(255) NOT NULL, 
  PRIMARY KEY (id)
);


番組テーブルにチャンネルIDカラムを追加します。
ALTER TABLE programs ADD COLUMN channel_id BIGINT NOT NULL;

番組テーブルのチャンネルIDカラムがチャンネルカラムのIDを参照するように外部キー制約を設定します。
ALTER TABLE programs ADD FOREIGN KEY fk_channel(channel_id) REFERENCES channels(id);

外部キー制約がかかっているかは以下で確認できます。
SHOW CREATE TABLE programs;


シーズンテーブルを作成します。
テーブル名はseasonsです。

CREATE TABLE seasons (
  id BIGINT AUTO_INCREMENT,
  PRIMARY KEY (id)
);


エピソードテーブルを作成します。
テーブル名はepisodesです。

CREATE TABLE episodes (
  id BIGINT AUTO_INCREMENT,
  PRIMARY KEY (id)
);

テーブルの構造は以下で確認できます。
DESCRIBE episodes;

番組テーブルにシーズンIDカラムを追加します。
ALTER TABLE programs ADD COLUMN season_id BIGINT NOT NULL;

エピソードテーブルのエピソードIDカラムがシーズンカラムのシーズンIDカラムを参照するように外部キー制約を設定します。
ALTER TABLE programs ADD FOREIGN KEY fk_channel(channel_id) REFERENCES channels(id);

カラム名がIDだとわかりづらいので、program_idに変更します。
ALTER TABLE programs CHANGE COLUMN id program_id BIGINT; 

カラム名がIDだとわかりづらいので、ジャンルテーブルのidカラムをgenre_idに変更します。
しかし、今のままでは外部キー制約がかかっていて変更できません。
外部キー制約をいったん外します。
ALTER TABLE programs DROP FOREIGN KEY programs_ibfk_1;

これでカラム名を変更できます。
ALTER TABLE genres CHANGE COLUMN id genre_id BIGINT; 

再び外部キー制約を設定します。
ALTER TABLE programs ADD FOREIGN KEY fk_genre(genre_id) REFERENCES genres(genre_id);


カラム名がIDだとわかりづらいので、チャンネルテーブルのidカラムをchannel_idに変更します。
しかし、今のままでは外部キー制約がかかっていて変更できません。
外部キー制約をいったん外します。
ALTER TABLE programs DROP FOREIGN KEY programs_ibfk_1;

これでカラム名を変更できます。
ALTER TABLE channels CHANGE COLUMN id channel_id BIGINT; 

再び外部キー制約を設定します。
ALTER TABLE programs ADD FOREIGN KEY fk_channel(channel_id) REFERENCES channels(channel_id);

カラム名がIDだとわかりづらいので、season_idに変更します。
ALTER TABLE seasons CHANGE COLUMN id season_id BIGINT;

カラム名がIDだとわかりづらいので、episode_idに変更します。
ALTER TABLE episodes CHANGE COLUMN id episode_id BIGINT;


エピソードテーブルのepisode_idカラムがシーズンテーブルのseason_idカラムを参照するように外部キー制約を設定します。
ALTER TABLE episodes ADD FOREIGN KEY episode_fk(episode_id) REFERENCES seasons(season_id);

正しく設定されたか以下で確認できます。
SHOW CREATE TABLE episodes;


シーズンテーブルのseason_idカラムが番組テーブルのseason_idカラムを参照するように外部キー制約を設定します。
ALTER TABLE seasons ADD FOREIGN KEY season_fk(season_id) REFERENCES programs(program_id);

正しく設定されたか以下で確認できます。
SHOW CREATE TABLE seasons;

programsテーブルのseasons_idカラムは不要なので削除します。
ALTER TABLE programs DROP COLUMN season_id;

チャンネルテーブルにデータを入れます。
INSERT INTO channels (channel_id, channel) VALUES(1, "ドラマ&映画1");
INSERT INTO channels (channel_id, channel) VALUES(2, "ドラマ&映画2");
QINSERT INTO channels (channel_id, channel) VALUES(3, "バラエティ1");
INSERT INTO channels (channel_id, channel) VALUES(4, "バラエティ2");
INSERT INTO channels (channel_id, channel) VALUES(5, "ニュース");
INSERT INTO channels (channel_id, channel) VALUES(6, "アニメ1");
INSERT INTO channels (channel_id, channel) VALUES(7, "アニメ2");
INSERT INTO channels (channel_id, channel) VALUES(8, "アニメ3");
INSERT INTO channels (channel_id, channel) VALUES(9, "韓流・華流ドラマ");
INSERT INTO channels (channel_id, channel) VALUES(10, "スポーツ");
INSERT INTO channels (channel_id, channel) VALUES(11, "将棋");
INSERT INTO channels (channel_id, channel) VALUES(12, "麻雀");
INSERT INTO channels (channel_id, channel) VALUES(13, "格闘");


ジャンルテーブルにデータを入れます。
INSERT INTO genres (genre_id, genre) VALUES(1, "アニメ");
INSERT INTO genres (genre_id, genre) VALUES(2, "スポーツ");
INSERT INTO genres (genre_id, genre) VALUES(3, "サッカー");
INSERT INTO genres (genre_id, genre) VALUES(4, "バラエティ");
INSERT INTO genres (genre_id, genre) VALUES(5, "恋愛番組");
INSERT INTO genres (genre_id, genre) VALUES(6, "映画");
INSERT INTO genres (genre_id, genre) VALUES(7, "ドラマ");
INSERT INTO genres (genre_id, genre) VALUES(8, "ニュース");
INSERT INTO genres (genre_id, genre) VALUES(9, "韓流・華流");
INSERT INTO genres (genre_id, genre) VALUES(10, "将棋");
INSERT INTO genres (genre_id, genre) VALUES(11, "麻雀");
INSERT INTO genres (genre_id, genre) VALUES(12, "格闘");

番組テーブルにデータを入れます。
INSERT INTO programs(program_id, title, onair_date, start_time, end_time, minutes, views, genre_id, channel_id) VALUES(1, "黒革の手帖", "2024-02-29",
"20:00:00", "21:00:00", 60, 50000, 7, 1);


シーズンテーブルにデータを入れます。
INSERT INTO seasons(season_id) VALUES(1);

INSERT INTO seasons(season_id) VALUES(2);
エラーが発生しました。
Cannot add or update a child row: a foreign key constraint fails (`internet_tv`.`seasons`, CONSTRAINT `seasons_ibfk_1` FOREIGN KEY (`season_id`) REFERENCES `programs` (`program_id`))
seasons_idはprogramsテーブルのprogram_idを参照しており、program_id=2が存在しないため、登録できないのが現状です。

外部キー制約の設定を誤っているため修正します。
外部キー制約を外します。
ALTER TABLE seasons DROP FOREIGN KEY seasons_ibfk_1;

seasonsテーブルに外部キー設定用のカラムを追加します。
ALTER TABLE seasons ADD COLUMN program_id BIGINT NOT NULL;

seasonsテーブルに残っているデータを削除します。
DELETE FROM seasons WHERE season_id = 1;

seasonsテーブルのprogram_idカラムがprogramsテーブルのprogram_idカラムを参照するようにします。（外部キー制約）
ALTER TABLE seasons ADD FOREIGN KEY season_fk(program_id) REFERENCES programs(program_id);

正しく設定されたか以下で確認できます。
SHOW CREATE TABLE seasons;

現状だと、episodesテーブルのepisode_idカラムがseasonsテーブルのseason_idカラムを参照するようになっています。
このままだとシーズンとエピソードが対になってしまいます。

外部キー制約を外します。
ALTER TABLE episodes DROP FOREIGN KEY episodes_ibfk_1;

episodesテーブルにseasonsテーブルを参照するためのseason_idカラムを追加します。
ALTER TABLE episodes ADD COLUMN season_id BIGINT NOT NULL;

外部キー制約をかけます。
ALTER TABLE episodes ADD FOREIGN KEY episode_fk(season_id) REFERENCES seasons(season_id);



seasonsテーブルにデータを入れます。
INSERT INTO seasons(season_id, program_id) VALUES(1, 1);

episodesテーブルにデータを入れます。
INSERT INTO episodes(episode_id, season_id) VALUES(1, 1);

programsテーブルに説明カラムを追加します。
ALTER TABLE programs ADD COLUMN description VARCHAR(255) NOT NULL;

すでに入ってるデータ(program_id=1)の説明を更新します。
UPDATE programs SET description = "これまで何度も映像化され、多くの反響・共感を得てきた『黒革の手帖』。「清張史上最強」と言われるあの“悪女”が甦る！武井咲、江口洋介出演。" WHERE program_id = 1;

programsテーブルからonair_date, start_time, end_time, minutes, viewsカラムを削除します。
（これらの情報はepisodesテーブルで管理するため）
ALTER TABLE programs DROP COLUMN onair_date;
ALTER TABLE programs DROP COLUMN views;
ALTER TABLE programs DROP COLUMN start_time;
ALTER TABLE programs DROP COLUMN end_time;
ALTER TABLE programs DROP COLUMN minutes;

エピソードテーブルにタイトル(title)、エピソード詳細(epi_desc)、動画時間(time)、公開日(date)、視聴数(views)のカラムを追加します。
ALTER TABLE episodes ADD COLUMN title VARCHAR(255) NOT NULL;
ALTER TABLE episodes ADD COLUMN epi_desc VARCHAR(255) NOT NULL;
ALTER TABLE episodes ADD COLUMN time BIGINT NOT NULL;
ALTER TABLE episodes ADD COLUMN date DATE NOT NULL;
ALTER TABLE episodes ADD COLUMN views BIGINT NOT NULL;

episodesテーブルに1件入っているデータの情報を更新します。
UPDATE episodes SET title = "松本清張 黒革の手帖 第1話" WHERE episode_id = 1;
UPDATE episodes SET epi_desc = "東林銀行に勤める原口元子(米倉涼子)は、今日も営業用の笑顔で窓口に座っていた。その一方で、銀行の架空名義口座から大金を横領しつつ、架空名義預金者たちのリストを愛用の黒革の手帖に記していた。横領金が1億2千万円に達したとき、支店次長の村井(渡辺いっけい)らが元子の横領に気づく。それを知った元子は、そのまま銀行の外へ飛び出した。" WHERE episode_id = 1;
UPDATE episodes SET time = 59 WHERE episode_id = 1;
UPDATE episodes SET date = "2024-03-01" WHERE episode_id = 1;
UPDATE episodes SET views = 88000 WHERE episode_id = 1;

episodesテーブルに、放送開始時刻、放送終了時刻カラムを追加します。
ALTER TABLE episodes ADD COLUMN start_time TIME NOT NULL;
ALTER TABLE episodes ADD COLUMN end_time TIME NOT NULL;


UPDATE episodes SET start_time = "17:00" WHERE episode_id = 1;
UPDATE episodes SET end_time = "18:05" WHERE episode_id = 1;

episodesテーブルにデータを入れます。
INSERT INTO episodes(episode_id, season_id, title, epi_desc, time, date, views, start_time, end_time) VALUES(2, 1, "松本清張 黒革の手帖 第2話", "楢林美容外科クリニックの婦長で楢林(小林稔侍)の愛人でもある市子(室井滋)を呼び出した元子は、楢林と波子(釈由美子)の仲を中傷し、いかに市子が楢林のクリニック発展に貢献したかを褒め上げる。市子の嫉妬を煽り、楢林と波子の仲を裂くように仕向けなければならない。市子の信頼を得るために、元子はしたたかな計算を働かせていた。",
46, "2024-03-08", 23000, "17:00", "18:00");

INSERT INTO episodes(episode_id, season_id, title, epi_desc, time, date, views, start_time, end_time) VALUES(3, 1, "松本清張 黒革の手帖 第3話", "安島(仲村トオル)に危ないところを助けられた元子(米倉涼子)は、警察に連絡するという安島に、藤岡(小野武彦)は不倫相手で大ごとにしたくないと誤魔化す。だが安島は、藤岡と元子の会話を立ち聞きしていた。",
46, "2024-03-15", 19000, "17:00", "18:00");

INSERT INTO episodes(episode_id, season_id, title, epi_desc, time, date, views, start_time, end_time) VALUES(4, 1, "松本清張 黒革の手帖 第4話", "安島とベッドをともにした元子は、これは過去を知られたことに対する口止めであり、自分は一生誰も愛さないと安島に言い放つ。それは、安島に惹かれていく自分自身への戒めの言葉でもあった。",
46, "2024-03-22", 17000, "17:00", "18:00");

INSERT INTO episodes(episode_id, season_id, title, epi_desc, time, date, views, start_time, end_time) VALUES(5, 1, "松本清張 黒革の手帖 第5話", "元子(米倉涼子)に、裏口入学周旋の証拠を突きつけられた橋田(柳葉敏郎)は、それはニセモノだと笑い飛ばす。というのも、澄江(吉岡美穂)が元子を裏切り、橋田と共謀、彼女が元子に渡した証拠はニセモノだというのだ。だが、元子は動じなかった。",
46, "2024-03-29", 17000, "17:00", "18:00");

INSERT INTO episodes(episode_id, season_id, title, epi_desc, time, date, views, start_time, end_time) VALUES(6, 1, "松本清張 黒革の手帖 第6話", "元子が新装オープンさせた『ロダン』に、波子(釈由美子)が客としてやってくる。元子や店のホステスたちに散々嫌味を述べ立て、店を後にする波子。翌日、元子は京都に向かった。",
46, "2024-04-05", 16000, "17:00", "18:00");

INSERT INTO episodes(episode_id, season_id, title, epi_desc, time, date, views, start_time, end_time) VALUES(7, 1, "松本清張 黒革の手帖 最終話", "安島(仲村トオル)の口から長谷川(津川雅彦)の屈辱的な伝言を聞かされ、愕然とする元子(米倉涼子)。長谷川に『ロダン』の残金2億1千万円どころか、キャンセル料8千4百万円さえも払えなくなってしまい、自分の着物や装飾品を売ってまで金を作ろうとするが、とても足りるような額にはならない。",
78, "2024-04-12", 18000, "17:00", "18:30");

INSERT INTO programs(program_id, title, genre_id, channel_id, description) VALUES(2, "葬送のフリーレン", 1, 6, "勇者ヒンメルたちと共に、10 年に及ぶ冒険の末に魔王を打ち倒し、世界に平和をもたらした魔法使いフリーレン。千年以上生きるエルフである彼女は、ヒンメルたちと再会の約束をし、独り旅に出る。");

seasonsテーブルにseasonカラムを追加します。
ALTER TABLE seasons ADD COLUMN season BIGINT NOT NULL;

既存データのseasonカラムを更新します。
UPDATE seasons SET season = 1 WHERE season_id = 1;

葬送のフリーレンのデータを入れていきます。
INSERT INTO seasons(season_id, program_id, season) VALUES(2, 2, 1);

episodesテーブルにepisodeカラムを追加します。
ALTER TABLE episodes ADD COLUMN episode BIGINT NOT NULL;

UPDATE episodes SET episode = 1 WHERE episode_id = 1;
UPDATE episodes SET episode = 2 WHERE episode_id = 2;
UPDATE episodes SET episode = 3 WHERE episode_id = 3;
UPDATE episodes SET episode = 4 WHERE episode_id = 4;
UPDATE episodes SET episode = 5 WHERE episode_id = 5;
UPDATE episodes SET episode = 6 WHERE episode_id = 6;
UPDATE episodes SET episode = 7 WHERE episode_id = 7;

INSERT INTO episodes(episode_id, season_id, title, epi_desc, time, date, views, start_time, end_time, episode) VALUES(8, 2, "葬送のフリーレン #25", "勇者ヒンメルたちと共に、10年に及ぶ冒険の末に魔王を打ち倒し、世界に平和をもたらした魔法使いフリーレン。千年以上生きるエルフである彼女は、ヒンメルたちと再会の約束をし、独り旅に出る。",
30, "2024-03-02", 0, "00:00", "00:30", 25);

INSERT INTO episodes(episode_id, season_id, title, epi_desc, time, date, views, start_time, end_time, episode) VALUES(9, 2, "#24 完璧な複製体", "第二次試験でダンジョン「零落の王墓」に入った受験者たちの前に、彼らの複製体が立ちふさがる。その複製体は魔法によりそれぞれの実力・魔力・技術などを完全にコピーした実体だった。",
30, "2024-02-24", 419000, "00:00", "00:30", 24);


メジャーのデータを入れていきます。
INSERT INTO programs(program_id, title, genre_id, channel_id, description) VALUES(3, "メジャー", 1, 7, "吾郎がおとさんと同じプロ野球選手の道を志し、やがて、メジャー・リーグの選手になることを目指す物語。");

INSERT INTO seasons(season_id, program_id, season) VALUES(3, 3, 3);

INSERT INTO episodes(episode_id, season_id, title, epi_desc, time, date, views, start_time, end_time, episode) VALUES(10, 3, "第1話 ゼロからのスタート", "海堂高校をやめた吾郎は、旧友・小森たちがいる三船高校の野球部に入るつもりだったが、夏の大会予選の三船高校の試合を見て考えを変え、他の高校の編入試験を目指すことにする。",
26, "2024-03-01", 562000, "22:35", "23:00", 1);

INSERT INTO episodes(episode_id, season_id, title, epi_desc, time, date, views, start_time, end_time, episode) VALUES(11, 3, "第2話 新しい仲間", "通学中に突然、目の前に現れた吾郎から、聖秀高校に入って野球部を作ると聞いた清水は、嬉しさ半分、心配半分。クラスで吾郎に一目ぼれした中村は、「マネージャーになってあげる」と積極的にアタック。",
26, "2024-03-01", 169000, "23:00", "23:30", 2);

INSERT INTO episodes(episode_id, season_id, title, epi_desc, time, date, views, start_time, end_time, episode) VALUES(12, 3, "第3話 父から子へ", "今シーズン負け続きの吾郎の父・茂野。気晴らしをして朝帰りも多いため、桃子も機嫌が悪い。吾郎は理事長に野球部設立をかけあうが、まず同好会として承認し、正式な部として認めるかは今後の活動次第だという。",
26, "2024-03-01", 154000, "23:30", "24:00", 3);

INSERT INTO episodes(episode_id, season_id, title, epi_desc, time, date, views, start_time, end_time, episode) VALUES(13, 3, "第4話 無謀な賭け", "野球部の顧問・山田のつてで、強豪・帝仁高校との練習試合が決まった吾郎たち。吾郎のボールは帝仁選手たちの度胆をぬき、バットに当てることもできない。だが、田代が「清水がキャッチャーで公式戦は戦えない」とクレームをつけた。",
26, "2024-03-02", 157000, "00:00", "00:30", 4);

INSERT INTO episodes(episode_id, season_id, title, epi_desc, time, date, views, start_time, end_time, episode) VALUES(14, 3, "第4話 俺たちのグラウンド", "清水と藤井のプレーで、同点に追いついた聖秀。そこでまた、田代が清水と口論に。そのとき「もう無理にチームに入ってくれとは頼まない」と言い出す吾郎。",
26, "2024-03-02", 155000, "00:30", "01:00", 5);

世界の果てに、ひろゆき置いてきたのデータを入れていきます。
INSERT INTO programs(program_id, title, genre_id, channel_id, description) VALUES(4, "世界の果てに、ひろゆき置いてきた", 4, 4, "ひろゆきを、アフリカのナミブ砂漠に置き去りに… 「予算10万円、移動は陸路のみ」という過酷なルールでアフリカ横断に挑む!!");

INSERT INTO seasons(season_id, program_id, season) VALUES(4, 4, 1);

INSERT INTO episodes(episode_id, season_id, title, epi_desc, time, date, views, start_time, end_time, episode) VALUES(15, 4, "#6：世界最貧国！マラウイ屠殺場で出会った男", "世界最貧国と言われるマラウイへ入国したひろゆき＆東出昌大。東出が自力で牛を解体し、町民総出でBBQをしていると。警察が出動する騒ぎに…", 48, "2024-03-02", 578000, "16:00", "17:00", 6);

INSERT INTO episodes(episode_id, season_id, title, epi_desc, time, date, views, start_time, end_time, episode) VALUES(16, 4, "#7：鉄槌！神に背きし者たち", "世界最貧国マラウイでひろゆき＆東出昌大が事故に巻き込まれる。
旅を続けることは出来るのか…？", 52, "2024-03-02", 685000, "17:00", "18:00", 7);

INSERT INTO episodes(episode_id, season_id, title, epi_desc, time, date, views, start_time, end_time, episode) VALUES(17, 4, "#8：悶絶！東出…人生最大の危機", "とりあえず、ひろゆきをナミビアの砂漠に置き去りにしました。", 52, "2024-03-02", 607000, "18:00", "19:00", 8);

channelsテーブルからアニメ3、韓流・華流ドラマ、将棋、麻雀、格闘を削除します。
DELETE FROM channels WHERE channel_id = 8;
DELETE FROM channels WHERE channel_id = 9;
DELETE FROM channels WHERE channel_id = 11;
DELETE FROM channels WHERE channel_id = 12;
DELETE FROM channels WHERE channel_id = 13;

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

