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
番組テーブルを作成します。

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
ジャンルテーブルを作成します。
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
チャンネルテーブルを作成します。
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
チャンネルテーブルにデータを入れます。
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
ジャンルテーブルにデータを入れます。
```sql
INSERT INTO genres (genre_id, genre) VALUES(1, "アニメ");
INSERT INTO genres (genre_id, genre) VALUES(2, "スポーツ");
INSERT INTO genres (genre_id, genre) VALUES(3, "バラエティ");
INSERT INTO genres (genre_id, genre) VALUES(4, "映画");
INSERT INTO genres (genre_id, genre) VALUES(5, "ドラマ");
INSERT INTO genres (genre_id, genre) VALUES(6, "ニュース");
```

### 番組テーブル

番組テーブルにデータを入れます。
```sql
INSERT INTO programs(program_id, title, genre_id, channel_id, description) VALUES(1, "星降る夜の奇跡", 5, 1, "町の人々が不思議な出来事を目撃する物語。");
INSERT INTO programs(program_id, title, genre_id, channel_id, description) VALUES(2, "スターライト・クエスト", 1, 6, "「スターライト・クエスト」は、銀河の果てに眠る伝説の宝を求めて、勇敢な冒険者たちが旅立つファンタジーアニメ。主人公のアリアと彼女の仲間たちは、魔法と冒険が溢れる世界を旅しながら、友情や成長を経験し、最後には銀河の秘宝を手に入れるために壮大な戦いに挑む。 ");
INSERT INTO programs(program_id, title, genre_id, channel_id, description) VALUES(3, "クリスタル・ウィングスの冒険", 1, 7, "少女エリアと仲間たちは、伝説の魔法の羽根「クリスタル・ウィングス」を探す旅に出る。彼らは魔法の力を学びながら、邪悪な魔法使いとの戦いに立ち向かい、最後のクリスタル・ウィングスを見つけるために奮闘する。");
INSERT INTO programs(program_id, title, genre_id, channel_id, description) VALUES(4, "アフリカ探検隊", 3, 3, "「アフリカ探検隊」は、大自然の美しさや文化の多様性を探求するバラエティ番組。冒険好きな旅団がアフリカ大陸を旅し、驚異的な動物たちや壮大な風景、地元の人々の暮らしを紹介する。彼らはサファリで野生動物を追跡し、熱帯雨林や砂漠を探検しながら、アフリカの魅力的な魅力を発見する。");
INSERT INTO programs(program_id, title, genre_id, channel_id, description) VALUES(5, "味の記憶", 5, 2, "「味の記憶」は、料理と人生の物語が交錯する感動のグルメ系ドラマ。主人公は、料理人としての才能を持ちながら、過去のトラウマや挫折に苦しみながらも、料理を通じて新たな人生の可能性を模索する。彼（彼女）の料理は、食材の魔法のように人々の心を癒し、過去の傷を癒す。");
INSERT INTO programs(program_id, title, genre_id, channel_id, description) VALUES(6, "ワールド・フォーカス", 6, 5, "「ワールド・フォーカス」は、世界中の最新のニュースと情報を提供するリアルタイムのニュース番組です。国際情勢、政治、経済、文化、エンターテイメントなど、様々な分野から厳選されたニュースが伝えられます。");
INSERT INTO programs(program_id, title, genre_id, channel_id, description) VALUES(7, "グリーン・マスターズ", 2, 8, "「グリーン・マスターズ」は、ゴルフ愛好家のためのエキサイティングなゴルフ番組です。この番組では、世界中のプロゴルファーやアマチュアゴルファーが競い合う様子を生中継し、ゴルフ界の最新情報やテクニックを紹介します。");
INSERT INTO programs(program_id, title, genre_id, channel_id, description) VALUES(8, "ハチャメチャトーク！", 3, 4, "「ハチャメチャトーク！」は、笑いと驚きに満ちたトークバラエティ番組です。ホストたちがゲストを招き、さまざまな面白いトピックや興味深いエピソードについて話します。");
INSERT INTO programs(program_id, title, genre_id, channel_id, description) VALUES(9, "笑いのサーカス！", 3, 3, "「笑いのサーカス！」は、笑いとエンターテイメントが溢れるお笑い番組です。有名なお笑い芸人や新人コメディアンが登場し、個性豊かなネタやコントを披露します。");
INSERT INTO programs(program_id, title, genre_id, channel_id, description) VALUES(10, "影の謎", 5, 2, "「影の謎」は、都市の裏社会で起こる様々な事件を描いたミステリードラマです。主人公は、秘密の捜査官であり、彼（彼女）は犯罪や陰謀に満ちた街を舞台に、未解決の事件や謎に挑みます。");
INSERT INTO programs(program_id, title, genre_id, channel_id, description) VALUES(11, "サイバー・ストライカーズ", 1, 7, ""サイバー・ストライカーズ"は、未来の都市を舞台にしたアクション満載のアニメ番組です。主人公たちは、特殊な能力を持つ若きサイバーネット戦士で、悪の組織と戦う特殊部隊に所属しています。");
INSERT INTO programs(program_id, title, genre_id, channel_id, description) VALUES(12, "泳ぎの舞台", 2, 8, "「泳ぎの舞台」は、世界各地の水泳競技を取り上げるスポーツ番組です。プールやオープンウォーターなど、さまざまな水域での競技を紹介し、プロフェッショナルな水泳選手たちの情熱と競技力を追います。");
INSERT INTO programs(program_id, title, genre_id, channel_id, description) VALUES(13, "未知の探求者", 4, 1, "「未知の探求者」は、冒険心と好奇心に満ちた人々が未知の地域や未知の領域を探求する姿を追ったドキュメンタリー映画です。");
INSERT INTO programs(program_id, title, genre_id, channel_id, description) VALUES(14, "影の隠者", 5, 2, "「影の隠者」は、都市の裏社会で暗躍する謎の人物と、彼に挑む警察官たちの攻防を描いたサスペンスドラマです。");
```

### シーズンテーブル

シーズンテーブルにデータを入れます。

```sql
INSERT INTO seasons(season_id, program_id, season) VALUES(1, 1, 1);
INSERT INTO seasons(season_id, program_id, season) VALUES(2, 2, 1);
INSERT INTO seasons(season_id, program_id, season) VALUES(3, 3, 3);
INSERT INTO seasons(season_id, program_id, season) VALUES(4, 4, 1);
INSERT INTO seasons(season_id, program_id, season) VALUES(5, 5, 10);
INSERT INTO seasons(season_id, program_id, season) VALUES(6, 6, NULL);
INSERT INTO seasons(season_id, program_id, season) VALUES(7, 7, NULL);
INSERT INTO seasons(season_id, program_id, season) VALUES(8, 8, NULL);
INSERT INTO seasons(season_id, program_id, season) VALUES(9, 9, 1);
INSERT INTO seasons(season_id, program_id, season) VALUES(10, 10, 1);
INSERT INTO seasons(season_id, program_id, season) VALUES(11, 11, 1);
INSERT INTO seasons(season_id, program_id, season) VALUES(12, 12, 1);
INSERT INTO seasons(season_id, program_id, season) VALUES(13, 13, NULL);
INSERT INTO seasons(season_id, program_id, season) VALUES(14, 14, 1);
```

### エピソードテーブル

エピソードテーブルにデータを入れます。

```sql
INSERT INTO episodes(episode_id, season_id, title, epi_desc, time, date, views, start_time, end_time, episode) VALUES(1, 1, "第1話 - 「星降る夜の出会い」", "新婚の夫婦、太郎と花子は、星が降る夜に偶然出会った。彼らはその夜、星を見ながら将来の夢や希望について語り合う。", 59, "2024-03-01", 88000, "2024-03-01 17:00:00", "2024-03-01 18:05:00", 1);
INSERT INTO episodes(episode_id, season_id, title, epi_desc, time, date, views, start_time, end_time, episode) VALUES(2, 1, "第2話 - 「星降る夜の誓い」", "太郎と花子は結婚記念日を迎え、星空の下で再び誓いを交わす。しかし、突然の出来事が二人の関係に影を投げかける。", 46, "2024-03-08", 23000, "2024-03-08 17:00:00", "2024-03-08 18:00:00", 2);
INSERT INTO episodes(episode_id, season_id, title, epi_desc, time, date, views, start_time, end_time, episode) VALUES(3, 1, "第3話 - 「星降る夜の旅立ち」", "太郎と花子は新しい挑戦に向けて家族と共に遠くへ旅立つ。星空の下での新たな人生の旅が始まる。", 46, "2024-03-15", 19000, "2024-03-15 17:00:00", "2024-03-15 18:00:00", 3);
INSERT INTO episodes(episode_id, season_id, title, epi_desc, time, date, views, start_time, end_time, episode) VALUES(4, 1, "第4話 - 「星降る夜の絆」", "旅先で太郎と花子は困難に直面するが、家族や地元の人々との出会いによって絆を深める。", 46, "2024-03-22", 17000, "2024-03-22 17:00:00", "2024-03-22 18:00:00", 4);
INSERT INTO episodes(episode_id, season_id, title, epi_desc, time, date, views, start_time, end_time, episode) VALUES(5, 1, "第5話 - 「星降る夜の再会」", "太郎と花子は過去の出来事を乗り越え、再び幸せな日々を取り戻す。しかし、新たな試練が待ち受けている。", 46, "2024-03-29", 17000, "2024-03-29 17:00:00", "2024-03-29 18:00:00", 5);
INSERT INTO episodes(episode_id, season_id, title, epi_desc, time, date, views, start_time, end_time, episode) VALUES(6, 1, "第6話 - 「星降る夜の輝き」", "家族や友情の力を信じて、太郎と花子は困難を乗り越える。星空の下で、彼らの愛と絆が輝きを放つ。", 46, "2024-04-05", 16000, "2024-04-05 17:00:00", "2024-04-05 18:00:00", 6);
INSERT INTO episodes(episode_id, season_id, title, epi_desc, time, date, views, start_time, end_time, episode) VALUES(7, 1, "第7話 - 「星降る夜の奇跡」", "物語の結末を迎える夜、太郎と花子は星が降る奇跡を目撃する。運命の軌跡が交差する中、彼らは新たな未来への扉を開く。", 78, "2024-04-12", 18000, "2024-04-12 17:00:00", "2024-04-12 18:30:00", 6);
INSERT INTO episodes(episode_id, season_id, title, epi_desc, time, date, views, start_time, end_time, episode) VALUES(8, 2, "#25 星の輝き", "最後の試練を乗り越えた主人公たちは、ついに伝説の宝を手に入れる。しかし、その力を手にしたことで新たなる脅威が現れ、彼らは団結して立ち向かう。最終決戦が幕を開ける。", 30, "2024-03-02", 0, "2024-03-02 00:00:00", "2024-03-02 00:30:00", 25);
INSERT INTO episodes(episode_id, season_id, title, epi_desc, time, date, views, start_time, end_time, episode) VALUES(9, 2, "#24 最後の試練", "主人公たちは、最後の試練に挑むために魔法の神殿に到着する。神殿内では、彼らを待ち受ける数々の難関が彼らの力を試し、最後の力を発揮することが求められる。", 30, "2024-02-24", 419000, "2024-02-24 00:00:00", "2024-02-24 00:30:00", 24);
INSERT INTO episodes(episode_id, season_id, title, epi_desc, time, date, views, start_time, end_time, episode) VALUES(10, 3, "1話: 新たなる旅立ち", "エリアと仲間たちは新たな冒険に出発し、未知の地を目指す。しかし、彼らを待ち受けるのは予想外の困難だった。", 26, "2024-03-01", 562000, "2024-03-01 22:35:00", "2024-03-01 23:00:00", 1);
INSERT INTO episodes(episode_id, season_id, title, epi_desc, time, date, views, start_time, end_time, episode) VALUES(11, 3, "2話: 魔法の森の謎", "一行は魔法の森に到着し、クリスタル・ウィングスの手掛かりを求めて探索を始める。しかし、森には古代の呪いが潜んでおり、彼らの進路を阻む。", 26, "2024-03-01", 169000, "2024-03-01 23:00:00", "2024-03-01 23:30:00", 2);
INSERT INTO episodes(episode_id, season_id, title, epi_desc, time, date, views, start_time, end_time, episode) VALUES(12, 3, "3話: 友情の絆", "困難に立ち向かう中、エリアと仲間たちの絆がさらに深まる。彼らは互いの信頼と力を借り合いながら、進化する敵に立ち向かう。", 26, "2024-03-01", 154000, "2024-03-01 23:30:00", "2024-03-02 00:00:00", 3);
INSERT INTO episodes(episode_id, season_id, title, epi_desc, time, date, views, start_time, end_time, episode) VALUES(13, 3, "4話: 魔法の試練", "クリスタル・ウィングスを求める一行は、魔法の試練に挑む。彼らは個々の魔法の力を高め、自らの内なる強さを発見する。", 26, "2024-03-02", 157000, "2024-03-02 00:00:00", "2024-03-02 00:30:00", 4);
INSERT INTO episodes(episode_id, season_id, title, epi_desc, time, date, views, start_time, end_time, episode) VALUES(14, 3, "5話: 闇の脅威", "途中、彼らは闇の力によって脅かされる。新たな敵が現れ、エリアたちは自らの過去と向き合いながら、闇の脅威に立ち向かう決意をする。", 26, "2024-03-02", 155000, "2024-03-02 00:30:00", "2024-03-02 01:00:00", 5);
INSERT INTO episodes(episode_id, season_id, title, epi_desc, time, date, views, start_time, end_time, episode) VALUES(15, 4, "#6: 砂漠の謎", "探検隊はアフリカの砂漠地帯に入り、厳しい環境と広大な砂漠の美しさに出会う。彼らは生き物たちの生態と、砂漠の生命力について学びながら、砂漠の謎に迫る。", 48, "2024-03-02", 578000, "2024-03-02 16:00:00", "2024-03-02 17:00:00", 6);
INSERT INTO episodes(episode_id, season_id, title, epi_desc, time, date, views, start_time, end_time, episode) VALUES(16, 4, "#7： 野生の王国", "探検隊はアフリカのサバンナに足を踏み入れ、野生動物たちの王国を訪れる。ライオン、ゾウ、シマウマなど、アフリカの象徴的な動物たちの生態や行動を観察し、サバンナの生態系の驚異に触れる。", 52, "2024-03-02", 685000, "2024-03-02 17:00:00", "2024-03-02 18:00:00", 7);
INSERT INTO episodes(episode_id, season_id, title, epi_desc, time, date, views, start_time, end_time, episode) VALUES(17, 4, "#8： 原始の美", "探検隊はアフリカの熱帯雨林に入り、原始的な美しさに魅了される。密林の奥深くに潜む生物たちや、川や滝の神秘的な姿を探求しながら、熱帯雨林の驚くべき生態系と美しさを体験する。", 52, "2024-03-02", 607000, "2024-03-02 18:00:00", "2024-03-02 19:00:00", 8);
INSERT INTO episodes(episode_id, season_id, title, epi_desc, time, date, views, start_time, end_time, episode) VALUES(18, 5, "再会の味", "主人公はかつての恩師と再会し、彼の料理店で働く機会を得る。しかし、過去の確執や誤解が彼らの関係を複雑にし、再び料理の世界で対立することになる。彼らは料理の魔法を通じて過去の問題を解決し、新たなる絆を築くことができるのか、それとも決裂してしまうのか…。", 30, "2024-03-02", 19000, "2024-03-02 20:15:00", "2024-03-02 20:57:00", 2);
INSERT INTO episodes(episode_id, season_id, title, epi_desc, time, date, views, start_time, end_time, episode) VALUES(19, 6, "南極大陸の挑戦", "特派員たちは、南極の氷山や氷河を背景に、科学者や探検家たちが直面する困難や彼らの研究成果について報告します。さらに、南極の野生動物や地球の気候変動への影響についても探求し、視聴者に地球の未知の一面を紹介します。", 60, "2024-03-03", 0, "2024-03-03 16:00:00", "2024-03-03 17:00:00", NULL);
INSERT INTO episodes(episode_id, season_id, title, epi_desc, time, date, views, start_time, end_time, episode) VALUES(20, 7, "ゴルフ王者の挑戦", "世界トップクラスのゴルフプレイヤーたちが様々なゴルフコースでの挑戦を繰り広げます。特に注目されるのは、前人未到のゴルフコースでの新たなレコード挑戦です。", 475, "2024-03-04", 0, "2024-03-04 19:05:00", "2024-03-05 03:00:00", NULL);
INSERT INTO episodes(episode_id, season_id, title, epi_desc, time, date, views, start_time, end_time, episode) VALUES(21, 8, "しくじりトーク大解剖！", "ゲストたちが過去のしくじりや失敗について率直に語ります。トークのテーマは、誰もが経験する失敗や挫折に関するものであり、ゲストたちは自身の失敗談や失敗から学んだことについて熱く語ります。", 54, "2024-03-05", 0, "2024-03-05 13:00:00", "2024-03-05 13:54:00", NULL);
INSERT INTO episodes(episode_id, season_id, title, epi_desc, time, date, views, start_time, end_time, episode) VALUES(22, 9, "賭け事大騒動！", "ゲストたちは過去の面白い賭けや勝負、あるいは失敗した賭けについて語ります。お金やプライドをかけた大胆な賭けや、思わぬ展開が待ち受けるトークで、視聴者は笑いと緊張感に包まれます。", 92, "2024-03-06", 0, "2024-03-06 05:34:00", "2024-03-06 07:06:00", 3);
INSERT INTO episodes(episode_id, season_id, title, epi_desc, time, date, views, start_time, end_time, episode) VALUES(23, 5, "失われたレシピ", "料理界の伝説とされるある料理人の秘密のレシピが再び世に現れるという噂が広まり、シェフたちはその真偽を確かめるために旅に出ます。彼らは失われたレシピの手掛かりを求め、様々な場所を巡りながら過去の味の記憶を辿ります。", 35, "2024-03-07", 0, "2024-03-07 08:40:00", "2024-03-07 09:15:00", 7);
INSERT INTO episodes(episode_id, season_id, title, epi_desc, time, date, views, start_time, end_time, episode) VALUES(24, 10, "消えた証拠", "警察官のジョンソンは、殺人事件の容疑者を追跡する中で、重要な証拠が突如として消えてしまう。捜査が行き詰まりつつある中、彼は自らの直感に従い、証拠の消失に隠された真相を解明するために奮闘する。", 35, "2024-03-07", 0, "2024-03-07 08:40:00", "2024-03-07 09:15:00", 7);
INSERT INTO episodes(episode_id, season_id, title, epi_desc, time, date, views, start_time, end_time, episode) VALUES(25, 11, "暗黒のウェブ", "彼らは暗黒のウェブと呼ばれる極秘のネットワークにアクセスし、敵の計画を阻止するために情報を収集します。しかし、ウェブの奥深くには危険な罠が待ち受けており、チームはその罠から逃れるために結束しなければなりません。", 30, "2024-03-09", 0, "2024-03-09 03:10:00", "2024-03-09 03:40:00", 22);
INSERT INTO episodes(episode_id, season_id, title, epi_desc, time, date, views, start_time, end_time, episode) VALUES(26, 12, "日本海の戦い", "本海に面した競技場で、日本を代表する水泳選手たちが激しく競い合います。視聴者は、彼らの熱い戦いや努力を通じて、日本の水泳文化と選手たちの情熱に触れます。", 230, "2024-03-10", 0, "2024-03-10 07:20:00", "2024-03-10 11:10:00", 2);
INSERT INTO episodes(episode_id, season_id, title, epi_desc, time, date, views, start_time, end_time, episode) VALUES(27, 5, "忘れられた食堂", "忘れ去られた食堂の秘密が明らかにされます。主人公たちは、かつて人々に愛されたある食堂の謎を解き明かすために旅に出ます。彼らは、かつての常連客や関係者との面会を通じて、その食堂が人々の心に残した特別な思い出を探ります。", 42, "2024-03-05", 0, "2024-03-05 20:15:00", "2024-03-05 20:57:00", 5);
INSERT INTO episodes(episode_id, season_id, title, epi_desc, time, date, views, start_time, end_time, episode) VALUES(28, 13, "未知の探求者", "冒険心と好奇心に満ちた人々が未知の地域や未知の領域を探求する姿を追ったドキュメンタリー映画です。映画は、探検家、科学者、アーティストなど、さまざまな分野の人々が新しい発見や挑戦に取り組む様子を追い、彼らの情熱と努力を称賛します。", 65, "2024-03-09", 0, "2024-03-09 12:00:00", "2024-03-09 13:05:00", NULL);
INSERT INTO episodes(episode_id, season_id, title, epi_desc, time, date, views, start_time, end_time, episode) VALUES(29, 14, "追跡者", "主人公が自らの過去を追跡する旅が描かれます。彼は過去の出来事や人物の謎に迫るために、新たな手がかりを探し求めます。その過程で、彼は不意に敵の存在に気付き、彼らの陰謀を暴くために行動します。", 55, "2024-03-10", 0, "2024-03-10 04:00:00", "2024-03-09 04:55:00", 3);
```