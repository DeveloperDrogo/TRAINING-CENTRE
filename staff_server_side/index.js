const express = require("express");
const cors = require("cors");
const path = require("path");
const dotenv = require("dotenv");
const connectDB = require("./config/DB"); // Correct casing


const userRoute = require("./router/usersRouter");
const adminRouter = require("./router/adminRouter");
const managerRoute = require("./router/managerRouter");


dotenv.config();

const app = express();

app.use(cors());
app.use(express.json()); // Built-in body-parser since Express 4.16.0

app.use("/api", userRoute);
app.use("/api", managerRoute);
app.use("/api", adminRouter);


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

connectDB()
  .then(() => {
    app.listen(PORT, IP, () => {
      console.log(`Server connected for ${IP}:${PORT}`);
    });
  })
  .catch((err) => {
    console.log("MONGO db connection !!!", err);
  });
