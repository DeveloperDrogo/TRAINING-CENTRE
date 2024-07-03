const mongoose = require("mongoose");

const connectDB = async () => {
  try {
    
    const DB = process.env.DB;
   await mongoose.connect(DB);

    console.log(`MongoDB Connected`);
  } catch (error) {
    console.log("Mongodb connection error", error);
    process.exit(1);
  }
};

module.exports = connectDB;
