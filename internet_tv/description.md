## 手順
以下3つの手順で進めていきます。
1. データベース作成
2. テーブル作成
3. サンプルデータ入れる

## データベース作成
MySQLにログインします。
```sql
mysql -u test_user
```

データベースを作成します。
```sql
CREATE DATABASE internet_tv;
```

データベースに移動します。
```sql
USE internet_tv;
```

## テーブル作成

### 番組テーブル
テーブル名はprogramsです。

```sql
CREATE TABLE programs (
  program_id BIGINT AUTO_INCREMENT NOT NULL,
  title VARCHAR(255) NOT NULL,
  genre_id BIGINT NOT NULL,
  channel_id BIGINT NOT NULL,
  description VARCHAR(255) NOT NULL,
  PRIMARY KEY (program_id)
);
```

テーブルが正しく作れているか確認します。
```sql
DESCRIBE programs;
```
### ジャンルテーブル
```sql
CREATE TABLE genres (
  genre_id BIGINT AUTO_INCREMENT NOT NULL,
  genre VARCHAR(255) NOT NULL, 
  PRIMARY KEY (genre_id)
);
```

テーブルが正しく作れているか確認します。
```sql
DESCRIBE genres;
```
#### 外部キー制約
programsテーブルのgenre_idカラムにgenresテーブルのgenre_idを参照する外部キー制約を設定します。
```sql
ALTER TABLE programs ADD FOREIGN KEY fk_genre(genre_id) REFERENCES genres(genre_id);
```

外部キー制約を確認します。
```sql
SHOW CREATE TABLE programs;
```

### チャンネルテーブル
```sql
CREATE TABLE channels (
  channel_id BIGINT AUTO_INCREMENT NOT NULL,
  channel VARCHAR(255) NOT NULL, 
  PRIMARY KEY (channel_id)
);
```

テーブルが正しく作れているか確認します。
```sql
DESCRIBE channels;
```

#### 外部キー制約
programsテーブルのchannel_idカラムにchannelsテーブルのchannel_idを参照する外部キー制約を設定します。
```sql
ALTER TABLE programs ADD FOREIGN KEY fk_channel(channel_id) REFERENCES channels(channel_id);
```

外部キー制約を確認します。
```sql
SHOW CREATE TABLE programs;
```

### シーズンテーブル
```sql
CREATE TABLE seasons (
  season_id BIGINT AUTO_INCREMENT NOT NULL,
  season BIGINT,
  program_id BIGINT NOT NULL,
  PRIMARY KEY (season_id)
);
```

#### 外部キー制約
seasonsテーブルのprogram_idカラムにprogramsテーブルのprogram_idを参照する外部キー制約を設定します。
```sql
ALTER TABLE seasons ADD FOREIGN KEY fk_program(program_id) REFERENCES programs(program_id);
```

外部キー制約を確認します。
```sql
SHOW CREATE TABLE seasons;
```

### エピソードテーブル
```sql
CREATE TABLE episodes (
  episode_id BIGINT AUTO_INCREMENT NOT NULL,
  season_id BIGINT NOT NULL,
  title VARCHAR(255) NOT NULL, 
  epi_desc VARCHAR(255) NOT NULL, 
  time BIGINT NOT NULL,
  date DATE NOT NULL,
  views BIGINT NOT NULL,
  start_time DATETIME NOT NULL,
  end_time DATETIME NOT NULL,
  episode BIGINT,
  PRIMARY KEY (episode_id)
);
```

#### 外部キー制約
episodesテーブルのseason_idカラムにseasonsテーブルのseason_idカラムを参照する外部キー制約を設定します。
```sql
ALTER TABLE episodes ADD FOREIGN KEY fk_season(season_id) REFERENCES seasons(season_id);
```

外部キー制約を確認します。
```sql
SHOW CREATE TABLE episodes;
```

## サンプルデータを入れる

### チャンネルテーブル
```sql
INSERT INTO channels (channel_id, channel) VALUES(1, "ドラマ&映画1");
INSERT INTO channels (channel_id, channel) VALUES(2, "ドラマ&映画2");
INSERT INTO channels (channel_id, channel) VALUES(3, "バラエティ1");
INSERT INTO channels (channel_id, channel) VALUES(4, "バラエティ2");
INSERT INTO channels (channel_id, channel) VALUES(5, "ニュース");
INSERT INTO channels (channel_id, channel) VALUES(6, "アニメ1");
INSERT INTO channels (channel_id, channel) VALUES(7, "アニメ2");
INSERT INTO channels (channel_id, channel) VALUES(8, "スポーツ");
```

### ジャンルテーブル
```sql
INSERT INTO genres (genre_id, genre) VALUES(1, "アニメ");
INSERT INTO genres (genre_id, genre) VALUES(2, "スポーツ");
INSERT INTO genres (genre_id, genre) VALUES(3, "バラエティ");
INSERT INTO genres (genre_id, genre) VALUES(4, "映画");
INSERT INTO genres (genre_id, genre) VALUES(5, "ドラマ");
INSERT INTO genres (genre_id, genre) VALUES(6, "ニュース");
```

### 番組テーブル
```sql
INSERT INTO programs(program_id, title, genre_id, channel_id, description) VALUES(1, "黒革の手帖", 5, 1, "これまで何度も映像化され、多くの反響・共感を得てきた『黒革の手帖』。「清張史上最強」と言われるあの“悪女”が甦る！武井咲、江口洋介出演。");
INSERT INTO programs(program_id, title, genre_id, channel_id, description) VALUES(2, "葬送のフリーレン", 1, 6, "勇者ヒンメルたちと共に、10 年に及ぶ冒険の末に魔王を打ち倒し、世界に平和をもたらした魔法使いフリーレン。千年以上生きるエルフである彼女は、ヒンメルたちと再会の約束をし、独り旅に出る。");
INSERT INTO programs(program_id, title, genre_id, channel_id, description) VALUES(3, "メジャー", 1, 7, "吾郎がおとさんと同じプロ野球選手の道を志し、やがて、メジャー・リーグの選手になることを目指す物語。");
INSERT INTO programs(program_id, title, genre_id, channel_id, description) VALUES(4, "世界の果てに、ひろゆき置いてきた", 3, 3, "ひろゆきを、アフリカのナミブ砂漠に置き去りに… 「予算10万円、移動は陸路のみ」という過酷なルールでアフリカ横断に挑む!!");
INSERT INTO programs(program_id, title, genre_id, channel_id, description) VALUES(5, "孤独のグルメ", 5, 2, "ただ料理のうんちくを述べるのではなく、ひたすらに主人公の食事シーンと心理描写をつづり、ドキュメンタリーのように淡々とストーリーが流れていく原作人気マンガ、「孤独のグルメ」を実写化。");
INSERT INTO programs(program_id, title, genre_id, channel_id, description) VALUES(6, "APPRENTICEニュース会見", 6, 5, "日本初「会見チャンネル」。注目の記者会見や政府の会見からスポーツ・芸能関連の会見まで。日本に限らず世界の注目会見をリアルタイムに。");
INSERT INTO programs(program_id, title, genre_id, channel_id, description) VALUES(7, "ASO飯塚チャレンジドゴルフトーナメント", 2, 8, "2022年よりジャパンゴルフツアーの新規トーナメントとして「ASO飯塚チャレンジドゴルフトーナメント」が開催されることとなりました。");
```

### シーズンテーブル
```sql
INSERT INTO seasons(season_id) VALUES(1);
```
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

