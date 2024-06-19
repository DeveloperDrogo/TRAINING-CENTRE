const mongoose = require('mongoose');

const RoleSchema = mongoose.Schema({

    role:{
        type:String
    },
    
    role_id:{
        type:String
    },

    is_deleted:{
        type:Number
    }

});

const RoleModel = mongoose.model('tbl_role',RoleSchema,'tbl_role');
module.exports=RoleModel;