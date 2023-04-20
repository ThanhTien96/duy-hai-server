const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
require('dotenv').config();
const app = express();



app.use(bodyParser.urlencoded({ extended: true, limit: '30mb' }));
app.use(bodyParser.json());
app.use(cors());
app.use(express.static('.'))

const userRoute = require('./router/userRouter');
const menuRoute = require('./router/menuRouter');
const bannerRoute = require('./router/bannerRoute');
const categoriesRoute = require('./router/categoriesRoute');
const productRoute = require('./router/productRoute');
const newsRoute = require('./router/newsRoute');
const statusRoute = require('./router/statusRoute.js');
const orderRoute = require('./router/orderRoute');
const priorityRoute = require('./router/priorityRoute');
const commentRoute = require('./router/commentRoute');
const rateRoute = require('./router/rateRoute');
const contactRoute = require('./router/contactRoute');
const fixPostRoute = require('./router/fixPostRoute');

app.use('/api',

    userRoute,
    menuRoute,
    bannerRoute,
    categoriesRoute,
    productRoute,
    newsRoute,
    statusRoute,
    orderRoute,
    priorityRoute,
    commentRoute,
    rateRoute,
    contactRoute,
    fixPostRoute,

);


const Port = process.env.PORT || 8001
app.listen(Port, () => {
    console.log('server is running on port ' + Port)
});



