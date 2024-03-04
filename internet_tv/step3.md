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






