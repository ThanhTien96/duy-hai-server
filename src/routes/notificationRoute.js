const express = require('express');
const { getAllNotification, changeStatusNotification, deleteNotification } = require('../controllers/notification');


const route = express.Router();


route.get("/notification", getAllNotification);
route.put("/notification", changeStatusNotification);
route.delete("/notification", deleteNotification);


module.exports = route;