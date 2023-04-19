const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
const message = require('../services/message');


const getAllComment = async (req, res) => {
    try {

        const data = await prisma.comments.findMany();

        res.status(200).json({ data })

    } catch (err) {
        res.status(500).json(err);
    };
};


const getDetailComment = async (req, res) => {
    try {

        const {maComment} = req.query;

        const data = await prisma.comments.findFirst({
            where: { maComment: String(maComment)},
            include: {
                sanPham: true
            }
        });

        res.status(200).json({data})

    } catch (err) {
        res.status(500).json(err);
    };
};

const getCommentWithProduct = async (req, res) => {
    try {

        const { maSanPham } = req.query;

        const data = await prisma.comments.findMany({
            where: {
                maSanPham: String(maSanPham)
            }
        });

    

        res.status(200).json({ data })

    } catch (err) {
        res.status(500).json(err)
    };
};

const createComment = async (req, res) => {
    try {

        const { hoTen, noiDung, maSanPham } = req.body;

        console.log(req.body)

        const findProduct = await prisma.products.findFirst({
            where: { maSanPham: String(maSanPham) },
        });
        console.log(findProduct)

        if (!findProduct) {
            res.status(404).json({ message: message.NOT_FOUND })
        }

        const data = await prisma.comments.create({
            data: {
                hoTen,
                noiDung,
                maSanPham: String(maSanPham)
            }
        });

        res.status(200).json({ data });

    } catch (err) {
        res.status(500).json(err);
    };
};

const updateComment = async (req, res) => {
    try {

        const { maComment } = req.query;
        const { hoTen, noiDung } = req.body;

        const findComment = await prisma.comments.findFirst({
            where: {
                maComment: String(maComment)
            },
        });

        if(!findComment) {
            return res.status(404).json({message: message.NOT_FOUND});
        };

        await prisma.comments.update({
            where: {
                maComment: String(maComment),
            },
            data: {
                hoTen, noiDung
            }
        })

        res.status(200).json({message: message.UPDATE});

    } catch (err) {
        res.status(500).json(err);
    };
};

const deleteComment = async (req, res) => {
    try {

        const { maComment } = req.query;

        const findComment = await prisma.comments.findFirst({
            where: {
                maComment: String(maComment)
            },
        });

        if ( !findComment ) {
            return res.status(404).json({message: message.NOT_FOUND});
        };

        await prisma.comments.delete({
            where: {
                maComment: String(maComment)
            }
        });

        res.status(404).json({message: message.DELETE});

    } catch (err) {
        res.status(500).json(err);
    };
};

module.exports = {
    getAllComment,
    getDetailComment,
    getCommentWithProduct,
    createComment,
    updateComment,
    deleteComment

}