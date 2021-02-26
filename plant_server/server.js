var express = require('express');
var http = require('http');
var mysql = require('mysql');
var multer = require('multer');
const path= require('path');
var fs = require('fs');

var app = express();

// var jwt = require('jsonwebtoken');
app.use(express.static('images'));
app.use(express.json());
app.use(express.urlencoded({extended: true}));

var db = mysql.createConnection({
  host: "220.120.148.231",
  port: 3307,
  user: "chms0330",
  password: "chch9603",
  database: "plant_DB"
});

var imgStorage = multer.diskStorage({
   destination: function (req, file, cb) {
     cb(null, 'images')
   },
   filename: function (req, file, cb) {
     cb(null, file.originalname + ".jpg")
   }
 })

 var upload = multer({ storage: imgStorage })

app.get('/allPlant', (req, res, next) => {

  var getPlants = "select * from PLANT_INFO;"

  db.query(getPlants, function(err,result){
        if(err) console.log(err);
        else{
            console.log(result);
            res.send(result);
            }
  });
});

app.get('/plantName', (req, res, next) => {

  var getPlant = "select * from PLANT_INFO Where plantName = \"" + req.query.plantName + "\";";

  db.query(getPlant, function(err,result){
        if(err) console.log(err);
        else{
            console.log(result);
            res.send(result);
            }
  });
});

app.put('/updatePlant', (req, res, next) => {

  var updatePlant = "update PLANT_INFO set lastDateWater = \"" + req.query.lastDateWater + "\" Where plantName = \"" + req.query.plantName + "\";";

  db.query(updatePlant, function(err,result){
        if(err) console.log(err);
        else{
            console.log(result);
            res.send(result);
            }
  });
});

app.delete('/deletePlant', (req, res, next) => {

  var deletePlant = "delete from PLANT_INFO Where plantName = \"" + req.query.plantName + "\";";

  fs.unlink('images/' + req.query.plantName + '.jpg', (err) =>{})

  db.query(deletePlant, function(err,result){
        if(err) console.log(err);
        else{
            console.log(result);
            res.send(result);
            }
  });
});

app.post('/postPlant', upload.single('file') ,(req, res, next) => {

  let plantKind = req.body.plantKind;
  let plantName = req.body.plantName;
  let lastDateWater = req.body.lastDateWater;
  let waterCycle = req.body.waterCycle;
  let imageFilePath = req.body.imageFilePath;

  plantKind = '\"' + plantKind + '\"';
  plantName = '\"' + plantName + '\"';
  lastDateWater = '\"' + lastDateWater + '\"';
  imageFilePath = '\"' + imageFilePath + '\"';

  console.log("plantKind: " + plantKind + " plantName: " + plantName + " lastDateWater: " + lastDateWater + " waterCycle: " + waterCycle + " imageFilePath: " + imageFilePath);

  var po = "INSERT INTO PLANT_INFO (plantKind, plantName, lastDateWater, waterCycle, imageFilePath) VALUES (" + plantKind + "," + plantName + "," + lastDateWater + "," + waterCycle + "," + imageFilePath +")";

  db.query(po, function(err,result){
        if(err){
          if(err.code === 'ER_DUP_ENTRY' || err.errno === 1062) {
            res.send({duplicate: 'Yes'});
            return (res.status(500).json());
          }
          console.log(err);
          return (res.status(500).json());
        } else{
          console.log(result);
          res.status(201).send({success: 'Yes'});
          }
  });
});

app.post('/changePlantPicture', upload.single('file') ,(req, res, next) => {
});


http.createServer(app).listen(3000, () => {
  console.log('running on port 3000');
})
