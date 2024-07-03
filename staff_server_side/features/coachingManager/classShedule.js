const express = require("express");
const LoginModel = require("../../models/loginModel");
const subjectModel = require("../../models/subjectsModel");
const batchTimeModel = require("../../models/batchTimeModel");

const classSheduleRouter = express.Router();

classSheduleRouter.post("/api/listStaffs", async (req, res) => {
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
});

classSheduleRouter.get("/api/listSubjects", async (req, res) => {
  try {
    const listAllSubjects = await subjectModel.find({
      is_deleted: 0,
    });

    if (!listAllSubjects) {
      return res.status(401).json("subjects are not found");
    }

    return res.status(200).json(listAllSubjects);
  } catch (error) {
    console.log(error);
    return res.json(500).json("internal server error");
  }
});

classSheduleRouter.get("/api/listBatchTime", async (req, res) => {
  try {
    const listAllBAtchTime = await batchTimeModel.find({
      is_deleted: 0,
    });

    if (!listAllBAtchTime) {
      return res.status(401).json("Batches not found");
    }

    console.log(listAllBAtchTime);

    return res.status(200).json(listAllBAtchTime);
  } catch (error) {
    console.log(error);
    return res.json(500).json("internal server error");
  }
});

module.exports = classSheduleRouter;
