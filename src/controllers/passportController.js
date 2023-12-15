const {PrismaClient} = require('@prisma/client');
const { generateToken } = require('./authController');
const prisma = new PrismaClient();



const facebookLogin = async (req, res) => {
    try {
        const token = generateToken({maNguoiDung: req.user.maNguoiDug}, '1h')
        let expired = new Date(new Date().getTime() + 1 * 60 * 60 * 1000);
        const refreshToken = generateToken({maNguoiDung: req.user.maNguoiDug}, '3m');

        res.status(200).json({token, refreshToken ,expiredAt: expired});

    } catch (err) {
        res.status(500).json(err);
    };
};

module.exports = {
    facebookLogin,
}