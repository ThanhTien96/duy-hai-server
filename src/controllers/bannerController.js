const { PrismaClient } = require('@prisma/client')
const prisma = new PrismaClient();
require('dotenv').config();
const fs = require('fs');
const message = require('../services/message');


const getAllBanner = async (req, res) => {
    try {

        const data = await prisma.banner.findMany();

        const newData = data.map((ele) => {
            return ({ ...ele, hinhAnh: process.env.BASE_URL + '/public/banner/' + ele.hinhAnh })
        })
        res.status(200).json({ data: newData });

    } catch (err) {
        res.status(500).json(err);
    }
}

const getDetailBanner = async (req, res) => {
    try {

        const { maBanner } = req.query;

        const findBanner = await prisma.banner.findFirst({
            where: { maBanner }
        });


        if (!findBanner) {
            return res.status(404).json({ message: message.NOT_FOUND });
        };

        const data = {
            ...findBanner,
            hinhAnh: process.env.BASE_URL + '/public/banner/' + findBanner.hinhAnh
        }

        res.status(200).json({ data })

    } catch (err) {
        res.status(500).json(err);
    };
};

const createBanner = async (req, res) => {
    try {

        const { filename } = req.file;


        const newBanner = await prisma.banner.create({ data: { hinhAnh: filename } })

        const data = {
            ...newBanner,
            hinhAnh: process.env.BASE_URL + '/public/banner/' + newBanner.hinhAnh
        }

        res.status(200).json({ data, message: 'Thêm Banner Thành Công !!!' });


    } catch (err) {
        res.status(500).json(err);
    }
};


const updateBanner = async (req, res) => {
    const {filename} = req.file;
    try {

        const { maBanner } = req.query;
        const directoryPath = process.cwd() + "/public/banner/";
        
        const find = await prisma.banner.findFirst({
            where: { maBanner: String(maBanner) }
        });

        if (!find) {
            if (fs.existsSync(directoryPath + filename)) {

                fs.unlinkSync(directoryPath + filename);

            }
            return res.status(404).json({ message: "Không tìm thấy !" })
        }

        if (filename) {


            if (fs.existsSync(directoryPath + find.hinhAnh)) {

                fs.unlinkSync(directoryPath + find.hinhAnh);
            };

            const data = await prisma.banner.update({
                where: { maBanner: String(maBanner) },
                data: { hinhAnh: req.file.filename }
            })

            res.status(200).json({ data, message: 'Cập Nhật Banner Thành Công !!!' });
        } else {

            res.status(404).json({ message: "Vui lòng nhập file !" })
        }


    } catch (err) {
        
        const directoryPath = process.cwd() + "/public/banner/";
        if (fs.existsSync(directoryPath + filename)) {

            fs.unlinkSync(directoryPath + filename);
        }
        res.status(500).json(err);
    }
};


const deleteBanner = async (req, res) => {
    try {

        const { maBanner } = req.query;

        const find = await prisma.banner.findUnique({ where: { maBaner: String(maBanner) } });


        if (!find) {
            return res.status(404).json({ message: 'Không Tìm Thấy Menu !!!' });
        }

        const directoryPath = process.cwd() + "/public/images/";

        if (fs.existsSync(directoryPath + find.hinhAnh)) {

            fs.unlinkSync(directoryPath + find.hinhAnh);

        }

        await prisma.banner.delete({ where: { maBaner: String(maBanner) } });

        res.status(200).json({ message: 'Xóa Banner Thành Công !!!' });



    } catch (err) {
        res.status(500).json(err);
    }
};




module.exports = {
    createBanner,
    getDetailBanner,
    updateBanner,
    deleteBanner,
    getAllBanner
}