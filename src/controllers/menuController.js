const { PrismaClient } = require('@prisma/client')
const prisma = new PrismaClient();
require('dotenv').config();
const fs = require('fs');
const message = require('../services/message');

/////////////////////////////////////////////////////////////////
///////////////////////  MENU   ////////////////////////////////
///////////////////////////////////////////////////////////////

////    GET MENU WITH MA MENU   ////
const getMenu = async (req, res) => {

    try {

        const findMenu = await prisma.menu.findMany({
            include: {
                navlink: true
            }
        });

        if (findMenu.length <= 0) {
            return res.status(204).json()
        };

        const data = findMenu.map(ele => ({
            maMenu: ele.maMenu,
            logo: process.env.BASE_URL + '/public/logo/' + ele.logo,
            navlink: ele.navlink.map(link => ({
                maNavLink: link.maNavLink,
                tenNavLink: link.tenNavLink,
                url: link.url
            }))
        }));

        res.status(200).json({ data });

    } catch (err) {
        res.status(500).json({ message: 'server is error', err })
    }
}

const getDetailMenu = async (req, res) => {
    try {

        const {maMenu} = req.query;

        const findMenu = await prisma.menu.findFirst({
            where: {maMenu},
            include: {
                navlink: true
            }
        });

        const data = {
            maMenu: findMenu.maMenu,
            logo: process.env.BASE_URL + '/public/logo/' + findMenu.logo,
            navlink: {
                ...findMenu.navlink
            }
        };

        if( !findMenu ) {
            res.status(404).json({message: message.NOT_FOUND});
        };

        res.status(200).json({data});

    } catch (err) {
        res.status(500).json(err);
    };
};


////    CREATE MENU     /////
const createMenu = async (req, res) => {
    try {

        const { file } = req;

        const createMenu = await prisma.menu.create({ data: { logo: file.filename } })

        res.status(200).json({ data: createMenu, message: 'Thêm menu thành công !!!' })


    } catch (err) {
        res.status(500).json(err)
    }
}

////    UPDATE MENU     ////
const updateMenu = async (req, res) => {
    try {

        const { maMenu } = req.query;

        const findMenu = await prisma.menu.findFirst({
            where: { maMenu }
        });

        if (!findMenu) {
            return res.status(404).json({ message: message.NOT_FOUND });
        };

        const directoryPath = process.cwd() + '/public/logo/'

        if (fs.existsSync(directoryPath + findMenu.logo)) {
            fs.unlinkSync(directoryPath + findMenu.logo);
        };

        const data = await prisma.menu.update({
            where: { maMenu: String(maMenu) },
            data: { logo: req.file.filename }
        });

        res.status(200).json({ message: message.UPDATE })


    } catch (err) {

        res.status(500).json(err);

    };
};


////    DELETE MENU     ////
const deleteMenu = async (req, res) => {
    try {

        const { maMenu } = req.query;


        const find = await prisma.menu.findFirst({
            where: { maMenu: String(maMenu) }
        });


        if (!find) {
            return res.status(404).json({ message: message.NOT_FOUND });
        };

        const directoryPath = process.cwd() + '/public/logo/';

        if (fs.existsSync(directoryPath + find.logo)) {

            fs.unlinkSync(directoryPath + find.logo);

        };

        await prisma.menu.delete({ where: { maMenu: String(maMenu) } });

        res.status(200).json({ message: message.DELETE });

    } catch (err) {
        res.status(500).json(err)
    }
}



////////////////////////////////////////////////////////////////////
///////////////////////// Nav Link ////////////////////////////////
//////////////////////////////////////////////////////////////////

//// get all ////
const getAllNavLink = async (req, res) => {
    try {

        const data = await prisma.navlink.findMany();

        if (data) {
            res.status(200).json({ data })
        }

    } catch (err) {
        res.status(500).json(err);
    };
};

const getANavLink = async (req, res) => {
    try {

        const {maNavLink} = req.query;

        const findNavLink = await prisma.navlink.findFirst({
            where: {maNavLink},
        });

        if( !findNavLink ) {
            return res.status(404).json({message: message.NOT_FOUND});
        };

        res.status(200).json({data: findNavLink});

    } catch (err) {
        res.status(500).json(err);
    };
};

//// tạo nav Link ////
const createNavLink = async (req, res) => {
    try {

        const { tenNavLink,url ,maMenu } = req.body;

        const findName = await prisma.navlink.findMany({
            where: {tenNavLink: String(tenNavLink)}
        });


        if( findName.length > 0 ) {
            return res.status(409).json({message: "Tên Nav Link đã tồn tại !"})
        };

        const newData = await prisma.navlink.create({
            data: {tenNavLink, url, maMenu},
            include: {
                menu: true
            }
        });

        res.status(200).json({data: newData})

    } catch (err) {
        res.status(500).json(err);
    };
};

//// sửa nav Link ////
const updateNavLink = async (req, res) => {
    try {

        const { maNavLink } = req.query;
        const { tenNavLink, maMenu, url } = req.body;

        const findNavLink = await prisma.navlink.findFirst({
            where: {maNavLink}
        });
        
        if( !findNavLink ) {
            return res.status(404).json({message: message.NOT_FOUND});
        };

        await prisma.navlink.update({
            where: {maNavLink},
            data: {tenNavLink,url ,maMenu}
        });

        res.status(200).json({message: message.UPDATE});
       
    } catch (err) {
        res.status(500).json({ message: 'Lỗi server !', err })
    }
}


//// xoa nav Link ////
const deleteNavLink = async (req, res) => {
    try {

        const { maNavLink } = req.query;

        const findNavLink = await prisma.navlink.findUnique({ where: { maNavLink: String(maNavLink) } })

        if (findNavLink) {
            await prisma.navlink.delete({ where: { maNavLink: String(maNavLink) } })

            res.status(200).json({ message: "Xóa Thành Công !" });
        } else {
            res.status(404).json({ message: "Không Tìm Thấy !" });
        }

    } catch (err) {
        res.status(500).json(err);
    };
};


module.exports = {

    getMenu,
    getDetailMenu,
    createMenu,
    updateMenu,
    deleteMenu,
    ///// NAV LINK /////
    getAllNavLink,
    getANavLink,
    createNavLink,
    deleteNavLink,
    updateNavLink,

}