const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
require('dotenv').config();

const getAllStatus = async (req, res) => {
    const {orders} = req.query;
    try {

        const newData = await prisma.status.findMany({
            orderBy: {role: 'asc'},
            include: orders && orders === "true" ? {
                donHang: {
                    orderBy: {
                        createAt: "desc"
                    },
                    include: {
                        trangThai: true
                    }
                },
            } : false,
        });

        res.status(200).json({data:newData})

    } catch(err) {
        res.status(500).json(err);
    };
};

const getStatusDetail = async (req, res) => {
    try {

        const { maTrangThai } = req.query;

        const data = await prisma.status.findFirst({
            where: {maTrangThai: String(maTrangThai)},
            include: {
                donHang: {
                    orderBy: {createAt: 'desc'}
                },
            }
        });

        res.status(200).json({data});

    } catch (err) {
        res.status(500).json(err);
    };
};


const createStatus = async (req, res) => {

    try {

        const { trangThai, role  } = req.body;


        const find = await prisma.status.findFirst({
            where: {
                trangThai: String(trangThai),
            }
        });


        if (find) {
            return res.status(404).json({message: "Trạng thái đã tồn tại !"})
        }

        const data = await prisma.status.create({
            data: {trangThai,role: role * 1 },
        })

        res.status(200).json({data})

    } catch (err) {
        res.status(500).json(err);
    };
};

const updateStatus = async (req, res) => {
    try {

        const { maTrangThai } = req.query;
        const { trangThai, role } = req.body;

        const find = await prisma.status.findFirst({
            where: {
                maTrangThai: String(maTrangThai),
            },
        });

        if (!find) {
            return res.status(404).json({message: "Không tìm thấy !"});
        };

        const data = await prisma.status.update({
            where: {
                maTrangThai: String(maTrangThai),
            },
            data: {
                trangThai, role: role && role * 1
            }
        })

        res.status(200).json({data});

    } catch (err) {
        res.status(500).json(err);
    };
};


const deleteStatus = async (req, res) => {
    try {

        const { maTrangThai } = req.query;
        
        const find = await prisma.status.findFirst({
            where: {
                maTrangThai: String(maTrangThai),
            },
        });

        if (!find) {
            return res.status(404).json({message: "Không tìm thấy !"});
        };

        await prisma.status.delete({
            where: {maTrangThai: String(maTrangThai)},
        });

        res.status(200).json({message: "Xóa thành công !"})

    } catch (err) {
        res.status(500).json(err);
    };
};


module.exports = {
    getAllStatus,
    getStatusDetail,
    createStatus,
    updateStatus,
    deleteStatus
}
