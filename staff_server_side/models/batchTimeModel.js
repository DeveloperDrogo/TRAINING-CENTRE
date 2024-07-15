const mongoose = require("mongoose");

const batchTimeSchema = mongoose.Schema(
  {
    batch_time: {
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
    collection: "tbl_batch_times",
  }
);

const batchTimeModel = mongoose.model("batchTime", batchTimeSchema);

module.exports = batchTimeModel;
