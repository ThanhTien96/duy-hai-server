const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
require('dotenv').config();
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();


const swaggerUI = require('swagger-ui-express');
const YAML = require('yamljs');
const swaggerJsDocs = YAML.load('./api.yaml');
const passport = require('passport');
const facebookStrategy = require('passport-facebook-token');

const app = express();



app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
app.use(cors());
app.use(express.static('.'));
app.use('/api-docs', swaggerUI.serve, swaggerUI.setup(swaggerJsDocs));




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
const { hashPass } = require('./controllers/authController');
const { facebookLogin } = require('./controllers/passportController');
const { UserType } = require('./constants/checkUserConst');



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

passport.use('facebookAuth', new facebookStrategy({
    clientID: '1006315314083797',
    clientSecret: 'e02c0a1052229136387cb635c53ca217',

}, async (accessToken, refreshToken, profile, done) => {
    try {
        const email = profile.emails[0].value;
        const name = profile.displayName;
        const foundUser = await prisma.user.findUnique({
            where: { email },
            include: { user_type: true }
        });

        const findUserType = await prisma.user_type.findFirst({
            where: {loaiNguoiDung: UserType.USER}
        });

        const hasPassword = hashPass('user123');
        let loginUser = foundUser;
        if (!loginUser) {
            loginUser = await prisma.user.create({
                data: {
                    email,
                    taiKhoan: email,
                    matKhau: hasPassword,
                    maLoaiNguoiDung: findUserType.maLoaiNguoiDung,
                    hoTen: name,
                },
                include: {
                    user_type: true
                }
            })
        }
        return done(null, loginUser)
    
    } catch (err) {
        return done(err)
    };
}));

app.post('/api/facebook/login', passport.authenticate('facebookAuth', { session: false }), facebookLogin);




const Port = process.env.BASE_PORT || 8001
app.listen(Port, () => {
    console.log('server is running on port ' + Port)
});



