/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

DROP TABLE IF EXISTS `about_image`;
CREATE TABLE `about_image` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `hinhAnh` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `maHinhAnh` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `about_image_maHinhAnh_fkey` (`maHinhAnh`),
  CONSTRAINT `about_image_maHinhAnh_fkey` FOREIGN KEY (`maHinhAnh`) REFERENCES `about_page` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `about_page`;
CREATE TABLE `about_page` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `noiDung` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `banner`;
CREATE TABLE `banner` (
  `maBanner` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `hinhAnh` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`maBanner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments` (
  `maComment` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `noiDung` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `maSanPham` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updateAt` datetime(3) NOT NULL,
  `hoTen` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`maComment`),
  KEY `comments_maSanPham_fkey` (`maSanPham`),
  CONSTRAINT `comments_maSanPham_fkey` FOREIGN KEY (`maSanPham`) REFERENCES `products` (`maSanPham`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `commune`;
CREATE TABLE `commune` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` int NOT NULL,
  `codeName` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `typeId` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `districtId` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `commune_code_key` (`code`),
  UNIQUE KEY `commune_codeName_key` (`codeName`),
  KEY `commune_typeId_fkey` (`typeId`),
  KEY `commune_districtId_fkey` (`districtId`),
  CONSTRAINT `commune_districtId_fkey` FOREIGN KEY (`districtId`) REFERENCES `district` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `commune_typeId_fkey` FOREIGN KEY (`typeId`) REFERENCES `location_type` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `contact_status`;
CREATE TABLE `contact_status` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` int NOT NULL,
  `trangThai` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `contact_status_role_key` (`role`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `contacts`;
CREATE TABLE `contacts` (
  `maLienHe` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `soDT` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `diaChi` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `chuDe` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `noiDung` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `hinhAnh` longtext COLLATE utf8mb4_unicode_ci,
  `hoTen` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updateAt` datetime(3) NOT NULL,
  `maTrangThai` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`maLienHe`),
  KEY `contacts_maTrangThai_fkey` (`maTrangThai`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `country`;
CREATE TABLE `country` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` int NOT NULL,
  `codeName` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `country_code_key` (`code`),
  UNIQUE KEY `country_codeName_key` (`codeName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `credit`;
CREATE TABLE `credit` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `chuTaiKhoan` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `soTaiKhoan` int NOT NULL,
  `chiNhanh` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `soDT` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `district`;
CREATE TABLE `district` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` int NOT NULL,
  `codeName` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `typeId` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `provinceId` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `district_code_key` (`code`),
  UNIQUE KEY `district_codeName_key` (`codeName`),
  KEY `district_typeId_fkey` (`typeId`),
  KEY `district_provinceId_fkey` (`provinceId`),
  CONSTRAINT `district_provinceId_fkey` FOREIGN KEY (`provinceId`) REFERENCES `province` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `district_typeId_fkey` FOREIGN KEY (`typeId`) REFERENCES `location_type` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `fixpost`;
CREATE TABLE `fixpost` (
  `maBaiViet` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tieuDe` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `noiDung` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `tenKySu` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updateAt` datetime(3) NOT NULL,
  PRIMARY KEY (`maBaiViet`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `fixpost_image`;
CREATE TABLE `fixpost_image` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `hinhAnh` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `maBaiViet` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fixpost_image_maBaiViet_fkey` (`maBaiViet`),
  CONSTRAINT `fixpost_image_maBaiViet_fkey` FOREIGN KEY (`maBaiViet`) REFERENCES `fixpost` (`maBaiViet`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `image_product`;
CREATE TABLE `image_product` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `maSanPham` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `hinhAnh` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `image_product_maSanPham_fkey` (`maSanPham`),
  CONSTRAINT `image_product_maSanPham_fkey` FOREIGN KEY (`maSanPham`) REFERENCES `products` (`maSanPham`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `location_type`;
CREATE TABLE `location_type` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `maincategories`;
CREATE TABLE `maincategories` (
  `maDanhMucChinh` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tenDanhMuc` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`maDanhMucChinh`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `maMenu` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `logo` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`maMenu`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `navlink`;
CREATE TABLE `navlink` (
  `maNavLink` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tenNavLink` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `maMenu` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`maNavLink`),
  KEY `navLink_maMenu_fkey` (`maMenu`),
  CONSTRAINT `navLink_maMenu_fkey` FOREIGN KEY (`maMenu`) REFERENCES `menu` (`maMenu`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `news`;
CREATE TABLE `news` (
  `maTinTuc` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tieuDe` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `noiDung` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `maNguoiDang` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `maLoaiTinTuc` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updateAt` datetime(3) NOT NULL,
  PRIMARY KEY (`maTinTuc`),
  KEY `news_maLoaiTinTuc_fkey` (`maLoaiTinTuc`),
  KEY `news_maNguoiDang_fkey` (`maNguoiDang`),
  CONSTRAINT `news_maLoaiTinTuc_fkey` FOREIGN KEY (`maLoaiTinTuc`) REFERENCES `news_type` (`maLoaiTinTuc`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `news_maNguoiDang_fkey` FOREIGN KEY (`maNguoiDang`) REFERENCES `user` (`maNguoiDung`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `news_image`;
CREATE TABLE `news_image` (
  `hinhAnh` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `maTinTuc` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `news_image_maTinTuc_fkey` (`maTinTuc`),
  CONSTRAINT `news_image_maTinTuc_fkey` FOREIGN KEY (`maTinTuc`) REFERENCES `news` (`maTinTuc`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `news_type`;
CREATE TABLE `news_type` (
  `maLoaiTinTuc` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `loaiTinTuc` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`maLoaiTinTuc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `maDonHang` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tenKhachHang` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `diaChi` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `soDT` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tongTien` int NOT NULL,
  `loiNhan` longtext COLLATE utf8mb4_unicode_ci,
  `maTrangThai` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updateAt` datetime(3) NOT NULL,
  `maDoUuTien` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`maDonHang`),
  KEY `oders_maTrangThai_fkey` (`maTrangThai`),
  KEY `orders_maDoUuTien_fkey` (`maDoUuTien`),
  CONSTRAINT `orders_maDoUuTien_fkey` FOREIGN KEY (`maDoUuTien`) REFERENCES `priority` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `orders_maTrangThai_fkey` FOREIGN KEY (`maTrangThai`) REFERENCES `status` (`maTrangThai`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `orders_products`;
CREATE TABLE `orders_products` (
  `maDonHang` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `maSanPham` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `soLuongSanPham` int NOT NULL,
  PRIMARY KEY (`maDonHang`,`maSanPham`),
  KEY `orders_products_maSanPham_fkey` (`maSanPham`),
  CONSTRAINT `orders_products_maDonHang_fkey` FOREIGN KEY (`maDonHang`) REFERENCES `orders` (`maDonHang`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `orders_products_maSanPham_fkey` FOREIGN KEY (`maSanPham`) REFERENCES `products` (`maSanPham`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `otp_auth`;
CREATE TABLE `otp_auth` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `otp` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleteAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `priority`;
CREATE TABLE `priority` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `doUuTien` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `priority_role_key` (`role`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `products`;
CREATE TABLE `products` (
  `maSanPham` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tenSanPham` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `moTa` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `giaGoc` int NOT NULL,
  `giaGiam` int DEFAULT NULL,
  `tongSoLuong` int NOT NULL,
  `maDanhMucNho` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updateAt` datetime(3) NOT NULL,
  PRIMARY KEY (`maSanPham`),
  KEY `products_maDanhMucNho_fkey` (`maDanhMucNho`),
  CONSTRAINT `products_maDanhMucNho_fkey` FOREIGN KEY (`maDanhMucNho`) REFERENCES `subcategories` (`maDanhMucNho`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `province`;
CREATE TABLE `province` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` int NOT NULL,
  `codeName` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `typeId` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `countryId` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `province_code_key` (`code`),
  UNIQUE KEY `province_codeName_key` (`codeName`),
  KEY `province_countryId_fkey` (`countryId`),
  KEY `province_typeId_fkey` (`typeId`),
  CONSTRAINT `province_countryId_fkey` FOREIGN KEY (`countryId`) REFERENCES `country` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `province_typeId_fkey` FOREIGN KEY (`typeId`) REFERENCES `location_type` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `rates`;
CREATE TABLE `rates` (
  `maDanhGia` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `soSao` int NOT NULL,
  `soLuotDanhGia` int NOT NULL,
  `maSanPham` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`maDanhGia`),
  KEY `rates_maSanPham_fkey` (`maSanPham`),
  CONSTRAINT `rates_maSanPham_fkey` FOREIGN KEY (`maSanPham`) REFERENCES `products` (`maSanPham`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `status`;
CREATE TABLE `status` (
  `maTrangThai` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `trangThai` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` int NOT NULL,
  PRIMARY KEY (`maTrangThai`),
  UNIQUE KEY `status_role_key` (`role`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `subcategories`;
CREATE TABLE `subcategories` (
  `maDanhMucNho` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tenDanhMucNho` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `maDanhMucChinh` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`maDanhMucNho`),
  KEY `subCategories_maDanhMucChinh_fkey` (`maDanhMucChinh`),
  CONSTRAINT `subCategories_maDanhMucChinh_fkey` FOREIGN KEY (`maDanhMucChinh`) REFERENCES `maincategories` (`maDanhMucChinh`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `support_comment`;
CREATE TABLE `support_comment` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `noiDung` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `hoTen` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  `maBaiVietHoTro` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updateAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `support_comment_maBaiVietHoTro_fkey` (`maBaiVietHoTro`),
  CONSTRAINT `support_comment_maBaiVietHoTro_fkey` FOREIGN KEY (`maBaiVietHoTro`) REFERENCES `support_post` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `support_post`;
CREATE TABLE `support_post` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tieuDe` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `noiDung` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `createAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updateAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `maNguoiDung` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `taiKhoan` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `matKhau` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `hinhAnh` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hoTen` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `soDT` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `colorTheme` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `maLoaiNguoiDung` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updateAt` datetime(3) NOT NULL,
  PRIMARY KEY (`maNguoiDung`),
  UNIQUE KEY `user_taiKhoan_key` (`taiKhoan`),
  UNIQUE KEY `user_email_key` (`email`),
  KEY `user_maLoaiNguoiDung_fkey` (`maLoaiNguoiDung`),
  CONSTRAINT `user_maLoaiNguoiDung_fkey` FOREIGN KEY (`maLoaiNguoiDung`) REFERENCES `user_type` (`maLoaiNguoiDung`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `user_type`;
CREATE TABLE `user_type` (
  `maLoaiNguoiDung` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `loaiNguoiDung` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`maLoaiNguoiDung`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `ytview`;
CREATE TABLE `ytview` (
  `maYT` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tieuDe` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `hinhAnh` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updateAt` datetime(3) NOT NULL,
  PRIMARY KEY (`maYT`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;































































INSERT INTO `user` (`maNguoiDung`, `taiKhoan`, `matKhau`, `hinhAnh`, `hoTen`, `soDT`, `email`, `colorTheme`, `maLoaiNguoiDung`, `createAt`, `updateAt`) VALUES
('ada2c4f1-2cf6-472a-94ec-82241e549ad3', 'admin', '$2b$10$8Wyk18mHN1Iux1qtav9ZceieghNDlG4tPqULUan5myMAsQG9bJXUi', '1686990636832_depositphotos_117893952-stock-photo-hacker-with-mask.jpg', 'Nguyễn Thanh Tiến', '0788246979', 'thanhtien200294@gmail.com', NULL, '5df48fbe-5c87-421c-96f7-4caa92b42aad', '2023-06-17 08:30:37.181', '2023-06-17 08:30:37.181');


INSERT INTO `user_type` (`maLoaiNguoiDung`, `loaiNguoiDung`) VALUES
('5df48fbe-5c87-421c-96f7-4caa92b42aad', 'admin');
INSERT INTO `user_type` (`maLoaiNguoiDung`, `loaiNguoiDung`) VALUES
('d2e12ea2-237e-4bac-b467-b39e709a7e68', 'user');





/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;