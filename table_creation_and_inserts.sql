mysql -u user -p -h host_nueva_rds movie_db < script

CREATE TABLE movie_db.publication (name VARCHAR(255) PRIMARY KEY, avatar VARCHAR(21));
CREATE TABLE movie_db.reviewer (name VARCHAR(255) PRIMARY KEY, avatar VARCHAR(255), publication VARCHAR(255), FOREIGN KEY (publication) REFERENCES publication(name) ON DELETE CASCADE);
CREATE TABLE movie_db.moviereview (title VARCHAR(255) PRIMARY KEY, `release` VARCHAR(255), score INTEGER, reviewer VARCHAR(255), publication VARCHAR(255), pending BOOLEAN,FOREIGN KEY (reviewer) REFERENCES reviewer(name) ON DELETE CASCADE);

CREATE USER 'training'@'%' IDENTIFIED BY 'access123';
GRANT SELECT ON movie_db.* TO 'training'@'%';

INSERT INTO movie_db.publication (name, avatar) VALUES ('The Daily Reviewer', 'glyphicon-eye-open');
INSERT INTO movie_db.publication (name, avatar) VALUES ('International Movie Critic', 'glyphicon-fire');
INSERT INTO movie_db.publication (name, avatar) VALUES ('MoviesNow', 'glyphicon-time');
INSERT INTO movie_db.publication (name, avatar) VALUES ('MyNextReview', 'glyphicon-record');
INSERT INTO movie_db.publication (name, avatar) VALUES ('Movies n\' Games', 'glyphicon-heart-empty');
INSERT INTO movie_db.publication (name, avatar) VALUES ('TheOne', 'glyphicon-globe');
INSERT INTO movie_db.publication (name, avatar) VALUES ('ComicBookHero.com', 'glyphicon-flash');

INSERT INTO movie_db.reviewer (name, avatar, publication) VALUES ('Robert Smith','https://s3.amazonaws.com/uifaces/faces/twitter/angelcolberg/128.jpg','The Daily Reviewer');
INSERT INTO movie_db.reviewer (name, avatar, publication) VALUES ('Chris Harris','https://s3.amazonaws.com/uifaces/faces/twitter/bungiwan/128.jpg','International Movie Critic');
INSERT INTO movie_db.reviewer (name, avatar, publication) VALUES ('Janet Garcia','https://s3.amazonaws.com/uifaces/faces/twitter/grrr_nl/128.jpg','MoviesNow');
INSERT INTO movie_db.reviewer (name, avatar, publication) VALUES ('Andrew West','https://s3.amazonaws.com/uifaces/faces/twitter/d00maz/128.jpg','MyNextReview');
INSERT INTO movie_db.reviewer (name, avatar, publication) VALUES ('Mindy Lee','https://s3.amazonaws.com/uifaces/faces/twitter/laurengray/128.jpg','Movies n\' Games');
INSERT INTO movie_db.reviewer (name, avatar, publication) VALUES ('Martin Thomas','https://s3.amazonaws.com/uifaces/faces/twitter/karsh/128.jpg','TheOne');
INSERT INTO movie_db.reviewer (name, avatar, publication) VALUES ('Anthony Miller','https://s3.amazonaws.com/uifaces/faces/twitter/9lessons/128.jpg','ComicBookHero.com');

INSERT INTO movie_db.moviereview (title, `release`, score, reviewer, publication, pending) VALUES ('Deadpool', '2016', 11, 'Robert Smith', 'The Daily Reviewer', false);
INSERT INTO movie_db.moviereview (title, `release`, score, reviewer, publication, pending) VALUES ('Thor: Ragnarok', '2017', 7, 'Chris Harris', 'International Movie Critic', false);
INSERT INTO movie_db.moviereview (title, `release`, score, reviewer, publication, pending) VALUES ('It', '2017', 8, 'Janet Garcia', 'MoviesNow', false);
INSERT INTO movie_db.moviereview (title, `release`, score, reviewer, publication, pending) VALUES ('Dunkirk', '2017', 8, 'Andrew West', 'MyNextReview', false);
INSERT INTO movie_db.moviereview (title, `release`, score, reviewer, publication, pending) VALUES ('Logan', '2017', 8, 'Mindy Lee', 'TheOne', false);
INSERT INTO movie_db.moviereview (title, `release`, score, reviewer, publication, pending) VALUES ('Batman V Superman', '2016', 6, 'Martin Thomas', 'Movies n\' Games', false);
INSERT INTO movie_db.moviereview (title, `release`, score, reviewer, publication, pending) VALUES ('Mad Max: Fury Road', '2015', 6, 'Anthony Miller', 'ComicBookHero.com', false);
INSERT INTO movie_db.moviereview (title, `release`, score, reviewer, publication, pending) VALUES ('Logan 2', '2020', 8, 'Mindy Lee', 'TheOne', true);
INSERT INTO movie_db.moviereview (title, `release`, score, reviewer, publication, pending) VALUES ('Batman V Superman 2', '2020', 6, 'Martin Thomas', 'Movies n\' Games', true);
INSERT INTO movie_db.moviereview (title, `release`, score, reviewer, publication, pending) VALUES ('Mad Max: Fury Road 2', '2020', 6, 'Anthony Miller', 'ComicBookHero.com', true);