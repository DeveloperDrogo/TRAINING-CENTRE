const express = require("express");
const upload = require("../middleware/multerConfig");

const {
  checkNumberIsExist,
  userInfoUpdateWithDoc,
  userInfoUpdateWithoutDoc,
  dashboardMenu,
} = require("../controller/userController");


const router = express.Router();


router.route("/checkNumberIsExist").post(checkNumberIsExist);

router
  .route("/userInfoUpdateWithDoc")
  .post(upload.single("file"), userInfoUpdateWithDoc);

router.route("/userInfoUpdateWithoutDoc").post(userInfoUpdateWithoutDoc);
router.route("/dashboardMenu").post(dashboardMenu);


module.exports = router;
