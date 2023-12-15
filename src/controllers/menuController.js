const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();
require("dotenv").config();
const fs = require("fs");
const message = require("../services/message");

/////////////////////////////////////////////////////////////////
///////////////////////  MENU   ////////////////////////////////
///////////////////////////////////////////////////////////////

////    GET MENU WITH MA MENU   ////
const getMenu = async (req, res) => {
  try {
    const findMenu = await prisma.menu.findMany({
      include: {
        navlink: {
          include: {
            subLink: true,
          },
          orderBy: {
            role: "asc",
          },
        },
      },
    });

    if (findMenu.length <= 0) {
      return res.status(204).json();
    }

    const data = findMenu.map((ele) => ({
      maMenu: ele.maMenu,
      active: ele.active,
      logo: process.env.SERVER_URL + "/public/logo/" + ele.logo,
      navlink: ele.navlink,
    }));

    res.status(200).json({ data: data[0] });
  } catch (err) {
    res.status(500).json({ message: "server is error", err });
  }
};

const getDetailMenu = async (req, res) => {
  try {
    const { maMenu } = req.query;

    const findMenu = await prisma.menu.findFirst({
      where: { maMenu },
      include: {
        navlink: {
          include: {
            subLink: true,
          },
        },
      },
    });

    const data = {
      maMenu: findMenu.maMenu,
      logo: process.env.SERVER_URL + "/public/logo/" + findMenu.logo,
      active: findMenu.active,
      navlink: {
        ...findMenu.navlink,
      },
    };

    if (!findMenu) {
      res.status(404).json({ message: message.NOT_FOUND });
    }

    res.status(200).json({ data });
  } catch (err) {
    res.status(500).json(err);
  }
};

////    CREATE MENU     /////
const createMenu = async (req, res) => {
  try {
    const { file } = req;
    const { active } = req.body;
    let parseActive = active;
    if (parseActive === "true") {
      parseActive = true;
    } else {
      parseActive = false;
    }
    const createMenu = await prisma.menu.create({
      data: { logo: file.filename, active: parseActive },
    });
    res
      .status(200)
      .json({ data: createMenu, message: "Thêm menu thành công !!!" });
  } catch (err) {
    res.status(500).json(err);
  }
};

////    UPDATE MENU     ////
const updateMenu = async (req, res) => {
  try {
    const { active } = req.body;

    const { maMenu } = req.query;
    let parseActive = active;
    if (parseActive === "true") {
      parseActive = true;
    } else {
      parseActive = false;
    }
    const findMenu = await prisma.menu.findFirst({
      where: { maMenu },
    });

    if (!findMenu) {
      return res.status(404).json({ message: message.NOT_FOUND });
    }


    const directoryPath = process.cwd() + "/public/logo/";

    if (req.file) {
      if (fs.existsSync(directoryPath + findMenu.logo)) {
        fs.unlinkSync(directoryPath + findMenu.logo);
      }
    }

    await prisma.menu.update({
      where: { maMenu: String(maMenu) },
      data: { logo: req.file && req.file.filename, active: parseActive },
    });

    res.status(200).json({ message: message.UPDATE });
  } catch (err) {
    res.status(500).json(err);
  }
};

////    DELETE MENU     ////
const deleteMenu = async (req, res) => {
  try {
    const { maMenu } = req.query;

    const find = await prisma.menu.findFirst({
      where: { maMenu: String(maMenu) },
    });

    if (!find) {
      return res.status(404).json({ message: message.NOT_FOUND });
    }

    const directoryPath = process.cwd() + "/public/logo/";

    if (fs.existsSync(directoryPath + find.logo)) {
      fs.unlinkSync(directoryPath + find.logo);
    }

    await prisma.menu.delete({ where: { maMenu: String(maMenu) } });

    res.status(200).json({ message: message.DELETE });
  } catch (err) {
    res.status(500).json(err);
  }
};

////////////////////////////////////////////////////////////////////
///////////////////////// Nav Link ////////////////////////////////
//////////////////////////////////////////////////////////////////

//// get all ////
const getAllNavLink = async (req, res) => {
  try {
    const data = await prisma.navlink.findMany({
      include: {
        subLink: true,
      },
    });

    if (data) {
      res.status(200).json({ data });
    }
  } catch (err) {
    res.status(500).json(err);
  }
};

const getANavLink = async (req, res) => {
  try {
    const { maNavLink } = req.query;

    const findNavLink = await prisma.navlink.findFirst({
      where: { maNavLink },
    });

    if (!findNavLink) {
      return res.status(404).json({ message: message.NOT_FOUND });
    }

    res.status(200).json({ data: findNavLink });
  } catch (err) {
    res.status(500).json(err);
  }
};

//// tạo nav Link ////
const createNavLink = async (req, res) => {
  try {
    const { tenNavLink, url, maMenu, role } = req.body;

    if (!role) {
      return res.status(404).json({ message: "role không được để trống" });
    }

    const findName = await prisma.navlink.findMany({
      where: { tenNavLink: String(tenNavLink) },
    });

    if (findName.length > 0) {
      return res.status(409).json({ message: "Tên Nav Link đã tồn tại !" });
    }

    const newData = await prisma.navlink.create({
      data: { tenNavLink, url, maMenu, role: Number(role) },
      include: {
        menu: true,
      },
    });

    res.status(200).json({ data: newData });
  } catch (err) {
    res.status(500).json(err);
  }
};

//// sửa nav Link ////
const updateNavLink = async (req, res) => {
  try {
    const { maNavLink } = req.query;
    const { tenNavLink, maMenu, url, role } = req.body;

    const findNavLink = await prisma.navlink.findFirst({
      where: { maNavLink },
    });

    if (!findNavLink) {
      return res.status(404).json({ message: message.NOT_FOUND });
    }

    await prisma.navlink.update({
      where: { maNavLink },
      data: { tenNavLink, url, maMenu, role: role * 1 },
    });

    res.status(200).json({ message: message.UPDATE });
  } catch (err) {
    res.status(500).json({ message: "Lỗi server !", err });
  }
};

//// xoa nav Link ////
const getAllSubLink = async (req, res) => {
  try {
    const subLink = await prisma.subNavLink.findMany();

    if (subLink.length <= 0) {
      res.status(204);
      return;
    } else {
      res.status(200).json({ data: subLink });
    }
  } catch (err) {
    res.status(500).json(err);
  }
};

const getASubLink = async (req, res) => {
  try {
    const subLink = await prisma.subNavLink.findUnique({
      where: { id: req.query.id },
    });

    if (!subLink) {
      res.status(404).json({ message: message.NOT_FOUND });
      return;
    } else {
      res.status(200).json({ data: subLink });
    }
  } catch (err) {
    res.status(500).json(err);
  }
};

const updateSubNavLink = async (req, res) => {
  try {
    const { tenSubLink, url, maNavLink } = req.body;
    const { id } = req.query;

    const find = await prisma.subNavLink.findUnique({
      where: { id },
    });

    if (!find) {
      res.status(404).json({ message: message.NOT_FOUND });
      return;
    }

    const update = await prisma.subNavLink.update({
      where: { id },
      data: {
        tenSubLink,
        url,
        maNavLink,
      },
    });
    return res.status(200).json({ data: update, message: message.UPDATE });
  } catch (err) {
    res.status(500).json(err);
  }
};
const deleteNavLink = async (req, res) => {
  try {
    const { maNavLink } = req.query;

    const findNavLink = await prisma.navlink.findUnique({
      where: { maNavLink: String(maNavLink) },
    });

    if (findNavLink) {
      await prisma.navlink.delete({ where: { maNavLink: String(maNavLink) } });

      res.status(200).json({ message: "Xóa Thành Công !" });
    } else {
      res.status(404).json({ message: "Không Tìm Thấy !" });
    }
  } catch (err) {
    res.status(500).json(err);
  }
};

/** subNavLink */
const createSubNavLink = async (req, res) => {
  try {
    const { tenSubLink, maNavLink, url } = req.body;

    const findNavLink = await prisma.navlink.findUnique({
      where: { maNavLink: String(maNavLink) },
    });

    if (!findNavLink) {
      res.status(404).json({ message: message.NOT_FOUND });
      return;
    }

    await prisma.subNavLink.create({ data: { tenSubLink, maNavLink, url } });

    res.status(200).json({ message: message.CREATE_SUCCESS });
  } catch (err) {
    res.status(500).json(err);
  }
};

const deleleSubLink = async (req, res) => {
  try {
    const find = await prisma.subNavLink.findUnique({
      where: { id: req.query.id },
    });

    if (!find) {
      return res.status(404).json({ message: message.NOT_FOUND });
    }
    await prisma.subNavLink.delete({ where: { id: find.id } });
    return res.status(200).json({ message: message.DELETE });
  } catch (err) {
    res.status(500).json(err);
  }
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
  /** sub link */
  createSubNavLink,
  getAllSubLink,
  getASubLink,
  updateSubNavLink,
  deleleSubLink,
};
