const express = require("express");
const trainingCenterModel = require("../../models/trainingCenterModel");
const RoleModel = require("../../models/roleModel");
const LoginModel = require("../../models/loginModel");

const trainingRouter = express.Router();

trainingRouter.post("/api/addTrainingCenter", async (req, res) => {
  try {
    const {
      training_center_name,
      training_center_address,
      training_center_subscription,
      manager_name,
      manager_email,
      manager_contact,
      manager_address,
      user_id,
    } = req.body;

    console.log(req.body);

    let addTrainingcenter = new trainingCenterModel({
      training_center_name: training_center_name,
      training_center_address: training_center_address,
      subscription_amount: training_center_subscription,
      created_by: user_id,
      status:"PENDING",
      is_subscribed: 0,
      is_deleted: 0,
    });

    addTrainingcenter = await addTrainingcenter.save();

    const getMangerRole = await RoleModel.find({
        role_id:'2'
    });

    console.log(getMangerRole);

    let addManagerInfo = new LoginModel({
        name:manager_name,
        email:manager_email,
        role_id:getMangerRole._id,
        mblnumber:manager_contact,
        training_center_id:addTrainingcenter._id,
        address:manager_address,
        created_by:user_id,
        is_deleted:0
    });

    addManagerInfo = addManagerInfo.save();
    res.status(200).json({msg:'success'});

  } catch (error) {
    return res.status(500).json({msg:"Internal Server Error"});
  }
});

trainingRouter.post("/api/listTrainingCenters", async (req, res) => {
    try {
        const { user_id } = req.body;
        console.log(req.body);

        // Fetch manager roles
        const getMangerRole = await RoleModel.find({
            role_id: '2',
            is_deleted: 0
        });

        console.log(getMangerRole);

        // Fetch managers with the manager role
        const fetchMangerInfo = await LoginModel.find({
            role_id: getMangerRole._id,
            is_deleted: 0
        });

        console.log(fetchMangerInfo);

        // Fetch training center information for each manager
        const fetchTrainingcenterData = await Promise.all(fetchMangerInfo.map(async (manager) => {
            const trainingCenter = await trainingCenterModel.findOne({
                is_deleted: 0,
                _id: manager.training_center_id
            });

            if (trainingCenter) {
                return {
                    ...manager._doc, // Spread manager document
                    training_center: trainingCenter // Add training center information
                };
            }
            return null;
        }));

        // Filter out managers without valid training center data
        const validManagers = fetchTrainingcenterData.filter(manager => manager !== null);

        console.log(validManagers);

        // Send the combined data as the response
        res.status(200).send(validManagers);

    } catch (error) {
        console.log(error);
        res.status(500).send({ message: 'Internal server error' });
    }
});



module.exports = trainingRouter;
