const mongoose = require("mongoose");

const LoginSchema = mongoose.Schema({
  name: {
    type: String,
  },
  email: {
    type: String,
  },
  role_id: {
    type: String,
  },
  mblnumber: {
    type: String,
  },
  address:{
    type:String
  },
  is_deleted: {
    type: Number,
  },
});



const LoginModel = mongoose.model(
  "tbl_user_info",
  LoginSchema,
  "tbl_user_info"
);
module.exports = LoginModel;
