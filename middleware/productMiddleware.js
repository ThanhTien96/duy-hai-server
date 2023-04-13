
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();


const checkValid = async (req, res, next) => {
    try {

        const { maSanPham } = req.query;

        const { maDanhMucNho } = req.body;


        const find = await prisma.products.findFirst({
            where: { maSanPham: String(maSanPham) },
        });

        if (!find) {
            return res.status(404).json('Không tìm thấy !')
        } else {

            next();

        }


    } catch (err) {
        res.status(500).json(err);
    };
};


module.exports = {
    checkValid,
}


