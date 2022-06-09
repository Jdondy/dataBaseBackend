var express = require('express');
var router = express.Router();
var db = require('../db')

router.get('/', function (req, res, next) {
  res.send(`Yes I am working!`);
});

router.get('/showTables', (req, res, next) => {
  try {
    let query = "show tables;"
    db.executeQueryAsPromise(query, null)
      .then((queryResults) => {
        if (queryResults.length == 0) {
          queryResults = "No results found"
        }
        res.send(queryResults)
      }).catch((err) => { next(err) })
  }
  catch (err) { next(err) }
})

//************************************ */
//************CREATE ROUTES*********** */
//************************************ */

router.post("/addOrUpdateUser", function (req, res, next) {
  let { inputs } = req.body;
  let issue = null
  const validatedInputs = validateAndFormatInputs(inputs)
  if (validatedInputs.inputsAreValid) {
    let query = "INSERT INTO `apple_music`.`user` (userId,`userName`, `userPhoto`) VALUES  \
    (?,?,?) \
    on duplicate key update userName=values(userName), userPhoto=values(userPhoto);\
    \
    select * from `user`"
    db.executeQueryAsPromise(query, validatedInputs.placeholders)
      .then((queryResults) => {
        res.send(queryResults)
      }).catch((error) => {
        issue = { issue: "There was a problem running your queries", error }
        console.log(issue)
        res.send(issue)
      })
  } else {
    issue = { issue: "There was a problem validating your inputs", validatedInputs }
    console.log(issue)
    res.send(issue)
  }
})

router.post("/addOrUpdateGenre", function (req, res, next) {
  let { inputs } = req.body;
  let issue = null
  const validatedInputs = validateAndFormatInputs(inputs)
  if (validatedInputs.inputsAreValid) {
    let query = "INSERT INTO `apple_music`.`genre` (genreId,`genreName`) VALUES \
    (?,?) \
    on duplicate key update genreName=values(genreName);\
    \
    select * from `genre`"
    db.executeQueryAsPromise(query, validatedInputs.placeholders)
      .then((queryResults) => {
        res.send(queryResults)
      }).catch((error) => {
        issue = { issue: "There was a problem running your queries", error }
        console.log(issue)
        res.send(issue)
      })
  } else {
    issue = { issue: "There was a problem validating your inputs", validatedInputs }
    console.log(issue)
    res.send(issue)
  }
})

router.post("/addOrUpdatePlaylist", function (req, res, next) {
  let { inputs } = req.body;
  let issue = null
  const validatedInputs = validateAndFormatInputs(inputs)
  if (validatedInputs.inputsAreValid) {
    let query = "INSERT INTO `apple_music`.`playlist` (playlistId,`playlistPhoto`,`playlistName`) VALUES    \
    (?,?,?) \
    on duplicate key update playlistPhoto=values(playlistPhoto), playlistName=values(playlistName);\
    \
    select * from `playlist`"
    db.executeQueryAsPromise(query, validatedInputs.placeholders)
      .then((queryResults) => {
        res.send(queryResults)
      }).catch((error) => {
        issue = { issue: "There was a problem running your queries", error }
        console.log(issue)
        res.send(issue)
      })
  } else {
    issue = { issue: "There was a problem validating your inputs", validatedInputs }
    console.log(issue)
    res.send(issue)
  }
})

router.post("/addOrUpdateAlbum", function (req, res, next) {
  let { inputs } = req.body;
  let issue = null
  const validatedInputs = validateAndFormatInputs(inputs)
  if (validatedInputs.inputsAreValid) {
    let query = "INSERT INTO `apple_music`.`album` (albumId,`albumDescription`, `albumTitle`, `albumPhoto`) VALUES    \
    (?,?,?,?) \
    on duplicate key update albumDescription=values(albumDescription), albumTitle=values(albumTitle), albumPhoto=values(albumPhoto);\
    \
    select * from `album`"
    db.executeQueryAsPromise(query, validatedInputs.placeholders)
      .then((queryResults) => {
        res.send(queryResults)
      }).catch((error) => {
        issue = { issue: "There was a problem running your queries", error }
        console.log(issue)
        res.send(issue)
      })
  } else {
    issue = { issue: "There was a problem validating your inputs", validatedInputs }
    console.log(issue)
    res.send(issue)
  }
})

//************************************ */
//*********RETRIEVE ROUTES************ */
//************************************ */
//Select queries can be done as gets

router.get('/getUsersAndPlaylists/:boardId', (req, res, next) => {
  const inputs = [req.params.boardId]
  const query = "\
  select * from apple_music.user \
  join `user-playlist` on `user-playlist`.userId = `user`.`userId` \
  join playlist on `user-playlist`.playlistId = `playlist`.playlistId \
  where playlist.playlistId = ?;"
  db.executeQueryAsPromise(query, inputs)
    .then(results => {
      if (results.length == 0) {
        res.send("No results found")
      } else {
        res.send(results)
      }
    }).catch((error) => {
      issue = { issue: "There was a problem running your queries", error }
      console.log(issue)
      res.send(issue)
    })
})

router.get('/getArtistsAndGenres/:boardId', (req, res, next) => {
  const inputs = [req.params.boardId]
  const query = "\
  select * from apple_music.artist \
  join `genre-artist` on `genre-artist`.artistId = `artist`.`artistId` \
  join genre on `genre-artist`.genreId = `genre`.genreId \
  where genre.genreId = ?;" 
  db.executeQueryAsPromise(query, inputs)
    .then(results => {
      if (results.length == 0) {
        res.send("No results found")
      } else {
        res.send(results)
      }
    }).catch((error) => {
      issue = { issue: "There was a problem running your queries", error }
      console.log(issue)
      res.send(issue)
    })
})

router.get('/getRadioStationsAndUsers/:boardId', (req, res, next) => {
  const inputs = [req.params.boardId]
  const query = "\
  select * from radio_episodes \
  where radio_episodes.userId = ?;" 
  db.executeQueryAsPromise(query, inputs)
    .then(results => {
      if (results.length == 0) {
        res.send("No results found")
      } else {
        res.send(results)
      }
    }).catch((error) => {
      issue = { issue: "There was a problem running your queries", error }
      console.log(issue)
      res.send(issue)
    })
})


//************************************ */
//***********UPDATE ROUTES************ */
//************************************ */
//Update queries can be done as posts

router.post("/updateUser", function (req, res, next) {
  let { inputs } = req.body;
  let issue = null
  const validatedInputs = validateAndFormatInputs(inputs)
  if (validatedInputs.inputsAreValid) {
    let query = "\
    update user set `userName` =? where userId=?;\
    \
    select * from user order by user.userId;"
    db.executeQueryAsPromise(query, validatedInputs.placeholders)
      .then((queryResults) => {
        res.send(queryResults)
      }).catch((error) => {
        issue = { issue: "There was a problem running your queries", error }
        console.log(issue)
        res.send(issue)
      })
  } else {
    issue = { issue: "There was a problem validating your inputs", validatedInputs }
    console.log(issue)
    res.send(issue)
  }
})

router.post("/updateAlbum", function (req, res, next) {
  let { inputs } = req.body;
  let issue = null
  const validatedInputs = validateAndFormatInputs(inputs)
  if (validatedInputs.inputsAreValid) {
    let query = "\
    update album set `albumTitle`=? where albumId=?;\
    \
    select * from album;"
    db.executeQueryAsPromise(query, validatedInputs.placeholders)
      .then((queryResults) => {
        res.send(queryResults)
      }).catch((error) => {
        issue = { issue: "There was a problem running your queries", error }
        console.log(issue)
        res.send(issue)
      })
  } else {
    issue = { issue: "There was a problem validating your inputs", validatedInputs }
    console.log(issue)
    res.send(issue)
  }
})
//************************************ */
//***********DELETE ROUTES*********** */
//************************************ */

router.post("/deleteUser", function (req, res, next) {
  let { inputs } = req.body;
  let issue = null
  const validatedInputs = validateAndFormatInputs(inputs)
  if (validatedInputs.inputsAreValid) {
    let query = "\
    delete from user where userId = ?;\
    \
    select * from user;"
    db.executeQueryAsPromise(query, validatedInputs.placeholders)
      .then((queryResults) => {
        res.send(queryResults)
      }).catch((error) => {
        issue = { issue: "There was a problem running your queries", error }
        console.log(issue)
        res.send(issue)
      })
  } else {
    issue = { issue: "There was a problem validating your inputs", validatedInputs }
    console.log(issue)
    res.send(issue)
  }
})

router.post("/deletePlaylist", function (req, res, next) {
  let { inputs } = req.body;
  let issue = null
  const validatedInputs = validateAndFormatInputs(inputs)
  if (validatedInputs.inputsAreValid) {
    let query = "\
    delete from playlist where playlistId = ?;\
    \
    select * from playlist;"
    db.executeQueryAsPromise(query, validatedInputs.placeholders)
      .then((queryResults) => {
        res.send(queryResults)
      }).catch((error) => {
        issue = { issue: "There was a problem running your queries", error }
        console.log(issue)
        res.send(issue)
      })
  } else {
    issue = { issue: "There was a problem validating your inputs", validatedInputs }
    console.log(issue)
    res.send(issue)
  }
})

router.post("/deleteAlbum", function (req, res, next) {
  let { inputs } = req.body;
  let issue = null
  const validatedInputs = validateAndFormatInputs(inputs)
  if (validatedInputs.inputsAreValid) {
    let query = "\
    delete from album where albumId = ?;\
    \
    select * from album;"
    db.executeQueryAsPromise(query, validatedInputs.placeholders)
      .then((queryResults) => {
        res.send(queryResults)
      }).catch((error) => {
        issue = { issue: "There was a problem running your queries", error }
        console.log(issue)
        res.send(issue)
      })
  } else {
    issue = { issue: "There was a problem validating your inputs", validatedInputs }
    console.log(issue)
    res.send(issue)
  }
})

router.post("/deleteRadio_episode", function (req, res, next) {
  let { inputs } = req.body;
  let issue = null
  const validatedInputs = validateAndFormatInputs(inputs)
  if (validatedInputs.inputsAreValid) {
    let query = "\
    delete from radio_episodes where radioEpisodeId = ?;\
    \
    select * from radio_episodes;"
    db.executeQueryAsPromise(query, validatedInputs.placeholders)
      .then((queryResults) => {
        res.send(queryResults)
      }).catch((error) => {
        issue = { issue: "There was a problem running your queries", error }
        console.log(issue)
        res.send(issue)
      })
  } else {
    issue = { issue: "There was a problem validating your inputs", validatedInputs }
    console.log(issue)
    res.send(issue)
  }
})

router.post("/deleteSong", function (req, res, next) {
  let { inputs } = req.body;
  let issue = null
  const validatedInputs = validateAndFormatInputs(inputs)
  if (validatedInputs.inputsAreValid) {
    let query = "\
    delete from song where songId = ?;\
    \
    select * from song;"
    db.executeQueryAsPromise(query, validatedInputs.placeholders)
      .then((queryResults) => {
        res.send(queryResults)
      }).catch((error) => {
        issue = { issue: "There was a problem running your queries", error }
        console.log(issue)
        res.send(issue)
      })
  } else {
    issue = { issue: "There was a problem validating your inputs", validatedInputs }
    console.log(issue)
    res.send(issue)
  }
})
//************************************ */
//***********GENERIC ROUTES*********** */
//************************************ */
//These routes take care of any calls you make that are spelled wrong or have the wrong type
//No need to mess with them unless you are an experienced programmer

router.get('/*', (req, res, next) => {
  res.send(`The route you used:${req.originalUrl} was not found. Was it supposed to be a POST?`)
})
router.post('/*', (req, res, next) => {
  res.send(`The route you used:${req.originalUrl} was not found. Was it supposed to be a GET?`)
})


//************************************ */
//***********SUPPORTING CODES********* */
//************************************ */
//This code is used by the routes.
//No need to mess with it unless you are an experienced programmer

function rowsToHtmlTable(results) {
  const tableStyle = '"border:1px solid black;padding:5px"'
  const cellStyle = '"border:1px solid black;padding:5px"'
  const cellStyleFirstRow = '"font-weight:600"'
  const htmlRows = results.map((row, index) => {
    const columns = Object.keys(row).map((columnName) => {
      return { columnName, columnValue: row[columnName] }
    })
    let htmlColumns = null
    if (index == 0) {
      htmlColumns = columns.map((column) => {
        return `<th style=${cellStyleFirstRow}>${column.columnName}</th>`
      })
    } else {
      htmlColumns = columns.map((column) => {
        return `<td style=${cellStyle}>${column.columnValue}</td>`
      })
    }
    return `<tr>${htmlColumns.join("")}</tr>`
  })
  return `<table style=${tableStyle}>${htmlRows.join("")}</table>`
}

function validateAndFormatInputs(inputs) {
  let results = { inputsAreValid: true, validations: [], placeholders: [] }
  if (typeof (inputs) !== "object") {
    results.inputsAreValid = false
    results.validations.push({ error: true, message: `Expecting an object, got: ${typeof (inputs)}` })
  }
  Object.keys(inputs).forEach((input) => {
    let valueOfInput = inputs[input]
    switch (input) {
      //add a case for any input that you want to validate
      case "id":
        if (valueOfInput != null && !Number.isInteger(valueOfInput)) {
          results.inputsAreValid = false
          results.validations.push({ error: true, message: `In id value expecting null or an integer, got: ${valueOfInput}` })
        }
        break
      case "dateAdded":
        if (valueOfInput === "*fillInCurrentDate*") valueOfInput = mysqlTimestamp()
        if (isNaN(Date.parse(valueOfInput))) {
          results.inputsAreValid = false
          results.validations.push({ error: true, message: `This is not a valid date: ${valueOfInput}` })
        }
        break
      case "email":
        if (!valueOfInput.includes("@")) {
          results.inputsAreValid = false
          results.validations.push({ error: true, message: `There needs to be an @ in your email input, got: ${valueOfInput}` })
        }
        break
    }
    results.placeholders.push(valueOfInput)
  })
  return results
}

mysqlTimestamp = () => {
  var date = new Date(Date.now());
  var yyyy = date.getFullYear();
  var mm = date.getMonth() + 1;
  var dd = date.getDate();
  var hh = date.getHours();
  var min = date.getMinutes();
  var ss = date.getSeconds();
  var mysqlDateTime = yyyy + '-' + mm + '-' + dd + ' ' + hh + ':' + min + ':' + ss;
  return mysqlDateTime;
}
module.exports = router;
