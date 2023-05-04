const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
require('dotenv').config();
const fs = require('fs');
const message = require('../services/message');


const getAllContent = async (req, res) => {
    try {

        const findData = await prisma.about_page.findMany({
            include: {
                hinhAnh: true
            }
        });

        const data = findData.map(ele => ({
            ...ele,
            hinhAnh: ele.hinhAnh.map(img => ({
                hinhAnh: process.env.BASE_URL + '/public/aboutImage/' + img.hinhAnh
            }))
        }));

        res.status(200).json({data})

    } catch (err) {
        res.status(500).json(err);
    };
};

const getDetailContent = async (req, res) => {
    try {

        const {id} = req.query;

        const findData = await prisma.about_page.findUnique({
            where: {id},
            include: {
                hinhAnh: true
            }
        });

        if (!findData) {
            return res.status(404).json({message: message.NOT_FOUND});
        };

        const data = {
            ...findData,
            hinhAnh: findData.hinhAnh.map(img => ({
                ...img,
                hinhAnh: process.env.BASE_URL + '/public/aboutImage/' + img.hinhAnh,
            })),
        };

        res.status(200).json({data})

    } catch (err) {
        res.status(500).json(err);
    };
};

const createContent = async (req, res) => {
    try {

        const {files} = req;
        const {noiDung} = req.body;


        const newData = await prisma.about_page.create({
            data: {
                noiDung,
                hinhAnh: {
                    create: files.map(file => {
                        return {hinhAnh: file.filename}
                    })
                }
            },
            include: {
                hinhAnh: true 
            }
        });

        const data = {
            ...newData,
            hinhAnh: newData.hinhAnh.map(img => ({
                ...img,
                hinhAnh: process.env.BASE_URL + '/public/abouImage/' + img.hinhAnh
            }))
        }

        res.status(200).json({data,message: message.CREATE_SUCCESS});

    } catch (err) {

        const {files} = req;

        const directoryPath = process.cwd() + '/public/aboutImage/';

        for (let file of files) {
            if(fs.existsSync(directoryPath + file.filename)) {
                fs.unlinkSync(directoryPath + file.filename);
            };
        };


        res.status(500).json(err);
    };
};

const updateContent = async (req, res) => {
    try {

        const {files} = req;
        const {id} = req.query;
        const {noiDung} = req.body;

        const findData = await prisma.about_page.findUnique({
            where: {id},
            include: {
                hinhAnh: true
            }
        });

        if (!findData) {
            const {files} = req;

            const directoryPath = process.cwd() + '/public/aboutImage/';
    
            for (let ele of files) {
                if (fs.existsSync(directoryPath + ele.filename)) {
                    fs.unlinkSync(directoryPath + ele.filename);
                };
            };
    
            return res.status(404).json({message: message.NOT_FOUND});
        };

        if (files.length > 0) {

            const directoryPath = process.cwd() + '/public/aboutImage/';


            for (let i = 0; i < files.length; i++) {
                
                if (i < findData.hinhAnh.length) {
                    if (fs.existsSync(directoryPath + findData.hinhAnh[i].hinhAnh)) {
                        fs.unlinkSync(directoryPath + findData.hinhAnh[i].hinhAnh);
                    };

                    const update = await prisma.about_image.update({
                        where: {id: findData.hinhAnh[i].id},
                        data: {hinhAnh: files[i].filename}
                    });

                } else {
                    await prisma.about_image.create({
                        data: {
                            maHinhAnh: findData.id,
                            hinhAnh: files[i].filename
                        }
                    })
                }

            };
        };

        await prisma.about_page.update({
            where: {id},
            data: {
                noiDung,
            },

        })

        res.status(200).json({message: message.UPDATE});
        

    } catch (err) {

        const {files} = req;

        const directoryPath = process.cwd() + '/public/aboutImage/';

        for (let ele of files) {
            if (fs.existsSync(directoryPath + ele.filename)) {
                fs.unlinkSync(directoryPath + ele.filename);
            };
        };

        res.status(500).json(err);
    };
};

const deleteContent = async (req, res) => {
    try {

        const {id} = req.query;

        const findData = await prisma.about_page.findUnique({
            where: {id},
            include: {
                hinhAnh: true
            }
        });

        if (!findData) {
            return res.status(404).json({message: message.NOT_FOUND});
        };

        for (let item of findData.hinhAnh) {

            const directoryPath = process.cwd() + '/public/aboutImage/';

            if (fs.existsSync(directoryPath + item.hinhAnh)) {

                fs.unlinkSync(directoryPath + item.hinhAnh);

            };

            await prisma.about_image.delete({
                where: {
                    id: item.id
                }
            });
        };

        await prisma.about_page.delete({
            where: {id},
            
        });

        res.status(200).json({message: message.DELETE});
    

    } catch (err) {
        res.status(500).json(err);
    };
};

module.exports = {
    getAllContent,
    getDetailContent,
    createContent,
    updateContent,
    deleteContent,
}