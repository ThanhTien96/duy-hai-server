const { PrismaClient } = require('@prisma/client')
const prisma = new PrismaClient();

////////////////////////////////////////////
////////        Main Categories      ///////
////////////////////////////////////////////

const getAllCategories = async (req, res) => {
    try {
        const data = await prisma.maincategories.findMany({
            include: {
                subcategories: true
            }
        });

        res.status(200).json({ data })

    } catch (err) {
        res.status(500).json(err);
    };
};

const getACategories = async (req, res) => {
    try {

        const { maDanhMucChinh } = req.query;

        const data = await prisma.maincategories.findFirst({
            where: { maDanhMucChinh: String(maDanhMucChinh) }
        });


        res.status(200).json({ data })

    } catch (err) {
        res.status(500).json(err);
    };
};

const createCategories = async (req, res) => {
    try {

        const { tenDanhMuc, icon } = req.body;

        const findCategory = await prisma.maincategories.findMany({ where: { tenDanhMuc: String(tenDanhMuc) } });

        if (findCategory.length > 0) {

            return res.status(404).json({ message: 'Ten danh mục đã tồn tại !' });

        };

        const data = await prisma.maincategories.create({ data: { tenDanhMuc: tenDanhMuc, icon: icon } });


        res.status(200).json({ data, message: 'Tạo danh mục thành công !' });


    } catch (err) {
        res.status(500).json(err);
    };
};


const updateCategories = async (req, res) => {
    try {

        const { maDanhMucChinh } = req.query;

        const { tenDanhMuc, icon } = req.body;

        const find = await prisma.maincategories.findFirst({ where: { maDanhMucChinh: String(maDanhMucChinh) } });

        if (!find) {
            res.status(404).json({ message: "Không tìm thấy !" })
        }
        const data = await prisma.maincategories.update({
            where: { maDanhMucChinh: String(maDanhMucChinh) },
            data: { tenDanhMuc, icon }
        });

        res.status(200).json({ data, message: "Cập nhật thành công !" });


    } catch (err) {
        res.status(500).json(err);
    };
};

const deleteCategories = async (req, res) => {
    try {

        const { maDanhMucChinh } = req.query;

        const find = await prisma.maincategories.findFirst({
            where: { maDanhMucChinh: String(maDanhMucChinh) }
        });

        if (!find) {
            return res.status(404).json({ message: "Không tìm thấy !" })
        };

        await prisma.maincategories.delete({
            where: { maDanhMucChinh: String(maDanhMucChinh) }
        });

        res.status(200).json({ message: "Xóa thành công !" })


    } catch (err) {
        res.status(500).json(err);
    };
};

////////////////////////////////////////////
////////        sub Categories      ///////
////////////////////////////////////////////

const getAllSubCategory = async (req, res) => {
    try {
        const data = await prisma.subcategories.findMany({
            include: {
                maincategories: true,
                danhSachSanPham: {
                    include: {
                        hinhAnh: true,
                    }
                }
            }
        });
        res.status(200).json({ data })
    } catch (err) {
        res.status(500).json(err);
    }
}



const getASubCategory = async (req, res) => {
    try {
        const { maDanhMucNho } = req.query;

        const data = await prisma.subcategories.findFirst({
            where: { maDanhMucNho: String(maDanhMucNho) }
        });
        res.status(200).json({ data })
    } catch (err) {
        res.status(500).json(err);
    }
}



const createSubCategory = async (req, res) => {
    try {

        const { tenDanhMucNho, icon, maDanhMucChinh } = req.body;

        const findName = await prisma.subcategories.findMany({
            where: { tenDanhMucNho: String(tenDanhMucNho) }
        });

        if (findName.length > 0) {
            return res.status(404).json({ message: 'Tên danh mục đã tồn tại !' });
        };

        const findDanhMucChinh = await prisma.maincategories.findFirst({
            where: { maDanhMucChinh: String(maDanhMucChinh) }
        });


        if (!findDanhMucChinh) {
            return res.status(404).json({ message: "Mã danh mục chính không đúng !" });
        };

        const data = await prisma.subcategories.create({
            data: { tenDanhMucNho, icon, maDanhMucChinh }
        })

        res.status(200).json({ data })

    } catch (err) {
        res.status(500).json(err);
    };
};

const updateSubCategory = async (req, res) => {
    try {

        const { maDanhMucNho } = req.query;
        const { tenDanhMucNho, icon, maDanhMucChinh } = req.body;

        const find = await prisma.subcategories.findFirst({
            where: { maDanhMucNho: String(maDanhMucNho) }
        });

        if (!find) {
            return res.status(404).json({ message: "Không tìm thấy !" });
        };

        const dataUpdate = await prisma.subcategories.update({
            where: { maDanhMucNho: String(maDanhMucNho) },
            data: { tenDanhMucNho, icon, maDanhMucChinh },
        });

        res.status(200).json({ data: dataUpdate, message: "Cập nhật thành công !" })

    } catch (err) {
        res.status(500).json(err)
    }
};

const deleteSubCategory = async (req, res) => {
    try {

        const { maDanhMucNho } = req.query;

        const find = await prisma.subcategories.findFirst({
            where: { maDanhMucNho: String(maDanhMucNho) }
        });

        if (!find) {
            return res.status(404).json({ message: "Không tìm thấy !" })
        }

        await prisma.subcategories.delete({
            where: { maDanhMucNho: String(maDanhMucNho) }
        })

        res.status(200).json({ message: "Xóa thành công !" });

    } catch (err) {
        res.status(500).json(err)
    }
}


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
    deleteSubCategory
}