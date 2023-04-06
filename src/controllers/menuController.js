const { PrismaClient } = require('@prisma/client')
const prisma = new PrismaClient()

/////////////////////////////////////////////////////////////////
///////////////////////  MENU   ////////////////////////////////
///////////////////////////////////////////////////////////////

////    GET MENU WITH MA MENU   ////
const getMenu = async (req, res) => {

    try {

        const data = await prisma.menu.findUnique({where: {maMenu: Number(1)},include: { navlink: true }})

        if (!data) {
            return res.status(404).json({message:"Không Tìm Thấy !"})
        } else {
            return res.status(200).json({data});
        }
        
    } catch (err) {
        res.status(500).json({ message: 'server is error', err })
    }
}


////    CREATE MENU     /////
const createMenu = async (req, res) => {
    try {

        const { logo } = req.body;


        const createMenu = await prisma.menu.create({data: {logo}})

        res.status(200).json({data: createMenu, message: 'Thêm menu thành công !!!'})


    } catch(err) {
        res.status(500).json(err)
    }
}

////    UPDATE MENU     ////
const updateMenu = async (req, res) => {
    try {

        const { maMenu } = req.query;
        const { logo } = req.body;

        const data = await prisma.menu.update({
            where: {maMenu: Number(maMenu)},
            data: {logo}
        });

        res.status(200).json({message: "Cập Nhật Thành Công !!!", data})


    } catch (err) {

        res.status(500).json(err);

    };
};


////    DELETE MENU     ////
const deleteMenu = async (req, res) => {
    try {

        const { maMenu } = req.query;


        const find = await prisma.menu.findUnique({
            where: { maMenu: Number(maMenu) }
        });

        if (find) {

            await prisma.menu.delete({ where: { maMenu: Number(maMenu) } });

            res.status(200).json('Xóa menu thành công!');

        }

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


        const dataUpdate = await prisma.navlink.findUnique({ where: { maNavLink: Number(maNavLink) } });

        if (!dataUpdate) {
            return res.status(404).json({ message: "Không tìm thấy!" });
        }

        if (maMenu) {
            const findMenu = await prisma.menu.findUnique({ where: { maMenu: Number(maMenu) } });
            console.log(findMenu)
            if (!findMenu) {
                return res.status(404).json({message: 'Menu chưa tồn tại !'});
            }

            const data = await prisma.navlink.update({
                where: { maNavLink: Number(maNavLink) },
                data: { tenNavLink, maMenu: Number(maMenu)  }
            });
            console.log(data)

             return res.status(200).json({ data, message: "Sửa thành công !" });
        }

        const data = await prisma.navlink.update({
            where: { maNavLink: Number(maNavLink) },
            data: { tenNavLink, maMenu: Number(maMenu) }
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
        console.log(maNavLink)

        const findNavLink = await prisma.navlink.findUnique({ where: { maNavLink: Number(maNavLink) } })

        if (findNavLink) {
            await prisma.navlink.delete({ where: { maNavLink: Number(maNavLink) } })

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