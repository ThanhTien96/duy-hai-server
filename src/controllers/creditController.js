const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
const message = require('../services/message');

const getAllCredit = async (req, res) => {
    try {

        const data = await prisma.credit.findMany();

        if (data.length <= 0) {
            res.status(204).json();
        };

        res.status(200).json({data})

    } catch (err) {
        res.status(500).json(err);
    };
};

const getDetailCredit = async (req, res) => {
    try {

        const {id} = req.query;

        const findData = await prisma.credit.findFirst({
            where: {id}
        });

        if (!findData) {
            return res.status(404).json({message: message.NOT_FOUND});
        };

        res.status(200).json({data: findData});

    } catch (err) {
        res.status(500).json(err);
    };
};

const createCredit = async (req, res) => {
    try {

        const {chuTaiKhoan, nganHang, soTaiKhoan, chiNhanh, soDT} = req.body;


        const newData = await prisma.credit.create({
            data: {chuTaiKhoan, nganHang, soTaiKhoan, chiNhanh, soDT}
        })

        res.status(200).json({data: newData, message: message.CREATE_SUCCESS})

    } catch (err) {
        res.status(500).json(err);
    };
};

const updateCredit = async(req, res) => {
    try {
        const {id} = req.query;
        const {chuTaiKhoan, nganHang, soTaiKhoan, chiNhanh, soDT} = req.body;
        
        const find = await prisma.credit.findFirst({
            where: {id}
        });

        if ( !find ) {
            return res.status(404).json({message: message.NOT_FOUND});
        };

        await prisma.credit.update({
            where: {id},
            data: {chuTaiKhoan, nganHang, soTaiKhoan, chiNhanh, soDT}
        })

        res.status(200).json({message: message.UPDATE});

    } catch (err) {
        res.status(500).json(err);
    };
};

const deleteCredit = async (req, res) => {
    try {

        const {id} = req.query;

        const findCard = await prisma.credit.findFirst({where: {id}});
        
        if(!findCard) {
            return res.status(404).json({message: message.DELETE});
        }

        await prisma.credit.delete({ where: {id} });

        res.status(200).json({message: message.DELETE});

    } catch (err) {
        res.status(500).json(err);
    };
};

module.exports = {
    getAllCredit,
    getDetailCredit,
    createCredit,
    updateCredit,
    deleteCredit
}
