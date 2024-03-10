## 1. 
よく見られているエピソードを知りたいです。エピソード視聴数トップ3のエピソードタイトルと視聴数を取得してください

```sql
SELECT title, views 
FROM episodes
ORDER BY views 
DESC LIMIT 3;
```

## 2. 
よく見られているエピソードの番組情報やシーズン情報も合わせて知りたいです。エピソード視聴数トップ3の番組タイトル、シーズン数、エピソード数、エピソードタイトル、視聴数を取得してください

```sql
SELECT programs.title, season, episode, episodes.title, views
FROM episodes
JOIN seasons
ON episodes.season_id = seasons.season_id
JOIN programs
ON seasons.program_id = programs.program_id
ORDER BY views DESC 
LIMIT 3;
```
## 3.
本日の番組表を表示するために、本日、どのチャンネルの、何時から、何の番組が放送されるのかを知りたいです。本日放送される全ての番組に対して、チャンネル名、放送開始時刻(日付+時間)、放送終了時刻、シーズン数、エピソード数、エピソードタイトル、エピソード詳細を取得してください。なお、番組の開始時刻が本日のものを本日方法される番組とみなすものとします

```sql
select channel, programs.title, season, start_time, end_time, season, episode, episodes.title, epi_desc
from episodes
join seasons
on episodes.season_id = seasons.season_id
join programs
on seasons.program_id = programs.program_id
join channels
on programs.channel_id = channels.channel_id 
WHERE start_time BETWEEN "2024-03-02 00:00:00" AND "2024-03-02 23:59:59";
```

## 4.
ドラマというチャンネルがあったとして、ドラマのチャンネルの番組表を表示するために、本日から一週間分、何日の何時から何の番組が放送されるのかを知りたいです。ドラマのチャンネルに対して、放送開始時刻、放送終了時刻、シーズン数、エピソード数、エピソードタイトル、エピソード詳細を本日から一週間分取得してください

```sql
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
```

## 5.
(advanced) 直近一週間で最も見られた番組が知りたいです。直近一週間に放送された番組の中で、エピソード視聴数合計トップ2の番組に対して、番組タイトル、視聴数を取得してください

```sql
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
```

## 6.
(advanced) ジャンルごとの番組の視聴数ランキングを知りたいです。番組の視聴数ランキングはエピソードの平均視聴数ランキングとします。ジャンルごとに視聴数トップの番組に対して、ジャンル名、番組タイトル、エピソード平均視聴数を取得してください。

```sql
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
```
