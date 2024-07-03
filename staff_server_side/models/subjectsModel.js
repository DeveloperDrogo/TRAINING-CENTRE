const mongoose = require('mongoose');

const subjectSchema = mongoose.Schema({

    subject_name:{
        type:String
    },

    is_deleted:{
        type:Number
    }

});

const subjectModel = mongoose.model('tbl_subjects',subjectSchema,'tbl_subjects');

module.exports = subjectModel;