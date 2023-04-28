const { PrismaClient } = require('@prisma/client');
const message = require('../services/message');
const prisma = new PrismaClient();


const getAllContact = async (req, res) => {
    try {

        const data = await prisma.contacts.findMany({
            orderBy: {createAt: 'desc'},
            include: {
                trangThai
            }
        });

        if (data.length <=0 ) {
            res.status(204).json()
        }

        res.status(200).json({data})

    } catch (err) {
        res.status(500).json(err);
    };
};

const getDetailContact = async (req, res) => {
    try {

        const { maLienHe } = req.query;

        const findContact = await prisma.contacts.findFirst({
            where: {
                maLienHe: String(maLienHe)
            }
        });

        if ( !findContact ) {
            return res.status(404).json({message: message.NOT_FOUND});
        };

        res.status(200).json({data: findContact})

    } catch (err) {
        res.status(500).json(err);
    };
};

const createContact = async (req, res) => {
    try {

        const { hoTen, soDT, diaChi, chuDe, noiDung, hinhAnh, maTrangThai } = req.body;

        const data = await prisma.contacts.create({
            data: { hoTen, soDT, diaChi, chuDe, noiDung, hinhAnh, maTrangThai },
        });


        res.status(200).json({data})

    } catch (err) {
        res.status(500).json(err);
    };
};

const updateContact = async (req, res) => {
    try {

        const { maLienHe } = req.query;
        const { hoTen, soDT, diaChi, chuDe, noiDung, hinhAnh } = req.body;

        const findContact = await prisma.contacts.findFirst({
            where: {
                maLienHe: String(maLienHe)
            },
        });

        if ( !findContact ) { 
            return res.satus(404).json({message: message.NOT_FOUND});
        };

        const data = await prisma.contacts.update({
            where: {
                maLienHe: String(maLienHe),
            },
            data: { hoTen, soDT, diaChi, chuDe, noiDung, hinhAnh }
        });

        res.status(200).json({data, message: message.UPDATE})

    } catch (err) {
        res.status(500).json(err);
    };
};

const deleteContact = async (req, res) => {
    try {

        const { maLienHe } = req.query;

        const findContact = await prisma.contacts.findFirst({
            where: {
                maLienHe: String(maLienHe)
            },
        });

        if( !findContact ) {
            return res.status(404).json({message: message.NOT_FOUND})
        }

        await prisma.contacts.delete({
            where: {
                maLienHe: String(maLienHe),
            },
        });

        res.status(200).json({message: message.DELETE})

    } catch (err) {
        res.status(500).json(err);
    };
};


const createContactStatus = async (req, res) => {
    try { 

        const { trangThai, role } = req.body;
        
        const data = await prisma.contac_status.create({
            data: { trangThai, role: Number(role) }
        });

        res.status(200).json({data})

    } catch (err) {
        res.status(500).json(err);
    };
};

module.exports = {
    getAllContact,
    getDetailContact,
    createContact,
    updateContact,
    deleteContact,


    createContactStatus,
}