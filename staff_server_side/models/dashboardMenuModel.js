const mongoose = require("mongoose");

const dashboardSchema = mongoose.Schema({
  title: {
    type: String,
  },
  route: {
    type: String,
  },
  icon_img_path: {
    type: String,
  },
  priority: {
    type: Number,
  },
  is_deleted: {
    type: Number,
  },
});

const dashboardModel = mongoose.model(
  "tbl_staff_dashboard_menu",
  dashboardSchema,
  "tbl_staff_dashboard_menu"
);
module.exports = dashboardModel;
