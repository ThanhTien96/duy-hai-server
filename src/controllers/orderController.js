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
                doUuTien: true,
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


        /** tim don hang tu database */

        const findOrder = await prisma.orders.findFirst({
            where: {
                maDonHang: String(maDonHang),
            },
            include: {
                trangThai: true
            }
        });



        /** kiem tra trang thai co ton tai trong db */
        const checkStatus = await prisma.status.findFirst({
            where: {
                maTrangThai: String(maTrangThai)
            }
        })

        /** khong tim thay thi send message */

        if (!findOrder) {
            return res.status(404).json({ message: message.NOT_FOUND });

        } else if (findOrder.trangThai.role !== 4) {

            if (findOrder.trangThai.role >= checkStatus.role) {
                return res.status(400).json({ message: "Vòng đời trạng thái đơn không đúng !" })
            }

        }

        /** khong thay thi return */

        if (!checkStatus) {
            return res.status(404).json({ message: message.NOT_FOUND })
        }

        /** update don hang */

        const updateData = await prisma.orders.update({
            where: {
                maDonHang: String(maDonHang)
            },
            data: {
                maTrangThai: String(maTrangThai)
            },
            include: {
                doUuTien: true,
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


        /** kiem tra so luong va updat lai tong so luong ben san pham ***/

        if (updateData && updateData.sanPham.length > 0 && updateData.trangThai.role === 2) {

            for (let i of updateData.sanPham) {

                const findProd = await prisma.products.findFirst({
                    where: {
                        maSanPham: String(i.sanPham.maSanPham)
                    }
                });

                console.log(findProd)

                if (!findProd) {

                    return res.status(404).json({ message: "Không tìm thấy sản phẩm !" })
                }
                else {

                    if (findProd.tongSoLuong <= 0) {
                        return res.status(400).json({message: "Sản phẩm tạm hết hàng !"})
                    }
                    await prisma.products.update({
                        where: {
                            maSanPham: String(i.sanPham.maSanPham)
                        },
                        data: {
                            tongSoLuong: {
                                decrement: i.soLuongSanPham
                            }
                        }
                    })
                }

            }
        }

        res.status(200).json({ message: message.UPDATE })

    } catch (err) {
        res.status(500).json(err)
    };
};


const updatePriorityOrder = async (req, res) => {
    try {

        const { maDonHang } = req.query;
        const { maDoUuTien } = req.body;

        const findOrder = await prisma.orders.findFirst({
            where: {
                maDonHang: String(maDonHang)
            },
        });

        if (!findOrder) {
            return res.status(404).json({message: message.NOT_FOUND})
        }

        const findPriority = await prisma.priority.findFirst({
            where: {
                id: String(maDoUuTien)
            }
        });

        if (!findPriority) {
            return res.status(404).json({message: message.NOT_FOUND});
        };

        await prisma.orders.update({
            where: {
                maDonHang: String(maDonHang)
            },
            data: {
                maDoUuTien: String(maDoUuTien)
            }
        });

        res.status(200).json({message: message.UPDATE})



    } catch (err) {
        res.status(500).json(err);
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
    updatePriorityOrder,
    deleteOrder,
}