const mongoose = require("mongoose");

const classroomSchema = new mongoose.Schema(
  {
    class_room: {
      type: String,
      required: true,
      trim: true,
    },
    is_deleted: {
      type: Number,
    },
    training_center_id: {
      type: mongoose.Schema.Types.ObjectId,
      required: true,
      ref: "trainingCenterModel", // Assuming there is a TrainingCenter model
    },
    created_by: {
      type: mongoose.Schema.Types.ObjectId,
    },

    created_date_time: {
      type: String,
    },
    
    updated_by: {
      type: mongoose.Schema.Types.ObjectId,
    },

    updated_date_time: {
      type: String,
    },
  },
  {
    timestamps: true, // Add createdAt and updatedAt fields automatically
    collection: "tbl_class_rooms",
  }
);

const ClassroomModel = mongoose.model("Classroom", classroomSchema);

module.exports = ClassroomModel;
