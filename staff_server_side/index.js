const express = require("express");
const mongoose = require("mongoose");
const cors = require('cors');
const path = require('path');
const authRouter = require('./features/auth/auth');
const homeRouter = require('./features/home/home');
const trainingRouter = require('./features/trainingCenter/trainingCenter');


const app = express();
app.use(cors());
app.use(express.json()); // Built-in body-parser since Express 4.16.0
app.use(authRouter);
app.use(homeRouter);
app.use(trainingRouter);


app.use('/assets/dashboardMenu', express.static(path.join(__dirname, '/assets/dashboardMenu')));

const DB =
  "mongodb+srv://ankith:EHvMIfU0rIrVZ6uj@cluster0.jy0s1qs.mongodb.net/db_manomay?retryWrites=true&w=majority";

PORT = 3000;
IP = "192.168.1.6";

app.listen(PORT, IP, () => {
  console.log(`Server connected for ${IP}:${PORT}`);
});

mongoose
  .connect(DB)
  .then(() => {
    console.log("Database connected");
  })
  .catch((e) => {
    console.log(e);
  });
