const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();
require('dotenv').config()
const fs = require('fs');


const getAllProducts = async (req, res) => {
    try {

        const data = await prisma.products.findMany({
            include: {
                hinhAnh: true,
                danhMucNho: true,
            },
        });



        const newData = []

        for (let product of data) {
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
                hinhAnh: product.hinhAnh.map(ele => ({ id: ele.id, hinhAnh: process.env.BASE_URL + '/public/images/' + ele.hinhAnh })),
                danhMucNho: {
                    maDanhMucNho: product.danhMucNho.maDanhMucNho,
                    tenDanhMucNho: product.danhMucNho.tenDanhMucNho
                }

            };

            newData.push(newProduct)
        };

        res.status(200).json({ data: newData });

    } catch (err) {
        res.status(500).json(err);
    };
};



const createProduct = async (req, res) => {
    const {
        tenSanPham,
        moTa,
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
                hinhAnh: true,
            }
        });

        const data = {
            ...newProduct,
            hinhAnh: newProduct.hinhAnh.map(ele => ({
                id: ele.id,
                hinhAnh: process.env.BASE_URL + '/public/images/' + ele.hinhAnh
            }))
        }
        res.status(200).json({ data });
    } catch (err) {

        const { files } = req;

        const directoryPath = process.cwd() + '/public/images/';

        for (let img of files) {

            if (fs.existsSync(directoryPath + img.filename)) {

                fs.unlinkSync(directoryPath + img.filename)

            };

        };

        res.status(500).json({ err });
    }
};


const getDetailProduct = async (req, res) => {
    try {

        const { maSanPham } = req.query;

        const findProduct = await prisma.products.findFirst({
            where: { maSanPham: String(maSanPham) },
            include: {
                hinhAnh: true,
                danhMucNho: true,
                danhGia: true,
                donHang: true,
            }
        });

        if (!findProduct) {
            return res.status(404).json({ message: 'Không tìm thấy !' });
        };

        const data = {
            ...findProduct,
            hinhAnh: findProduct.hinhAnh.map((ele => ({
                id: ele.id,
                hinhAnh: process.env.BASE_URL + '/public/images/' + ele.hinhAnh
            }))),
            comment: findProduct.comment.map(ele => ({
                maComment: ele.maComment,
                hoTen: ele.hoTen,
                noiDung: ele.noiDung,
            }))
        }

        res.status(200).json({ data })



    } catch (err) {
        res.status(500).json(err);
    };
};


const getProductPerPage = async (req, res) => {
    try {

        const { soTrang, soPhanTu } = req.query;

        const perPage = Number(soPhanTu);
        const page = Number(soTrang);

        if (perPage < 0) {
            perPage = 10;
        }

        if (page < 0) {
            page = 1;
        }

        const total = await prisma.products.count();
        const totalPages = Math.ceil(total / perPage)
        const currentPage = Math.min(page, totalPages);
        const skip = (currentPage - 1) * perPage;

        const newData = await prisma.products.findMany({
            take: perPage,
            skip: skip,
            include: {
                hinhAnh: true,
                danhMucNho: true,
            }
        })

        let data = []

        for (let product of newData) {

            let item = {
                ...product,
                hinhAnh: product.hinhAnh.map(ele => {
                    return {
                        id: ele.id,
                        hinhAnh: process.env.BASE_URL + '/public/images/' + ele.hinhAnh
                    };
                }),
            };

            data.push(item);

        }

        res.status(200).json({
            data,
            total,
            currentPage,
            totalPages
        })



    } catch (err) {
        res.status(500).json(err);
    };
};


/** cap nhat san pham và update hinh anh */
const updateProduct = async (req, res) => {
    {
        try {

            const { maSanPham } = req.query;
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

            const directoryPath = process.cwd() + '/public/images/'

            const findProduct = await prisma.products.findFirst({
                where: { maSanPham: String(maSanPham) },
                include: { hinhAnh: true }
            });

            // neu la 3 hinh hoac it hon thi update duoc them hinh thi khong them duoc
            if (files.length > 0) {

                for (let i = 0; i < files.length; i++) {

                    if( i < findProduct.hinhAnh.length) {
                        if (fs.existsSync(directoryPath + findProduct.hinhAnh[i].hinhAnh)) {
                        
                            fs.unlinkSync(directoryPath + findProduct.hinhAnh[i].hinhAnh);
    
                        };
    
                        await prisma.image_product.update({
                            where: { id: findProduct.hinhAnh[i].id },
                            data: { hinhAnh: files[i].filename }
                        });
                    } else {
                        await prisma.image_product.create({
                            data: {
                                maSanPham: findProduct.maSanPham,
                                hinhAnh: files[i].filename
                            }
                        })
                    }
                   
                }

            };

            const data = await prisma.products.update({
                where: { maSanPham: String(maSanPham) },
                data: { tenSanPham, moTa, khuyenMai, tongSoLuong, maDanhMucNho, giaGiam, giaGoc },
                include: { hinhAnh: true }
            })

            const newData = { ...data, hinhAnh: data.hinhAnh.map(ele => ({ hinhAnh: process.env.BASE_URL + '/public/images/' + ele.hinhAnh, id: ele.id })) }

            res.status(200).json({ data: newData, message: 'Cập nhật thành công !' })

        } catch (err) {

            const { files } = req;

            const directoryPath = process.cwd() + '/public/images/'

            for (let item of files) {
                if (fs.existsSync(directoryPath + item.filename)) {

                    fs.unlinkSync(directoryPath + item.filename);

                };
            }

            res.status(500).json(err);
        };
    }
};



const deleteProduct = async (req, res) => {
    try {

        const { maSanPham } = req.query;


        const findProduct = await prisma.products.findFirst({
            where: { maSanPham: String(maSanPham) },
            include: {
                hinhAnh: true,
                comment: true,
                danhGia: true,
                donHang: true
            },
        });


        if (!findProduct) {
            res.status(404).json({ message: "Không tìm thấy !" });
        }
        else {
            const directoryPath = process.cwd() + '/public/images/'

            if (findProduct.hinhAnh.length > 0) {

                for (let image of findProduct.hinhAnh) {

                    if (fs.existsSync(directoryPath + image.hinhAnh)) {
                        fs.unlinkSync(directoryPath + image.hinhAnh)
                    };

                    await prisma.image_product.delete({
                        where: { id: String(image.id) }
                    });

                };
            };

            if (findProduct.donHang.length > 0) {

                await prisma.orders_products.deleteMany({
                    where: {
                        maSanPham: String(maSanPham)
                    }
                })
            };

            if (findProduct.comment.length > 0) {
                await prisma.comments.deleteMany({
                    where: {
                        maSanPham: String(maSanPham)
                    }
                })
            }

            if (findProduct.danhGia.length > 0) {
                await prisma.rates_products.deleteMany({
                    where: {
                        maSanPham: String(maSanPham)
                    }
                })
            }

            await prisma.products.delete({
                where: {
                    maSanPham: String(maSanPham)
                },
            });

            res.status(200).json({ message: "Xóa thành công !" })
        }

    } catch (err) {
        res.status(500).json(err);
    };
};




module.exports = {
    getAllProducts,
    getDetailProduct,
    getProductPerPage,
    createProduct,
    updateProduct,
    deleteProduct,

}