const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();
require('dotenv').config()


const getAllProducts = async (req, res) => {
    try {

        const data = await prisma.products.findMany({
            include: {
                hinhAnh: true,
                danhMucNho: true,
            },
        });

        const newData = []

        for(let product of data) {
            const newProduct = {
                maSanPham: product.maSanPham,
                tenSanPham: product.tenSanPham,
                moTa: product.moTa,
                khuyenMai: product.khuyenMai,
                giaGiam: product.giaGiam,
                giaGoc: product.giaGoc,
                tongSoLuong: product.tongSoLuong,
                createAt: product.createAt,
                updateAt: product.updateAt,
                hinhAnh: product.hinhAnh.map(ele => ({id: ele.id, hinhAnh: process.env.BASE_URL + '/public/images/' + ele.hinhAnh})),
                danhMucNho: {
                    maDanhMucNho: product.danhMucNho.maDanhMucNho,
                    tenDanhMucNho: product.danhMucNho.tenDanhMucNho
                }
    
            };

            newData.push(newProduct)
        };

        res.status(200).json({data: newData});

    } catch (err) {
        res.status(500).json(err);
    };
};



const createProduct = async (req, res) => {
    const {
        tenSanPham,
        moTa,
        khuyenMai,
        tongSoLuong,
        maDanhMucNho,
        giaGiam,
        giaGoc
    } = req.body;

    const { files } = req;

    try {
        const newProduct = await prisma.products.create({
            data: {
                tenSanPham,
                moTa,
                khuyenMai: Number(khuyenMai),
                tongSoLuong: Number(tongSoLuong),
                maDanhMucNho: String(maDanhMucNho),
                giaGiam: Number(giaGiam),
                giaGoc: Number(giaGoc),
                hinhAnh: {
                    create: files.map(file => {
                        return {
                            hinhAnh: file.filename
                        };
                    })
                }
            },
            include: {
                hinhAnh: true
            }
        });
        res.status(200).json({ data: newProduct });
    } catch (err) {
        res.status(500).json(err);
    }
};

module.exports = {
    createProduct,
    getAllProducts,
}