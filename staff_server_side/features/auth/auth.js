const express = require("express");
const jwt = require("jsonwebtoken");

const LoginModel = require("../../models/loginModel");
const RoleModel = require("../../models/roleModel");

const authRouter = express.Router();

authRouter.post("/api/checkNumberIsExist", async (req, res) => {
  console.log(req.body);

  try {
    const { mobile } = req.body;

    console.log(mobile);

    const checkNumberIsExist = await LoginModel.findOne({
      mblnumber: mobile,
      is_deleted: 0,
    });


    if (!checkNumberIsExist) {
      return res.status(401).json({ msg: "Mobile Number Not Registered" });
    }


    const getRole = await RoleModel.findById(checkNumberIsExist.role_id);


    const jwtSecretKey = "manomay@123";

    const jwtToken = jwt.sign({ id: checkNumberIsExist._id }, jwtSecretKey);

    console.log(jwtToken);

    return res
      .status(200)
      .json({
        msg: "Success",
        jwtToken,
        ...checkNumberIsExist._doc,
        ...getRole._doc,
        user_id: checkNumberIsExist._id,
      });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ msg: "Internal Server Error" });
  }
});

module.exports = authRouter;
