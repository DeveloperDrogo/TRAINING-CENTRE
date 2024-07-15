const express = require("express");
const formatDateMiddleware = require("../middleware/dateTime");
const timeFormatterMiddleware = require("../middleware/timFormat");

const {
  listRoles,
  insertStaff,
  listAllStaffs,
  updateStaff,
  listStaffs,
  listSubjects,
  listBatchTime,
  classRoomList,
  insertClassShedule,
  insertSubject,
  insertBatch,
  insertClassRoom,
  deleteBatch,
  deleteClassRoom,
  deleteSubject,
  listAllTimeTables
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
router
  .route("/insertClassShedule")
  .post(formatDateMiddleware, insertClassShedule);
router.route("/insertSubject").post(formatDateMiddleware, insertSubject);
router
  .route("/insertBatch")
  .post(formatDateMiddleware, timeFormatterMiddleware, insertBatch);
router.route("/insertClassRoom").post(formatDateMiddleware, insertClassRoom);
router.route("/deleteBatch").post(formatDateMiddleware, deleteBatch);
router.route("/deleteClassRoom").post(formatDateMiddleware, deleteClassRoom);
router.route("/deleteSubject").post(formatDateMiddleware,deleteSubject);
router.route("/listAllTimeTables").post(listAllTimeTables);

module.exports = router;
