const { PrismaClient } = require('@prisma/client');
const { verifyToken } = require('../controllers/authController');
const message = require('../services/message');
const prisma = new PrismaClient();




const authUser = async (req, res, next) => {
    // Check if the authorization header is present in the request
    if (!req.headers.authorization) {
        return res.status(401).json({ error: 'Authorization header is missing' });
    }

    // Get the authorization token from the header
    const token = req.headers.authorization.split(' ')[1];

    // Verify the token
    try {
        const decoded = verifyToken(token);

        if (!decoded) {
            return res.status(401).json({ err: 'Token không hợp lệ !' })
        }

        const checked = await prisma.user.findFirst({
            where: { maNguoiDung: decoded.maNguoiDung }
        })

        if (!checked) {
            return res.status(403).json({ err: 'Bạn không đủ quyền truy cập !' })
        }
        req.user = decoded

        next();
    } catch (err) {
        return res.status(401).json({ error: 'Invalid authorization token' });
    }
};


/***********    check token it is role admin    ***************/
const isAdmin = async (req, res, next) => {

    if (!req.headers.authorization) {
        return res.status(401).json({ error: 'Authorization header is missing' });
    }

    const token = req.headers.authorization.split(' ')[1];

    try { 

        const decoded = verifyToken(token);

        if (!decoded) {
            return res.status(401).json({error: 'Token không hợp lệ !'});
        };

        const checkAdmin = await prisma.user.findFirst({
            where: {maNguoiDung: decoded.maNguoiDung},
            include:{
                user_type: true
            }
        });


        if(checkAdmin.user_type.loaiNguoiDung === 'admin') {
            req.user = checkAdmin;
            next()
        } else {
            return res.status(403).json({error: 'Bạn không đủ quyền !'})
        }

    } catch (err) {
        res.status(401).json({error: 'Token không hợp lệ !'})
    };
};


/****** check valid access token ******/
const checkAccessToken = async (req, res, next) => {

    const { accesstoken } = req.headers;

    if(!accesstoken) {
        return res.status(401).json({error: 'Vui lòng nhập token access!'})
    }

    try { 

        const decoded = verifyToken(accesstoken);

        if( !decoded ) {
            return res.status(403).json({error: 'Token access không hợp lệ !'})
        }

        const checkToken = await prisma.user.findFirst({
            where: {maNguoiDung: decoded.maNguoiDung}
        });

        if(!checkToken) {
            return res.status(403).json({error: message.ERROR_TOKEN});
        }
        else {
            next();
        };

    } catch (err) {
        res.status(401).json({error: 'Token không hợp lệ !'})
    };
};


module.exports = {
    authUser,
    isAdmin,
    checkAccessToken,
}