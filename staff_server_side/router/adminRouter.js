const express = require("express");
const formatDateMiddleware = require("../middleware/dateTime");

const {
  addTrainingCenter,
  listTrainingCenters,
  updateTrainingCenter,
} = require("../controller/adminController");

const router = express.Router();

router.route("/addTrainingCenter", addTrainingCenter);
router.route("/listTrainingCenters", listTrainingCenters);
router.route(
  "/updateTrainingCenter",
  formatDateMiddleware,
  updateTrainingCenter
);

module.exports = router;
