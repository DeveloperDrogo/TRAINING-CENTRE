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

const LoginSchema = mongoose.Schema({
  name: {
    type: String,
  },

  dob:{
    type:String
  },

  email: {
    type: String,
  },
  
  role_id: {
    type: mongoose.Schema.Types.ObjectId,
  },
  
  mblnumber: {
    type: String,
  },

  training_center_id:{
    type:mongoose.Schema.Types.ObjectId
  },

  gender:{
    type:String
  },

  bloodGroup:{
    type:String
  },

  qualification:{
    type:String
  },

  work_experience:{
    type:String
  },

  government_id:{
    type:String
  },

  image_path:{
    type:String
  },

  address:{
    type:String
  },
  is_deleted: {
    type: Number,
  },

  staff_id:{
    type:String
  },

  created_date_time:{
    type:String,
    default: () => formatDate(new Date()),
  },

  updated_date_time:{
    type:String
  },

  updated_by:{
    type:mongoose.Schema.Types.ObjectId
  },

  created_by:{
    type:mongoose.Schema.Types.ObjectId
  }
});



const LoginModel = mongoose.model(
  "tbl_user_info",
  LoginSchema,
  "tbl_user_info"
);
module.exports = LoginModel;
