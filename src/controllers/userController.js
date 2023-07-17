const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();
const authController = require("./authController");
const fs = require("fs");
const { generateToken } = require("./authController");
const message = require("../services/message");
const sendMail = require("../middleware/sendMailMiddleware");
require("dotenv").config();
const OtpGenerator = require("otp-generator");
const cron = require("node-cron");
const { emailConst } = require("../constants/emailConstants");

cron.schedule("* * * * *", async () => {
  const expirationTime = new Date(Date.now() - 5 * 1000);

  await prisma.otp_auth.deleteMany({
    where: { deleteAt: { lt: expirationTime } },
  });
});

const getTokenAccess = async (req, res) => {
  try {
    const Token = generateToken(req.user, "1y");

    res.status(200).json({ token: Token });
  } catch (err) {
    res.status(500).json(err);
  }
};

/** forgot password and cheking OTP */
const forgetPassWord = async (req, res) => {
  try {
    const { email } = req.body;

    const checkMail = await prisma.user.findFirst({
      where: { email },
    });

    if (!checkMail) {
      return res.status(404).json({ message: message.EMAIL_NOTFOUND });
    }

    const findOTP = await prisma.otp_auth.findMany({
      where: { email },
    });

    if (findOTP.length > 0) {
      await prisma.otp_auth.deleteMany({
        where: { email },
      });
    }

    const OtpNumber = OtpGenerator.generate(6, {
      digits: true,
      lowerCaseAlphabets: false,
      upperCaseAlphabets: false,
      specialChars: false,
    });

    const expirationTime = 600 * 1000;
    await prisma.otp_auth.create({
      data: {
        email: checkMail.email,
        otp: OtpNumber,
        deleteAt: new Date(Date.now() + expirationTime),
      },
    });

    await sendMail({
      to: checkMail.email,
      from: emailConst.EMAIL_FROM,
      templateId: emailConst.TEMPLATE_ID,
      dynamic_template_data: {
        password: OtpNumber,
      },
    });

    res.status(200).json({ message: message.SEND_OTP });
  } catch (err) {
    res.status(500).json(err);
  }
};

const checkOtpAndChangePassword = async (req, res) => {
  try {
    const { otp } = req.body;

    const checkOTP = await prisma.otp_auth.findFirst({
      where: { otp },
    });

    if (!checkOTP) {
      return res.status(404).json({ message: message.OTP_EXPIRED });
    }

    const newPassword = OtpGenerator.generate(8, {
      digits: true,
      lowerCaseAlphabets: true,
      upperCaseAlphabets: true,
      specialChars: false,
    });

    const changPass = await prisma.user.update({
      where: { email: checkOTP.email },
      data: { matKhau: authController.hashPass(newPassword) },
    });

    const data = {
      taiKhoan: changPass.taiKhoan,
      email: changPass.email,
      matKhau: newPassword,
    };

    res.status(200).json({ data, message: message.CHANGE_PASSWORD_SUCCES });
  } catch (err) {
    res.status(500).json(err);
  }
};

/** Chang pass word with account */
const changePasswordWithAccount = async (req, res) => {
  try {
    const { maNguoiDung } = req.query;
    const { matKhauCu, matKhauMoi } = req.body;

    const findAccount = await prisma.user.findUnique({
      where: { maNguoiDung },
    });

    if (!findAccount) {
      return res.status(404).json({ message: message.NOT_FOUND });
    }

    const checkPassword = authController.comparePass(
      matKhauCu,
      findAccount.matKhau
    );

    if (!checkPassword) {
      return res.status(400).json({ message: message.WRONG_PASSWORD });
    }

    await prisma.user.update({
      where: { maNguoiDung },
      data: { matKhau: authController.hashPass(matKhauMoi) },
    });

    res.status(200).json({ message: message.CHANGE_PASSWORD_SUCCES });
  } catch (err) {
    res.status(500).json(err);
  }
};

///////////////////////
const getAllOTP = async (req, res) => {
  try {
    const find = await prisma.otp_auth.findMany();

    res.status(200).json({ data: find });
  } catch (err) {
    res.status(500).json(err);
  }
};

/// register ///
const registerUser = async (req, res) => {
  try {
    const { taiKhoan, matKhau, hoTen, soDT, email, loaiNguoiDung } = req.body;

    const findTaiKhoan = await prisma.user.findMany({
      where: { taiKhoan: String(taiKhoan) },
    });

    const findUserType = await prisma.user_type.findFirst({
      where: { loaiNguoiDung },
    });

    if (!findUserType) {
      return res.status(404).json({ message: "Loại người dùng không hợp lệ!" });
    }

    if (findTaiKhoan.length > 0) {
      return res.status(404).json({ message: "Tài khoản đã tổn tài !" });
    }

    const findEmail = await prisma.user.findMany({
      where: { email: String(email) },
    });

    if (findEmail.length > 0) {
      return res.status(404).json({ message: "Email đã tồn tại !" });
    }

    const data = {
      taiKhoan,
      matKhau: authController.hashPass(matKhau),
      hoTen,
      soDT,
      email,
      maLoaiNguoiDung: findUserType.maLoaiNguoiDung,
    };

    const Newdata = await prisma.user.create({ data });

    res
      .status(200)
      .json({ data: Newdata, message: "Tạo tài khoản thành công !" });
  } catch (err) {
    res.status(500).json(err);
  }
};

const loginUser = async (req, res) => {
  try {
    const { taiKhoan, matKhau } = req.body;
    const checkTaiKhoan = await prisma.user.findFirst({
      where: { taiKhoan: String(taiKhoan) },
    });

    if (checkTaiKhoan) {
      const checkMatKhau = await authController.comparePass(
        matKhau,
        checkTaiKhoan.matKhau
      );

      if (checkMatKhau) {
        const token = await authController.generateToken(
          { maNguoiDung: checkTaiKhoan.maNguoiDung },
          "1h"
        );

        let expired = new Date(new Date().getTime() + 1 * 60 * 60 * 1000);

        const refreshToken = authController.generateToken(
          { maNguoiDung: checkTaiKhoan.maNguoiDung },
          "3m"
        );

        return res.status(200).json({
          data: { token, refreshToken, expiredAt: expired },
          message: "Đăng nhập thành công !",
        });
      } else {
        return res.status(404).json({ message: "Mật khẩu không hợp lệ !" });
      }
    } else {
      return res.status(404).json({ message: "Tài khoảng không tồn tại !" });
    }
  } catch (err) {
    res.status(500).json(err);
  }
};

/** refresh get access token */

const getRefreshToken = async (req, res) => {
  try {
    const { tokenRefresh } = req.query;

    const decode = authController.verifyToken(tokenRefresh);

    const findUser = await prisma.user.findUnique({
      where: { maNguoiDung: decode.maNguoiDung },
    });

    if (!findUser) {
      return res.status(404).json({ message: message.REFRESH_TOKEN_FAIL });
    }

    const newAccessToken = authController.generateToken(
      { maNguoiDung: findUser.maNguoiDung },
      "1h"
    );
    const newRefreshToken = authController.generateToken(
      { maNguoiDung: findUser.maNguoiDung },
      "3m"
    );
    let expired = new Date(new Date().getTime() + 1 * 60 * 60 * 1000);

    res.status(200).json({
      token: newAccessToken,
      refreshToken: newRefreshToken,
      expiredAt: expired,
      message: message.REFRESH_TOKEN_SUCCESS,
    });
  } catch (err) {
    res.status(500).json({ message: message.REFRESH_TOKEN_FAIL });
  }
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
            contains: hoTen,
          },
        },
        include: {
          user_type: true,
        },
      });

      if (findUserByName.length <= 0) {
        return res.status(404).json({ message: message.NOT_FOUND });
      }

      const newData = [];
      for (let item of findUserByName) {
        let user = {
          maNguoiDung: item.maNguoiDung,
          taiKhoan: item.taiKhoan,
          hinhAnh:
            item.hinhAnh !== null
              ? process.env.SERVER_URL + "/public/avatar/" + item.hinhAnh
              : null,
          hoTen: item.hoTen,
          soDT: item.soDT,
          email: item.email,
          loaiNguoiDung: item.user_type,
        };
        newData.push(user);
      }

      res.status(200).json({ data: newData });
    } else {
      const data = await prisma.user.findMany({ include: { user_type: true } });

      const newData = [];
      for (let item of data) {
        let user = {
          maNguoiDung: item.maNguoiDung,
          taiKhoan: item.taiKhoan,
          hinhAnh:
            item.hinhAnh !== null
              ? process.env.SERVER_URL + "/public/avatar/" + item.hinhAnh
              : null,
          hoTen: item.hoTen,
          soDT: item.soDT,
          email: item.email,
          loaiNguoiDung: item.user_type,
        };
        newData.push(user);
      }
      res.status(200).json({ data: newData });
    }
  } catch (err) {
    res.status(500).json(err);
  }
};

const getAUser = async (req, res) => {
  try {
    const { maNguoiDung } = req.query;
    const findUser = await prisma.user.findFirst({
      where: { maNguoiDung },
      include: {
        user_type: true,
      },
    });

    if (!findUser) {
      return res.status(404).json({ message: message.NOT_FOUND });
    }
   
    const data = {
      maNguoiDung: findUser.maNguoiDung,
      taiKhoan: findUser.taiKhoan,
      hinhAnh:
        findUser.hinhAnh !== null
          ? process.env.SERVER_URL + "/public/avatar/" + findUser.hinhAnh
          : null,
      hoTen: findUser.hoTen,
      soDT: findUser.soDT,
      email: findUser.email,
      loaiNguoiDung: findUser.user_type,
    };

    res.status(200).json({ data });
  } catch (err) {
    res.status(500).json(err);
  }
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
            contains: hoTen,
          },
        },
        take: PerPage,
        skip: skip,
        include: {
          user_type: true,
        },
      });

      if (dataSearch.length <= 0) {
        return res.status(204).json({ message: message.NOT_FOUND });
      }

      const data = dataSearch.map((ele) => ({
        maNguoiDung: ele.maNguoiDung,
        hoTen: ele.hoTen,
        taiKhoan: ele.taiKhoan,
        email: ele.email,
        soDT: ele.soDT,
        hinhAnh:
          ele.hinhAnh !== null
            ? process.env.SERVER_URL + "/public/avatar/" + item.hinhAnh
            : null,
        loaiNguoiDung: ele.user_type,
      }));

      return res.status(200).json({ data, total, totalPage, currentPage });
    } else {
      const findData = await prisma.user.findMany({
        take: PerPage,
        skip,
        include: {
          user_type: true
        }
      });

      const data = findData.map(user => ({
        maNguoiDung: user.maNguoiDung,
        taiKhoan: user.taiKhoan,
        hoTen: user.hoTen,
        colorTheme: user.colorTheme,
        soDT: user.soDT,
        email: user.email,
        loaiNguoiDung: user.user_type,
        hinhAnh: user.hinhAnh !== null ? process.env.SERVER_URL + '/public/avatar/' + user.hinhAnh : null
      }))
    
      return res.status(200).json({ data, total, totalPage, currentPage });
    }
  } catch (err) {
    res.status(500).json(err);
  }
};

const fetchProfileAccount = async (req, res) => {
  try {
    const findUser = await prisma.user.findFirst({
      where: { maNguoiDung: req.user.maNguoiDung },
      include: {
        user_type: true,
      },
    });

    if (!findUser) {
      return res.status(404).json({ message: message.NOT_FOUND });
    }

    const data = {
      maNguoiDung: findUser.maNguoiDung,
      taiKhoan: findUser.taiKhoan,
      hoTen: findUser.hoTen,
      hinhAnh:
        findUser.hinhAnh !== null
          ? process.env.SERVER_URL + "/public/avatar/" + findUser.hinhAnh
          : null,
      email: findUser.email,
      soDT: findUser.soDT,
      loaiNguoiDung: findUser.user_type,
    };

    res.status(200).json({ data });
  } catch (err) {
    res.status(500).json(err);
  }
};

const createUser = async (req, res) => {
  try {
    const { taiKhoan, matKhau, hoTen, soDT, email, maLoaiNguoiDung } = req.body;
    const directoryPath = process.cwd() + "/public/avatar/";

    const findAccount = await prisma.user.findFirst({
      where: { taiKhoan: String(taiKhoan) },
    });

    if (findAccount) {
      if (req.file) {
        if (fs.existsSync(directoryPath + req.file.filename)) {
          fs.unlinkSync(directoryPath + req.file.filename);
        }
      }

      return res.status(404).json({ message: "Tài Khoản Đã Tồn Tại !" });
    }

    const findEmail = await prisma.user.findFirst({
      where: { email: String(email) },
    });

    if (findEmail) {
      if (fs.existsSync(directoryPath + filename)) {
        fs.unlinkSync(directoryPath + filename);
      }
      return res.status(404).json({ message: "Email đã tồn tại !" });
    }

    const findUserType = await prisma.user_type.findFirst({
      where: { maLoaiNguoiDung: String(maLoaiNguoiDung) },
    });

    if (!findUserType) {
      if (fs.existsSync(directoryPath + filename)) {
        fs.unlinkSync(directoryPath + filename);
      }
      return res
        .status(404)
        .json({ message: "Loại người dùng không tồn tại !" });
    }

    const newData = await prisma.user.create({
      data: {
        taiKhoan,
        matKhau: authController.hashPass(matKhau),
        hinhAnh: req.file && req.file.filename,
        hoTen,
        soDT,
        email,
        maLoaiNguoiDung: maLoaiNguoiDung,
      },
    });

    const data = {
      ...newData,
      hinhAnh: process.env.SERVER_URL + "/public/avatar/" + newData.hinhAnh,
    };

    res.status(200).json({ data, message: "Tạo tài Khoản Thành Công !" });
  } catch (err) {
    console.log(req.file);
    const directoryPath = process.cwd() + "/public/avatar/";

    if (req.file) {
      if (fs.existsSync(directoryPath + req.file.filename)) {
        fs.unlinkSync(directoryPath + req.file.filename);
      }
    }
    res.status(500).json(err);
  }
};

const updateUser = async (req, res) => {
  try {
    const { maNguoiDung } = req.query;
    const { taiKhoan, matKhau, hoTen, email, soDT, maLoaiNguoiDung } = req.body;
    const { file } = req;

    const findUser = await prisma.user.findFirst({
      where: { maNguoiDung },
    });

    const directoryPath = process.cwd() + "/public/avatar/";
    if (!findUser) {
      if (file) {
        if (fs.existsSync(directoryPath + file.filename)) {
          fs.unlinkSync(directoryPath + file.filename);
        }
      }
      return res.status(404).json({ message: message.NOT_FOUND });
    }

    if (file && findUser.hinhAnh) {
      if (fs.existsSync(directoryPath + findUser.hinhAnh)) {
        fs.unlinkSync(directoryPath + findUser.hinhAnh);
      }
    }
    await prisma.user.update({
      where: { maNguoiDung },
      data: {
        taiKhoan,
        matKhau,
        hoTen,
        email,
        soDT,
        maLoaiNguoiDung,
        hinhAnh: file && file.filename,
      },
    });

    res.status(200).json({ message: message.UPDATE });
  } catch (err) {
    const { filename } = req.file;
    const directoryPath = process.cwd() + "/public/avatar/";

    if (filename) {
      if (fs.existsSync(directoryPath + filename)) {
        fs.unlinkSync(directoryPath + filename);
      }
    }
    res.status(500).json(err);
  }
};

const deleteUser = async (req, res) => {
  try {
    const { maNguoiDung } = req.query;

    const find = await prisma.user.findFirst({
      where: { maNguoiDung: String(maNguoiDung) },
    });

    if (!find) {
      return res.status(404).json({ message: "Không tìm thấy tài khoản !" });
    }

    await prisma.user.delete({ where: { maNguoiDung: String(maNguoiDung) } });

    res.status(200).json({ message: "Xóa thành công !" });
  } catch (err) {
    res.status(500).json(err);
  }
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
  }
};

const getAUserType = async (req, res) => {
  try {
    const { maLoaiNguoiDung } = req.query;

    const data = await prisma.user_type.findUnique({
      where: { maLoaiNguoiDung: String(maLoaiNguoiDung) },
    });

    if (!data) {
      return res
        .status(404)
        .json({ message: "Không Tìm Thấy Loại Người Dùng !" });
    }

    res.status(200).json({ data });
  } catch (err) {
    res.status(500).json(err);
  }
};

const createUserType = async (req, res) => {
  try {
    const { loaiNguoiDung } = req.body;

    const find = await prisma.user_type.findFirst({
      where: { loaiNguoiDung: String(loaiNguoiDung) },
    });

    if (find) {
      return res.status(404).json({ message: "Loại Người Dùng Đã Tồn Tại !" });
    }

    const data = await prisma.user_type.create({ data: { loaiNguoiDung } });

    res
      .status(200)
      .json({ data, message: "Thêm Loại Người Dùng Thành Công !" });
  } catch (err) {
    res.status(500).json(err);
  }
};

const updateUserType = async (req, res) => {
  try {
    const { maLoaiNguoiDung } = req.query;
    const { loaiNguoiDung } = req.body;

    const data = await prisma.user_type.update({
      where: { maLoaiNguoiDung: String(maLoaiNguoiDung) },
      data: { loaiNguoiDung },
    });

    res.status(200).json({ data, message: "Cập Nhật Thành Công !" });
  } catch (err) {
    res.status(500).json(err);
  }
};

const deleteUserType = async (req, res) => {
  try {
    const { maLoaiNguoiDung } = req.query;

    const find = await prisma.user_type.findUnique({
      where: { maLoaiNguoiDung: String(maLoaiNguoiDung) },
    });
    if (!find) {
      return res
        .status(404)
        .json({ message: "Không Tìm Thấy Loại Người Dùng !" });
    }

    await prisma.user_type.delete({
      where: { maLoaiNguoiDung: String(maLoaiNguoiDung) },
    });

    res.status(200).json({ message: "Xóa Thành Công !" });
  } catch (err) {
    res.status(500).json(err);
  }
};

module.exports = {
  getAllOTP,
  checkOtpAndChangePassword,
  changePasswordWithAccount,
  /***   GET TOKEN ACCESS   ***/
  getTokenAccess,
  forgetPassWord,
  /***  USER LOGIN   ***/
  registerUser,
  loginUser,
  getRefreshToken,

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
};
