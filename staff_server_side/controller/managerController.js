const LoginModel = require("../models/loginModel");
const subjectModel = require("../models/subjectsModel");
const batchTimeModel = require("../models/batchTimeModel");
const RoleModel = require("../models/roleModel");
const ClassroomModel = require("../models/classRoomModel");
const clssSheduleModel = require("../models/classShedulesModel");

async function listRoles(req, res) {
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
}

async function insertStaff(req, res) {
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
      const findAllStaffs = await LoginModel.find({
        training_center_id: userInfo.training_center_id,
      }).sort({ staff_id: -1 });

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

async function listAllStaffs(req, res) {
  try {
    const { user_id } = req.body;

    console.log(user_id);

    const fetchTrainingCenterId = await LoginModel.findById(user_id);

    const listAllStaffs = await LoginModel.find({
      training_center_id: fetchTrainingCenterId.training_center_id,
      is_deleted: 0,
      _id: { $ne: user_id },
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

    if (!staffsWithRoles) {
      return res.status(401).json({ msg: "No staffs Found" });
    }

    //console.log(staffsWithRoles);

    return res.status(200).json({ staffsWithRoles });
  } catch (error) {
    return res.status(501).json({ msg: "Internal Server Error" });
  }
}

async function updateStaff(req, res) {
  try {
    const {
      user_id,
      my_id,
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

    const getRoleInfo = await RoleModel.findById(roleId);
    if (!getRoleInfo) {
      return res.status(404).json({ msg: "Role not found" });
    }

    const updated_data = {
      name: name,
      email: email,
      role_id: roleId,
      mblnumber: contact,
      address: address,
      dob: dob,
      gender: gender,
      bloodGroup: bloodGroup,
      qualification: qualification,
      work_experience: work_experience,
      government_id: government_id,
      updated_date_time: req.formattedDate,
      is_deleted: 0,
      updated_by: my_id,
    };

    // Determine if the role is "TRAINING MANAGER"
    const updateStaffInfo = await LoginModel.findByIdAndUpdate(
      user_id,
      updated_data,
      { new: true }
    );

    if (!updateStaffInfo) {
      return res.status(404).json({ msg: "User not found" });
    }

    console.log("Updated User:", updateStaffInfo);

    return res
      .status(200)
      .json({ msg: "Staff updated successfully", staff: updateStaffInfo });
  } catch (error) {
    console.error(error);
    return res.status(501).json({ msg: "Internal Server Error" });
  }
}

async function listStaffs(req, res) {
  try {
    const { id } = req.body;

    const institutionId = await LoginModel.findById(id);

    const listAllStaffs = await LoginModel.find({
      is_deleted: 0,
      training_center_id: institutionId.training_center_id,
      _id: { $ne: id },
    });

    if (!listAllStaffs) {
      return res.status(401).json("staffs are not found");
    }

    return res.status(200).json(listAllStaffs);
  } catch (error) {
    console.log(error);
    return res.json(500).json("internal server error");
  }
}

async function listSubjects(req, res) {
  try {
    const { id } = req.body;

    const findTrainingCenterId = await LoginModel.findById(id);

    const listAllSubjects = await subjectModel.find({
      is_deleted: 0,
      training_center_id: findTrainingCenterId.training_center_id,
    });

    if (!listAllSubjects) {
      return res.status(401).json("subjects are not found");
    }

    return res.status(200).json(listAllSubjects);
  } catch (error) {
    console.log(error);
    return res.json(500).json("internal server error");
  }
}

async function listBatchTime(req, res) {
  try {
    const { id } = req.body;

    const findTrainingCenterId = await LoginModel.findById(id);

    const listAllBAtchTime = await batchTimeModel.find({
      is_deleted: 0,
      training_center_id: findTrainingCenterId.training_center_id,
    });

    if (!listAllBAtchTime) {
      return res.status(401).json("Batches not found");
    }

    return res.status(200).json(listAllBAtchTime);
  } catch (error) {
    console.log(error);
    return res.json(500).json("internal server error");
  }
}

async function classRoomList(req, res) {
  try {
    const { id } = req.body;

    const findTrainingCenterId = await LoginModel.findById(id);

    const fetchAllClassRooms = await ClassroomModel.find({
      is_deleted: 0,
      training_center_id: findTrainingCenterId.training_center_id,
    });

    if (!fetchAllClassRooms) {
      return res.status(401).json("no classrooms found");
    }

    return res.status(200).json(fetchAllClassRooms);
  } catch (error) {
    console.log(error);
    return res.status(500).json("Internal Server Error");
  }
}

async function insertClassShedule(req,res) {
  try {
    const { user_id, staff_id, subject_id, batch_id, class_id } = req.body;

    const findTrainingCenterId = await LoginModel.findById(user_id);

    let insertClassShedule = new clssSheduleModel({
        staff_id:staff_id,
        subject_id:subject_id,
        batch_id:batch_id,
        class_room_id:class_id,
        created_by:user_id,
        is_deleted:0,
        training_center_id:findTrainingCenterId.training_center_id,
        created_date_time:req.formattedDate
    });

    insertClassShedule = insertClassShedule.save();

    return res.status(200).json(insertClassShedule);

  } catch (error) {
    return res.status(500).json("Internal Server Error");
  }
}

module.exports = {
  listRoles,
  insertStaff,
  listAllStaffs,
  updateStaff,
  listStaffs,
  listSubjects,
  listBatchTime,
  classRoomList,
  insertClassShedule,
};
