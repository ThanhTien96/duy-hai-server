const express = require('express');
const { getAllYT, getDetailYT, createYT, updateYT, deleteYT } = require('../controllers/youtubeController');
const route = express.Router();


/**
 * @openapi
 * /api/youtube
 *  get:
 *      tag:
 *          - ytview
 *          description: lien ket youtube
 *          responses:
 *              200:
 *                  description: successfully!
 * 
 */

route.get('/layDanhSachYT', getAllYT);
route.get('/chiTietYT', getDetailYT);
route.post('/themYT', createYT);
route.put('/capNhatYT', updateYT);
route.delete('/xoaYT', deleteYT);

module.exports = route;