const { PrismaClient } = require('@prisma/client')
const prisma = new PrismaClient();
require('dotenv').config();
const fs = require('fs');


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

const createBanner = async (req, res) => {
    try {

        const { filename } = req.file;


        const newBanner = await prisma.banner.create({ data: { hinhAnh: filename } })

        res.status(200).json({ data: newBanner, message: 'Thêm Banner Thành Công !!!' });


    } catch (err) {
        res.status(500).json(err);
    }
};


const updateBanner = async (req, res) => {
    try {

        const { maBanner } = req.query;

        const find = await prisma.banner.findFirst({
            where: { maBaner: String(maBanner) }
        });

        if (!find) {
            return res.status(404).json({ message: "Không tìm thấy !" })
        }

        if(req.file) {

            const directoryPath = process.cwd() + "/public/banner/";

            if(fs.existsSync(directoryPath + find.hinhAnh)) {

                await fs.unlinkSync(directoryPath + find.hinhAnh);

            } 

            const data = await prisma.banner.update({
                where: {maBaner: String(maBanner)},
                data: {hinhAnh: req.file.filename}
            })

            res.status(200).json({ data,message: 'Cập Nhật Banner Thành Công !!!' });
        } else {
            res.status(404).json({message: "Vui lòng nhập file !"})
        }


    } catch (err) {
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
    updateBanner,
    deleteBanner,
    getAllBanner
}