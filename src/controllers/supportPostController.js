const { PrismaClient } = require('@prisma/client');
const message = require('../services/message');
const sendMail = require('../middleware/sendMailMiddleware');
const prisma = new PrismaClient();


const getALlSpPost = async (req, res) => {
    try {

        const data = await prisma.support_post.findMany({
            orderBy: { createAt: 'desc' }
        });

        if (data.length <= 0) {
            return res.status(204).json();
        };

        res.status(200).json({ data });

    } catch (err) {
        res.status(500).json(err);
    };
};


const getDetailSpPost = async (req, res) => {
    try {

        const { id } = req.query;
        const findPost = await prisma.support_post.findUnique({
            where: { id },
            include: {
                comment: {
                    orderBy: {createAt: 'desc'}
                }
            }
        });

        if (!findPost) {
            return res.status(404).json({ message: message.NOT_FOUND });
        };

        res.status(200).json({ data: findPost })

    } catch (err) {
        res.status(500).json(err);
    };
};

const createSpPost = async (req, res) => {
    try {

        const { tieuDe, noiDung } = req.body;

        console.log(tieuDe)

        await prisma.support_post.create({
            data: { tieuDe, noiDung }
        });

        res.status(200).json({ message: message.CREATE_SUCCESS });

    } catch (err) {
        res.status(500).json(err);
    };
};


const updateSpPost = async (req, res) => {
    try {

        const { id } = req.query;
        const { tieuDe, noiDung } = req.body;

        const find = await prisma.support_post.findUnique({
            where: { id }
        });

        if (!find) {
            return res.status(404).json({ message: message.NOT_FOUND });
        };

        await prisma.support_post.update({
            where: { id },
            data: { tieuDe, noiDung }
        });

        res.status(200).json({ message: message.UPDATE });


    } catch (err) {
        res.status(500).json(err);
    };
};

const deleteSpPost = async (req, res) => {
    try {

        const { id } = req.query;

        const find = await prisma.support_post.findUnique({
            where: { id }
        });

        if (!find) {
            return res.status(404).json({ message: message.NOT_FOUND });
        };

        await prisma.support_post.delete({ where: { id } });

        res.status(200).json({ message: message.DELETE });


    } catch (err) {
        res.status(500).json(err);
    };
};


/** comment support post */


const getAllCommentSpPost = async (req, res) => {
    try {

        const data = await prisma.support_comment.findMany({
            orderBy: { createAt: 'desc' },
            include: {
                baiViet: true
            }
        });

        if (data.length <= 0) {
            return res.status(204).json()
        };

        res.status(200).json({ data });

    } catch (err) {
        res.status(500).json(err);
    };
};

const getDetailCommentSpPost = async (req, res) => {
    try {

        const {id} = req.query;

        const findData = await prisma.support_comment.findUnique({where: {id}});

        if (!findData) {
            return res.status(404).json({message: message.NOT_FOUND});
        };

        res.status(200).json({data: findData})

    } catch (err) {
        res.status(500).json(err);
    };
};

const createCommentSpPost = async (req, res) => {
    try {

        const { hoTen, noiDung, maBaiVietHoTro, admin } = req.body;

        const data = await prisma.support_comment.create({
            data: {
                hoTen,
                noiDung,
                maBaiVietHoTro,
                admin: admin && Boolean(admin),
            }
        });

        res.status(200).json({ data })

    } catch (err) {
        res.status(500).json(err);
    };
};

const updateCommentSpPost = async (req, res) => {
    try {

        const {id} = req.query;
        const { hoTen, noiDung, maBaiVietHoTro, admin } = req.body;

        const findData = await prisma.support_comment.findUnique({where: {id}});

        
        if (!findData) {
            return res.status(404).json({message: message.NOT_FOUND});
        };

        await prisma.support_comment.update({
            where: {id},
            data: { hoTen, noiDung, maBaiVietHoTro, admin: Boolean(admin)}
        });

        res.status(200).json({message: message.UPDATE});

    } catch (err) {
        res.status(500).json(err);
    };
};

const deleteCommentSpPost = async (req, res) => {
    try {

        const {id} = req.query;

        const findData = await prisma.support_comment.findUnique({where: {id}});

        if (!findData) {
            return res.status(404).json({message: message.NOT_FOUND});
        };

        await prisma.support_comment.delete({
            where: {id}
        });

        res.status(200).json({message: message.DELETE});

    } catch (err) {
        res.status(500).json(err);
    };
};





module.exports = {
    getALlSpPost,
    getDetailSpPost,
    createSpPost,
    updateSpPost,
    deleteSpPost,

    /** comment support post */
    createCommentSpPost,
    getDetailCommentSpPost,
    getAllCommentSpPost,
    updateCommentSpPost,
    deleteCommentSpPost,

}


