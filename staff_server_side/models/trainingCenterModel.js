const mongoose = require("mongoose");

const formatDate = (date) => {
    const pad = (n) => (n < 10 ? "0" + n : n);

    const year = date.getFullYear();
    const month = pad(date.getMonth() + 1);
    const day = pad(date.getDate());
    const hours = pad(date.getHours());
    const minutes = pad(date.getMinutes());
    const seconds = pad(date.getSeconds());

    return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
};

const trainingCenterSchema = mongoose.Schema({
  training_center_name: {
    type: String,
  },

  training_center_address: {
    type: String,
  },

  subscription_amount: {
    type: String,
  },

  created_by:{
    type:mongoose.Schema.Types.ObjectId
  },

  created_date_time:{
    type:String,
    default: () => formatDate(new Date()),
  },
  
  status:{
    type:String
  },

  is_subscribed: {
    type: Number,
  },

  is_deleted: {
    type: Number,
  },


  
});

const trainingCenterModel = mongoose.model(
  "tbl_training_center",
  trainingCenterSchema,
  "tbl_training_center"
);

module.exports = trainingCenterModel;
