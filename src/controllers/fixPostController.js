
const { PrismaClient } = require('@prisma/client');

const prisma = new PrismaClient();

require('dotenv').config;
const fs = require('fs');
const message = require('../services/message');



const getAllPost = async (req, res) => {
    try {

        const findData = await prisma.fixpost.findMany({
            orderBy: {createAt: 'desc'},
            include: {
                hinhAnh: true
            }
        });

        if(findData.length <= 0) {
            return res.status(204).json();
        };

        const data = findData.map(ele => ({
            ...ele,
            hinhAnh: ele.hinhAnh.map(img => ({
                id: img.id,
                hinhAnh: process.env.SEVER_URL + '/public/fixPostImage/' + img.hinhAnh
            }))
        }))

        res.status(200).json({ data })
    } catch (err) {
        res.status(500).json(err);
    };
};

const getDetailPost = async (req, res) => {
    try {

        const { maBaiViet } = req.query;

        const findData = await prisma.fixpost.findFirst({
            where: {
                maBaiViet: String(maBaiViet)
            },
            include: {
                hinhAnh: true
            },
        });

        const data = {
            ...findData,
            hinhAnh: findData.hinhAnh.map(img => ({
                id: img.id,
                hinhAnh: process.env.SEVER_URL + '/public/fixPostImage/' + img.hinhAnh,
            }))
        };

        res.status(200).json({ data })

    } catch (err) {
        res.status(500).json(err);
    };
};

const createPost = async (req, res) => {
    try {

        const { tieuDe, noiDung, tenKySu } = req.body;

        const { files } = req;

        const newData = await prisma.fixpost.create({
            data: {
                tieuDe,
                noiDung,
                tenKySu,
                hinhAnh: {
                    create: files.map(ele => ({
                        hinhAnh: ele.filename
                    }))
                }
            },
            include: {
                hinhAnh: true
            }
        });

        const data = {
            ...newData,
            hinhAnh: newData.hinhAnh.map(img => ({
                id: img.id,
                hinhAnh: process.env.SEVER_URL + '/public/fixPostImage/' + img.hinhAnh
            }))
        }

        res.status(200).json({ data })

    } catch (err) {

        const { files } = req

        const directoryPath = process.cwd() + '/public/fixPostImage/';

        for (let img of files) {

            if (fs.existsSync(directoryPath + img.filename)) {

                fs.unlinkSync(directoryPath + img.filename);

            };

        }



        res.status(500).json(err);
    };
};

const updatePost = async (req, res) => {
    try {

        const { maBaiViet } = req.query;

        const { tieuDe, noiDung, tenKySu } = req.body;

        const { files } = req;

        const findPost = await prisma.fixpost.findFirst({
            where: {
                maBaiViet: String(maBaiViet)
            },
            include: {
                hinhAnh: true
            }
        });

        if (!findPost) {

            const directoryPath = process.cwd() + '/public/fixPostImage/'

            for (let img of files) {

                if (fs.existsSync(directoryPath + img.filename)) {
                    fs.unlinkSync(directoryPath + img.filename)
                }

            }

            return res.status(404).json({ message: message.NOT_FOUND });

        };

        if (findPost) {

            if (files.length > 0) {

                for (let i in files) {

                    const directoryPath = process.cwd() + '/public/fixPostImage/';

                    /** kiem tra hinh anh co trong storage ney co thi xoa di */
                    if (fs.existsSync(directoryPath + findPost.hinhAnh[i].hinhAnh)) {

                        fs.unlinkSync(directoryPath + findPost.hinhAnh[i].hinhAnh)

                    };

                    /** cap nhat ten hinh anh trong data base */

                    await prisma.fixpost_image.update({
                        where: {
                            id: String(findPost.hinhAnh[i].id)
                        },
                        data: {
                            hinhAnh: files[i].filename
                        }
                    })

                }

            }

        };


        const newData = await prisma.fixpost.update({
            where: {
                maBaiViet: String(maBaiViet),
            },
            data: {
                tieuDe,
                noiDung,
                tenKySu,
            },
            include: {
                hinhAnh: true
            }
        });

        const data = {
            ...newData,
            hinhAnh: newData.hinhAnh.map(img => ({
                id: img.id,
                hinhAnh: process.env.SEVER_URL + '/public/fixPostImage/' + img.hinhAnh
            }))
        }


        res.status(200).json({ data, message: message.UPDATE })

    } catch (err) {

        const { files } = req;

        const directoryPath = process.cwd() + '/public/fixPostImage/'

        for (let img of files) {

            if (fs.existsSync(directoryPath + img.filename)) {
                fs.unlinkSync(directoryPath + filename)
            }

        }

        res.status(500).json(err);
    };
};

const deletePost = async (req, res) => {
    try {

        const { maBaiViet } = req.query;

        const findPost = await prisma.fixpost.findFirst({
            where: {
                maBaiViet: String(maBaiViet)
            },
            include: {
                hinhAnh: true
            }
        });

        if (!findPost) {
            return res.status(404).json({ message: message.NOT_FOUND })
        };

        if (findPost.hinhAnh.length > 0) {

            for (let img of findPost.hinhAnh) {

                const directoryPath = process.cwd() + '/public/fixPostImage/';

                if (fs.existsSync(directoryPath + img.hinhAnh)) {
                    fs.unlinkSync(directoryPath + img.hinhAnh)
                };

                if(img.id) {
                    await prisma.fixpost_image.delete({
                        where: {
                            id: String(img.id)
                        }
                    })
                }
            };
        };


        await prisma.fixpost.delete({
            where: {
                maBaiViet: String(maBaiViet),
            }
        });


        res.status(200).json({ message: message.DELETE })

    } catch (err) {
        res.status(500).json(err);
    };
};


module.exports = {
    getAllPost,
    getDetailPost,
    createPost,
    updatePost,
    deletePost
}

