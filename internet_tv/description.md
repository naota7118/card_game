
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
ALTER TABLE seasons ADD FOREIGN KEY season_fk(season_id) REFERENCES programs(season_id);

正しく設定されたか以下で確認できます。
SHOW CREATE TABLE seasons;