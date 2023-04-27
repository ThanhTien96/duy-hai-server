const { PrismaClient } = require('@prisma/client');
const message = require('../services/message');
const prisma = new PrismaClient();
require('dotenv').config()


const getAllRate = async (req, res) => {
    try {

        const data = await prisma.rates.findMany({
            orderBy: {soSao: 'desc'}
        });

        if(data.length <= 0) {
            return res.status(204).json()
        }

        res.status(200).json({data});

    } catch (err) {
        res.status(500).json(err);
    };
};

const rateProduct = async (req, res) => {
    try {
      const { maSanPham, soSao } = req.query;
  
      if (soSao < 1 || soSao > 5) {
        return res.status(400).json({ message: "Số sao chỉ nhận từ 1 đến 5!" });
      }
  
      const findProduct = await prisma.products.findUnique({
        where: { maSanPham },
        include: { danhGia: true },
      });
  
      if (!findProduct) {
        return res.status(404).json({ message: message.NOT_FOUND });
      }
  
      const existingRating = findProduct.danhGia.find((ele) => ele.soSao === Number(soSao));

      console.log(existingRating)
  
      if (!existingRating) {
        await prisma.rates.create({
          data: { soSao: Number(soSao), maSanPham, soLuotDanhGia: Number(1) },
        });
        return res.status(200).json({ message: "Tạo đánh giá mới thành công!" });
      } else {
        await prisma.rates.update({
          where: { maDanhGia: existingRating.maDanhGia },
          data: { soLuotDanhGia: existingRating.soLuotDanhGia + 1 },
        });
        return res.status(200).json({ message: "Cập nhật đánh giá thành công!" });
      }
    } catch (err) {
      res.status(500).json(err);
    }
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


const deleteRate = async (req, res) => {
    try {
        const { maDanhGia } = req.query;

        const findRate = await prisma.rates.findUnique({
            where: {
                maDanhGia: String(maDanhGia)
            }
        });


        if (!findRate) {
            return res.status(404).json({ message: message.NOT_FOUND });
        }

        await prisma.rates.delete({
            where: {
                maDanhGia: String(maDanhGia)
            },
        });

        res.status(200).json({ message: message.DELETE });
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: message.INTERNAL_SERVER_ERROR });
    }
};

module.exports = {
    getAllRate,
    getDetailRate,
    rateProduct,
    getRateWithProduct,
    deleteRate
}



