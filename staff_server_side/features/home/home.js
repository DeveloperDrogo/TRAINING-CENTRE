const express = require("express");
const dashboardModel = require("../../models/dashboardMenuModel");

const homeRouter = express.Router();

homeRouter.post("/api/dashboardMenu", async (req, res) => {
  try {
    const { role } = req.body;
    const listAllMenu = await dashboardModel.find({is_deleted:0});
    console.log(listAllMenu);
    res.status(200).json(listAllMenu);
  } catch (error) {
    return res.status(500).json({ msg: "Internal Server Error" });
  }
});

module.exports = homeRouter;
