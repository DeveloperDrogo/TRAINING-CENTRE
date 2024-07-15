const mongoose = require("mongoose");

const clssSheduleSchema = new mongoose.Schema(
  {
   
    training_center_id: {
      type: mongoose.Schema.Types.ObjectId,
      required: true,
      ref: "trainingCenterModel", // Assuming there is a TrainingCenter model
    },

    staff_id:{
        type:mongoose.Schema.Types.ObjectId,
        required:true,
        ref:"LoginModel"
    },

    subject_id:{
        type:mongoose.Schema.Types.ObjectId,
        required: true,
        ref:"subjectModel"
    },

    batch_id:{
        type:mongoose.Schema.Types.ObjectId,
        required:true,
        ref:"batchTimeModel"
    },

    class_room_id:{
        type:mongoose.Schema.Types.ObjectId,
        required:true,
        ref:"ClassroomModel"
    },

    day:{
      type:String,
      required:true
    },

    created_by:{
        type:mongoose.Schema.Types.ObjectId,
        required:true,
    },

    created_date_time:{
        type:String
    },
    
    updated_date_time:{
        type:String
    },

    is_deleted:{
        type:Number
    }
  },
  {
    timestamps: true, // Add createdAt and updatedAt fields automatically
    collection: "tbl_class_shedules",
  }
);

const clssSheduleModel = mongoose.model("ClassShedule", clssSheduleSchema);

module.exports = clssSheduleModel;
