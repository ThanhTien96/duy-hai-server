const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
const authController = require('./authController');
const fs = require('fs');
const { generateToken } = require('./authController');
const message = require('../services/message');
require('dotenv').config();



const getTokenAccess = async (req, res) => {
    try {

        const Token = generateToken(req.user, '1y')

        res.status(200).json({ token: Token })

    } catch (err) {
        res.status(500).json(err);
    };
};


/// register ///
const registerUser = async (req, res) => {
    try {

        const { taiKhoan, matKhau, hoTen, soDT, email, loaiNguoiDung } = req.body;

        const findTaiKhoan = await prisma.user.findMany({
            where: { taiKhoan: String(taiKhoan) }
        });

        const findUserType = await prisma.user_type.findFirst({
            where: { loaiNguoiDung }
        });

        if (!findUserType) {
            return res.status(404).json({ message: "Loại người dùng không hợp lệ!" });
        }


        if (findTaiKhoan.length > 0) {
            return res.status(404).json({ message: 'Tài khoản đã tổn tài !' });
        };

        const findEmail = await prisma.user.findMany({
            where: { email: String(email) }
        });

        if (findEmail.length > 0) {
            return res.status(404).json({ message: 'Email đã tồn tại !' });
        };

        const data = { taiKhoan, matKhau: authController.hashPass(matKhau), hoTen, soDT, email, maLoaiNguoiDung: findUserType.maLoaiNguoiDung }

        const Newdata = await prisma.user.create({ data });

        res.status(200).json({ data: Newdata, message: 'Tạo tài khoản thành công !' });


    } catch (err) {
        res.status(500).json(err);
    };
};



const loginUser = async (req, res) => {
    try {

        const { taiKhoan, matKhau } = req.body;

        const checkTaiKhoan = await prisma.user.findFirst({
            where: { taiKhoan: String(taiKhoan) },
        });

        if (checkTaiKhoan) {

            const checkMatKhau = await authController.comparePass(matKhau, checkTaiKhoan.matKhau);

            if (checkMatKhau) {

                const token = await authController.generateToken(checkTaiKhoan, '4h');


                return res.status(200).json({ data: { token: token }, message: 'Đăng nhập thành công !' })
            } else {
                return res.status(404).json({ message: 'Mật khẩu không hợp lệ !' })
            }


        } else {
            return res.status(404).json({ message: 'Tài khoảng không tồn tại !' });
        }



    } catch (err) {
        res.status(500).json(err);
    };
};



/**
 * USER
 */

const getAllUser = async (req, res) => {
    try {

        const { hoTen } = req.query;

        if (hoTen) {

            const findUserByName = await prisma.user.findMany({
                where: {
                    hoTen: {
                        contains: hoTen
                    }
                },
                include: {
                    user_type: true
                }
            });



            if (findUserByName.length <= 0) {
                return res.status(404).json({ message: message.NOT_FOUND });
            };

            const newData = []
            for (let item of findUserByName) {
                let user = {
                    maNguoiDung: item.maNguoiDung,
                    taiKhoan: item.taiKhoan,
                    hinhAnh: item.hinhAnh !== null ? (process.env.BASE_URL + '/public/avatar/' + item.hinhAnh) : null,
                    hoTen: item.hoTen,
                    soDT: item.soDT,
                    email: item.email,
                    loaiNguoiDung: item.user_type
                }
                newData.push(user)
            }

            res.status(200).json({ data: newData })


        } else {

            const data = await prisma.user.findMany({ include: { user_type: true } });

            const newData = []
            for (let item of data) {
                let user = {
                    maNguoiDung: item.maNguoiDung,
                    taiKhoan: item.taiKhoan,
                    hinhAnh: item.hinhAnh !== null ? (process.env.BASE_URL + '/public/avatar/' + item.hinhAnh) : null,
                    hoTen: item.hoTen,
                    soDT: item.soDT,
                    email: item.email,
                    loaiNguoiDung: item.user_type
                }
                newData.push(user)
            }
            res.status(200).json({ data: newData });
        }

    } catch (err) {
        res.status(500).json(err);
    };
};


const getAUser = async (req, res) => {
    try {

        const { maNguoiDung } = req.query;

        const findUser = await prisma.user.findFirst({
            where: { maNguoiDung },
            include: {
                user_type: true
            }
        });

        if (!findUser) {
            return res.status(404).json({ message: message.NOT_FOUND });
        };

        const data = {
            hoTen: findUser.hoTen,
            hinhAnh: findUser.hinhAnh !== null ? (process.env.BASE_URL + '/public/avatar/' + item.hinhAnh) : null,
            taiKhoan: findUser.taiKhoan,
            email: findUser.email,
            soDT: findUser.soDT,
            loaiNguoiDung: findUser.user_type
        }

        res.status(200).json({ data });

    } catch (err) {
        res.status(500).json(err);
    };
};

const getUserPagination = async (req, res) => {
    try {

        const { page, perPage, hoTen } = req.query;

        const Page = Number(page);
        const PerPage = Number(perPage);
        if (Page <= 0) Page = 1;
        if (PerPage <= 0) PerPage = 10;

        const total = await prisma.user.count();
        const totalPage = Math.ceil(total / PerPage);
        const currentPage = Math.min(Page, totalPage);
        const skip = (currentPage - 1) * PerPage;

        if (hoTen) {
            const dataSearch = await prisma.user.findMany({
                where: {
                    hoTen: {
                        contains: hoTen
                    }
                },
                take: PerPage,
                skip: skip,
                include: {
                    user_type: true,
                }
            });

            if (dataSearch.length <= 0) {
                return res.status(204).json({ message: message.NOT_FOUND });
            }

            const data = dataSearch.map(ele => ({
                hoTen: ele.hoTen,
                taiKhoan: ele.taiKhoan,
                email: ele.email,
                soDT: ele.soDT,
                hinhAnh: ele.hinhAnh !== null ? (process.env.BASE_URL + '/public/avatar/' + item.hinhAnh) : null,
                loaiNguoiDung: ele.user_type
            }))

            return res.status(200).json({ data, total, totalPage, currentPage });
        } else {

            const findData = await prisma.user.findMany({
                take: PerPage,
                skip
            });

            const data = findData.map(ele => ({
                hoTen: ele.hoTen,
                taiKhoan: ele.taiKhoan,
                email: ele.email,
                soDT: ele.soDT,
                hinhAnh: ele.hinhAnh !== null ? (process.env.BASE_URL + '/public/avatar/' + item.hinhAnh) : null,
                loaiNguoiDung: ele.user_type
            }));

            return res.status(200).json({ data, total, totalPage, currentPage });

        }


    } catch (err) {
        res.status(500).json(err);
    };
};

const fetchProfileAccount = async (req, res) => {
    try {

        const findUser = await prisma.user.findFirst({
            where: { maNguoiDung: req.user.maNguoiDung },
            include: {
                user_type: true,
            }
        });

        if (!findUser) {
            return res.status(404).json({ message: message.NOT_FOUND });
        };

        const data = {
            maNguoiDung: findUser.maNguoiDung,
            taiKhoan: findUser.taiKhoan,
            hoTen: findUser.hoTen,
            hinhAnh: findUser.hinhAnh !== null ? (process.env.BASE_URL + '/public/avatar/' + findUser.hinhAnh) : null,
            email: findUser.email,
            soDT: findUser.soDT,
            loaiNguoiDung: findUser.user_type,
        };



        res.status(200).json({ data })

    } catch (err) {
        res.status(500).json(err);
    };
};

const createUser = async (req, res) => {
    try {

        const { taiKhoan, matKhau, hoTen, soDT, email, maLoaiNguoiDung } = req.body;

        const { filename } = req.file;
        const image = filename

        const directoryPath = process.cwd() + '/public/avatar/';


        const findAccount = await prisma.user.findFirst({
            where: { taiKhoan: String(taiKhoan) }
        });

        if (findAccount) {
            if (fs.existsSync(directoryPath + filename)) {
                fs.unlinkSync(directoryPath + filename)
            }

            return res.status(404).json({ message: "Tài Khoản Đã Tồn Tại !" });

        }

        const findEmail = await prisma.user.findFirst({
            where: { email: String(email) }
        });

        if (findEmail) {
            if (fs.existsSync(directoryPath + filename)) {
                fs.unlinkSync(directoryPath + filename)
            }
            return res.status(404).json({ message: 'Email đã tồn tại !' });
        };

        const findUserType = await prisma.user_type.findFirst({
            where: { maLoaiNguoiDung: String(maLoaiNguoiDung) }
        });

        if (!findUserType) {
            if (fs.existsSync(directoryPath + filename)) {
                fs.unlinkSync(directoryPath + filename)
            }
            return res.status(404).json({ message: 'Loại người dùng không tồn tại !' })
        }




        const newData = await prisma.user.create({
            data: { taiKhoan, matKhau: authController.hashPass(matKhau), hinhAnh: image, hoTen, soDT, email, maLoaiNguoiDung: maLoaiNguoiDung }
        })


        const data = {
            ...newData,
            hinhAnh: process.env.BASE_URL + '/public/avatar/' + newData.hinhAnh
        }

        res.status(200).json({ data, message: 'Tạo tài Khoản Thành Công !' })

    } catch (err) {

        const directoryPath = process.cwd() + '/public/avatar/';

        if (fs.existsSync(directoryPath + filename)) {
            fs.unlinkSync(directoryPath + filename)
        }
        res.status(500).json(err);
    };
};

const updateUser = async (req, res) => {
    try {

        const { maNguoiDung } = req.query;
        const { taiKhoan, matKhau, hoTen, email, soDT, maLoaiNguoiDung } = req.body;
        const { file } = req;


        const findUser = await prisma.user.findFirst({
            where: { maNguoiDung }
        });

        if (!findUser) {
            const directoryPath = process.cwd() + '/public/avatar/';

            if (fs.existsSync(directoryPath + filename)) {
                fs.unlinkSync(directoryPath + filename)
            }
            return res.status(404).json({ message: message.NOT_FOUND });
        };

        await prisma.user.update({
            where: { maNguoiDung },
            data: {
                taiKhoan,
                matKhau,
                hoTen,
                email,
                soDT,
                maLoaiNguoiDung,
                hinhAnh: file.filename
            }
        });

        res.status(200).json({ message: message.UPDATE });


    } catch (err) {
        const directoryPath = process.cwd() + '/public/avatar/';

        if (fs.existsSync(directoryPath + filename)) {
            fs.unlinkSync(directoryPath + filename)
        }
        res.status(500).json(err);
    };
};



const deleteUser = async (req, res) => {
    try {

        const { maNguoiDung } = req.query;

        const find = await prisma.user.findFirst({ where: { maNguoiDung: String(maNguoiDung) } })

        if (!find) {
            return res.status(404).json({ message: "Không tìm thấy tài khoản !" })
        }

        await prisma.user.delete({ where: { maNguoiDung: String(maNguoiDung) } });

        res.status(200).json({ message: "Xóa thành công !" });

    } catch (err) {
        res.status(500).json(err);
    };
};



/**
 * USER TYPE
 */
const getAllUserType = async (req, res) => {
    try {

        const data = await prisma.user_type.findMany();

        res.status(200).json({ data });

    } catch (err) {
        res.status(500).json(err);
    };
};

const getAUserType = async (req, res) => {
    try {

        const { maLoaiNguoiDung } = req.query;

        const data = await prisma.user_type.findUnique({
            where: { maLoaiNguoiDung: String(maLoaiNguoiDung) }
        });

        if (!data) {
            return res.status(404).json({ message: 'Không Tìm Thấy Loại Người Dùng !' });
        }

        res.status(200).json({ data })

    } catch (err) {
        res.status(500).json(err);
    };
};

const createUserType = async (req, res) => {
    try {


        const { loaiNguoiDung } = req.body;

        const find = await prisma.user_type.findFirst({
            where: { loaiNguoiDung: String(loaiNguoiDung) }
        });

        if (find) {
            return res.status(404).json({ message: "Loại Người Dùng Đã Tồn Tại !" });
        }

        const data = await prisma.user_type.create({ data: { loaiNguoiDung } });

        res.status(200).json({ data, message: 'Thêm Loại Người Dùng Thành Công !' });

    } catch (err) {
        res.status(500).json(err);
    };
};

const updateUserType = async (req, res) => {
    try {

        const { maLoaiNguoiDung } = req.query;
        const { loaiNguoiDung } = req.body;

        const data = await prisma.user_type.update({
            where: { maLoaiNguoiDung: String(maLoaiNguoiDung) },
            data: { loaiNguoiDung }
        });

        res.status(200).json({ data, message: 'Cập Nhật Thành Công !' });

    } catch (err) {
        res.status(500).json(err);
    };
};

const deleteUserType = async (req, res) => {
    try {

        const { maLoaiNguoiDung } = req.query;

        const find = await prisma.user_type.findUnique({
            where: { maLoaiNguoiDung: String(maLoaiNguoiDung) },
        });
        console.log(find)

        if (!find) {
            return res.status(404).json({ message: 'Không Tìm Thấy Loại Người Dùng !' });
        }

        await prisma.user_type.delete({
            where: { maLoaiNguoiDung: String(maLoaiNguoiDung) },
        });

        res.status(200).json({ message: 'Xóa Thành Công !' })

    } catch (err) {
        res.status(500).json(err);
    };
};


module.exports = {
    /***   GET TOKEN ACCESS   ***/
    getTokenAccess,
    /***  USER LOGIN   ***/
    registerUser,
    loginUser,

    /*****  USER MANAGEMENT   *****/
    getAllUser,
    getAUser,
    getUserPagination,
    fetchProfileAccount,
    createUser,
    updateUser,
    deleteUser,

    /////// USER TYPE   ////////
    getAllUserType,
    getAUserType,
    createUserType,
    updateUserType,
    deleteUserType,

}