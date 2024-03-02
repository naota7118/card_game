
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

エピソードテーブルにタイトル(title)、エピソード詳細(epi_desc)、動画時間(time)、公開日(date)、視聴数(views)のカラムを追加します。
ALTER TABLE episodes ADD COLUMN title VARCHAR(255) NOT NULL;
ALTER TABLE programs ADD COLUMN epi_desc VARCHAR(255) NOT NULL;
ALTER TABLE programs ADD COLUMN time BIGINT NOT NULL;
ALTER TABLE programs ADD COLUMN date TIME NOT NULL;
ALTER TABLE programs ADD COLUMN views BIGINT NOT NULL;

programsテーブルからonair_date, start_time, end_time, minutes, viewsカラムを削除します。
（これらの情報はepisodesテーブルで管理するため）
ALTER TABLE programs DROP COLUMN onair_date;
ALTER TABLE programs DROP COLUMN views;
ALTER TABLE programs DROP COLUMN start_time;
ALTER TABLE programs DROP COLUMN end_time;
ALTER TABLE programs DROP COLUMN minutes;