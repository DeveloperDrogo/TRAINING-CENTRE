// middleware/multerConfig.js

const multer = require('multer');
const path = require('path');

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'uploads/user_images'); // Specify the directory where you want to save the images
  },
  filename: function (req, file, cb) {
    cb(null, file.originalname); // Keep the original name of the file initially
  }
});

const upload = multer({ storage: storage });

module.exports = upload;
