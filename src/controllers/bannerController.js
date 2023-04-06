const { PrismaClient } = require('@prisma/client')
const prisma = new PrismaClient();
require('dotenv').config();


const getAllBanner = async (req, res) => {
    try {

        const data = await prisma.banner.findMany();
        const newData = data.map((ele) => {
            return ({...ele, hinhAnh: process.env.BASE_URL + ele.hinhAnh})
        })
        res.status(200).json({data: newData});

    } catch (err) {
        res.status(500).json(err);
    }
}

const createBanner = async ( req , res ) => {
    try {
        
        const { filename } = req.file;
        const hinhAnh = `/public/images/${filename}`

        const newBanner = await prisma.banner.create({data: {hinhAnh}})

        res.status(200).json({data: newBanner, message: 'Thêm Banner Thành Công !!!'});
        

    } catch (err) {
        res.status(500).json(err);
    }
};


const updateBanner = async ( req , res ) => {
    try {
        

        res.status(200).json({ message: 'Cập Nhật Banner Thành Công !!!'});
        

    } catch (err) {
        res.status(500).json(err);
    }
};


const deleteBanner = async ( req , res ) => {
    try {
        
        const { maBanner } = req.query;

        const find = await prisma.banner.findUnique({where: {maBaner: Number(maBanner)}});

        if (!find){
            return res.status(404).json({message: 'Không Tìm Thấy Menu !!!'});
        }

        await prisma.banner.delete({where:{maBaner: Number(maBanner)}});

        res.status(200).json({ message: 'Xóa Banner Thành Công !!!'});
        

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