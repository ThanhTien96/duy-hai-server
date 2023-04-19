const { PrismaClient } = require('@prisma/client');
const message = require('../services/message');
const prisma = new PrismaClient();
require('dotenv').config()


const getAllRate = async (req, res) => {
    try {

        const data = await prisma.rates.findMany({
            include:{
                sanPham: {
                    include: {
                        danhGia: true,
                        sanPham: true
                    }
                }
            }
        });

        if(data.length <= 0) {
            return res.status(204).json()
        }

        res.status(200).json({data});

    } catch (err) {
        res.status(500).json(err);
    };
};

const getDetailRate = async (req, res) => {
    try {

        const { maDanhGia } = req.query;

        const findRate = await prisma.rates.findFirst({
            where: {
                maDanhGia: String(maDanhGia)
            },
            include: {
                sanPham: {
                    include: {
                        sanPham: true
                    }
                }
            }
        });


        if( !findRate ) {
            return res.status(204).json()
        }

        res.status(200).json({data: findRate})
        
    } catch (err) {
        res.status(500).json(err);
    };
};

const getRateWithProduct = async (req, res) => {
    try {

        const { maSanPham } = req.query;

        const findRate = await prisma.rates_products.findMany({
            where: {
                maSanPham: String(maSanPham)
            },
            include: {
                danhGia: true
            }
        });

        res.status(200).json({data: findRate})

    } catch (err) {
        res.status(500).json(err);
    };
};

const createRate = async (req, res) => {
    try {

        const { soSao, maSanPham } = req.body;

        const findProduct = await prisma.products.findFirst({
            where: {
                maSanPham: String(maSanPham)
            }
        });

        if (!findProduct) {
            return res.status(404).json({message: message.NOT_FOUND});
        };

        if(soSao > 5) {
            return res.status(404).json({message: "Số sao không lớn hơn 5 !"})
        }

        const data = await prisma.rates.create({
            data: {
                soSao: soSao * 1,
                sanPham: {
                    create: {
                        maSanPham: String(maSanPham)
                    }
                }
            },
            include: {
                sanPham: {
                    include: {
                        sanPham: true
                    }
                },

            }
        })

        res.status(200).json({data})



    } catch (err) {
        res.status(500).json(err);
    };
};


const deleteRate = async (req, res) => {
    try {

        const { maDanhGia } = req.query;

        const findRate = await prisma.rates.findFirst({
            where: {
                maDanhGia: String(maDanhGia)
            },
            include: {
                sanPham: true
            }
        });

        console.log(findRate)

        if (!findRate) {
            return res.status(404).json({message: message.NOT_FOUND});
        };

        await prisma.rates_products.delete({
            where: {
                maSanPham_maDanhGia: String(findRate.sanPham.maSanPham)
            }
        })

        await prisma.rates.delete({
            where: {
                maDanhGia: String(maDanhGia)
            },
        });

        res.status(200).json({message: message.DELETE})

    } catch (err) {
        res.status(500).json(err);
    };
};

module.exports = {
    getAllRate,
    getDetailRate,
    getRateWithProduct,
    createRate,
    deleteRate
}



