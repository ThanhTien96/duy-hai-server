const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
require('dotenv').config();
const app = express();



app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
app.use(cors());
app.use(express.static('.'))

const userRoute = require('./router/userRouter');
const menuRoute = require('./router/menuRouter');
const bannerRoute = require('./router/bannerRoute');
const categoriesRoute = require('./router/categoriesRoute');
const productRoute = require('./router/productRoute');
app.use('/api',
    userRoute,
    menuRoute,
    bannerRoute,
    categoriesRoute,
    productRoute,

);

const Port = process.env.PORT || 8001
app.listen(Port, () => {
    console.log('server is running on port ' + Port)
});



