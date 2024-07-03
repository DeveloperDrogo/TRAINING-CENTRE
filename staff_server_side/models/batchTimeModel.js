const mongoose = require('mongoose');

const batchTimeSchema = mongoose.Schema({
    batch_time:{
        type:String
    },
    is_deleted:{
        type:Number
    }
});

const batchTimeModel = mongoose.model("tbl_batch_time",batchTimeSchema,"tbl_batch_time");

module.exports = batchTimeModel;