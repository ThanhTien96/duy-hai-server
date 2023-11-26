const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();
require("dotenv").config();
const message = require("../services/message");

////////////////////////////////////////////
////////        Main Categories      ///////
////////////////////////////////////////////

const getAllCategories = async (req, res) => {
  try {
    const {withProduct} = req.query;
    let data;

    if(withProduct && withProduct === "true" | withProduct === true) {
      data = await prisma.maincategories.findMany({
        include: {
          subcategories: {
            include: {
              danhSachSanPham: {
                include: {
                  hinhAnh: true
                },
                orderBy: {
                  createAt: "desc",
                }
              }
            }
          },
        },
        orderBy: {
          role: "asc"
        }
      });
    } else {
      data = await prisma.maincategories.findMany({
        include: {
          subcategories: true,
        },
        orderBy: {
          role: "asc"
        }
      });
    }

    res.status(200).json({ data });
  } catch (err) {
    res.status(500).json(err);
  }
};

const getACategories = async (req, res) => {
  try {
    const { maDanhMucChinh } = req.query;

    const data = await prisma.maincategories.findFirst({
      where: { maDanhMucChinh: String(maDanhMucChinh) },
    });

    res.status(200).json({ data });
  } catch (err) {
    res.status(500).json(err);
  }
};

const getProductWithMainCategory = async (req, res) => {
  try {
    const { maDanhMucChinh } = req.query;

    const newData = await prisma.maincategories.findFirst({
      where: { maDanhMucChinh: String(maDanhMucChinh) },
      include: {
        subcategories: {
          include: {
            danhSachSanPham: {
              orderBy: { createAt: "desc" },
              include: {
                hinhAnh: true,
              },
            },
          },
        },
      },
    });

    const data = {
      ...newData,
      subcategories: newData.subcategories.map((subCate) => {
        return {
          ...subCate,
          danhSachSanPham: subCate.danhSachSanPham.map((pro) => {
            return {
              ...pro,
                hinhAnh: pro.hinhAnh.map((img) => {
                return {
                    id: img.id,
                    hinhAnh:
                    process.env.SERVER_URL + "/public/images/" + img.hinhAnh,
                };
              }),
            };
          }),
        };
      }),
    };

    res.status(200).json({ data });
  } catch (err) {
    res.status(500).json(err);
  }
};

const createCategories = async (req, res) => {
  try {
    const { tenDanhMuc, icon, role } = req.body;

    const findCategory = await prisma.maincategories.findMany({
      where: { tenDanhMuc: String(tenDanhMuc) },
    });
    if (findCategory.length > 0) {
      return res.status(404).json({ message: "Ten danh mục đã tồn tại !" });
    }

    const data = await prisma.maincategories.create({
      data: { tenDanhMuc, icon, role:Number(role) },
    });
    res.status(200).json({ data, message: "Tạo danh mục thành công !" });
  } catch (err) {
    res.status(500).json(err);
  }
};

const updateCategories = async (req, res) => {
  try {
    const { maDanhMucChinh } = req.query;

    const { tenDanhMuc, icon } = req.body;

    const find = await prisma.maincategories.findFirst({
      where: { maDanhMucChinh: String(maDanhMucChinh) },
    });

    if (!find) {
      res.status(404).json({ message: "Không tìm thấy !" });
    }
    const data = await prisma.maincategories.update({
      where: { maDanhMucChinh: String(maDanhMucChinh) },
      data: { tenDanhMuc, icon },
    });

    res.status(200).json({ data, message: "Cập nhật thành công !" });
  } catch (err) {
    res.status(500).json(err);
  }
};

const deleteCategories = async (req, res) => {
  try {
    const { maDanhMucChinh } = req.query;

    const find = await prisma.maincategories.findFirst({
      where: { maDanhMucChinh: String(maDanhMucChinh) },
    });

    if (!find) {
      return res.status(404).json({ message: "Không tìm thấy !" });
    }

    await prisma.maincategories.delete({
      where: { maDanhMucChinh: String(maDanhMucChinh) },
    });

    res.status(200).json({ message: "Xóa thành công !" });
  } catch (err) {
    res.status(500).json(err);
  }
};

////////////////////////////////////////////
////////        sub Categories      ///////
////////////////////////////////////////////

const getAllSubCategory = async (req, res) => {
  try {
    const data = await prisma.subcategories.findMany({
      include: {
        maincategories: true,
      },
    });
    res.status(200).json({ data });
  } catch (err) {
    res.status(500).json(err);
  }
};

const getASubCategory = async (req, res) => {
  try {
    const { maDanhMucNho } = req.query;

    const data = await prisma.subcategories.findFirst({
      where: { maDanhMucNho: String(maDanhMucNho) },
    });
    res.status(200).json({ data });
  } catch (err) {
    res.status(500).json(err);
  }
};

const getProductWithSubCategory = async (req, res) => {
  try {
    const { maDanhMucNho } = req.query;

    const findData = await prisma.subcategories.findFirst({
      where: { maDanhMucNho: String(maDanhMucNho) },
      include: {
        danhSachSanPham: {
          include: {
            hinhAnh: true,
          },
        },
      },
    });

    if (!findData) {
      return res.status(404).json({ message: message.NOT_FOUND });
    }

    const data = {
      ...findData,
      danhSachSanPham: findData.danhSachSanPham.map((ele) => {
        return {
          ...ele,
          hinhAnh: ele.hinhAnh.map((image) => {
            return {
              id: image.id,
              hinhAnh: process.env.SERVER_URL + "/public/images/" + image.hinhAnh,
            };
          }),
        };
      }),
    };

    res.status(200).json({ data });
  } catch (err) {
    res.status(500).json(err);
  }
};

const createSubCategory = async (req, res) => {
  try {
    const { tenDanhMucNho, icon, maDanhMucChinh } = req.body;

    const findDanhMucChinh = await prisma.maincategories.findFirst({
      where: { maDanhMucChinh: String(maDanhMucChinh) },
    });

    if (!findDanhMucChinh) {
      return res
        .status(404)
        .json({ message: "Mã danh mục chính không đúng !" });
    }

    const data = await prisma.subcategories.create({
      data: { tenDanhMucNho, icon, maDanhMucChinh },
    });

    res.status(200).json({ data });
  } catch (err) {
    res.status(500).json(err);
  }
};

const updateSubCategory = async (req, res) => {
  try {
    const { maDanhMucNho } = req.query;
    const { tenDanhMucNho, icon, maDanhMucChinh } = req.body;

    const find = await prisma.subcategories.findFirst({
      where: { maDanhMucNho: String(maDanhMucNho) },
    });

    if (!find) {
      return res.status(404).json({ message: "Không tìm thấy !" });
    }

    const dataUpdate = await prisma.subcategories.update({
      where: { maDanhMucNho: String(maDanhMucNho) },
      data: { tenDanhMucNho, icon, maDanhMucChinh },
    });

    res
      .status(200)
      .json({ data: dataUpdate, message: "Cập nhật thành công !" });
  } catch (err) {
    res.status(500).json(err);
  }
};

const deleteSubCategory = async (req, res) => {
  try {
    const { maDanhMucNho } = req.query;

    const find = await prisma.subcategories.findFirst({
      where: { maDanhMucNho: String(maDanhMucNho) },
    });

    if (!find) {
      return res.status(404).json({ message: "Không tìm thấy !" });
    }

    await prisma.subcategories.delete({
      where: { maDanhMucNho: String(maDanhMucNho) },
    });

    res.status(200).json({ message: "Xóa thành công !" });
  } catch (err) {
    res.status(500).json(err);
  }
};

module.exports = {
  getAllCategories,
  getACategories,
  createCategories,
  updateCategories,
  deleteCategories,

  //// sub category ////
  createSubCategory,
  getAllSubCategory,
  getASubCategory,
  updateSubCategory,
  deleteSubCategory,

  /** lay san pham theo danh muc chinh */
  getProductWithMainCategory,
  /** lay san pham theo danh muc nho*/
  getProductWithSubCategory,
};
