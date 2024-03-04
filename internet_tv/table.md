
テーブル：programs
| カラム名        | データ型         | NULL | キー      | 初期値 | AUTO INCREMENT |
| ----------- | ------------ | ---- | ------- | --- | -------------- |
| program_id  | bigint       |      | PRIMARY |     | YES            |
| genre_id    | bigint       |      |         |     |                |
| channel_id  | bigint       |      |         |     |                |
| title       | varchar(255) |      |         |     |                |
| description | varchar(255) |      |         |     |                |

・外部キー制約：program_idに対して、seasonsテーブルのprogram_idカラムから設定

テーブル：genres
| カラム名     | データ型         | NULL | キー      | 初期値 | AUTO INCREMENT |
| -------- | ------------ | ---- | ------- | --- | -------------- |
| genre_id | bigint       |      | PRIMARY |     | YES            |
| genre    | varchar(255) |      |         |     |                |

・外部キー制約：genre_idに対して、programsテーブルのgenre_idカラムから設定。

テーブル：channels
| カラム名       | データ型         | NULL | キー      | 初期値 | AUTO INCREMENT |
| ---------- | ------------ | ---- | ------- | --- | -------------- |
| channel_id | bigint       |      | PRIMARY |     | YES            |
| channel    | varchar(255) |      |         |     |                |

・外部キー制約：channel_idに対して、programsテーブルのchannel_idカラムから設定。

テーブル：seasons
| カラム名      | データ型   | NULL | キー      | 初期値 | AUTO INCREMENT |
| --------- | ------ | ---- | ------- | --- | -------------- |
| season_id | bigint |      | PRIMARY |     | YES            |
| season    | bigint | YES  |         |     |                |

・外部キー制約：season_idに対して、episodesテーブルのseason_idカラムから設定。

テーブル：episodes
| カラム名       | データ型         | NULL | キー      | 初期値 | AUTO INCREMENT |
| ---------- | ------------ | ---- | ------- | --- | -------------- |
| episode_id | bigint       |      | PRIMARY |     | YES            |
| season_id  | bigint       |      |         |     |                |
| title      | varchar(255) |      |         |     |                |
| epi_desc   | varchar(255) |      |         |     |                |
| time       | bigint       |      |         |     |                |
| date       | date         |      |         |     |                |
| views      | bigint       |      |         | 0   |                |
| start_time | datetime     |      |         |     |                |
| end_time   | datetime     |      |         |     |                |
| episode    | bigint       | YES  |         |     |                |