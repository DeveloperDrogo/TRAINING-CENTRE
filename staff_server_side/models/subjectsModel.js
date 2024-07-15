const mongoose = require("mongoose");

const subjectSchema = mongoose.Schema(
  {
    subject_name: {
      type: String,
    },

    is_deleted: {
      type: Number,
    },

    training_center_id: {
      type: mongoose.Schema.Types.ObjectId,
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
    collection: "tbl_subjects",
  }
);

const subjectModel = mongoose.model("subjects", subjectSchema);

module.exports = subjectModel;
