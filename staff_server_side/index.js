const express = require("express");
const cors = require("cors");
const path = require("path");
const authRouter = require("./features/auth/auth");
const homeRouter = require("./features/home/home");
const trainingRouter = require("./features/trainingCenter/trainingCenter");
const staffInfoRouter = require("./features/coachingManager/staffInfo");
const dotenv = require("dotenv");
const classSheduleRouter = require('./features/coachingManager/classShedule');
const connectDB = require('./config/DB'); // Correct casing

dotenv.config();

const app = express();
app.use(cors());
app.use(express.json()); // Built-in body-parser since Express 4.16.0
app.use(authRouter);
app.use(homeRouter);
app.use(trainingRouter);
app.use(staffInfoRouter);
app.use(classSheduleRouter);

app.use(
  "/assets/dashboardMenu",
  express.static(path.join(__dirname, "/assets/dashboardMenu"))
);
app.use(
  "/uploads/user_images",
  express.static(path.join(__dirname, "uploads/user_images"))
);

PORT = process.env.PORT;
IP = process.env.IP;

connectDB().then(()=>{
  app.listen(PORT, IP, () => {
    console.log(`Server connected for ${IP}:${PORT}`);
  });
}).catch((err)=>{
  console.log("MONGO db connection !!!",err);
});




