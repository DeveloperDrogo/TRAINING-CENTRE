const express = require("express");
const RoleModel = require("../../models/roleModel");
const LoginModel = require("../../models/loginModel");
const formatDateMiddleware = require("../../middleware/dateTime");
const staffInfoRouter = express.Router();

staffInfoRouter.get("/api/listRoles", async (req, res) => {
  try {
    const fetchAllRoles = await RoleModel.find({
      is_deleted: 0,
      role_id: { $ne: "1" },
    });

    if (!fetchAllRoles) {
      return res.status(401).json({ msg: "roles not found" });
    }

    return res.status(200).json({ fetchAllRoles });
  } catch (error) {
    return res.status(501).json({ msg: "Internal Server Error" });
  }
});

staffInfoRouter.post(
  "/api/insertStaff",
  formatDateMiddleware,
  async (req, res) => {
    try {
      const {
        user_id,
        name,
        contact,
        roleId,
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

      const userInfo = await LoginModel.findById(user_id);
      if (!userInfo) {
        return res.status(404).json({ msg: "User not found" });
      }
      console.log(`user info is ${userInfo}`);

      const getRoleInfo = await RoleModel.findById(roleId);
      if (!getRoleInfo) {
        return res.status(404).json({ msg: "Role not found" });
      }

      // Determine if the role is "TRAINING MANAGER"
      const isTrainingManager = getRoleInfo.role === "TRAINING MANAGER";

      let newStaffId = "0001";

      if (!isTrainingManager) {
        const findAllStaffs = await LoginModel.find({training_center_id:userInfo.training_center_id}).sort({ staff_id: -1 });

        if (findAllStaffs.length > 0) {
          const lastStaff = findAllStaffs[0];
          const lastStaffId = parseInt(lastStaff.staff_id, 10);
          if (!isNaN(lastStaffId)) {
            newStaffId = (lastStaffId + 1).toString().padStart(4, "0");
          }
        }
      }

      let addStaff = new LoginModel({
        name: name,
        email: email,
        role_id: roleId,
        mblnumber: contact,
        training_center_id: userInfo.training_center_id,
        address: address,
        created_by: user_id,
        dob: dob,
        gender: gender,
        bloodGroup: bloodGroup,
        qualification: qualification,
        work_experience: work_experience,
        government_id: government_id,
        created_date_time: req.formattedDate,
        is_deleted: 0,
      });

      // Set staff_id only if the role is not "TRAINING MANAGER"
      if (!isTrainingManager) {
        addStaff.staff_id = newStaffId;
      }

      await addStaff.save();

      return res
        .status(200)
        .json({ msg: "Staff added successfully", staff: addStaff });
    } catch (error) {
      console.error(error);
      return res.status(501).json({ msg: "Internal Server Error" });
    }
  }
);

staffInfoRouter.post("/api/listAllStaffs", async (req, res) => {
  try {
    const { user_id } = req.body;

    console.log(user_id);

    const fetchTrainingCenterId = await LoginModel.findById(user_id);

   

    const listAllStaffs = await LoginModel.find({
      training_center_id: fetchTrainingCenterId.training_center_id,
      is_deleted: 0,
      _id:{$ne:user_id}
    });

    

    const staffsWithRoles = await Promise.all(
      listAllStaffs.map(async (staff) => {
        const role = await RoleModel.findById(staff.role_id); // Assuming staff.role_id points to the role in RoleModel
        return {
          ...staff.toObject(), // Convert Mongoose document to plain JavaScript object
          role: role ? role.role : "Unknown Role", // Assuming role.role contains the role name
        };
      })
    );

    if(!staffsWithRoles){
      return res.status(401).json({msg:"No staffs Found"});
    }


    return res.status(200).json({staffsWithRoles});

  } catch (error) {
    return res.status(501).json({ msg: "Internal Server Error" });
  }
});

module.exports = staffInfoRouter;
