const dashboardModel = require("../models/dashboardMenuModel");
const LoginModel = require("../models/loginModel");
const RoleModel = require("../models/roleModel");
const jwt = require("jsonwebtoken");
const path = require("path");
const fs = require("fs");
const moment = require("moment");
const trainingCenterModel = require("../models/trainingCenterModel");

async function checkNumberIsExist(req, res) {
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

    const getTrainingCenter = await trainingCenterModel.findById(
      checkNumberIsExist.training_center_id
    );

    const jwtSecretKey = "manomay@123";

    const jwtToken = jwt.sign({ id: checkNumberIsExist._id }, jwtSecretKey);

    console.log(getRole.role);

    if (getRole.role == "ADMIN") {
      return res.status(200).json({
        msg: "Success",
        jwtToken,
        ...checkNumberIsExist._doc,
        ...getRole._doc,
        user_id: checkNumberIsExist._id,
      });
    } else {
      if (
        getTrainingCenter.is_subscribed == 1 &&
        getTrainingCenter.is_deleted != 1
      ) {
        return res.status(200).json({
          msg: "Success",
          jwtToken,
          ...checkNumberIsExist._doc,
          ...getRole._doc,
          ...getTrainingCenter._doc,
          user_id: checkNumberIsExist._id,
        });
      } else {
        return res.status(401).json({
          msg: "Not subscribed",
        });
      }
    }
  } catch (error) {
    console.log(error);
    return res.status(500).json({ msg: "Internal Server Error" });
  }
}

async function userInfoUpdateWithDoc(req, res) {
  try {
    const {
      user_id, // Assume user_id is passed in the request body
      name,
      dob,
      email,
      gender,
      bloodGroup,
      address,
      qualification,
      work_experience,
      government_id,
    } = req.body;

    console.log(req.body);
    // Find the user by ID
    let user = await LoginModel.findById(user_id);

    if (!user) {
      return res.status(404).json({ msg: "User not found" });
    }

    // Update user fields
    user.name = name || user.name;
    user.email = email || user.email;
    user.address = address || user.address;
    user.dob = moment(dob).format("YYYY-MM-DD") || user.dob;
    user.government_id = government_id || user.government_id;
    user.gender = gender || user.gender;
    user.bloodGroup = bloodGroup || user.bloodGroup;
    user.qualification = qualification || user.qualification;
    user.work_experience = work_experience || user.work_experience;

    if (req.file) {
      const originalImagePath = req.file.path; // Get the path of the uploaded file
      const newFilename = `${user_id}.jpg`;
      const newImagePath = path.join("uploads/user_images", newFilename);

      // Replace the old image with the new one
      fs.rename(originalImagePath, newImagePath, async (err) => {
        if (err) {
          console.log(err);
          return res.status(500).json({ msg: "Internal Server Error" });
        }

        user.image_path = newImagePath;
        await user.save();

        res
          .status(200)
          .json({ msg: "User updated successfully", ...user._doc });
      });
    } else {
      // If no new file is uploaded, simply save the updated user
      await user.save();
      res.status(200).json({ msg: "User updated successfully", ...user._doc });
    }
  } catch (error) {
    console.log(error);
    return res.status(500).json({ msg: "Internal Server Error" });
  }
}

async function userInfoUpdateWithoutDoc(req, res) {
  try {
    const {
      user_id, // Assume user_id is passed in the request body
      name,
      dob,
      email,
      gender,
      bloodGroup,
      address,
      qualification,
      work_experience,
      government_id,
    } = req.body;

    console.log(req.body);
    // Find the user by ID
    let user = await LoginModel.findById(user_id);

    if (!user) {
      return res.status(404).json({ msg: "User not found" });
    }

    // Update user fields if they are provided
    if (name) user.name = name;
    if (dob) user.dob = moment(dob).format("YYYY-MM-DD"); // Format dob to YYYY-MM-DD using moment
    if (email) user.email = email;
    if (address) user.address = address;
    if (government_id) user.government_id = government_id;
    if (gender) user.gender = gender;
    if (bloodGroup) user.bloodGroup = bloodGroup;
    if (qualification) user.qualification = qualification;
    if (work_experience) user.work_experience = work_experience;

    // Save the updated user object
    await user.save();

    console.log(user);

    res.status(200).json({ msg: "User updated successfully", ...user._doc });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ msg: "Internal Server Error" });
  }
}

async function dashboardMenu(req, res) {
  try {
    const { user_id } = req.body;

    // Fetch user information
    const getUserInfo = await LoginModel.findById(user_id);

    // Fetch user role
    const getRole = await RoleModel.findById(getUserInfo.role_id);

    // Fetch all menu items
    const listAllMenu = await dashboardModel.find({ is_deleted: 0 });

    // Filter menu items based on role
    let filteredMenu = listAllMenu;

    if (getRole.role === "ADMIN") {
      filteredMenu = listAllMenu.filter(
        (item) =>
          item.title === "Add Training Center" ||
          item.title === "Training Center Info" ||
          item.title === "Profile" ||
          item.title === "Notification"
      );
    } else if (getRole.role === "TRAINING MANAGER") {
      filteredMenu = listAllMenu.filter(
        (item) =>
          item.title === "Profile" ||
          item.title === "Notification" ||
          item.title === "Staffs Info" ||
          item.title === "Training Shedule" ||
          item.title === 'Time Table'
      );
    }

    // Sort filtered menu by priority
    filteredMenu.sort((a, b) => a.priority - b.priority);

    // Respond with the filtered menu
    res.status(200).json(filteredMenu);
  } catch (error) {
    return res.status(500).json({ msg: "Internal Server Error" });
  }
}

module.exports = {
  checkNumberIsExist,
  userInfoUpdateWithDoc,
  userInfoUpdateWithoutDoc,
  dashboardMenu,
};
