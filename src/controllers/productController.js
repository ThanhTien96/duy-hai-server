const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();
require("dotenv").config();
const fs = require("fs");
const message = require("../services/message");

const activeProductImage = async (req, res) => {
  try {
    const { id } = req.query;
    const { hinhChinh } = req.body;

    const findImg = await prisma.image_product.findUnique({ where: { id } });

    if (!findImg) return res.status(404).json({ message: message.NOT_FOUND });

    const findImgIncludeProd = await prisma.image_product.findMany({
      where: { maSanPham: findImg.maSanPham, hinhChinh: true },
    });
    if (findImgIncludeProd.length > 0) {
      findImgIncludeProd.forEach(async (ele) => {
        await prisma.image_product.update({
          where: { id: ele.id },
          data: { hinhChinh: false },
        });
      });
    }
    let active = hinhChinh;

    if (typeof active !== "boolean") {
      if (active !== "true") {
        active = false;
      } else {
        active = true;
      }
    }

    const data = await prisma.image_product.update({
      where: { id: findImg.id },
      data: { hinhChinh: active },
    });
    res.status(200).json(data);
  } catch (err) {
    res.status(500).json(err);
  }
};

const updateImageProduct = async (req, res) => {
  const directoryPath = process.cwd() + "/public/images/";
  const { file } = req;
  try {
    const { id } = req.query;

    const findImage = await prisma.image_product.findUnique({ where: { id } });
    if (!findImage) {
      if (file) {
        if (fs.existsSync(directoryPath + file.filename)) {
          fs.unlinkSync(directoryPath + file.filename);
        }
      }
      return res.status(404).json({ message: message.NOT_FOUND });
    }

    if (fs.existsSync(directoryPath + findImage.filename)) {
      fs.unlinkSync(directoryPath + findImage.filename);
    }

    const newData = await prisma.image_product.update({
      where: { id },
      data: {
        hinhAnh: file.filename,
      },
    });
    res.status(200).json({ data: newData, message: message.UPDATE });
  } catch (err) {
    if (file) {
      if (fs.existsSync(directoryPath + file.filename)) {
        fs.unlinkSync(directoryPath + file.filename);
      }
    }
    res.status(500).json(err);
  }
};

const deleteImageProduct = async (req, res) => {
  const directPath = process.cwd() + "/public/images/";
  try {
    const { id } = req.query;
    const findImage = await prisma.image_product.findUnique({ where: { id } });
    if (!findImage) return res.status(404).json({ message: message.NOT_FOUND });
    if (findImage.hinhChinh)
      return res.status(400).json({ message: "Không thể xoá hình chính !" });

    if (fs.existsSync(directPath + findImage.hinhAnh)) {
      fs.unlinkSync(directPath + findImage.hinhAnh);
    }

    await prisma.image_product.delete({ where: { id: findImage.id } });
    res.status(200).json({ message: message.DELETE });
  } catch (err) {
    res.status(500).json(err);
  }
};

const getAllProducts = async (req, res) => {
  try {
    const { tenSanPham, filter } = req.query;

    if (tenSanPham) {
      const findProduct = await prisma.products.findMany({
        where: {
          tenSanPham: {
            contains: tenSanPham,
          },
        },
        orderBy: {
          createAt: "desc",
        },
        include: {
          hinhAnh: true,
          danhMucNho: {
            include: {
              maincategories: true,
            },
          },
        },
      });

      if (findProduct.length <= 0) {
        return res.status(204).json({ message: message.NOT_FOUND });
      }

      const data = findProduct.map((ele) => ({
        ...ele,
        hinhAnh: ele.hinhAnh.map((img) => ({
          ...img,
          hinhChinh: img.hinhChinh,
          hinhAnh: process.env.SERVER_URL + "/public/images/" + img.hinhAnh,
        })),
      }));

      res.status(200).json({ data });
    } else {
      let formatFilter = filter && {
        [Object.keys(filter)[0]]:
          Object.values(filter)[0] === "true"
            ? true
            : Object.values(filter)[0] === "false"
            ? false
            : undefined,
      };
      const getData = await prisma.products.findMany({
        where: { ...formatFilter },
        orderBy: { createAt: "desc" },
        include: {
          hinhAnh: true,
          danhMucNho: {
            include: {
              maincategories: true,
            },
          },
        },
      });

      const data = getData.map((ele) => ({
        ...ele,
        hinhAnh: ele.hinhAnh.map((img) => ({
          ...img,
          hinhAnh: process.env.SERVER_URL + "/public/images/" + img.hinhAnh,
        })),
      }));

      res.status(200).json({ data });
    }
  } catch (err) {
    res.status(500).json(err);
  }
};

const getAllImageProduct = async (req, res) => {
  try {
    const { id } = req.query;

    if (!id) return res.status(404).json({ message: "thiếu mã sản phẩm!" });

    const findImage = await prisma.image_product.findMany({
      where: { maSanPham: id },
    });
    if (!findImage) return res.status(404).json({ message: message.NOT_FOUND });

    res.status(200).json({ data: findImage });
  } catch (err) {
    res.status(500).json(err);
  }
};

const addImageToProduct = async (req, res) => {
  const path = process.cwd() + "/public/images/";
  const { file } = req;
  try {
    const { id } = req.query;
    const findProduct = await prisma.products.findUnique({
      where: { maSanPham: id },
      include: {
        hinhAnh: true,
      },
    });
    if (!findProduct) {
      if (file && fs.existsSync(path + file.filename)) {
        fs.unlinkSync(path + file.filename);
      }
      return res.status(404).json({ message: message.NOT_FOUND });
    }

    if (findProduct.hinhAnh.length >= 6) {
      if (file && fs.existsSync(path + file.filename)) {
        fs.unlinkSync(path + file.filename);
      }
      return res
        .status(400)
        .json({ message: "Số lượng hình ảnh đã đạt tối đa" });
    }

    await prisma.image_product.create({
      data: {
        maSanPham: findProduct.maSanPham,
        hinhAnh: file.filename,
      },
    });

    res.status(200).json({
      message: `Thêm hình ảnh vô ${findProduct.tenSanPham} Thành Công!`,
    });
  } catch (err) {
    if (file && fs.existsSync(path + file.filename)) {
      fs.unlinkSync(path + file.filename);
    }
    res.status(500).json(err);
  }
};

const getDetailProduct = async (req, res) => {
  try {
    const { maSanPham } = req.query;

    const findProduct = await prisma.products.findFirst({
      where: { maSanPham },
      include: {
        hinhAnh: true,
        danhMucNho: true,
        donHang: true,
        comment: true,
        danhGia: true,
      },
    });
    if (!findProduct) {
      return res.status(404).json({ message: "Không tìm thấy !" });
    }

    const data = {
      ...findProduct,
      hinhAnh: findProduct.hinhAnh.map((ele) => ({
        id: ele.id,
        hinhChinh: ele.hinhChinh,
        hinhAnh: process.env.SERVER_URL + "/public/images/" + ele.hinhAnh,
      })),
    };

    res.status(200).json({ data });
  } catch (err) {
    res.status(500).json(err);
  }
};

const getProductPerPage = async (req, res) => {
  let { soTrang, soPhanTu, tenSanPham, maDanhMucNho, maDanhMucChinh } =
    req.query;
  if (!soTrang || soTrang <= 0) soTrang = 1;
  if (!soPhanTu || soPhanTu <= 0) soPhanTu = 10;
  try {
    const total = await prisma.products.count({
      where: {
        danhMucNho: { maDanhMucChinh },
        maDanhMucNho,
      },
    });
    const totalPages = Math.ceil(total / soPhanTu);
    const skip = (Number(soTrang) - 1) * Number(soPhanTu);

    if (tenSanPham) {
      const productSearch = await prisma.products.findMany({
        where: {
          tenSanPham: {
            contains: tenSanPham,
          },
        },
        orderBy: { createAt: "desc" },
        skip: Number(skip),
        take: Number(soPhanTu),
        include: {
          hinhAnh: true,
          danhMucNho: true,
        },
      });

      if (productSearch.length <= 0) {
        return res.status(204).json();
      }
      const totalCountSearch = await prisma.products.count({
        where: {
          tenSanPham: {
            contains: tenSanPham,
          },
        },
      });

      const totalPagesSearch = Math.ceil(totalCountSearch / soPhanTu);

      const data = productSearch.map((ele) => ({
        ...ele,
        hinhAnh: ele.hinhAnh.map((img) => ({
          id: img.id,
          hinhChinh: img.hinhChinh,
          hinhAnh: process.env.SERVER_URL + "/public/images/" + img.hinhAnh,
        })),
        danhMucNho: {
          maDanhMucNho: ele.danhMucNho.maDanhMucNho,
          tenDanhMucNho: ele.danhMucNho.tenDanhMucNho,
        },
      }));

      return res.status(200).json({
        data,
        total: Number(totalCountSearch),
        totalPages: Number(totalPagesSearch),
        currentPage: Number(soTrang),
      });
    } else {
      const newData = await prisma.products.findMany({
        where: { danhMucNho: { maDanhMucChinh }, maDanhMucNho },
        take: Number(soPhanTu),
        skip: Number(skip),
        orderBy: { createAt: "desc" },
        include: {
          hinhAnh: true,
          danhMucNho: true,
          comment: true,
          danhGia: true,
          donHang: true,
        },
      });

      if (newData.length <= 0) {
        return res.status(204).json();
      }

      const dataPagination = newData.map((ele) => ({
        ...ele,
        hinhAnh: ele.hinhAnh.map((img) => ({
          id: img.id,
          hinhChinh: img.hinhChinh,
          hinhAnh: process.env.SERVER_URL + "/public/images/" + img.hinhAnh,
        })),
        danhMucNho: {
          maDanhMucNho: ele.danhMucNho.maDanhMucNho,
          tenDanhMucNho: ele.danhMucNho.tenDanhMucNho,
        },
      }));

      return res.status(200).json({
        data: dataPagination,
        total,
        totalPages,
        currentPage: Number(soTrang),
      });
    }
  } catch (err) {
    res.status(500).json(err);
  }
};

const createProduct = async (req, res) => {
  const {
    tenSanPham,
    moTa,
    moTaNgan,
    tongSoLuong,
    maDanhMucNho,
    giaGiam,
    giaGoc,
    seoTitle,
    seoDetail,
    youtubeVideo,
    seo,
    hot,
  } = req.body;

  const { files } = req;
  try {
    const findProductType = await prisma.subcategories.findUnique({
      where: { maDanhMucNho },
    });
    if (!findProductType)
      return res.status(404).json({ message: message.NOT_FOUND });

    const newProduct = await prisma.products.create({
      data: {
        tenSanPham,
        moTa,
        moTaNgan,
        seoTitle,
        seoDetail,
        youtubeVideo,
        seo,
        hot,
        tongSoLuong: Number(tongSoLuong),
        maDanhMucNho: maDanhMucNho,
        giaGiam: Number(giaGiam),
        giaGoc: giaGoc && Number(giaGoc),
        hinhAnh: {
          create: files.map((file, index) => {
            return {
              hinhChinh: index === 0 && true,
              hinhAnh: file.filename,
            };
          }),
        },
      },
      include: {
        hinhAnh: true,
      },
    });

    const data = {
      ...newProduct,
      hinhAnh: newProduct.hinhAnh.map((ele) => ({
        id: ele.id,
        hinhAnh: process.env.SERVER_URL + "/public/images/" + ele.hinhAnh,
      })),
    };

    await prisma.notification.create({
      data: {
        title: `sản phẩm mới`,
        subTitle: `bạn thêm thành công 1 sản phẩm mới`,
        rootTitle: data.tenSanPham,
        type: "product"
      },
    });
    res.status(200).json({ data });
  } catch (err) {
    const { files } = req;

    const directoryPath = process.cwd() + "/public/images/";

    for (let img of files) {
      if (fs.existsSync(directoryPath + img.filename)) {
        fs.unlinkSync(directoryPath + img.filename);
      }
    }

    res.status(500).json({ err });
  }
};

/** cap nhat san pham và update hinh anh */
const updateProduct = async (req, res) => {
  {
    try {
      const { maSanPham } = req.query;
      const {
        tenSanPham,
        moTa,
        moTaNgan,
        khuyenMai,
        tongSoLuong,
        youtubeVideo,
        maDanhMucNho,
        giaGiam,
        giaGoc,
        seoTitle,
        seoDetail,
        seo,
        hot,
      } = req.body;

      const { files } = req;

      const directoryPath = process.cwd() + "/public/images/";

      const findProduct = await prisma.products.findFirst({
        where: { maSanPham: String(maSanPham) },
        include: { hinhAnh: true },
      });
      if (!findProduct) {
        return res.status(404).json({ message: message.NOT_FOUND });
      }

      // neu la 3 hinh hoac it hon thi update duoc them hinh thi khong them duoc
      if (files.length > 0) {
        for (let i = 0; i < files.length; i++) {
          if (i < findProduct.hinhAnh.length) {
            if (fs.existsSync(directoryPath + findProduct.hinhAnh[i].hinhAnh)) {
              fs.unlinkSync(directoryPath + findProduct.hinhAnh[i].hinhAnh);
            }

            await prisma.image_product.update({
              where: { id: findProduct.hinhAnh[i].id },
              data: { hinhAnh: files[i].filename },
            });
          } else {
            await prisma.image_product.create({
              data: {
                maSanPham: findProduct.maSanPham,
                hinhAnh: files[i].filename,
              },
            });
          }
        }
      }

      const data = await prisma.products.update({
        where: { maSanPham: String(maSanPham) },
        data: {
          tenSanPham,
          moTa,
          moTaNgan,
          seoTitle,
          youtubeVideo,
          seoDetail,
          seo,
          hot,
          khuyenMai,
          tongSoLuong: tongSoLuong && Number(tongSoLuong),
          maDanhMucNho,
          giaGiam: giaGiam && Number(giaGiam),
          giaGoc: giaGoc && Number(giaGoc),
        },
        include: { hinhAnh: true },
      });

      const newData = {
        ...data,
        hinhAnh: data.hinhAnh.map((ele) => ({
          hinhAnh: process.env.SERVER_URL + "/public/images/" + ele.hinhAnh,
          id: ele.id,
        })),
      };

      res.status(200).json({ data: newData, message: "Cập nhật thành công !" });
    } catch (err) {
      const { files } = req;

      const directoryPath = process.cwd() + "/public/images/";

      for (let item of files) {
        if (fs.existsSync(directoryPath + item.filename)) {
          fs.unlinkSync(directoryPath + item.filename);
        }
      }

      res.status(500).json(err);
    }
  }
};

const updateFieldProduct = async (req, res) => {
  try {
    const { id } = req.query;
    const {
      tenSanPham,
      moTa,
      moTaNgan,
      khuyenMai,
      tongSoLuong,
      youtubeVideo,
      maDanhMucNho,
      giaGiam,
      giaGoc,
      seoTitle,
      seoDetail,
      seo,
      hot,
    } = req.body;

    const findProduct = await prisma.products.findUnique({
      where: { maSanPham: id },
    });
    if (!findProduct)
      return res.status(404).json({ message: message.NOT_FOUND });

    await prisma.products.update({
      where: { maSanPham: findProduct.maSanPham },
      data: {
        tenSanPham,
        moTa,
        moTaNgan,
        khuyenMai,
        tongSoLuong: tongSoLuong && Number(tongSoLuong),
        youtubeVideo,
        maDanhMucNho,
        giaGiam: giaGiam && Number(giaGiam),
        giaGoc: giaGoc && Number(giaGoc),
        seoTitle,
        seoDetail,
        seo,
        hot,
      },
    });

    res.status(200).json({ message: "Cập nhật sản phẩm thành công!" });
  } catch (err) {
    res.status(500).json(err);
  }
};

const deleteProduct = async (req, res) => {
  try {
    const { maSanPham } = req.query;

    const findProduct = await prisma.products.findFirst({
      where: { maSanPham: String(maSanPham) },
      include: {
        hinhAnh: true,
        comment: true,
        danhGia: true,
        donHang: true,
      },
    });
    if (!findProduct) {
      res.status(404).json({ message: "Không tìm thấy !" });
    } else {
      const directoryPath = process.cwd() + "/public/images/";

      if (findProduct.hinhAnh.length > 0) {
        for (let image of findProduct.hinhAnh) {
          if (fs.existsSync(directoryPath + image.hinhAnh)) {
            fs.unlinkSync(directoryPath + image.hinhAnh);
          }

          await prisma.image_product.delete({
            where: { id: String(image.id) },
          });
        }
      }

      if (findProduct.donHang.length > 0) {
        await prisma.orders_products.deleteMany({
          where: {
            maSanPham: String(maSanPham),
          },
        });
      }

      if (findProduct.comment.length > 0) {
        await prisma.comments.deleteMany({
          where: {
            maSanPham: String(maSanPham),
          },
        });
      }

      if (findProduct.danhGia.length > 0) {
        await prisma.rates_products.deleteMany({
          where: {
            maSanPham: String(maSanPham),
          },
        });
      }

      await prisma.products.delete({
        where: {
          maSanPham: String(maSanPham),
        },
      });

      res.status(200).json({ message: "Xóa thành công !" });
    }

    await prisma.notification.create({
      data: {
        title: `xóa sản phẩm`,
        subTitle: `bạn mới xóa 1 sản phẩm`,
        rootTitle: findProduct.tenSanPham,
      },
    });
  } catch (err) {
    res.status(500).json(err);
  }
};

module.exports = {
  getAllProducts,
  getDetailProduct,
  getProductPerPage,
  createProduct,
  updateProduct,
  deleteProduct,
  activeProductImage,
  updateImageProduct,
  deleteImageProduct,
  getAllImageProduct,
  addImageToProduct,
  updateFieldProduct,
};
