const { PrismaClient } = require('@prisma/client');
const message = require('../services/message');
const prisma = new PrismaClient();

require('dotenv').config;



const getAllOrders = async (req, res) => {
    try {


        const newData = await prisma.orders.findMany({
            include: {
                sanPham: {
                    include: {
                        sanPham: {
                            include: {
                                hinhAnh: true
                            }
                        }
                    }
                },
                trangThai: true,
            }
        })

        if (newData.length <= 0) {
            return res.status(204).json()
        }

        const data = newData.map(order => ({
            ...order,
            sanPham: order.sanPham.map(prod => ({
                soLuongSanPham: prod.soLuongSanPham,
                sanPham: {
                    ...prod.sanPham,
                    hinhAnh: prod.sanPham.hinhAnh.map(img => ({
                        id: img.id,
                        hinhAnh: process.env.BASE_URL + '/public/images/' + img.hinhAnh,
                    }))
                }
            }))
        }))

        res.status(200).json({ data })

    } catch (err) {
        res.status(500).json(err);
    };
};

const getDetailOrder = async (req, res) => {
    try {

        const { maDonHang } = req.query;

        const findOrderDetail = await prisma.orders.findFirst({
            where: {
                maDonHang: String(maDonHang)
            },
            include: {
                trangThai: true,
                sanPham: {
                    include: {
                        sanPham: {
                            include: {
                                hinhAnh: true
                            }
                        }
                    }
                }
            }
        });

        if (!findOrderDetail) {
            return res.status(404).json({ message: "Không tìm thấy" });
        };

        const data = {
            ...findOrderDetail,
            sanPham: findOrderDetail.sanPham.map(prod => ({
                ...prod,
                sanPham: {
                    ...prod.sanPham,
                    hinhAnh: prod.sanPham.hinhAnh.map(img => ({
                        ...img,
                        hinhAnh: process.env.BASE_URL + '/public/images/' + img.hinhAnh
                    }))
                }
            }))
        }

        res.status(200).json({ data })

    } catch (err) {
        res.status(500).json(err);
    };
};

const createOrder = async (req, res) => {
    try {

        const { tenKhachHang, diaChi, soDT, loiNhan, sanPham, maTrangThai } = req.body;

        // Tìm thông tin sản phẩm trong database
        const findProducts = await prisma.products.findMany({
            where: {
                maSanPham: {
                    in: sanPham.map((p) => p.maSanPham),
                },
            },
        });


        for (let prod of sanPham) {

            const findProd = await prisma.products.findFirst({
                where: { maSanPham: String(prod.maSanPham) }
            });

            if (!findProd) {
                return res.status(404).json({ message: message.NOT_FOUND });
            };

        };



        // Tính tổng giá của đơn hàng
        const tongTien = sanPham.reduce(
            (total, { maSanPham, soLuong }) =>
                total + soLuong * findProducts.find((p) => p.maSanPham === maSanPham).giaGiam,
            0
        );

        // Tìm trạng thái của đơn hàng trong database
        const status = await prisma.status.findFirst({
            where: { maTrangThai },
        });

        if (!status) {
            return res.status(404).json({ message: "Không tìm thấy trạng thái đơn hàng!" });
        }

        const findPriority = await prisma.priority.findMany();



        if (findPriority.length <= 0) {
            return res.status(404).json({ message: "Không tìm thấy độ ưu tiên !" })
        }



        // Tạo đơn hàng mới trong database
        const newOrder = await prisma.orders.create({
            data: {
                tenKhachHang,
                diaChi,
                soDT,
                loiNhan,
                tongTien,
                maTrangThai,
                maDoUuTien: String(findPriority.find(ele => ele.role === 2).id),
                sanPham: {
                    create: sanPham.map((p) => ({
                        maSanPham: String(p.maSanPham),
                        soLuongSanPham: Number(p.soLuong),
                    })),
                },
            },
            include: {
                sanPham: {
                    include: {
                        sanPham: {
                            include: {
                                hinhAnh: true
                            }
                        }
                    }
                },
                trangThai: true,
                doUuTien: true
            },
        });



        const data = {
            ...newOrder,
            sanPham: newOrder.sanPham.map(products => ({
                maSanPham: products.maSanPham,
                soLuongSanPham: products.soLuongSanPham,
                sanPham: {
                    ...products.sanPham,
                    hinhAnh: products.sanPham.hinhAnh.map(file => ({
                        ...file,
                        hinhAnh: process.env.BASE_URL + '/public/images/' + file.hinhAnh,
                    }))
                }
            }))
        }

        res.status(200).json({ data, message: 'Tạo đơn hàng thành công !' });
    } catch (err) {
        res.status(500).json(err);
    }
};


const updateStatusOrder = async (req, res) => {
    try {

        const { maTrangThai } = req.body;
        const { maDonHang } = req.query;

        const find = await prisma.orders.findFirst({
            where: {
                maDonHang: String(maDonHang)
            },
            include: {
                sanPham: {
                    include: {
                        sanPham: {
                            include: {
                                hinhAnh: true
                            }
                        }
                    }
                },
                trangThai: true,
            }
        });



        if (!find) {
            return res.status(404).json({ message: message.NOT_FOUND })
        }

        const newData = await prisma.orders.update({
            where: {
                maDonHang: String(maDonHang)
            },
            data: {
                maTrangThai: String(maTrangThai)
            },
            include: {
                sanPham: {
                    include: {
                        sanPham: {
                            include: {
                                hinhAnh: true
                            }
                        }
                    }
                },
                trangThai: true
            }
        });



        if (newData.trangThai.role === 2) {

            

            if (find.sanPham.length > 0) {
                console.log('vo đay')
                for (let i = 0; i < sanPham.length; i++) {

                    const checkProduct = await prisma.products.findFirst({
                        where: {
                            maSanPham: String(sanPham[i].maSanPham)
                        }
                    });

                    if (checkProduct.tongSoLuong <= 0) {
                        return res.status(404).json({ message: message.EMTY_QUANTITY })
                    }

                    await prisma.products.update({
                        where: { maSanPham: String(sanPham[i].maSanPham) },
                        data: {
                            tongSoLuong: {
                                decrement: Number(sanPham[i].soLuong),
                            },
                        },
                    });
                }
            }

        }




        const data = {
            ...newData,
            sanPham: newData.sanPham.map(prod => ({
                soLuongSanPham: prod.soLuongSanPham,
                sanPham: {
                    ...prod.sanPham,
                    hinhAnh: prod.sanPham.hinhAnh.map(img => ({
                        id: img.id,
                        hinhAnh: process.env.BASE_URL + '/public/images/' + img.hinhAnh
                    }))
                }
            }))
        }



        res.status(200).json({ data, message: message.UPDATE })

    } catch (err) {
        res.status(500).json(err)
    };
};


const deleteOrder = async (req, res) => {
    try {

        const { maDonHang } = req.query;


        const findOrder = await prisma.orders.findFirst({
            where: {
                maDonHang: String(maDonHang)
            },
            include: {
                sanPham: true
            }
        });

        if (!findOrder) {
            return res.status(404).json({ message: message.NOT_FOUND })
        }

        if (findOrder.sanPham.length > 0) {
            await prisma.orders_products.deleteMany({
                where: {
                    maDonHang: String(maDonHang)
                }
            })
        }

        await prisma.orders.delete({
            where: {
                maDonHang: String(maDonHang)
            }
        });

        res.status(200).json({ message: message.DELETE })
    } catch (err) {
        res.status(500).json(err);
    };
};


module.exports = {
    getAllOrders,
    getDetailOrder,
    createOrder,
    updateStatusOrder,
    deleteOrder,
}