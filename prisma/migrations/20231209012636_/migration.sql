-- CreateTable
CREATE TABLE `banner` (
    `maBanner` VARCHAR(191) NOT NULL,
    `hinhAnh` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`maBanner`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `user` (
    `maNguoiDung` VARCHAR(191) NOT NULL,
    `taiKhoan` VARCHAR(191) NOT NULL,
    `matKhau` VARCHAR(191) NOT NULL,
    `hinhAnh` VARCHAR(191) NULL,
    `hoTen` VARCHAR(191) NOT NULL,
    `soDT` VARCHAR(191) NULL,
    `email` VARCHAR(191) NOT NULL,
    `theme` VARCHAR(191) NOT NULL DEFAULT 'dark',
    `maLoaiNguoiDung` VARCHAR(191) NOT NULL,
    `createAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updateAt` DATETIME(3) NOT NULL,
    `colorTheme` VARCHAR(191) NULL,
    `primaryColor` VARCHAR(191) NOT NULL DEFAULT '#39caf5',

    UNIQUE INDEX `user_taiKhoan_key`(`taiKhoan`),
    UNIQUE INDEX `user_email_key`(`email`),
    INDEX `user_maLoaiNguoiDung_fkey`(`maLoaiNguoiDung`),
    PRIMARY KEY (`maNguoiDung`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `user_type` (
    `maLoaiNguoiDung` VARCHAR(191) NOT NULL,
    `loaiNguoiDung` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`maLoaiNguoiDung`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `menu` (
    `maMenu` VARCHAR(191) NOT NULL,
    `logo` VARCHAR(191) NOT NULL,
    `active` BOOLEAN NOT NULL DEFAULT false,

    PRIMARY KEY (`maMenu`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `navlink` (
    `maNavLink` VARCHAR(191) NOT NULL,
    `tenNavLink` VARCHAR(191) NOT NULL,
    `url` VARCHAR(191) NULL,
    `maMenu` VARCHAR(191) NOT NULL,
    `role` INTEGER NOT NULL,

    UNIQUE INDEX `navlink_role_key`(`role`),
    INDEX `navLink_maMenu_fkey`(`maMenu`),
    PRIMARY KEY (`maNavLink`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `subNavLink` (
    `id` VARCHAR(191) NOT NULL,
    `url` VARCHAR(191) NOT NULL,
    `tenSubLink` VARCHAR(191) NOT NULL,
    `maNavLink` VARCHAR(191) NOT NULL,

    INDEX `subNavLink_maNavLink_fkey`(`maNavLink`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `news` (
    `maTinTuc` VARCHAR(191) NOT NULL,
    `tieuDe` VARCHAR(191) NOT NULL,
    `noiDung` LONGTEXT NOT NULL,
    `noiDungNgan` MEDIUMTEXT NOT NULL,
    `maNguoiDang` VARCHAR(191) NOT NULL,
    `maLoaiTinTuc` VARCHAR(191) NOT NULL,
    `createAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updateAt` DATETIME(3) NOT NULL,

    INDEX `news_maLoaiTinTuc_fkey`(`maLoaiTinTuc`),
    INDEX `news_maNguoiDang_fkey`(`maNguoiDang`),
    PRIMARY KEY (`maTinTuc`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `news_image` (
    `hinhAnh` VARCHAR(191) NOT NULL,
    `maTinTuc` VARCHAR(191) NOT NULL,
    `id` VARCHAR(191) NOT NULL,

    INDEX `news_image_maTinTuc_fkey`(`maTinTuc`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `news_type` (
    `maLoaiTinTuc` VARCHAR(191) NOT NULL,
    `loaiTinTuc` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`maLoaiTinTuc`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `products` (
    `maSanPham` VARCHAR(191) NOT NULL,
    `tenSanPham` VARCHAR(191) NOT NULL,
    `moTa` LONGTEXT NULL,
    `giaGoc` INTEGER NOT NULL,
    `giaGiam` INTEGER NOT NULL,
    `tongSoLuong` INTEGER NOT NULL,
    `maDanhMucNho` VARCHAR(191) NOT NULL,
    `createAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updateAt` DATETIME(3) NOT NULL,
    `hot` BOOLEAN NOT NULL DEFAULT false,
    `seo` BOOLEAN NOT NULL DEFAULT false,
    `seoDetail` LONGTEXT NULL,
    `seoTitle` VARCHAR(191) NULL,
    `moTaNgan` LONGTEXT NOT NULL,
    `youtubeVideo` LONGTEXT NULL,

    INDEX `products_maDanhMucNho_fkey`(`maDanhMucNho`),
    PRIMARY KEY (`maSanPham`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `image_product` (
    `id` VARCHAR(191) NOT NULL,
    `maSanPham` VARCHAR(191) NOT NULL,
    `hinhAnh` VARCHAR(191) NOT NULL,
    `hinhChinh` BOOLEAN NOT NULL DEFAULT false,

    INDEX `image_product_maSanPham_fkey`(`maSanPham`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `status` (
    `maTrangThai` VARCHAR(191) NOT NULL,
    `trangThai` VARCHAR(191) NOT NULL,
    `role` INTEGER NOT NULL,

    UNIQUE INDEX `status_role_key`(`role`),
    PRIMARY KEY (`maTrangThai`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `orders` (
    `maDonHang` VARCHAR(191) NOT NULL,
    `tenKhachHang` VARCHAR(191) NOT NULL,
    `diaChi` VARCHAR(191) NOT NULL,
    `soDT` VARCHAR(191) NOT NULL,
    `tongTien` INTEGER NOT NULL,
    `loiNhan` LONGTEXT NULL,
    `maTrangThai` VARCHAR(191) NOT NULL,
    `createAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updateAt` DATETIME(3) NOT NULL,
    `maDoUuTien` VARCHAR(191) NOT NULL,
    `keyIndex` INTEGER NOT NULL AUTO_INCREMENT,
    `phuongThucThanhToan` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `orders_keyIndex_key`(`keyIndex`),
    INDEX `oders_maTrangThai_fkey`(`maTrangThai`),
    INDEX `orders_maDoUuTien_fkey`(`maDoUuTien`),
    PRIMARY KEY (`maDonHang`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `orders_products` (
    `maDonHang` VARCHAR(191) NOT NULL,
    `maSanPham` VARCHAR(191) NOT NULL,
    `soLuongSanPham` INTEGER NOT NULL,

    INDEX `orders_products_maSanPham_fkey`(`maSanPham`),
    PRIMARY KEY (`maDonHang`, `maSanPham`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `comments` (
    `maComment` VARCHAR(191) NOT NULL,
    `noiDung` LONGTEXT NOT NULL,
    `maSanPham` VARCHAR(191) NOT NULL,
    `createAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updateAt` DATETIME(3) NOT NULL,
    `hoTen` VARCHAR(191) NULL,
    `admin` BOOLEAN NOT NULL DEFAULT false,

    INDEX `comments_maSanPham_fkey`(`maSanPham`),
    PRIMARY KEY (`maComment`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `rates` (
    `maDanhGia` VARCHAR(191) NOT NULL,
    `soSao` INTEGER NOT NULL,
    `soLuotDanhGia` INTEGER NOT NULL,
    `maSanPham` VARCHAR(191) NOT NULL,

    INDEX `rates_maSanPham_fkey`(`maSanPham`),
    PRIMARY KEY (`maDanhGia`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `maincategories` (
    `maDanhMucChinh` VARCHAR(191) NOT NULL,
    `tenDanhMuc` VARCHAR(191) NOT NULL,
    `role` INTEGER NOT NULL,
    `icon` LONGTEXT NOT NULL,

    UNIQUE INDEX `maincategories_role_key`(`role`),
    PRIMARY KEY (`maDanhMucChinh`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `subcategories` (
    `maDanhMucNho` VARCHAR(191) NOT NULL,
    `tenDanhMucNho` VARCHAR(191) NOT NULL,
    `icon` LONGTEXT NOT NULL,
    `maDanhMucChinh` VARCHAR(191) NOT NULL,

    INDEX `subCategories_maDanhMucChinh_fkey`(`maDanhMucChinh`),
    PRIMARY KEY (`maDanhMucNho`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `contacts` (
    `maLienHe` VARCHAR(191) NOT NULL,
    `soDT` VARCHAR(191) NOT NULL,
    `diaChi` VARCHAR(191) NULL,
    `chuDe` VARCHAR(191) NULL,
    `noiDung` LONGTEXT NOT NULL,
    `hinhAnh` LONGTEXT NULL,
    `hoTen` VARCHAR(191) NOT NULL,
    `createAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updateAt` DATETIME(3) NOT NULL,
    `maTrangThai` VARCHAR(191) NOT NULL,

    INDEX `contacts_maTrangThai_fkey`(`maTrangThai`),
    PRIMARY KEY (`maLienHe`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `contact_status` (
    `id` VARCHAR(191) NOT NULL,
    `role` INTEGER NOT NULL,
    `trangThai` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `contact_status_role_key`(`role`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `fixpost` (
    `maBaiViet` VARCHAR(191) NOT NULL,
    `tieuDe` VARCHAR(191) NOT NULL,
    `noiDung` LONGTEXT NOT NULL,
    `tenKySu` VARCHAR(191) NULL,
    `createAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updateAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`maBaiViet`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `fixpost_image` (
    `id` VARCHAR(191) NOT NULL,
    `hinhAnh` VARCHAR(191) NOT NULL,
    `maBaiViet` VARCHAR(191) NOT NULL,

    INDEX `fixpost_image_maBaiViet_fkey`(`maBaiViet`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ytview` (
    `maYT` VARCHAR(191) NOT NULL,
    `tieuDe` VARCHAR(191) NULL,
    `url` VARCHAR(191) NOT NULL,
    `hinhAnh` VARCHAR(191) NOT NULL,
    `createAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updateAt` DATETIME(3) NOT NULL,
    `embedLink` VARCHAR(191) NULL,

    PRIMARY KEY (`maYT`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `priority` (
    `id` VARCHAR(191) NOT NULL,
    `doUuTien` VARCHAR(191) NOT NULL,
    `role` INTEGER NOT NULL,

    UNIQUE INDEX `priority_role_key`(`role`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `country` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `code` INTEGER NOT NULL,
    `codeName` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `country_code_key`(`code`),
    UNIQUE INDEX `country_codeName_key`(`codeName`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `location_type` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `province` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `code` INTEGER NOT NULL,
    `codeName` VARCHAR(191) NOT NULL,
    `typeId` VARCHAR(191) NOT NULL,
    `countryId` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `province_code_key`(`code`),
    UNIQUE INDEX `province_codeName_key`(`codeName`),
    INDEX `province_countryId_fkey`(`countryId`),
    INDEX `province_typeId_fkey`(`typeId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `district` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `code` INTEGER NOT NULL,
    `codeName` VARCHAR(191) NOT NULL,
    `typeId` VARCHAR(191) NOT NULL,
    `provinceId` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `district_code_key`(`code`),
    UNIQUE INDEX `district_codeName_key`(`codeName`),
    INDEX `district_typeId_fkey`(`typeId`),
    INDEX `district_provinceId_fkey`(`provinceId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `commune` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `code` INTEGER NOT NULL,
    `codeName` VARCHAR(191) NOT NULL,
    `typeId` VARCHAR(191) NOT NULL,
    `districtId` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `commune_code_key`(`code`),
    UNIQUE INDEX `commune_codeName_key`(`codeName`),
    INDEX `commune_typeId_fkey`(`typeId`),
    INDEX `commune_districtId_fkey`(`districtId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `credit` (
    `id` VARCHAR(191) NOT NULL,
    `chuTaiKhoan` VARCHAR(191) NOT NULL,
    `soTaiKhoan` BIGINT NOT NULL,
    `chiNhanh` VARCHAR(191) NULL,
    `soDT` VARCHAR(191) NOT NULL,
    `nganHang` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `about_page` (
    `id` VARCHAR(191) NOT NULL,
    `noiDung` LONGTEXT NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `about_image` (
    `id` VARCHAR(191) NOT NULL,
    `hinhAnh` VARCHAR(191) NOT NULL,
    `maHinhAnh` VARCHAR(191) NOT NULL,

    INDEX `about_image_maHinhAnh_fkey`(`maHinhAnh`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `support_post` (
    `id` VARCHAR(191) NOT NULL,
    `tieuDe` VARCHAR(191) NOT NULL,
    `noiDung` LONGTEXT NOT NULL,
    `createAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updateAt` DATETIME(3) NOT NULL,
    `slug` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `support_comment` (
    `id` VARCHAR(191) NOT NULL,
    `noiDung` VARCHAR(191) NOT NULL,
    `hoTen` VARCHAR(191) NULL,
    `admin` BOOLEAN NOT NULL DEFAULT false,
    `maBaiVietHoTro` VARCHAR(191) NOT NULL,
    `createAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updateAt` DATETIME(3) NOT NULL,

    INDEX `support_comment_maBaiVietHoTro_fkey`(`maBaiVietHoTro`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `otp_auth` (
    `id` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `otp` VARCHAR(191) NOT NULL,
    `deleteAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `contact_page` (
    `id` VARCHAR(191) NOT NULL,
    `title` VARCHAR(191) NOT NULL,
    `content` LONGTEXT NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `footerLink` (
    `id` VARCHAR(191) NOT NULL,
    `title` VARCHAR(191) NOT NULL,
    `link` VARCHAR(191) NOT NULL,
    `footerId` VARCHAR(191) NOT NULL,

    INDEX `footerLink_footerId_fkey`(`footerId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `footer` (
    `id` VARCHAR(191) NOT NULL,
    `contactTitle` VARCHAR(191) NOT NULL,
    `contactText` LONGTEXT NOT NULL,
    `address` VARCHAR(191) NOT NULL,
    `phoneNumber` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `website` VARCHAR(191) NOT NULL,
    `facebookLink` VARCHAR(191) NOT NULL,
    `youtubeLink` VARCHAR(191) NOT NULL,
    `zaloLink` VARCHAR(191) NOT NULL,
    `categoryTitle` VARCHAR(191) NOT NULL,
    `supportTitle` VARCHAR(191) NOT NULL,
    `map` LONGTEXT NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `user` ADD CONSTRAINT `user_maLoaiNguoiDung_fkey` FOREIGN KEY (`maLoaiNguoiDung`) REFERENCES `user_type`(`maLoaiNguoiDung`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `navlink` ADD CONSTRAINT `navLink_maMenu_fkey` FOREIGN KEY (`maMenu`) REFERENCES `menu`(`maMenu`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `subNavLink` ADD CONSTRAINT `subNavLink_maNavLink_fkey` FOREIGN KEY (`maNavLink`) REFERENCES `navlink`(`maNavLink`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `news` ADD CONSTRAINT `news_maLoaiTinTuc_fkey` FOREIGN KEY (`maLoaiTinTuc`) REFERENCES `news_type`(`maLoaiTinTuc`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `news` ADD CONSTRAINT `news_maNguoiDang_fkey` FOREIGN KEY (`maNguoiDang`) REFERENCES `user`(`maNguoiDung`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `news_image` ADD CONSTRAINT `news_image_maTinTuc_fkey` FOREIGN KEY (`maTinTuc`) REFERENCES `news`(`maTinTuc`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `products` ADD CONSTRAINT `products_maDanhMucNho_fkey` FOREIGN KEY (`maDanhMucNho`) REFERENCES `subcategories`(`maDanhMucNho`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `image_product` ADD CONSTRAINT `image_product_maSanPham_fkey` FOREIGN KEY (`maSanPham`) REFERENCES `products`(`maSanPham`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `orders` ADD CONSTRAINT `orders_maDoUuTien_fkey` FOREIGN KEY (`maDoUuTien`) REFERENCES `priority`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `orders` ADD CONSTRAINT `orders_maTrangThai_fkey` FOREIGN KEY (`maTrangThai`) REFERENCES `status`(`maTrangThai`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `orders_products` ADD CONSTRAINT `orders_products_maDonHang_fkey` FOREIGN KEY (`maDonHang`) REFERENCES `orders`(`maDonHang`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `orders_products` ADD CONSTRAINT `orders_products_maSanPham_fkey` FOREIGN KEY (`maSanPham`) REFERENCES `products`(`maSanPham`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `comments` ADD CONSTRAINT `comments_maSanPham_fkey` FOREIGN KEY (`maSanPham`) REFERENCES `products`(`maSanPham`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `rates` ADD CONSTRAINT `rates_maSanPham_fkey` FOREIGN KEY (`maSanPham`) REFERENCES `products`(`maSanPham`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `subcategories` ADD CONSTRAINT `subCategories_maDanhMucChinh_fkey` FOREIGN KEY (`maDanhMucChinh`) REFERENCES `maincategories`(`maDanhMucChinh`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `fixpost_image` ADD CONSTRAINT `fixpost_image_maBaiViet_fkey` FOREIGN KEY (`maBaiViet`) REFERENCES `fixpost`(`maBaiViet`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `province` ADD CONSTRAINT `province_countryId_fkey` FOREIGN KEY (`countryId`) REFERENCES `country`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `province` ADD CONSTRAINT `province_typeId_fkey` FOREIGN KEY (`typeId`) REFERENCES `location_type`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `district` ADD CONSTRAINT `district_provinceId_fkey` FOREIGN KEY (`provinceId`) REFERENCES `province`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `district` ADD CONSTRAINT `district_typeId_fkey` FOREIGN KEY (`typeId`) REFERENCES `location_type`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `commune` ADD CONSTRAINT `commune_districtId_fkey` FOREIGN KEY (`districtId`) REFERENCES `district`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `commune` ADD CONSTRAINT `commune_typeId_fkey` FOREIGN KEY (`typeId`) REFERENCES `location_type`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `about_image` ADD CONSTRAINT `about_image_maHinhAnh_fkey` FOREIGN KEY (`maHinhAnh`) REFERENCES `about_page`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `support_comment` ADD CONSTRAINT `support_comment_maBaiVietHoTro_fkey` FOREIGN KEY (`maBaiVietHoTro`) REFERENCES `support_post`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `footerLink` ADD CONSTRAINT `footerLink_footerId_fkey` FOREIGN KEY (`footerId`) REFERENCES `footer`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
