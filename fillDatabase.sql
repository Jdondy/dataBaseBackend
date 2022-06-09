SET FOREIGN_KEY_CHECKS=1;
-- User table
delete from user;
INSERT INTO `apple_music`.`user` (userId,`userName`, `userPhoto`) VALUES 
(1,'Jdondy', '54455354'),
(2,'Remyd33', '544555234'),
(3,'Windexxwiper', '5445535');
SELECT * FROM apple_music.user;

-- radio_episodes table
delete from radio_episodes;
INSERT INTO `apple_music`.`radio_episodes` (radioEpisodeId,`duration`, `radioPhoto`, `radioDescription`, `episode`, `name`, `userId`) VALUES 
(1,'500', '54455354', 'This is a great radio station!','1','Blake Shelton Fun','1'),
(2,'400', '4455354', 'This is not a great radio station!','2','Kanye West Fun','2'),
(3,'300', '46655354', 'This is a radio station!','3','Drake Fun','3');
select * from radio_episodes;

-- album table
delete from album;
INSERT INTO `apple_music`.`album` (albumId,`albumDescription`, `albumTitle`, `albumPhoto`) VALUES 
(1,'Drakes best album', 'More Life','46544'),
(2,'Kanyes best album', 'Donda','215641564'),
(3,'Jack Johnsons best album', 'Curious George','564564456');
select * from album;

-- album-song table
delete from `album-song`;
INSERT INTO `apple_music`.`album-song` (albumId,songId) VALUES 
(1,1),
(2,2),
(3,3);
select * from `album-song`;


-- genre table
delete from genre;
INSERT INTO `apple_music`.`genre` (genreId,`genreName`) VALUES 
(1,'country'),
(2,'Hip-Hop'),
(3,'K-pop');
select * from genre;

-- song-genre table
delete from `song-genre`;
INSERT INTO `apple_music`.`song-genre` (songId,genreId) VALUES 
(1,1),
(2,2),
(3,3);
select * from `song-genre`;

-- song table
delete from song;
INSERT INTO `apple_music`.`song` (songId,`lyrics`, `songTime`,`songPhoto`,`queue`,`title`) VALUES 
(1,'lyrics here', '200','564842','{"current":"value","previous":"value","next":"value"}', 'Happy birthday'),
(2,'lyrics here', '400','58842','{"current":"value","previous":"value","next":"value"}', 'From Time'),
(3,'lyrics here', '100','458974','{"current":"value","previous":"value","next":"value"}', 'Banana Pancakes');
select * from song;

-- artist table
delete from artist;
INSERT INTO `apple_music`.`artist` (artistId,`artistPhoto`, `artistDescription`, `artistName`, `albumId`, `songId`) VALUES 
(1,'556644', 'Country Singer', 'Morgan Wallen','1','1'),
(2,'336644', 'Rapper', 'Drake','3','2'),
(3,'5565694', 'Singer', 'Celo Green','2','3');
select * from artist;

-- playlist-song table
delete from `playlist-song`;
INSERT INTO `apple_music`.`playlist-song` (playlistId,songId) VALUES 
(1,1),
(2,2),
(3,3);
select * from `playlist-song`;

-- playlist table
delete from playlist;
INSERT INTO `apple_music`.`playlist` (playlistId,`playlistPhoto`, `playlistName`) VALUES 
(1,'545652', 'Bruh'),
(2,'4654652', 'QFC'),
(3,'465442', 'Moment');
select * from playlist;

-- user-playlist table
delete from `user-playlist`;
INSERT INTO `apple_music`.`user-playlist` (userId,playlistId) VALUES 
(1,1),
(2,2),
(3,3);
select * from `user-playlist`;
SET FOREIGN_KEY_CHECKS=1;

-- radio_episode-artist table
delete from `radio_episode-artist`;
insert into `radio_episode-artist` (artistId,radioEpisodeId) values
(1,1),
(2,1),
(3,1);
select * from `radio_episode-artist`;

-- genre-artist table
delete from `genre-artist`;
INSERT INTO `apple_music`.`genre-artist` (genreId,artistId) VALUES 
(1,1),
(2,2),
(3,3);
select * from `genre-artist`;