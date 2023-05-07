const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
require('dotenv').config();

const swaggerUI = require('swagger-ui-express');
const YAML = require('yamljs');
const swaggerJsDocs = YAML.load('./api.yaml');
const http = require('http');
const socketIo = require('socket.io');
const path = require('path');

const publicPathDirectory = path.join(__dirname, '../public');

const app = express();

const server = http.createServer(app);
const io = socketIo(server);

app.use(bodyParser.urlencoded({ extended: false}));
app.use(bodyParser.json());
app.use(cors());
app.use(express.static('.'));
app.use('/api-docs', swaggerUI.serve, swaggerUI.setup(swaggerJsDocs));
app.use(express.static(publicPathDirectory));




const userRoute = require('./routes/userRouter');
const menuRoute = require('./routes/menuRouter');
const bannerRoute = require('./routes/bannerRoute');
const categoriesRoute = require('./routes/categoriesRoute');
const productRoute = require('./routes/productRoute');
const newsRoute = require('./routes/newsRoute');
const statusRoute = require('./routes/statusRoute.js');
const orderRoute = require('./routes/orderRoute');
const priorityRoute = require('./routes/priorityRoute');
const commentRoute = require('./routes/commentRoute');
const rateRoute = require('./routes/rateRoute');
const contactRoute = require('./routes/contactRoute');
const fixPostRoute = require('./routes/fixPostRoute');
const locationRoute = require('./routes/locationRoute');
const youtubeRoute = require('./routes/youtubeRoute');
const creditRoute = require('./routes/creditRoute');
const aboutPageRoute = require('./routes/aboutPageRoute');
const supportPostRoute = require('./routes/supportPostRoute');



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
    youtubeRoute,
    creditRoute,
    aboutPageRoute,
    supportPostRoute,

);

app.use('/v1/api/location',
    locationRoute,
);





io.on("connection", (socket) => {
    console.log("new client connect")

    socket.on("message", (text) => {
        console.log(text);

        const hi = 'xin Chao io'
        if(text.length > 0){
            console.log('ok')
            socket.emit('reply', hi)
        }
    })
    
    socket.on("disconnect", () => {
        console.log('client disconnect');
    })
});

const Port = process.env.PORT || 8001
server.listen(Port, () => {
    console.log('server is running on port ' + Port)
});



