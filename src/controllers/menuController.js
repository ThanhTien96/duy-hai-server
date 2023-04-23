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

        const data = {
            maMenu: findMenu[0].maMenu,
            logo: process.env.BASE_URL + '/public/logo/' + findMenu[0].logo,
            navlink: findMenu[0].navlink
        };

        res.status(200).json({ data });

    } catch (err) {
        res.status(500).json({ message: 'server is error', err })
    }
}


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

//// tạo nav Link ////
const createNavLink = async (req, res) => {
    try {

        const { tenNavLink, maMenu } = req.body;
        const findName = await prisma.navlink.findFirst({ where: { tenNavLink: String(tenNavLink) } });

        if (!findName) {

            const newNavLink = await prisma.navlink.create({ data: { tenNavLink, maMenu } })

            res.status(200).json({ data: newNavLink, message: 'Thêm Nav Link Thành Công !' });

        } else {

            res.status(400).json({ message: 'Tên NavLink đã tồn tại !' });

        }

    } catch (err) {
        res.status(500).json(err);
    };
};

//// sửa nav Link ////
const updateNavLink = async (req, res) => {
    try {

        const { maNavLink } = req.query;
        const { tenNavLink, maMenu } = req.body;


        const dataUpdate = await prisma.navlink.findUnique({ where: { maNavLink: String(maNavLink) } });

        if (!dataUpdate) {
            return res.status(404).json({ message: "Không tìm thấy!" });
        }

        if (maMenu) {
            const findMenu = await prisma.menu.findUnique({ where: { maMenu: String(maMenu) } });
            console.log(findMenu)
            if (!findMenu) {
                return res.status(404).json({ message: 'Menu chưa tồn tại !' });
            }

            const data = await prisma.navlink.update({
                where: { maNavLink: String(maNavLink) },
                data: { tenNavLink, maMenu: String(maMenu) }
            });

            return res.status(200).json({ data, message: "Sửa thành công !" });
        }

        const data = await prisma.navlink.update({
            where: { maNavLink: String(maNavLink) },
            data: { tenNavLink, maMenu: String(maMenu) }
        });

        res.status(200).json({ data, message: "Sửa thành công !" });

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
    createMenu,
    updateMenu,
    deleteMenu,
    ///// NAV LINK /////
    getAllNavLink,
    createNavLink,
    deleteNavLink,
    updateNavLink,

}