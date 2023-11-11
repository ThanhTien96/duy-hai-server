const { PrismaClient } = require('@prisma/client');
const message = require('../services/message');
const prisma = new PrismaClient();
const fs = require('fs')




const getAllYT = async (req, res) => {
    try {
        const arrayData = await prisma.ytview.findMany({
            orderBy: { createAt: 'desc' }
        });


        if (arrayData.length <= 0) {
            res.status(204).json()
        };

        const data = arrayData.map(ele => ({
            ...ele,
            hinhAnh: process.env.SERVER_URL + '/public/youtubeImage/' + ele.hinhAnh,
        }))

        res.status(200).json({ data })

    } catch (err) {
        res.status(500).json(err);
    };
};


const getDetailYT = async (req, res) => {
    try {

        const { maYT } = req.query;

        const findData = await prisma.ytview.findFirst({
            where: { maYT }
        });

        if (!findData) {
            return res.status(404).json({ message: message.NOT_FOUND });
        };

        const data = {
            ...findData,
            hinhAnh: process.env.SERVER_URL + '/public/youtubeImage/' + findData.hinhAnh,
        }

        res.status(200).json({ data });

    } catch (err) {
        res.status(500).json(err);
    };
};

const createYT = async (req, res) => {
    try {

        const { tieuDe, url, embedLink } = req.body;
        const { filename } = req.file;

        const data = await prisma.ytview.create({
            data: {
                tieuDe,
                url,
                embedLink,
                hinhAnh: filename
            }
        });

        res.status(200).json({ data, message: message.CREATE_SUCCESS });

    } catch (err) {
        res.status(500).json(err);
    };
};

const updateYT = async (req, res) => {
    try {
        const { maYT } = req.query;
        const { tieuDe, url, embedLink } = req.body;

        const { filename } = req.file;
        const directoryPath = process.cwd() + '/public/youtubeImage/';


        const find = await prisma.ytview.findFirst({
            where: { maYT }
        });

        if (!find) {
            if (fs.existsSync(directoryPath + filename)) {
                fs.unlinkSync(directoryPath + filename);
            };
            return res.status(404).json({ message: message.NOT_FOUND });
        };



        if (fs.existsSync(directoryPath + find.hinhAnh)) {
            fs.unlinkSync(directoryPath + find.hinhAnh);
        };
        if(filename) {
            await prisma.ytview.update({
                where: { maYT: String(maYT) },
                data: {
                    tieuDe,
                    url,
                    embedLink,
                    hinhAnh: filename 
                },
            });
        } else {
            await prisma.ytview.update({
                where: { maYT: String(maYT) },
                data: {
                    tieuDe,
                    url,
                    embedLink,
                },
            });
        }
        

        res.status(200).json({ message: message.UPDATE });

    } catch (err) {

        const { filename } = req.file

        const directoryPath = process.cwd() + '/public/youtubeImage/';

        if (fs.existsSync(directoryPath + filename)) {
            fs.unlinkSync(directoryPath + filename);
        };
        res.status(500).json(err);
    };
};

const deleteYT = async (req, res) => {
    try {

        const { maYT } = req.query;

        const find = await prisma.ytview.findFirst({
            where: { maYT },
        });

        const directoryPath = process.cwd() + '/public/youtubeImage/';

        if (fs.existsSync(directoryPath + find.hinhAnh)) {
            fs.unlinkSync(directoryPath + find.hinhAnh);
        };

        if (!find) {
            return res.status(404).json({ message: message.NOT_FOUND });
        };

        await prisma.ytview.delete({ where: { maYT } });

        res.status(200).json({ message: message.DELETE });

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

