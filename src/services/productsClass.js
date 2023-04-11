class Product {
    constructor(
        maSanPham, 
        tenSanPham,
        moTa,
        khuyenMai,
        tongSoLuong,
        maDanhMucNho,
        createAt,
        upudateAt,
        giamGia,
        giaGoc
    ) {

        this.maSanPham = maSanPham; 
        this.tenSanPham = tenSanPham;
        this.moTa = moTa;
        this.khuyenMai = khuyenMai;
        this.tongSoLuong = tongSoLuong;
        this.maDanhMucNho = maDanhMucNho;
        this.createAt = createAt;
        this.upudateAt = upudateAt;
        this.giamGia = giamGia;
        this.giaGoc = giaGoc;
        
    }
}

const product = new Product()

module.exports = product