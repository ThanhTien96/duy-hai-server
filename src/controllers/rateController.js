const { PrismaClient } = require('@prisma/client');
const message = require('../services/message');
const prisma = new PrismaClient();
require('dotenv').config()


const getAllRate = async (req, res) => {
    try {

        const data = await prisma.rates.findMany({
            include:{
                sanPham: {
                    include:{
                        sanPham: true
                    }
                }
            },
            orderBy: { soSao: 'desc'}
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

const rateProduct = async (req, res) => {
    try {
      const { maDanhGia, maSanPham } = req.query;
  
      const product = await prisma.products.findUnique({
        where: { maSanPham },
      });
  
      if (!product) {
        return res.status(404).json({ message: message.NOT_FOUND });
      }
  
      const rate = await prisma.rates.findUnique({
        where: { maDanhGia },
        include: { sanPham: true },
      });
  
      if (!rate) {
        return res.status(404).json({ message: message.NOT_FOUND });
      }
  
      const existingRateProduct = await prisma.rates_products.findUnique({
        where: {
          maDanhGia_maSanPham: {
            maDanhGia: rate.maDanhGia,
            maSanPham: product.maSanPham,
          },
        },
      });
  
      if (!existingRateProduct) {
        await prisma.rates_products.create({
          data: {
            maDanhGia: rate.maDanhGia,
            maSanPham: product.maSanPham,
          },
        });
      } else {
        await prisma.rates_products.update({
          where: {
            maDanhGia_maSanPham: {
              maDanhGia: rate.maDanhGia,
              maSanPham: product.maSanPham,
            },
          },
          data: {
            maDanhGia: rate.maDanhGia,
            maSanPham: product.maSanPham,
          },
        });
      }
  
      res.status(200).json({ message: message.UPDATE });
    } catch (err) {
      console.error(err);
      res.status(500).json({ message: message.INTERNAL_SERVER_ERROR });
    }
  };

const createRate = async (req, res) => {
    try {

        const { soSao } = req.body;

        if(soSao <= 0 || soSao > 5) {
            return res.status(400).json({message: 'Số sao chỉ nhận từ 1 đến 5!'});
        };


        const data = await prisma.rates.create({
            data: {
                soSao: soSao * 1,
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

        const findRate = await prisma.rates.findUnique({
            where: {
                maDanhGia: String(maDanhGia)
            },
            include: {
                sanPham: true
            }
        });

        console.log(findRate)

        if (!findRate) {
            return res.status(404).json({ message: message.NOT_FOUND });
        }

        await prisma.rates_products.deleteMany({
            where: {
                danhGia: {
                    maDanhGia: String(maDanhGia)
                }
            }
        });

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
    getRateWithProduct,
    rateProduct,
    createRate,
    deleteRate
}



