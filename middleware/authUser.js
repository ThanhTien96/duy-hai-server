const authController = require("../src/controllers/authController");

const authUser = async (req, res, next) => {
    try {
        const { authorization } = req.headers;
        const auth = authorization.replace('Bearer ', '')
        if (auth) {

            if (authController.verifyToken(auth)) {
                next()
            } else {
                res.status(403).json({ messagae: 'Token không hợp lệ !' })
            }

        }
        else {
            res.status(403).json({ messagae: 'Token không hợp lệ !' })
        }

    } catch (err) {
        res.status(500).json(err);
    };
};


module.exports = {
    authUser,
}