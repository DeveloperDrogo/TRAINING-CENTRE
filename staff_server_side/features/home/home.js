const express = require("express");
const dashboardModel = require("../../models/dashboardMenuModel");
const LoginModel = require("../../models/loginModel");
const RoleModel = require("../../models/roleModel");

const homeRouter = express.Router();

homeRouter.post("/api/dashboardMenu", async (req, res) => {
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
          item.title === "Class Shedule"
      );
    }

    // Sort filtered menu by priority
    filteredMenu.sort((a, b) => a.priority - b.priority);

    // Respond with the filtered menu
    res.status(200).json(filteredMenu);
  } catch (error) {
    return res.status(500).json({ msg: "Internal Server Error" });
  }
});


module.exports = homeRouter;
