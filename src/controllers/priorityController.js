const { PrismaClient } = require('@prisma/client');
const message = require('../services/message');
const prisma = new PrismaClient();


const getAllPriority = async(req, res) => {
    try {

        const newData = await prisma.priority.findMany({orderBy: {role: 'asc'}});

        if(newData.length <= 0) {
            res.status(204).json()
        }

        res.status(200).json({data: newData})

    } catch (err) {
        res.status(500).json(err);
    };
};


const getDetailPriority = async (req, res) => {
    try {

        const { maDoUuTien } = req.query;

        const data = await prisma.priority.findFirst({
            where: {id: String(maDoUuTien)},
            include: {
                donHang: {
                    include:{ 
                        sanPham: true,
                        trangThai: true,
                    }
                },
            }
        });

        if (!data) {
            res.status(404).json({message: message.NOT_FOUND})
        } else {
            res.status(200).json({data})
        }

    } catch (err) {
        res.status(500).json(err);
    };
};

const createPriority = async(req, res) => {
    try {
        const { doUuTien, role } = req.body;

        const newData = await prisma.priority.create({
            data: {
                doUuTien: String(doUuTien),
                role: role * 1
            }
        })

        res.status(200).json({data: newData})
    } catch (err) {
        res.status(500).json(err)
    }
};

const updatePriority = async (req, res) => {
    try {

        const { maDoUuTien } = req.query;
        const { doUuTien } = req.body;

        const findData = await prisma.priority.findFirst({
            where: {
                id: String(maDoUuTien)
            }
        });

        if (!findData) {
            res.status(404).json({message: message.NOT_FOUND})
        };

        const dataUpdate = await prisma.priority.update({
            where: {
                id: String(maDoUuTien)
            },
            data: {doUuTien}
        })

        res.status(200).json({data: dataUpdate, message: message.UPDATE});

    } catch (err) {
        res.status(500).json(err);
    };
};

const deletePriority = async (req, res) => {
    try {

        const { maDoUuTien } = req.query;

        const findData = await prisma.priority.findFirst({
            where: {
                id: String(maDoUuTien),
            },
        });

        if (!findData) {
            res.status(404).json({message: message.NOT_FOUND})
        } else {
            
            await prisma.priority.delete({
                where: {id: String(maDoUuTien)}
            });
            res.status(200).json({message: message.DELETE})

        }

        

    } catch (err) {
        res.status(500).json(err);
    };
};

module.exports = {
    getAllPriority,
    createPriority,
    getDetailPriority,
    updatePriority,
    deletePriority,
}