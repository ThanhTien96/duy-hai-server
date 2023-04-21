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
    getDetailProvice, 
    createProvince, 
    updateProvince, 
    deleteProvince, 
    getProviceWithPerPage,
    getDistrictWithPerPage

} = require('../controllers/locationController');
const route = express.Router();


/*****  LOCATION_TYPE  ******/
route.get('/getAllLocationType', getAllLocationType);
route.get('/detailLocationType', getDetailLocationType);
route.post('/addLocationType', createLocationType);
route.put('/updateLocationType', updateLocationType);
route.delete('/deleteLocationType', deleteLocationType);


/*********  COUNTRY  ***********/
route.get('/getAllCountry', getAllCountry);
route.get('/getDetailCountry', getDetailCountry);
route.post('/addCountry', createCountry);
route.put('/updateCountry',updateCountry);
route.delete('/deleteCountry', deleteCountry);

/*********  PROVINCE  ***********/
route.get('/getAllProvince', getAllProvince);
route.get('/getDetailProvince', getDetailProvice);
route.get('/getProvinceWithPagination', getProviceWithPerPage)
route.post('/addProvince', createProvince);
route.put('/updateProvince', updateProvince);
route.delete('/deleteProvince', deleteProvince);


/*****   DISTRICT    ******/
route.get('/getAllDistrict', getAllDistrict);
route.get('/detailDistrict', getDetailDistrict);
route.get('/getDistrictWithPagination', getDistrictWithPerPage)
route.post('/addDistrict', createDistrict);
route.put('/updateDistrict', updateDistrict);
route.delete('/deleteDistrict', deleteDistrict);


/*****  COUMMUNE  ******/
route.get('/getAllCommune', getAllCommune);
route.get('/detailCommune', getDetailCommune);
route.post('/addCommune', createCommune);
route.put('/updateCommune', updateCommune);
route.delete('/deleteCommune', deleteCommune);

module.exports = route;

