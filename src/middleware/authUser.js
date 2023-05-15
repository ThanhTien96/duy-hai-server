const { PrismaClient } = require('@prisma/client');
const { verifyToken } = require('../controllers/authController');
const message = require('../services/message');
const { UserType } = require('../constants/checkUserConst');
const { authMessage } = require('../services/authMessage');
const prisma = new PrismaClient();




const authUser = async (req, res, next) => {
    // Check if the authorization header is present in the request
    if (!req.headers.authorization) {
        return res.status(401).json({ error: authMessage.MISSING_AUTH_TOKEN });
    }

    // Get the authorization token from the header
    const token = req.headers.authorization.split(' ')[1];

    // Verify the token
    try {
        const decoded = verifyToken(token);

        if (!decoded) {
            return res.status(401).json({ err: authMessage.VALID_TOKEN })
        }

        const checked = await prisma.user.findFirst({
            where: { maNguoiDung: decoded.maNguoiDung }
        })

        if (!checked) {
            return res.status(403).json({ err: authMessage.FORBIDDEN })
        }
        req.user = decoded

        next();
    } catch (err) {
        return res.status(401).json({ error: authMessage.VALID_TOKEN });
    }
};


/***********    check token it is role admin    ***************/
const isAdmin = async (req, res, next) => {

    if (!req.headers.authorization) {
        return res.status(401).json({ error: authMessage.MISSING_AUTH_TOKEN });
    }

    const token = req.headers.authorization.split(' ')[1];

    try { 

        const decoded = verifyToken(token);

        if (!decoded) {
            return res.status(401).json({error: authMessage.VALID_TOKEN});
        };

        const checkAdmin = await prisma.user.findUnique({
            where: {maNguoiDung: decoded.maNguoiDung},
            include:{
                user_type: true
            }
        });


        if(checkAdmin.user_type.loaiNguoiDung === UserType.ADMIN) {
            req.user = {maNguoiDung: checkAdmin.maNguoiDung};
            next()
        } else {
            return res.status(403).json({error: authMessage.FORBIDDEN})
        }

    } catch (err) {
        res.status(401).json({error: authMessage.VALID_TOKEN})
    };
};


/****** check valid access token ******/
const checkAccessToken = async (req, res, next) => {

    const { accesstoken } = req.headers;

    if(!accesstoken) {
        return res.status(401).json({error: authMessage.NOT_VALID_ACCESS_TOKEN})
    }

    try { 

        const decoded = verifyToken(accesstoken);

        if( !decoded ) {
            return res.status(403).json({error: authMessage.VALID_TOKEN})
        }

        const checkToken = await prisma.user.findUnique({
            where: {maNguoiDung: decoded.maNguoiDung},
            include: {
                user_type: true
            }
        });


        if(!checkToken) {
            return res.status(403).json({error: authMessage.ERROR_TOKEN});
        }
       
        if (checkToken.user_type.loaiNguoiDung !== UserType.ADMIN) {
            res.status(403).json({error: authMessage.ERROR_TOKEN})
        } else {
            next();
        }

        

    } catch (err) {
        res.status(401).json({error: authMessage.VALID_TOKEN})
    };
};


module.exports = {
    authUser,
    isAdmin,
    checkAccessToken,
}