const { PrismaClient } = require('@prisma/client');
const message = require('../services/message');
const prisma = new PrismaClient();


const getAllContact = async (req, res) => {
    try {

        const data = await prisma.contacts.findMany({
            orderBy: {createAt: 'desc'},
            include: {
                trangThai: true
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
            },
            include: {
                trangThai: true
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

        const { hoTen, soDT, diaChi, chuDe, noiDung, hinhAnh } = req.body;

        const findStatus = await prisma.contact_status.findUnique({
            where: {role: 1}
        });

        const data = await prisma.contacts.create({
            data: { hoTen, soDT, diaChi, chuDe, noiDung, hinhAnh, maTrangThai: findStatus.id },
        });

        
        await prisma.notification.create({
            data: {
                title: `liên hệ mới`,
                subTitle: `khách hàng liên hệ cẫn hỗ trợ`,
                rootTitle: hoTen, 
            }
        })

        res.status(200).json({data})

    } catch (err) {
        res.status(500).json(err);
    };
};

const updateContactWithStatus = async (req, res) => {
    try {

        const { maLienHe, maTrangThai } = req.query;

        const findContact = await prisma.contacts.findFirst({
            where: {
                maLienHe: String(maLienHe)
            },
        });

        if ( !findContact ) { 
            return res.satus(404).json({message: message.NOT_FOUND});
        };

        await prisma.contacts.update({
            where: {
                maLienHe: String(maLienHe),
            },
            data: { maTrangThai }
        });

        res.status(200).json({message: message.UPDATE})

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

/****** trang thai lien he *******/
const getAllContactStatus = async (req, res) => {
    try {

        const allData = await prisma.contact_status.findMany({
            orderBy: {role: 'asc'}
        });

        if (allData.length <= 0) {
            return res.status(204).json();
        };

        res.status(200).json({data: allData});

    } catch (err) {
        res.status(500).json(err);
    };
};


const getDetailContactStatus = async (req, res) => {
    try {

        const { id } = req.query;
        
        const data = await prisma.contact_status.findUnique({
            where: {id}
        });

        if (!data) {
            return res.status(404).json({message: message.NOT_FOUND});
        };

        res.status(200).json({data})



    } catch (err) {
        res.status(500).json(err);
    };
};



const createContactStatus = async (req, res) => {
    try { 

        const { trangThai, role } = req.body;
        
        const data = await prisma.contact_status.create({
            data: { trangThai, role: Number(role) }
        });

        res.status(200).json({data});

    } catch (err) {
        res.status(500).json(err);
    };
};

const updateContactStatus = async (req, res) => {
    try {

        const {id} = req.query;
        const { role, trangThai} = req.body;

        const findData = await prisma.contact_status.findUnique({
            where: {id}
        });

        if (!findData) {
            return res.status(404).json({message: message.NOT_FOUND});
        };

        await prisma.contact_status.update({
            where: {id},
            data: {role: role && Number(role), trangThai}
        });

        res.status(200).json({message: message.UPDATE});

    } catch (err) {
        res.status(500).json(err);
    };
};

const deleteContactStatus = async (req, res) => {
    try {

        const {id} = req.query;

        const findData = await prisma.contact_status.findUnique({
            where: {id}
        });

        if (!findData) {
            return res.status(404).json({message: message.NOT_FOUND})
        };

        await prisma.contact_status.delete({
            where: {id}
        });

        res.status(200).json({message: message.DELETE});

    } catch (err) {
        res.status(500).json(err);
    };
};

module.exports = {
    getAllContact,
    getDetailContact,
    createContact,
    updateContactWithStatus,
    deleteContact,

    getAllContactStatus,
    getDetailContactStatus,
    createContactStatus,
    updateContactStatus,
    deleteContactStatus,
}