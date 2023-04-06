-- CreateTable
CREATE TABLE `banner` (
    `maBaner` INTEGER NOT NULL AUTO_INCREMENT,
    `hinhAnh` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`maBaner`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `user` (
    `maNguoiDung` INTEGER NOT NULL AUTO_INCREMENT,
    `taiKhoan` VARCHAR(191) NOT NULL,
    `matKhau` VARCHAR(191) NOT NULL,
    `hinhAnh` VARCHAR(191) NULL,
    `hoTen` VARCHAR(191) NOT NULL,
    `soDT` VARCHAR(191) NULL,
    `email` VARCHAR(191) NOT NULL,
    `maLoaiNguoiDung` INTEGER NOT NULL,
    `createAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updateAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `User_user_id_key`(`maNguoiDung`),
    INDEX `user_maLoaiNguoiDung_fkey`(`maLoaiNguoiDung`),
    PRIMARY KEY (`maNguoiDung`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `user_type` (
    `maLoaiNguoiDung` INTEGER NOT NULL AUTO_INCREMENT,
    `loaiNguoiDung` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `user_type_maLoaiNguoiDung_key`(`maLoaiNguoiDung`),
    PRIMARY KEY (`maLoaiNguoiDung`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `menu` (
    `maMenu` INTEGER NOT NULL AUTO_INCREMENT,
    `logo` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `menu_maMenu_key`(`maMenu`),
    PRIMARY KEY (`maMenu`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `news` (
    `maTinTuc` INTEGER NOT NULL AUTO_INCREMENT,
    `tieuDe` VARCHAR(191) NOT NULL,
    `noiDung` VARCHAR(191) NOT NULL,
    `maNguoiDang` INTEGER NOT NULL,
    `maLoaiTinTuc` INTEGER NOT NULL,
    `createAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updateAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `news_maTinTuc_key`(`maTinTuc`),
    INDEX `news_maLoaiTinTuc_fkey`(`maLoaiTinTuc`),
    INDEX `news_maNguoiDang_fkey`(`maNguoiDang`),
    PRIMARY KEY (`maTinTuc`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `news_image` (
    `maHinhAnh` INTEGER NOT NULL AUTO_INCREMENT,
    `hinhAnh` VARCHAR(191) NOT NULL,
    `maTinTuc` INTEGER NOT NULL,

    UNIQUE INDEX `news_image_maHinhAnh_key`(`maHinhAnh`),
    INDEX `news_image_maTinTuc_fkey`(`maTinTuc`),
    PRIMARY KEY (`maHinhAnh`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `news_type` (
    `maLoaiTinTuc` INTEGER NOT NULL AUTO_INCREMENT,
    `loaiTinTuc` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `news_type_maLoaiTinTuc_key`(`maLoaiTinTuc`),
    PRIMARY KEY (`maLoaiTinTuc`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `products` (
    `maSanPham` INTEGER NOT NULL AUTO_INCREMENT,
    `tenSanPham` VARCHAR(191) NOT NULL,
    `moTa` VARCHAR(191) NOT NULL,
    `gia` INTEGER NOT NULL,
    `giamGia` INTEGER NOT NULL,
    `khuyenMai` INTEGER NOT NULL,
    `tongSoLuong` INTEGER NOT NULL,
    `maDanhMucNho` INTEGER NOT NULL,

    UNIQUE INDEX `products_maSanPham_key`(`maSanPham`),
    INDEX `products_maDanhMucNho_fkey`(`maDanhMucNho`),
    PRIMARY KEY (`maSanPham`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `status` (
    `maTrangThai` INTEGER NOT NULL AUTO_INCREMENT,
    `trangThai` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `status_maTrangThai_key`(`maTrangThai`),
    PRIMARY KEY (`maTrangThai`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `oders` (
    `maDonHang` INTEGER NOT NULL AUTO_INCREMENT,
    `tenKhachHang` VARCHAR(191) NOT NULL,
    `diaChi` VARCHAR(191) NOT NULL,
    `soDT` VARCHAR(191) NOT NULL,
    `tongTien` VARCHAR(191) NOT NULL,
    `loiNhan` VARCHAR(191) NULL,
    `note` VARCHAR(191) NULL,
    `maSanPham` INTEGER NOT NULL,
    `maTrangThai` INTEGER NOT NULL,

    UNIQUE INDEX `oders_maDonHang_key`(`maDonHang`),
    INDEX `oders_maSanPham_fkey`(`maSanPham`),
    INDEX `oders_maTrangThai_fkey`(`maTrangThai`),
    PRIMARY KEY (`maDonHang`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `comments` (
    `maComment` INTEGER NOT NULL AUTO_INCREMENT,
    `noiDung` VARCHAR(191) NOT NULL,
    `tenNguoiCommnet` VARCHAR(191) NOT NULL,
    `maSanPham` INTEGER NOT NULL,

    UNIQUE INDEX `comments_maComment_key`(`maComment`),
    INDEX `comments_maSanPham_fkey`(`maSanPham`),
    PRIMARY KEY (`maComment`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `rates` (
    `maDanhGia` INTEGER NOT NULL AUTO_INCREMENT,
    `soSao` INTEGER NOT NULL,

    UNIQUE INDEX `rates_maDanhGia_key`(`maDanhGia`),
    PRIMARY KEY (`maDanhGia`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `rates_products` (
    `maSanPham` INTEGER NOT NULL,
    `maDanhGia` INTEGER NOT NULL,

    INDEX `rates_products_maDanhGia_fkey`(`maDanhGia`),
    PRIMARY KEY (`maSanPham`, `maDanhGia`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `maincategories` (
    `maDanhMucChinh` INTEGER NOT NULL AUTO_INCREMENT,
    `tenDanhMuc` VARCHAR(191) NOT NULL,
    `icon` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `mainCategories_maDanhMucChinh_key`(`maDanhMucChinh`),
    PRIMARY KEY (`maDanhMucChinh`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `navlink` (
    `maNavLink` INTEGER NOT NULL AUTO_INCREMENT,
    `tenNavLink` VARCHAR(191) NOT NULL,
    `maMenu` INTEGER NOT NULL,

    UNIQUE INDEX `navLink_maNavLink_key`(`maNavLink`),
    INDEX `navLink_maMenu_fkey`(`maMenu`),
    PRIMARY KEY (`maNavLink`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `subcategories` (
    `maDanhMucNho` INTEGER NOT NULL AUTO_INCREMENT,
    `tenDanhMucNho` VARCHAR(191) NOT NULL,
    `icon` VARCHAR(191) NOT NULL,
    `maDanhMucChinh` INTEGER NOT NULL,

    UNIQUE INDEX `subCategories_maDanhMucNho_key`(`maDanhMucNho`),
    INDEX `subCategories_maDanhMucChinh_fkey`(`maDanhMucChinh`),
    PRIMARY KEY (`maDanhMucNho`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `contacts` (
    `maLienHe` INTEGER NOT NULL AUTO_INCREMENT,
    `soDT` VARCHAR(191) NOT NULL,
    `diaChi` VARCHAR(191) NOT NULL,
    `chuDe` VARCHAR(191) NULL,
    `noiDung` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `contacts_maLienHe_key`(`maLienHe`),
    PRIMARY KEY (`maLienHe`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `fixpost` (
    `maBaiViet` INTEGER NOT NULL AUTO_INCREMENT,
    `tieuDe` VARCHAR(191) NOT NULL,
    `noiDung` VARCHAR(191) NOT NULL,
    `tenKySu` VARCHAR(191) NULL,
    `hinhAnh` VARCHAR(191) NULL,

    UNIQUE INDEX `fixPost_maBaiViet_key`(`maBaiViet`),
    PRIMARY KEY (`maBaiViet`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ytview` (
    `maYT` INTEGER NOT NULL AUTO_INCREMENT,
    `tieuDe` VARCHAR(191) NULL,
    `url` VARCHAR(191) NOT NULL,
    `hinhAnh` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `YTView_maYT_key`(`maYT`),
    PRIMARY KEY (`maYT`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `user` ADD CONSTRAINT `user_maLoaiNguoiDung_fkey` FOREIGN KEY (`maLoaiNguoiDung`) REFERENCES `user_type`(`maLoaiNguoiDung`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `news` ADD CONSTRAINT `news_maLoaiTinTuc_fkey` FOREIGN KEY (`maLoaiTinTuc`) REFERENCES `news_type`(`maLoaiTinTuc`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `news` ADD CONSTRAINT `news_maNguoiDang_fkey` FOREIGN KEY (`maNguoiDang`) REFERENCES `user`(`maNguoiDung`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `news_image` ADD CONSTRAINT `news_image_maTinTuc_fkey` FOREIGN KEY (`maTinTuc`) REFERENCES `news`(`maTinTuc`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `products` ADD CONSTRAINT `products_maDanhMucNho_fkey` FOREIGN KEY (`maDanhMucNho`) REFERENCES `subcategories`(`maDanhMucNho`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `oders` ADD CONSTRAINT `oders_maSanPham_fkey` FOREIGN KEY (`maSanPham`) REFERENCES `products`(`maSanPham`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `oders` ADD CONSTRAINT `oders_maTrangThai_fkey` FOREIGN KEY (`maTrangThai`) REFERENCES `status`(`maTrangThai`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `comments` ADD CONSTRAINT `comments_maSanPham_fkey` FOREIGN KEY (`maSanPham`) REFERENCES `products`(`maSanPham`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `rates_products` ADD CONSTRAINT `rates_products_maDanhGia_fkey` FOREIGN KEY (`maDanhGia`) REFERENCES `rates`(`maDanhGia`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `rates_products` ADD CONSTRAINT `rates_products_maSanPham_fkey` FOREIGN KEY (`maSanPham`) REFERENCES `products`(`maSanPham`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `navlink` ADD CONSTRAINT `navLink_maMenu_fkey` FOREIGN KEY (`maMenu`) REFERENCES `menu`(`maMenu`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `subcategories` ADD CONSTRAINT `subCategories_maDanhMucChinh_fkey` FOREIGN KEY (`maDanhMucChinh`) REFERENCES `maincategories`(`maDanhMucChinh`) ON DELETE RESTRICT ON UPDATE CASCADE;
