const { PrismaClient } = require('@prisma/client');
const message = require('../services/message');
const prisma = new PrismaClient();




const getAllYT = async (req, res) => {
    try {
        const data = await prisma.ytview.findMany();

        if(data.length <= 0 ) {
            res.status(204).json()
        };

        res.status(200).json({data})

    } catch (err) {
        res.status(500).json(err);
    };
};


const getDetailYT = async (req, res) => {
    try {

        const {maYT} = req.query;

        const findData = await prisma.ytview.findFirst({
            where: { maYT }
        });

        if ( !findData ) {
            return res.status(404).json({message: message.NOT_FOUND});
        };

        res.status(200).json({data: findData});

    } catch (err) {
        res.status(500).json(err);
    };
};

const createYT = async (req, res) => {
    try {

        const {tieuDe, link, hinhAnh} = req.body;

        const data = await prisma.ytview.create({
            data: {tieuDe, url: link, hinhAnh}
        });

        res.status(200).json({data, message: message.CREATE_SUCCESS});

    } catch (err) {
        res.status(500).json(err);
    };
};

const updateYT = async (req, res) => {
    try {
        const {maYT} = req.query;
        const {tieuDe, link, hinhAnh} = req.body;

        const find = await prisma.ytview.findFirst({
            where: {maYT}
        });

        if (!find) {
            return res.status(404).json({message: message.NOT_FOUND});
        };

        const updateData = await prisma.ytview.update({
            where: {maYT: String(maYT)},
            data: {tieuDe, url: link, hinhAnh},
        });

        res.status(200).json({data: updateData, message: message.UPDATE});

    } catch (err) {
        res.status(500).json(err); 
    };
};

const deleteYT = async(req, res) => {
    try {

        const {maYT} = req.query;

        const find = await prisma.ytview.findFirst({
            where: {maYT}
        });

        if (!find) {
            return res.status(404).json({message: message.NOT_FOUND});
        };

        await prisma.ytview.delete({where: {maYT}});

        res.status(200).json({message: message.DELETE});

    } catch (err) {
        res.status(500).json(err);
    };
};

module.exports = {
    getAllYT,
    getDetailYT,
    createYT,
    updateYT,
    deleteYT,
}

