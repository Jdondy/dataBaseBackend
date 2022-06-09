CREATE SCHEMA IF NOT EXISTS `apple_music` DEFAULT CHARACTER SET utf8;

CREATE TABLE `album` (
  `albumId` int NOT NULL AUTO_INCREMENT,
  `albumDescription` varchar(45) NOT NULL,
  `albumTitle` varchar(45) NOT NULL,
  `albumPhoto` blob NOT NULL,
  PRIMARY KEY (`albumId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

CREATE TABLE `song` (
  `songId` int NOT NULL AUTO_INCREMENT,
  `lyrics` mediumtext NOT NULL,
  `songTime` varchar(45) NOT NULL,
  `songPhoto` varchar(45) NOT NULL,
  `queue` json NOT NULL,
  `title` varchar(45) NOT NULL,
  PRIMARY KEY (`songId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

CREATE TABLE `album-song` (
  `albumId` int NOT NULL,
  `songId` int NOT NULL,
  PRIMARY KEY (`albumId`,`songId`),
  KEY `fromAlbumSongToSong_idx` (`songId`),
  CONSTRAINT `fromAlbumSongToAlbum` FOREIGN KEY (`albumId`) REFERENCES `album` (`albumId`) ON DELETE CASCADE,
  CONSTRAINT `fromAlbumSongToSong` FOREIGN KEY (`songId`) REFERENCES `song` (`songId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `artist` (
  `artistId` int NOT NULL AUTO_INCREMENT,
  `artistPhoto` blob NOT NULL,
  `artistDescription` varchar(200) NOT NULL,
  `artistName` varchar(45) NOT NULL,
  `albumId` int NOT NULL,
  `songId` int NOT NULL,
  PRIMARY KEY (`artistId`),
  KEY `fromArtistToAlbum_idx` (`albumId`),
  KEY `fromArtistToSong_idx` (`songId`),
  CONSTRAINT `fromArtistToAlbum` FOREIGN KEY (`albumId`) REFERENCES `album` (`albumId`) ON DELETE CASCADE,
  CONSTRAINT `fromArtistToSong` FOREIGN KEY (`songId`) REFERENCES `song` (`songId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

CREATE TABLE `genre` (
  `genreId` int NOT NULL AUTO_INCREMENT,
  `genreName` varchar(45) NOT NULL,
  PRIMARY KEY (`genreId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

CREATE TABLE `genre-artist` (
  `genreId` int NOT NULL,
  `artistId` int NOT NULL,
  PRIMARY KEY (`genreId`,`artistId`),
  KEY `fromGenreArtistToArtist_idx` (`artistId`),
  CONSTRAINT `fromGenreArtistToArtist` FOREIGN KEY (`artistId`) REFERENCES `artist` (`artistId`) ON DELETE CASCADE,
  CONSTRAINT `fromGenreArtistToGenre` FOREIGN KEY (`genreId`) REFERENCES `genre` (`genreId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `playlist` (
  `playlistId` int NOT NULL AUTO_INCREMENT,
  `playlistPhoto` blob NOT NULL,
  `playlistName` varchar(45) NOT NULL,
  PRIMARY KEY (`playlistId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

CREATE TABLE `playlist-song` (
  `playlistId` int NOT NULL AUTO_INCREMENT,
  `songId` int NOT NULL,
  PRIMARY KEY (`playlistId`,`songId`),
  KEY `fromPlaylistSongToSong_idx` (`songId`),
  CONSTRAINT `fromPlaylistSongToPlaylist` FOREIGN KEY (`playlistId`) REFERENCES `playlist` (`playlistId`) ON DELETE CASCADE,
  CONSTRAINT `fromPlaylistSongToSong` FOREIGN KEY (`songId`) REFERENCES `song` (`songId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

CREATE TABLE `user` (
  `userId` int NOT NULL AUTO_INCREMENT,
  `userName` varchar(45) NOT NULL,
  `userPhoto` blob NOT NULL,
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

CREATE TABLE `radio_episodes` (
  `radioEpisodeId` int NOT NULL AUTO_INCREMENT,
  `duration` int NOT NULL,
  `radioPhoto` blob NOT NULL,
  `radioDescription` varchar(500) NOT NULL,
  `episode` int NOT NULL,
  `name` varchar(45) NOT NULL,
  `userId` int NOT NULL,
  PRIMARY KEY (`radioEpisodeId`),
  KEY `fromRadioToUser_idx` (`userId`),
  CONSTRAINT `fromRadioToUser` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

CREATE TABLE `radio_episode-artist` (
  `artistId` int NOT NULL,
  `radioEpisodeId` int NOT NULL,
  PRIMARY KEY (`artistId`,`radioEpisodeId`),
  KEY `fromRadioEpisodeToRadioEpisode_idx` (`radioEpisodeId`),
  CONSTRAINT `fromRadioEpisodeToArtist` FOREIGN KEY (`artistId`) REFERENCES `artist` (`artistId`) ON DELETE CASCADE,
  CONSTRAINT `fromRadioEpisodeToRadioEpisode` FOREIGN KEY (`radioEpisodeId`) REFERENCES `radio_episodes` (`radioEpisodeId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `song-genre` (
  `songId` int NOT NULL,
  `genreId` int NOT NULL,
  PRIMARY KEY (`songId`,`genreId`),
  KEY `fromSongGenreToGenre_idx` (`genreId`),
  CONSTRAINT `fromSongGenreToGenre` FOREIGN KEY (`genreId`) REFERENCES `genre` (`genreId`) ON DELETE CASCADE,
  CONSTRAINT `fromSongGenreToSong` FOREIGN KEY (`songId`) REFERENCES `song` (`songId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `user-playlist` (
  `userId` int NOT NULL,
  `playlistId` int NOT NULL,
  PRIMARY KEY (`userId`,`playlistId`),
  KEY `fromUserPlaylistToPlaylist_idx` (`playlistId`),
  CONSTRAINT `fromUserPlaylistToPlaylist` FOREIGN KEY (`playlistId`) REFERENCES `playlist` (`playlistId`) ON DELETE CASCADE,
  CONSTRAINT `fromUserPlaylistToUser` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
