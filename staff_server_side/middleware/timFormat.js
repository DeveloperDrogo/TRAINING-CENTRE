// timeFormatterMiddleware.js

function timeFormatterMiddleware(req, res, next) {
    try {
      const { batch_time } = req.body;
  
      if (!batch_time) {
        return res.status(400).json("batch_time is required");
      }
  
      // Extract the time from TimeOfDay(11:30) format
      const timeMatch = batch_time.match(/TimeOfDay\((\d{1,2}:\d{2})\)/);
      if (!timeMatch) {
        return res.status(400).json("Invalid time format");
      }
  
      // Convert the time to 12-hour format with AM/PM
      let [hours, minutes] = timeMatch[1].split(':');
      hours = parseInt(hours, 10);
      const period = hours >= 12 ? 'PM' : 'AM';
      hours = hours % 12 || 12; // Convert to 12-hour format
      const formattedTime = `${hours}:${minutes} ${period}`;
  
      // Attach the formatted time to the request object
      req.formattedBatchTime = formattedTime;
  
      next();
    } catch (error) {
      console.error(error);
      return res.status(500).json("Internal Server Error");
    }
  }
  
  module.exports = timeFormatterMiddleware;
  