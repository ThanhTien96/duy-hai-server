const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

require('dotenv').config();
const fs = require('fs');


const getAllNews = async (req, res) => {
    try {

        const newData = await prisma.news.findMany({
            include: { hinhAnh: true, nguoiDang: true }
        });

        const data = newData.map(item => ({
            ...item,
            hinhAnh: item.hinhAnh.map(file => ({
                maHinhAnh: file.maHinhAnh,
                hinhAnh: process.env.BASE_URL + '/public/newsImages/' + file.hinhAnh,
            })),
            nguoiDang: {
                hoTen: item.nguoiDang.hoTen,
                taiKhoan: item.nguoiDang.taiKhoan,
                hinhAnh: process.env.BASE_URL + '/public/avatar/' + item.nguoiDang.hinhAnh
            }
        }))

        res.status(200).json({ data })

    } catch (err) {
        res.status(500).json(err);
    };
};

const getDetailNews = async (req, res) => {
    try {

        const { maTinTuc } = req.query;

        const newData = await prisma.news.findFirst({
            where: { maTinTuc: String(maTinTuc) },
            include: { hinhAnh: true, loaiTinTuc: true, nguoiDang: true }
        });

        const data = {
            ...newData,
            hinhAnh: newData.hinhAnh.map(file => ({
                maHinhAnh: file.maHinhAnh,
                hinhAnh: process.env.BASE_URL + '/public/newsImages/' + file.hinhAnh,
            })),
            nguoiDang: {
                hoTen: newData.nguoiDang.hoTen,
                taiKhoan: newData.nguoiDang.taiKhoan,
                hinhAnh: process.env.BASE_URL + '/public/avatar/' + newData.nguoiDang.hinhAnh
            }
        }

        res.status(200).json({ data })

    } catch (err) {
        res.status(500).json(err);
    };
};

const createNews = async (req, res) => {
    try {

        const { tieuDe, noiDung, maNguoiDang, maLoaiTinTuc } = req.body;

        const { files } = req;

        const newData = await prisma.news.create({
            data: {
                tieuDe,
                noiDung,
                maNguoiDang: String(maNguoiDang),
                maLoaiTinTuc: String(maLoaiTinTuc),
                hinhAnh: {
                    create: files.map(file => ({
                        hinhAnh: file.filename
                    }))
                }
            },
            include: { hinhAnh: true, nguoiDang: true, loaiTinTuc: true }
        });

        const data = {
            ...newData,
            hinhAnh: newData.hinhAnh.map(file => ({
                maHinhAnh: file.maHinhAnh,
                hinhAnh: process.env.BASE_URL + '/public/newsImages/' + file.hinhAnh,
            })),
            nguoiDang: {
                maNguoiDung: newData.nguoiDang.maNguoiDung,
                taiKhoan: newData.nguoiDang.taiKhoan,
                hoTen: newData.nguoiDang.hoTen,
                maLoaiNguoiDung: newData.nguoiDang.maLoaiNguoiDung
            },
        }

        res.status(200).json({ data })


    } catch (err) {

        const { files } = req;

        const directoryPath = process.cwd() + '/public/newsImages/';

        for (let file of files) {
            if (fs.existsSync(directoryPath + file.filename)) {
                fs.unlinkSync(directoryPath + file.filename);
            };
        };

        res.status(500).json(err);
    };
};


const updateNews = async (req, res) => {
    try {

        const { maTinTuc } = req.query;

        const { tieuDe, noiDung, maNguoiDang, maLoaiTinTuc } = req.body;
        const { files } = req;

        const findNews = await prisma.news.findFirst({
            where: { maTinTuc: String(maTinTuc) },
            include: {
                hinhAnh: true
            },
        });

        if (!findNews) {
            return res.status(404).json('Không tìm thấy !');
        };

        if (findNews) {
            if (files) {
                const directoryPath = process.cwd() + '/public/newsImages/';

                for (let i in files) {

                    if (fs.existsSync(directoryPath + findNews.hinhAnh[i].hinhAnh)) {
                        fs.unlinkSync(directoryPath + findNews.hinhAnh[i].hinhAnh)
                    }

                    await prisma.news_image.update({
                        where: {
                            maHinhAnh: String(findNews.hinhAnh[i].maHinhAnh)
                        },
                        data: {hinhAnh: String(files.filename)}
                    });
                };
            };
    
        };

        const newData = await prisma.news.update({
            where: {
                maTinTuc: String(maTinTuc),
            },
            data: { tieuDe, noiDung, maNguoiDang, maLoaiTinTuc },
            include: {
                hinhAnh: true
            }
        });

        
        const data = {
            ...newData,
            hinhAnh: newData.hinhAnh.map((file) => {
                return ({
                    maHinhAnh: file.maHinhAnh,
                    hinhAnh: process.env.BASE_URL + '/public/newsImages/' + file.hinhAnh
                })
            })
        };

        res.status(200).json({ data, message: "Cập nhật thành công !" })


    } catch (err) {

        const { files } = req;

        const directoryPath = process.cwd() + '/public/newsImages/';

        if (files) {
            if (fs.existsSync( directoryPath + files.filename)) {
                fs.unlinkSync( directoryPath + files.filename);
            };
        };

        res.status(500).json(err);
    };
};



const deleteNews = async (req, res) => {
    try {

        const { maTinTuc } = req.query;

        const find = await prisma.news.findFirst({
            where: { maTinTuc: String(maTinTuc) },
            include: { hinhAnh: true }
        });

        if (!find) {
            return res.status(404).json({ message: "Không tìm thấy !" });
        };

        const directoryPath = process.cwd() + '/public/newsImages/';

        for (let item of find.hinhAnh) {

            if (fs.existsSync(directoryPath + item.hinhAnh)) {
                fs.unlinkSync(directoryPath + item.hinhAnh);
            };

            await prisma.news_image.delete({
                where: { maHinhAnh: String(item.maHinhAnh) }
            });

        };

        await prisma.news.delete({
            where: { maTinTuc: String(maTinTuc) }
        });

        res.status(200).json({ message: 'Xóa thành công !' })



    } catch (err) {
        res.status(500).json(err);
    };
};




/******** NEWS TYPE ******************/

const getAllNewsType = async (req, res) => {
    try {

        const data = await prisma.news_type.findMany({
            include: {
                tinTuc: true
            }
        })

        res.status(200).json({ data });
    } catch (err) {
        res.status(500).json(err);
    };
};

const getDetailNewsType = async (req, res) => {
    try {

        const { maLoaiTinTuc } = req.query;

        const data = await prisma.news_type.findFirst({
            where: { maLoaiTinTuc: String(maLoaiTinTuc) },
            include: { tinTuc: true }
        });

        res.status(200).json({ data })

    } catch (err) {
        res.status(500).json(err);
    };
};


const createNewsType = async (req, res) => {
    try {

        const { loaiTinTuc } = req.body;

        const data = await prisma.news_type.create({
            data: { loaiTinTuc }
        });

        res.status(200).json({ data, message: "Tạo loại tin tức thành công !" });

    } catch (err) {
        res.status(500).json(err);
    };
};

const updateNewsType = async (req, res) => {
    try {

        const { maLoaiTinTuc } = req.query;
        const { loaiTinTuc } = req.body;

        const data = await prisma.news_type.update({
            where: { maLoaiTinTuc: String(maLoaiTinTuc) },
            data: { loaiTinTuc },
        });

        res.status(200).json({ data, message: "Cập nhật loại tin tức thành công" });


    } catch (err) {
        res.status(500).json(err);
    };
};


const deleteNewsType = async (req, res) => {
    try {

        const { maLoaiTinTuc } = req.query;

        await prisma.news_type.delete({
            where: { maLoaiTinTuc: String(maLoaiTinTuc) },
        });

        res.status(200).json({ message: "Xóa thành công !" });

    } catch (err) {
        res.status(500).json(err);
    };
};


module.exports = {

    getAllNews,
    getDetailNews,
    createNews,
    updateNews,
    deleteNews,

    /** News type ***/
    getAllNewsType,
    createNewsType,
    getDetailNewsType,
    updateNewsType,
    deleteNewsType,

}




