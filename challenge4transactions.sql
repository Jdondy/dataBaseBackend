SET FOREIGN_KEY_CHECKS=0;

-- ****************
-- Create (INSERT) Queries
-- ****************

-- addOrUpdateUser
-- Inerts or updates user table
select * from apple_music.user;
INSERT INTO `apple_music`.`user` (userId,`userName`, `userPhoto`) VALUES 
(null,'Johnson', '555354')
on duplicate key update userName=values(userName), userPhoto=values(userPhoto);
select * from apple_music.user;

-- addOrUpdateRadio_episodes
select * from apple_music.radio_episodes;
INSERT INTO `apple_music`.`radio_episodes` (radioEpisodeId,`duration`, `radioPhoto`, `radioDescription`, `episode`, `name`, `userId`) VALUES 
(5,'550', '5445354', 'An awesome radio station for cool people','12','Blake Shelton Fun','5')
on duplicate key update duration=values(duration), radioPhoto=values(radioPhoto), radioDescription=values(radioDescription), episode=values(episode), `name`=values(`name`);
select * from apple_music.radio_episodes;

-- addOrUpdateRadio_episode-artist
select * from apple_music.`radio_episode-artist`;
INSERT INTO `apple_music`.`radio_episode-artist` (radioEpisodeId,artistId) VALUES 
(2, 3);
select * from apple_music.`radio_episode-artist`;

-- addOrUpdateGenre
select * from apple_music.genre;
INSERT INTO `apple_music`.`genre` (genreId,`genreName`) VALUES 
(null, 'pop')
on duplicate key update genreName=values(genreName);
select * from apple_music.genre;

-- addOrUpdateAlbum
select * from apple_music.album;
INSERT INTO `apple_music`.`album` (albumId,`albumDescription`, `albumTitle`, `albumPhoto`) VALUES 
(10, 'A fun classical album with a twist', 'A bumble bee','787952')
on duplicate key update albumDescription=values(albumDescription), albumTitle=values(albumTitle), albumPhoto=values(albumPhoto);
select * from apple_music.album;

-- addOrUpdateAlbum-song
select * from apple_music.`album-song`;
INSERT INTO `apple_music`.`album-song` (albumId,songId) VALUES 
(2,7);
select * from apple_music.`album-song`;

-- addOrUpdateGenre-artist
select * from apple_music.`genre-artist`;
INSERT INTO `apple_music`.`genre-artist` (genreId,artistId) VALUES 
(3,4);
select * from apple_music.`genre-artist`;

-- addOrUpdateGenre
select * from apple_music.`genre`;
INSERT INTO `apple_music`.`genre` (genreId,genreName) VALUES 
(4,'Classical')
on duplicate key update genreName=values(genreName);
select * from apple_music.genre;

-- addOrUpdateSong-genre
select * from apple_music.`song-genre`;
INSERT INTO `apple_music`.`song-genre` (songId,genreId) VALUES 
(1,3);
select * from apple_music.`song-genre`;

-- addOrUpdateSong
select * from apple_music.`song`;
INSERT INTO `apple_music`.`song` (songId,`lyrics`,songTime,songPhoto,`queue`,`title`) VALUES 
(3,'happy birthday to you, happy birthday to you!', '400', '4564644', null, 'Happy Birthday')
on duplicate key update lyrics=values(lyrics), songTime=values(songTime), songPhoto=values(songPhoto), `queue`=values(`queue`),`title`=values(`title`);
select * from apple_music.song;

-- addOrUpdatePlaylist-song
select * from apple_music.`playlist-song`;
INSERT INTO `apple_music`.`playlist-song` (playlistId,songId) VALUES 
(4,5);
select * from apple_music.`playlist-song`;

-- addOrUpdatePlaylist
select * from apple_music.`playlist`;
INSERT INTO `apple_music`.`playlist` (playlistId,`playlistPhoto`,`playlistName`) VALUES 
(7,'456465', 'Best in da world')
on duplicate key update playlistPhoto=values(playlistPhoto), playlistName=values(playlistName);
select * from apple_music.playlist;

-- addOrUpdateuser-playlist
select * from apple_music.`user-playlist`;
INSERT INTO `apple_music`.`user-playlist` (userId,playlistId) VALUES 
(6,9);
select * from apple_music.`user-playlist`;


-- ****************
-- Retrieve (SELECT) Queries
-- ****************

-- getUsersAndPlaylists
select * from apple_music.user
join `user-playlist` on `user-playlist`.userId = `user`.`userId`
join playlist on `user-playlist`.playlistId = `playlist`.playlistId
where playlist.playlistId = 1;

-- getArtistsAndGenres
select * from apple_music.artist
join `genre-artist` on `genre-artist`.artistId = `artist`.`artistId`
join genre on `genre-artist`.genreId = `genre`.genreId
where genre.genreId = 2;

-- getRadioStationsAndUsers
select * from radio_episodes
where radio_episodes.userId = 3;

-- ****************
-- Update Queries
-- ****************

-- updateUser
select * from user;
update user set `userName` ='TTV-Windexxwiper' where userId=3;
select * from user order by user.userId;
 
-- updateArtist
select * from artist;
update artist set `songId`=5 where artistId=7;
select * from artist;

-- ****************
-- Delete Queries
-- ****************

-- deleteUser
select * from user;
delete from user where userId=1;
select * from user;

-- deletePlaylist
select * from playlist;
delete from playlist where playlistId=3;
select * from playlist;



