const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();


  ////////////////////////////////////////
 ///////           USER         /////////               
////////////////////////////////////////

const getAllUser = async (req, res) => {
    try {

        const data = await prisma.user.findMany({include: {user_type: true}});
       
       const newData = []
        for(let item of data) {
        let user = {
            maNguoiDung: item.maNguoiDung,
            taiKhoan: item.taiKhoan,
            hinhAnh: process.env.BASE_URL + item.hinhAnh,
            soDT: item.soDT,
            email: item.email,
            loaiNguoiDung: item.user_type.loaiNguoiDung
        }
         newData.push(user)
       }
        res.status(200).json({data:newData})

    } catch (err) {
        res.status(500).json(err);
    };
};

const getAUser = async (req, res) => {
    try {

    } catch (err) {
        res.status(500).json(err);
    };
};

const createUser = async (req, res) => {
    try {
       
        const { taiKhoan, matKhau, hoTen, soDT, email, maLoaiNguoiDung} = req.body;

        const { filename } = req.file;
        const image = `/public/images/${filename}`

      
        const findAccount = await prisma.user.findFirst({
            where: {taiKhoan: String(taiKhoan)}
        });

        if (findAccount) {
            return res.status(404).json({message: "Tài Khoản Đã Tồn Tại !"});
        }

        const findEmail = await prisma.user.findFirst({
            where: {email: String(email)}
        });

        if (findEmail) {
            return res.status(404).json({message: 'Email đã tồn tại !'});
        };

        const findUserType = await prisma.user_type.findFirst({
            where:{maLoaiNguoiDung: Number(maLoaiNguoiDung)}
        });

        if ( !findUserType ) {
            return res.status(404).json({message: 'Loại người dùng không tồn tại !'})
        }

        const data = {taiKhoan, matKhau, hinhAnh: image, hoTen, soDT, email, maLoaiNguoiDung: Number(maLoaiNguoiDung) }

        

        const newData = await prisma.user.create({
            data
        })

        res.status(200).json({data: newData, message: 'Tạo tài Khoản Thành Công !'})

    } catch (err) {
        res.status(500).json(err);
    };
};

const updateUser = async (req, res) => {
    try {

    } catch (err) {
        res.status(500).json(err);
    };
};

const deleteUser = async (req, res) => {
    try {

        const { maNguoiDung } = req.query;

        const find = await prisma.user.findFirst({where: {maNguoiDung: Number(maNguoiDung)}})

        if(!find) {
            return res.status(404).json({message: "Không tìm thấy tài khoản !"})
        }

        await prisma.user.delete({where: {maNguoiDung: Number(maNguoiDung)}});

        res.status(200).json({message: "Xóa thành công !"});

    } catch (err) {
        res.status(500).json(err);
    };
};



  ////////////////////////////////////////
 ///////      USER TYPE         /////////               
////////////////////////////////////////

const getAllUserType = async (req, res) => {
    try {

        const data = await prisma.user_type.findMany();

        res.status(200).json({data});

    } catch (err) {
        res.status(500).json(err);
    };
};

const getAUserType = async (req, res) => {
    try {

        const { maLoaiNguoiDung } = req.query;

        const data = await prisma.user_type.findUnique({
            where: {maLoaiNguoiDung: Number(maLoaiNguoiDung)}
        });

        if (!data) {
            return res.status(404).json({message: 'Không Tìm Thấy Loại Người Dùng !'});
        }

        res.status(200).json({data})
        
    } catch (err) {
        res.status(500).json(err);
    };
};

const createUserType = async (req, res) => {
    try {


        const { loaiNguoiDung } = req.body;

        const find = await prisma.user_type.findFirst({
            where: {loaiNguoiDung: String(loaiNguoiDung)}
        });

        if(find) {
            return res.status(404).json({message: "Loại Người Dùng Đã Tồn Tại !"});
        }

        const data = await prisma.user_type.create({data: {loaiNguoiDung}});

        res.status(200).json({data, message: 'Thêm Loại Người Dùng Thành Công !'});

    } catch (err) {
        res.status(500).json(err);
    };
};

const updateUserType = async (req, res) => {
    try {

        const { maLoaiNguoiDung } = req.query;
        const { loaiNguoiDung } = req.body;

        const data = await prisma.user_type.update({
            where: { maLoaiNguoiDung: Number(maLoaiNguoiDung)},
            data: {loaiNguoiDung}
        });

        res.status(200).json({data, message: 'Cập Nhật Thành Công !'});

    } catch (err) {
        res.status(500).json(err);
    };
};

const deleteUserType = async (req, res) => {
    try {

        const { maLoaiNguoiDung } = req.query;

        const find = await prisma.user_type.findUnique({
            where: {maLoaiNguoiDung: Number(maLoaiNguoiDung)},
        });
        console.log(find)

        if (!find) {
            return res.status(404).json({message:'Không Tìm Thấy Loại Người Dùng !'});
        }

        await prisma.user_type.delete({
            where:{maLoaiNguoiDung: Number(maLoaiNguoiDung)},
        });
        
        res.status(200).json({message: 'Xóa Thành Công !'})

    } catch (err) {
        res.status(500).json(err);
    };
};


module.exports = {
    getAllUser,
    getAUser,
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