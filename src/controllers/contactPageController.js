
const { PrismaClient } = require('@prisma/client')
const prisma = new PrismaClient();
const message = require('../services/message');

/** get all */
const getAllContactPage = async (req, res) => {
    try {
        const data = await prisma.contact_page.findMany();
        res.status(200).json({data})

    } catch (err) {
        return res.status(500).json(err)
    }
}

const getAContactPage = async (req, res) => {
    try {
        const find = await prisma.contact_page.findUnique({where: {id: req.query.id}});
        if(!find) {
            return res.status(404).json({message: message.NOT_FOUND});
        };

        return res.status(200).json({data: find});
    } catch (err) {
        res.status(500).json(err)
    }
}

const createContactPage = async (req, res) => {
    try {
        const {title, content} = req.body;
        await prisma.contact_page.create({data: {title, content}});

        res.status(200).json({message: message.CREATE_SUCCESS});

    } catch (err) {
        return res.status(500).json(err);
    }
}

const updateContactPage = async (req, res) => {
    try {
        const {title, content}= req.body;
        const find = await prisma.contact_page.findUnique({where: {id: req.query.id}});
        if(!find) {
            return res.status(404).json({message: message.NOT_FOUND});
        };

        await prisma.contact_page.update({
            where: {id: find.id},
            data: {title, content}
        });

        res.status(200).json({message: message.UPDATE});

    } catch (err) {
        return res.status(500).json(err)
    }
}

const deleteContactPage = async (req, res) => {
    try {
        await prisma.contact_page.delete({where: {id: req.query.id}})
        res.status(200).json({message: message.DELETE})
    } catch (err) {
        return res.status(500).json(err);
    }
}

module.exports = {
    getAllContactPage,
    getAContactPage,
    createContactPage,
    updateContactPage,
    deleteContactPage
}
