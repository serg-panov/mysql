/*
 * 9. Создадим таблицу с лайкам
 * Сценарий: пользователи могут ставить лайки и дизлайки на медиафайлы выложенные другими пользователями.
 * Каждый пользователь может поставить на один медиафайл только один лайк или один дизлайки, либо вообще ничего (запись в таблице отсутствует)
 * Помимо лайка/дизлайка храним дату установк и обновления (на случай если лайк сменили на дизлайк и наоборот)
*/
-- DROP TABLE likedislikes;

CREATE TABLE likedislikes (
	media_id BIGINT UNSIGNED NOT NULL,
	user_id BIGINT UNSIGNED NOT NULL,
	is_like ENUM('y', 'n') NOT NULL DEFAULT 'y',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY(media_id, user_id),
	INDEX(user_id),
	FOREIGN KEY (media_id) REFERENCES media (id),
	FOREIGN KEY (user_id) REFERENCES users (id)
) DEFAULT CHARSET=utf8;

INSERT INTO likedislikes(media_id, user_id, is_like) VALUES
(1, 2, 'y'),
(2, 2, 'n');


SELECT * FROM likedislikes;


/*
 * 10. Создадим таблицу с альбомами
 * Сценарий: пользователи могут объединять свои медиафайлы в альбомы.
 * Каждый альбом имеет уникальный id, имя, описание, дату создания, дату изменения, владельца
 * 
*/
-- DROP TABLE albums;

CREATE TABLE albums (
	id SERIAL PRIMARY KEY,
	name VARCHAR(145) NOT NULL,
	description VARCHAR(255),
	owner_id BIGINT UNSIGNED NOT NULL,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	INDEX(owner_id),
	FOREIGN KEY (owner_id) REFERENCES users (id)
) DEFAULT CHARSET=utf8;

INSERT INTO albums(name, description, owner_id) VALUES('My first album', 'My favorite medias', 1);

SELECT * FROM albums;

/*
 * 11. Создадим таблицу связку альбомов и медиафайлов
 * Сценарий: Один и тот же медиафайл может входить в несколько альбомов, отношение многие ко многим
 * Помимо связи необходимо хранить дату добавления медиафайла в альбом
 * 
*/
-- DROP TABLE album_medias;

CREATE TABLE album_medias (
	album_id BIGINT UNSIGNED NOT NULL,
	media_id BIGINT UNSIGNED NOT NULL,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(album_id, media_id),
	INDEX(media_id),
	FOREIGN KEY (album_id) REFERENCES albums (id),
	FOREIGN KEY (media_id) REFERENCES media (id)
) DEFAULT CHARSET=utf8;

INSERT INTO album_medias(album_id, media_id) VALUES(1, 1);

SELECT * FROM album_medias;

