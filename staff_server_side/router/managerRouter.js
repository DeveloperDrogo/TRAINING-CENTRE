const express = require("express");
const formatDateMiddleware = require("../middleware/dateTime");

const {
  listRoles,
  insertStaff,
  listAllStaffs,
  updateStaff,
  listStaffs,
  listSubjects,
  listBatchTime,
  classRoomList,
  insertClassShedule
} = require("../controller/managerController");

const router = express.Router();

router.route("/listStaffs").post(listStaffs);
router.route("/insertStaff").post(formatDateMiddleware, insertStaff);
router.route("/listAllStaffs").post(listAllStaffs);
router.route("/updateStaff").post(formatDateMiddleware, updateStaff);
router.route("/listRoles").post(listRoles);
router.route("/listSubjects").post(listSubjects);
router.route("/listBatchTime").post(listBatchTime);
router.route("/classRoomList").post(classRoomList);
router.route("/insertClassShedule").post(formatDateMiddleware,insertClassShedule);

module.exports = router;
