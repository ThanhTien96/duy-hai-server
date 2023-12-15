const express = require('express');
const { 
    
    getAllLocationType, 
    getDetailLocationType, 
    createLocationType, 
    updateLocationType, 
    deleteLocationType, 
    getAllCountry, 
    getDetailCountry, 
    createCountry, 
    updateCountry,
    deleteCountry, 
    getAllDistrict, 
    getDetailDistrict, 
    createDistrict, 
    updateDistrict, 
    deleteDistrict, 
    getAllCommune, 
    getDetailCommune, 
    createCommune, 
    updateCommune, 
    deleteCommune, 
    getAllProvince, 
    getDetailProvince, 
    createProvince, 
    updateProvince, 
    deleteProvince, 
    getProvinceWithPerPage,
    getDistrictWithPerPage

} = require('../controllers/locationController');
const { checkAccessToken, isAdmin } = require('../middleware/authUser');
const route = express.Router();



/*****  LOCATION_TYPE  ******/
route.get('/getAllLocationType', checkAccessToken, getAllLocationType);
route.get('/detailLocationType', checkAccessToken, getDetailLocationType);
route.post('/addLocationType', checkAccessToken, isAdmin, createLocationType);
route.put('/updateLocationType', checkAccessToken, isAdmin, updateLocationType);
route.delete('/deleteLocationType', checkAccessToken, isAdmin, deleteLocationType);


/*********  COUNTRY  ***********/
route.get('/getAllCountry', checkAccessToken, getAllCountry);
route.get('/getDetailCountry', checkAccessToken, getDetailCountry);
route.post('/addCountry', checkAccessToken, isAdmin, createCountry);
route.put('/updateCountry', checkAccessToken, isAdmin,updateCountry);
route.delete('/deleteCountry', checkAccessToken, isAdmin, deleteCountry);

/*********  PROVINCE  ***********/
route.get('/getAllProvince', checkAccessToken, getAllProvince);
route.get('/getDetailProvince', checkAccessToken, getDetailProvince);
route.get('/getProvinceWithPagination', checkAccessToken, getProvinceWithPerPage)
route.post('/addProvince', checkAccessToken, isAdmin, createProvince);
route.put('/updateProvince', checkAccessToken, isAdmin, updateProvince);
route.delete('/deleteProvince', checkAccessToken, isAdmin, deleteProvince);


/*****   DISTRICT    ******/
route.get('/getAllDistrict', checkAccessToken, getAllDistrict);
route.get('/detailDistrict', checkAccessToken, getDetailDistrict);
route.get('/getDistrictWithPagination', checkAccessToken, getDistrictWithPerPage)
route.post('/addDistrict', checkAccessToken, isAdmin, createDistrict);
route.put('/updateDistrict', checkAccessToken, isAdmin, updateDistrict);
route.delete('/deleteDistrict', checkAccessToken, isAdmin, deleteDistrict);


/*****  COUMMUNE  ******/
route.get('/getAllCommune', checkAccessToken, getAllCommune);
route.get('/detailCommune', checkAccessToken, getDetailCommune);
route.post('/addCommune', checkAccessToken, isAdmin, createCommune);
route.put('/updateCommune', checkAccessToken, isAdmin, updateCommune);
route.delete('/deleteCommune', checkAccessToken, isAdmin, deleteCommune);

module.exports = route;

