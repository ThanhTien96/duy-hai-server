/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE TABLE `about_image` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `hinhAnh` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `maHinhAnh` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `about_image_maHinhAnh_fkey` (`maHinhAnh`),
  CONSTRAINT `about_image_maHinhAnh_fkey` FOREIGN KEY (`maHinhAnh`) REFERENCES `about_page` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `about_page` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `noiDung` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `banner` (
  `maBanner` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `hinhAnh` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`maBanner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `comments` (
  `maComment` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `noiDung` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `maSanPham` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `createAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updateAt` datetime(3) NOT NULL,
  `hoTen` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`maComment`),
  KEY `comments_maSanPham_fkey` (`maSanPham`),
  CONSTRAINT `comments_maSanPham_fkey` FOREIGN KEY (`maSanPham`) REFERENCES `products` (`maSanPham`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `commune` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` int NOT NULL,
  `codeName` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `typeId` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `districtId` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `commune_code_key` (`code`),
  UNIQUE KEY `commune_codeName_key` (`codeName`),
  KEY `commune_typeId_fkey` (`typeId`),
  KEY `commune_districtId_fkey` (`districtId`),
  CONSTRAINT `commune_districtId_fkey` FOREIGN KEY (`districtId`) REFERENCES `district` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `commune_typeId_fkey` FOREIGN KEY (`typeId`) REFERENCES `location_type` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `contact_page` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `contact_status` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` int NOT NULL,
  `trangThai` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `contact_status_role_key` (`role`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `contacts` (
  `maLienHe` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `soDT` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `diaChi` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `chuDe` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `noiDung` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `hinhAnh` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `hoTen` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `createAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updateAt` datetime(3) NOT NULL,
  `maTrangThai` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`maLienHe`),
  KEY `contacts_maTrangThai_fkey` (`maTrangThai`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `country` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` int NOT NULL,
  `codeName` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `country_code_key` (`code`),
  UNIQUE KEY `country_codeName_key` (`codeName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `credit` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `chuTaiKhoan` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `soTaiKhoan` int NOT NULL,
  `chiNhanh` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `soDT` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `district` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` int NOT NULL,
  `codeName` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `typeId` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `provinceId` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `district_code_key` (`code`),
  UNIQUE KEY `district_codeName_key` (`codeName`),
  KEY `district_typeId_fkey` (`typeId`),
  KEY `district_provinceId_fkey` (`provinceId`),
  CONSTRAINT `district_provinceId_fkey` FOREIGN KEY (`provinceId`) REFERENCES `province` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `district_typeId_fkey` FOREIGN KEY (`typeId`) REFERENCES `location_type` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `fixpost` (
  `maBaiViet` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tieuDe` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `noiDung` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tenKySu` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updateAt` datetime(3) NOT NULL,
  PRIMARY KEY (`maBaiViet`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `fixpost_image` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `hinhAnh` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `maBaiViet` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fixpost_image_maBaiViet_fkey` (`maBaiViet`),
  CONSTRAINT `fixpost_image_maBaiViet_fkey` FOREIGN KEY (`maBaiViet`) REFERENCES `fixpost` (`maBaiViet`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `footer` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `contactTitle` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `contactText` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `facebookLink` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `youtubeLink` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `zaloLink` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `categoryTitle` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `supportTitle` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `map` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `footerLink` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `link` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `footerId` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `footerLink_footerId_fkey` (`footerId`),
  CONSTRAINT `footerLink_footerId_fkey` FOREIGN KEY (`footerId`) REFERENCES `footer` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `image_product` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `maSanPham` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `hinhAnh` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `image_product_maSanPham_fkey` (`maSanPham`),
  CONSTRAINT `image_product_maSanPham_fkey` FOREIGN KEY (`maSanPham`) REFERENCES `products` (`maSanPham`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `location_type` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `maincategories` (
  `maDanhMucChinh` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tenDanhMuc` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` int NOT NULL,
  `icon` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`maDanhMucChinh`),
  UNIQUE KEY `maincategories_role_key` (`role`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `menu` (
  `maMenu` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `logo` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`maMenu`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `navlink` (
  `maNavLink` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tenNavLink` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `maMenu` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` int NOT NULL,
  PRIMARY KEY (`maNavLink`),
  UNIQUE KEY `navlink_role_key` (`role`),
  KEY `navLink_maMenu_fkey` (`maMenu`),
  CONSTRAINT `navLink_maMenu_fkey` FOREIGN KEY (`maMenu`) REFERENCES `menu` (`maMenu`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `news` (
  `maTinTuc` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tieuDe` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `noiDung` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `maNguoiDang` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `maLoaiTinTuc` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `createAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updateAt` datetime(3) NOT NULL,
  PRIMARY KEY (`maTinTuc`),
  KEY `news_maLoaiTinTuc_fkey` (`maLoaiTinTuc`),
  KEY `news_maNguoiDang_fkey` (`maNguoiDang`),
  CONSTRAINT `news_maLoaiTinTuc_fkey` FOREIGN KEY (`maLoaiTinTuc`) REFERENCES `news_type` (`maLoaiTinTuc`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `news_maNguoiDang_fkey` FOREIGN KEY (`maNguoiDang`) REFERENCES `user` (`maNguoiDung`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `news_image` (
  `hinhAnh` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `maTinTuc` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `news_image_maTinTuc_fkey` (`maTinTuc`),
  CONSTRAINT `news_image_maTinTuc_fkey` FOREIGN KEY (`maTinTuc`) REFERENCES `news` (`maTinTuc`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `news_type` (
  `maLoaiTinTuc` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `loaiTinTuc` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`maLoaiTinTuc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `orders` (
  `maDonHang` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tenKhachHang` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `diaChi` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `soDT` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tongTien` int NOT NULL,
  `loiNhan` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `maTrangThai` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `createAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updateAt` datetime(3) NOT NULL,
  `maDoUuTien` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`maDonHang`),
  KEY `oders_maTrangThai_fkey` (`maTrangThai`),
  KEY `orders_maDoUuTien_fkey` (`maDoUuTien`),
  CONSTRAINT `orders_maDoUuTien_fkey` FOREIGN KEY (`maDoUuTien`) REFERENCES `priority` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `orders_maTrangThai_fkey` FOREIGN KEY (`maTrangThai`) REFERENCES `status` (`maTrangThai`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `orders_products` (
  `maDonHang` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `maSanPham` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `soLuongSanPham` int NOT NULL,
  PRIMARY KEY (`maDonHang`,`maSanPham`),
  KEY `orders_products_maSanPham_fkey` (`maSanPham`),
  CONSTRAINT `orders_products_maDonHang_fkey` FOREIGN KEY (`maDonHang`) REFERENCES `orders` (`maDonHang`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `orders_products_maSanPham_fkey` FOREIGN KEY (`maSanPham`) REFERENCES `products` (`maSanPham`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `otp_auth` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `otp` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleteAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `priority` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `doUuTien` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `priority_role_key` (`role`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `products` (
  `maSanPham` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tenSanPham` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `moTa` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `giaGoc` int DEFAULT NULL,
  `giaGiam` int NOT NULL,
  `tongSoLuong` int NOT NULL,
  `maDanhMucNho` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `createAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updateAt` datetime(3) NOT NULL,
  `hot` tinyint(1) NOT NULL DEFAULT '0',
  `seo` tinyint(1) NOT NULL DEFAULT '0',
  `seoDetail` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `seoTitle` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `moTaNgan` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `youtubeVideo` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`maSanPham`),
  KEY `products_maDanhMucNho_fkey` (`maDanhMucNho`),
  CONSTRAINT `products_maDanhMucNho_fkey` FOREIGN KEY (`maDanhMucNho`) REFERENCES `subcategories` (`maDanhMucNho`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `province` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` int NOT NULL,
  `codeName` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `typeId` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `countryId` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `province_code_key` (`code`),
  UNIQUE KEY `province_codeName_key` (`codeName`),
  KEY `province_countryId_fkey` (`countryId`),
  KEY `province_typeId_fkey` (`typeId`),
  CONSTRAINT `province_countryId_fkey` FOREIGN KEY (`countryId`) REFERENCES `country` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `province_typeId_fkey` FOREIGN KEY (`typeId`) REFERENCES `location_type` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `rates` (
  `maDanhGia` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `soSao` int NOT NULL,
  `soLuotDanhGia` int NOT NULL,
  `maSanPham` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`maDanhGia`),
  KEY `rates_maSanPham_fkey` (`maSanPham`),
  CONSTRAINT `rates_maSanPham_fkey` FOREIGN KEY (`maSanPham`) REFERENCES `products` (`maSanPham`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `status` (
  `maTrangThai` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `trangThai` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` int NOT NULL,
  PRIMARY KEY (`maTrangThai`),
  UNIQUE KEY `status_role_key` (`role`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `subcategories` (
  `maDanhMucNho` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tenDanhMucNho` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `maDanhMucChinh` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`maDanhMucNho`),
  KEY `subCategories_maDanhMucChinh_fkey` (`maDanhMucChinh`),
  CONSTRAINT `subCategories_maDanhMucChinh_fkey` FOREIGN KEY (`maDanhMucChinh`) REFERENCES `maincategories` (`maDanhMucChinh`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `subNavLink` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tenSubLink` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `maNavLink` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `subNavLink_maNavLink_fkey` (`maNavLink`),
  CONSTRAINT `subNavLink_maNavLink_fkey` FOREIGN KEY (`maNavLink`) REFERENCES `navlink` (`maNavLink`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `support_comment` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `noiDung` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `hoTen` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  `maBaiVietHoTro` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `createAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updateAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `support_comment_maBaiVietHoTro_fkey` (`maBaiVietHoTro`),
  CONSTRAINT `support_comment_maBaiVietHoTro_fkey` FOREIGN KEY (`maBaiVietHoTro`) REFERENCES `support_post` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `support_post` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tieuDe` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `noiDung` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `createAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updateAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `user` (
  `maNguoiDung` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `taiKhoan` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `matKhau` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `hinhAnh` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hoTen` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `soDT` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `theme` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'dark',
  `maLoaiNguoiDung` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `createAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updateAt` datetime(3) NOT NULL,
  `colorTheme` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `primaryColor` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '#39caf5',
  PRIMARY KEY (`maNguoiDung`),
  UNIQUE KEY `user_taiKhoan_key` (`taiKhoan`),
  UNIQUE KEY `user_email_key` (`email`),
  KEY `user_maLoaiNguoiDung_fkey` (`maLoaiNguoiDung`),
  CONSTRAINT `user_maLoaiNguoiDung_fkey` FOREIGN KEY (`maLoaiNguoiDung`) REFERENCES `user_type` (`maLoaiNguoiDung`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `user_type` (
  `maLoaiNguoiDung` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `loaiNguoiDung` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`maLoaiNguoiDung`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `ytview` (
  `maYT` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tieuDe` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `hinhAnh` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `createAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updateAt` datetime(3) NOT NULL,
  `embedLink` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`maYT`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;











INSERT INTO `contact_page` (`id`, `title`, `content`) VALUES
('2996aaa6-70af-4102-891c-c366627240aa', 'NÔNG NGƯ CƠ DUY HẢI', '<p>Địa chỉ: Ấp Bàu Lâm, Xuyên Mộc, Bà Rịa- Vũng Tàu</p>\n<p>Điện thoại: 0974 644 973</p>\n<p>Email: <a href=\"mailto:&#x74;&#104;&#97;&#110;&#x67;&#x6d;&#97;&#x79;&#99;&#117;&#x61;&#120;&#x69;&#99;&#x68;&#x40;&#x67;&#109;&#x61;&#x69;&#108;&#46;&#x63;&#x6f;&#x6d;\">&#x74;&#104;&#97;&#110;&#x67;&#x6d;&#97;&#x79;&#99;&#117;&#x61;&#120;&#x69;&#99;&#x68;&#x40;&#x67;&#109;&#x61;&#x69;&#108;&#46;&#x63;&#x6f;&#x6d;</a></p>\n<p>Website: <a href=\"http://nongcoduyhai.com/\">http://nongcoduyhai.com/</a></p>\n');
















INSERT INTO `footer` (`id`, `contactTitle`, `contactText`, `facebookLink`, `youtubeLink`, `zaloLink`, `categoryTitle`, `supportTitle`, `map`) VALUES
('b781d57e-455d-42c5-9098-3ef265d65711', 'THÔNG TIN LIÊN HỆ', '<p>NÔNG NGƯ CƠ DUY HẢI\nNÔNG CƠ DUY HẢI \nĐịa chỉ: Ấp Bàu Lâm, Xuyên Mộc, Bà Rịa- Vũng Tàu</p>\n<p>NÔNG CƠ DUY HẢI Điện thoại: 0974 644 973</p>\n<p>NÔNG CƠ DUY HẢI Email: <a href=\"mailto:&#116;&#104;&#97;&#x6e;&#x67;&#109;&#x61;&#x79;&#x63;&#117;&#x61;&#x78;&#105;&#x63;&#x68;&#x40;&#x67;&#109;&#x61;&#x69;&#x6c;&#46;&#x63;&#x6f;&#109;\">&#116;&#104;&#97;&#x6e;&#x67;&#109;&#x61;&#x79;&#x63;&#117;&#x61;&#x78;&#105;&#x63;&#x68;&#x40;&#x67;&#109;&#x61;&#x69;&#x6c;&#46;&#x63;&#x6f;&#109;</a></p>\n<p>NÔNG CƠ DUY HẢI Website: <a href=\"http://nongcohaitratan.com/\">http://nongcohaitratan.com/</a></p>\n', 'https://www.facebook.com/hainongco0932871994', 'https://www.youtube.com/@NONGCOHAITRATAN0932871994', '/zalo.com', 'DANH MỤC', 'CHÍNH SÁCH HỖ TRỢ', '<iframe src=\"https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d5537.564523326425!2d107.48146479448583!3d11.064888861754955!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3174453f2dae489b%3A0x306d6b8021dc331c!2zTsOUTkcgQ8agIEjhuqJJIFRSw4AgVMOCTg!5e0!3m2!1svi!2s!4v1693067837651!5m2!1svi!2s\" width=\"600\" height=\"450\" style=\"border:0;\" allowfullscreen=\"\" loading=\"lazy\" referrerpolicy=\"no-referrer-when-downgrade\"></iframe>');


INSERT INTO `footerLink` (`id`, `title`, `link`, `footerId`) VALUES
('b4f62b2c-7d40-4902-a46c-bf9de0068d65', 'chính sách bảo hành', 'chinh-sach-bao-hanh', 'b781d57e-455d-42c5-9098-3ef265d65711');






INSERT INTO `maincategories` (`maDanhMucChinh`, `tenDanhMuc`, `role`, `icon`) VALUES
('2f5518c8-0126-4ae8-824b-550f2b17c5a6', 'máy cắt cỏ', 2, 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAABa0lEQVQ4y+3UMWtUQRQF4I8gi0pIEUQMBIsUKiIpUoSgEBZLt0tlKShW6w/QViyCPyBVirRBCCks1CpNwEKLiIJgJQoqMYgRDIsmaU4xTPZlt7HzwjB3Zu45c+89bx7/0EbRajg7OSzJSOGfxnhGbedzYWnjaNdJjFRBlzDZh/RCRXgOy9hBr4nwJzoB3qgIr+BsUf5TfMDWcSXvBfQF1woCmMB0/MVk/HhQD+EHruMz7laCXcwlXazi2zCEb1L2Km5jrDg7g1vBrB2n8nSaDO8wg+2su5l72e9gH5vZn+qn8ifcj7qX84lM4QnuBfALs5hPPDxIIkdU3kmp6/gY8ByWAliIYGU/X+BUMh1NTLskbuE93kaQXTzEb7wM+UE1JnETr9KaI6+p2wd0gL/4Xu3t4lnOFpoEGsPXBtKmcWfQ214uMlgZQLYxzM+iXQCuBtRE2O1HcKJav8bzPK0WHsXfx5/Mvfjb/hscAupMbDTSWCY3AAAAAElFTkSuQmCC');
INSERT INTO `maincategories` (`maDanhMucChinh`, `tenDanhMuc`, `role`, `icon`) VALUES
('3526f4a4-9cc6-478e-ab8e-5d3f78fe13c5', 'phụ tùng các loại', 7, 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAECklEQVQ4y71Ub0jidxh/TuXSH5RmZ9hpeq2S/o6s0TTiftiKtWxsYt7hOrn2YuSNLAYyBK0GLehVRaFpRzQu1uAm8zDqmnOBerVS7NpSKVcyLCqo7EgxM/mxN/OWW2y9GHtePd+H5/vheZ7P83wA/k8bGRkpYDAY7pKSklk+n//4On9wfw0olcq7SX9/f78IRdGl/v5+MYZhBcm4QqGgq9XqN68CxCcdt9uNRCKRwdXV1fcZDMa7LS0tcbvd/ml+fv6cUql8yeFw7hUVFRWXl5fnOp3OL/x+/3tCoTC6trbmu7JCl8v11sbGRonL5RJyudznZrO5nc1mf83n858CAEil0vazszMIBAIfdHV1fSKXyz+z2+39brcbubL3ubm5myKRaGJ0dPSj68xKLBaPqVSqB/+YpNfr71ZWVv6YfEskEk5zc/NYTU3NN01NTZ+bTCYiAMD4+DhTIBDMXoVxAwBArVZzotFo2fLy8iOhUPhYo9E8VavVHLPZPFZYWDiFw+E24vG4BI/HMzUazcdVVVXRxsbGyZycnGBaWtoil8t1tre3v3pNSiAQsOBwuASBQHiOoqjRZDJhLBZrAEXRZzqd7onP59vd3Ny0lJaWvhMKhSI2my2gVCp/XlpaemNnZ0dsNpsrwuHw969JIZFI0c7OTrXVap2WyWQJAIBgMEglkUgpDNLp9PV4PE4HAJDL5b8tLCwMCgSCib29vVspLNNotI3e3l4Tj8czzc/PZwMAcDicFY/HI7tM2tbWVkNFRcULAACNRnOPx+OZbDZbq1Qq/TZlhgAAw8PDiNPp7E1PTw8bDIYv3W430t3dPRmLxY7YbPavDodDjGEYUyKRGAAAZmdn77NYLH9ubu46mUyORiKRgE6ne3bjckt9fX0PLBaLyOFwiAEApqamCIuLi3VMJpMyMzPz6Ojo6DaJRIpiGAZEIjGUSCQyMAwjAAAuGAxSTk9P2YQkmM1mu61SqR4ODAw8RFEUFAoFXSaTHQCABQCgtbW1ITMz80VmZqYrFotRotEoH0GQn8LhcIJCoQCGYa0+n+/PS1lfX78ViURwLpeLXldXp7Xb7dqysjKDXq+/k8wpLi5+iSBIxsnJSRWbzbaZTKYnVqt12mg0Tufl5flTTq+jo+OX+vp6rVarnaRSqYtKpfJ+QUFBaGVl5cM/VusOjUZ7dXBwUEUkEm9mZ2djl8d1fn5O+JvaDA0NfTc4OPi20Wiclslkierq6h88Hk9DT09P/fb2dkU4HEYyMjKOj4+PWYeHh8i15EskEsWSflZW1iqLxQr6/X4ZmUw+ZTAYQSqVGqqtrZ0wGAxfpcgWHp+6Nv9mbW1tQ16vl0mn07cSiQTu4uICuQzm9XqLdnd3G/5zlf8dDjG3cZ0WnSoAAAAASUVORK5CYII=');
INSERT INTO `maincategories` (`maDanhMucChinh`, `tenDanhMuc`, `role`, `icon`) VALUES
('5e5586fd-b560-4c12-b621-f511fc9873ec', 'máy xịt thuốc', 3, 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAB5klEQVQ4y62U26riMBRAV9I0tahQsaL//20+KefBW00vyT4PQ0JbO4czMIGwScJe2Xd1Pp+F/7jM3x6UUiilFt9EBBH5HTCCxsAoIyQCl8BmDrter1hr6fueqqro+573+41SivV6jYjwer3I85z3+01d1xNPzNwy5xxd11GWJcMw4L2n6zr6vgcghJA+cc4lYLRUxaRorSdbKUWWZRPXo4ve+4kMIRBCAEDP46a1JssyjDET+Xw+OZ/PiAhZlqU9j7dZAo5l0zTcbje89xRFweVyoaoqiqJAa52sjm6bpewCPB4PnHMAdF1HCCGFo+97yrJMoElSxodxrC6XC8MwpGBHa6KrS3WolMKICFrrj4cIK8uSw+GQ7pqmAeD1elGW5URHRP4kZVywAG3bstvtJorW2uSmc47r9brYPWZ8EWVRFCkh9/sd7/1kO+eoqmqxW8yYHkJIQbbWcjweyfOcruvw3gOw3++p65osy1IdjqFm3psRqrXGWsvpdAJIiQghTIo5nifACL3f7zjnEBGstTRNw2azAWC73fL19UXbthhjWK1WPJ9P8jynruvPXhYR2radFKq1NiXJe49SitVqBUDTNBhjKIriM4Zx7Xa7j/E1n4nz0fXj+Bor/GYe/tPEHivNgT+tb8ELlnAdcxM8AAAAAElFTkSuQmCC');
INSERT INTO `maincategories` (`maDanhMucChinh`, `tenDanhMuc`, `role`, `icon`) VALUES
('6498e419-5514-417d-b62f-a31d9ed3f56d', 'máy khoan đất', 4, 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAA6UlEQVQ4y+3TsUpDQRAF0EMQi1dYWFiIVRCxEEllZeEHSIqIjYUEsbYVbP2OlNaWfoB25g9SWUhIIDaKYBNt5sHyQNyNpQ4M3F2Yu3dm7vKno4d7zL7JO1S5ZIf4zMguLnIIHzPIPnASeIC9qN1AJ3C1FGC7YDQvOMMU77jFJXZx/BuFsJUo3Y8zMZucGfZyZwineG0QjDFJtrxSYpsqimuyGxxEG6uL+LDfUNfHCOclJK0EHyX4DXNslpi52e5zou4ptncVPiuOnbBFTTgpXUCz5XUsJ/druF6EsP4pQzygHY/MQ+V//BxfxHhZeXlQa0YAAAAASUVORK5CYII='),
('c3582784-1e91-4b33-8998-ea93f284a424', 'máy cưa xích', 1, 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAABK0lEQVQ4y93UIUtDYRTG8Z9zGJYWlkRERIuYDAZBMNgEm7BgMMjStfkF/ACmWUyGJYNhn2CgQQQFQbAZhzhFEERYUcsZXC+buq2IB264h/f533Pe55zLX4/RIfVlbKCFx2GB+wF7wDZucD8orIoGSvGeYA9yfYLGArYY1T1FfhkvPwmzUYg2L1KVwRHOemjASojqcWgycushLGZgjfgYGOkCrOMa0+HeO3axg4MMbAprePuu3U2cYzycS9BEO6pMt1n47eUfR9tJwJMAtlEJR0vdhPkewHw4eYvLuMtTrOIQsymHv0Suh8Odw1t4xivmI9fqZ84691aOefvIPE3M9QOs4yo1GtVhYGIvK5mZPIkdXRhkR2u4i/GoxR9kBhODLn0xKmpG60v+XXwC6K5FLotuIJEAAAAASUVORK5CYII='),
('c4271629-1fa4-45d6-acc8-8a92a84521b1', 'động cơ máy nổ', 5, 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAABcUlEQVQ4y+XUsWsUURAG8F/OY4kaJFEi4RCRQyRlughCGkFSBEljIbaCf4FNsNVGUljb2dgFUqSzEOwsREiVRkSUGE3kiivCGi4234XHcR6eleDAsDPzZmfffPPN8t/JxIA/jSp2jU7sFTyP3UhOjR66uIFv0EwRSXpa+B08zIvnMJd4F3exiEc4xPnyAjs4iO5hN7qX2A7WcBxdS+Ht+Lt4mfyVJlqYGgFLhdOx3+MJVvEZVxM/g4u418hVR8ng+TO8xpsCb8Gzbo45xAV8Ctb3hyU0/4IZbdwu/MlxC1b4gheF/64472QOJzw8yNhHydeCk8PkUp4bf9ryXMHD30m3bLk3JKExZvwEwwpvw7FymteDVRm/hiV8wKsi3sKtfsEpfMRmceM+yD+wFfsId1LwaCB+M5OvTmE55L0QSrQxg5/4jrO4jCuYTbv72Z52tqWVwusTwWQSjzFfbEcdOKqBranTSZ9/h3iQj/T+/R/sLxOLVAG4NlPZAAAAAElFTkSuQmCC'),
('ce9e10a9-52d9-4ac0-9dfe-0b269ed1b25b', 'bình xịt điện', 6, 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAACcUlEQVQ4y9WUMWgaURzG/xdfmhhP8zT12sajIVlMMJS7DKEQPUp0qKZdNLg2plS44UAuXRpuMDTgJpQKDimkIUMHKSoIoatCJUtjGlLbyUoGB0UjYqJy2g4lxRYHk3bJG//f+/78Pt7HA7h2JxQKYaPRuKNUKr8JgrDyzwutVutznU5XcLlc64ODg/VwODx+Gf/A3wONRnPWbrdRtVq9NTQ0JP+X2BzHbdA0vef3+xcv6/1NGA6Hx2mafrWwsCCOjY0dq9Xqrwih71emmpmZSVEUdaTT6QoEQZxPTEyk9Xp9PhqNaq5EmM1m5y0WyzMAeM2ybHJyctJeKpWow8ND+sqP0ul0WuVyuQUAUCwWEQDciMViG16vd0qSJPJSkTHGOaPRuEOS5HuGYeImk+kmQqiCMc4hhCqjo6NFmqb33G73vb4IfT7f00qlMtdsNh/K8q+2yLI87Ha7H6+urlqmp6c9JEl2otFommXZLUmS7vZFyvO8Q6VSNX0+3wOe5x3BYHC4W19eXrZhjI8Zhon3HZ9l2S2CIM49Hs+jXrooiigUCmGn0ylZrdb1bk3RyzA7O2ur1+t39vf3PWazuZXP5z926+l0umOz2UChUJyqVKovdrv9LJlMtnrSBYPBeYTQD7/fv8jzvIMgiLbX653q0dtIIBC4v7a2Nsdx3LuLOdF9aXt7mxME4YNWq31zcnIiAABQFHVkMBg+HRwcPAEAyGQyA7u7u4xWqz2VZXkYAAAh1Gg0GuTm5ubnP3qYSCRcIyMjby+WAQAsLS29qNVqt0VRRAAAuVyOjMfjAYxxuVAoOFKplMNkMpUikcjL6/FB/wRni9g963eawQAAAABJRU5ErkJggg==');

INSERT INTO `menu` (`maMenu`, `logo`, `active`) VALUES
('1991bf6b-ad50-4c7f-bdbc-6ef6e5de3238', '1693038496459_hai-tra-tan-logo.png', 1);


INSERT INTO `navlink` (`maNavLink`, `tenNavLink`, `url`, `maMenu`, `role`) VALUES
('0ffb6d76-9e2f-4b26-80ad-1a00e86a5e4d', 'sửa chữa', '/repair', '1991bf6b-ad50-4c7f-bdbc-6ef6e5de3238', 4);
INSERT INTO `navlink` (`maNavLink`, `tenNavLink`, `url`, `maMenu`, `role`) VALUES
('13963d06-bf9b-4414-b3a6-aa8dc7f44651', 'giới thiệu', '/about', '1991bf6b-ad50-4c7f-bdbc-6ef6e5de3238', 2);
INSERT INTO `navlink` (`maNavLink`, `tenNavLink`, `url`, `maMenu`, `role`) VALUES
('3f4a62eb-cffb-481f-b01e-714e3e7a3455', 'liên hệ', '/contact', '1991bf6b-ad50-4c7f-bdbc-6ef6e5de3238', 6);
INSERT INTO `navlink` (`maNavLink`, `tenNavLink`, `url`, `maMenu`, `role`) VALUES
('6fe96686-7011-430c-97d9-3fb22c7ed524', 'tin tức', '/news', '1991bf6b-ad50-4c7f-bdbc-6ef6e5de3238', 5),
('ddfd065e-b736-4c35-9087-0d84e45f5cb0', 'phụ tùng chính hãng', '/accessary', '1991bf6b-ad50-4c7f-bdbc-6ef6e5de3238', 3),
('f434ed54-d023-4078-9184-10b3b3daea78', 'trang chủ', '/', '1991bf6b-ad50-4c7f-bdbc-6ef6e5de3238', 1);























INSERT INTO `subcategories` (`maDanhMucNho`, `tenDanhMucNho`, `icon`, `maDanhMucChinh`) VALUES
('0325f20c-cb7d-4525-9bf4-809fdc41bde8', 'động cơ xăng roman', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAABcUlEQVQ4y+XUsWsUURAG8F/OY4kaJFEi4RCRQyRlughCGkFSBEljIbaCf4FNsNVGUljb2dgFUqSzEOwsREiVRkSUGE3kiivCGi4234XHcR6eleDAsDPzZmfffPPN8t/JxIA/jSp2jU7sFTyP3UhOjR66uIFv0EwRSXpa+B08zIvnMJd4F3exiEc4xPnyAjs4iO5hN7qX2A7WcBxdS+Ht+Lt4mfyVJlqYGgFLhdOx3+MJVvEZVxM/g4u418hVR8ng+TO8xpsCb8Gzbo45xAV8Ctb3hyU0/4IZbdwu/MlxC1b4gheF/64472QOJzw8yNhHydeCk8PkUp4bf9ryXMHD30m3bLk3JKExZvwEwwpvw7FymteDVRm/hiV8wKsi3sKtfsEpfMRmceM+yD+wFfsId1LwaCB+M5OvTmE55L0QSrQxg5/4jrO4jCuYTbv72Z52tqWVwusTwWQSjzFfbEcdOKqBranTSZ9/h3iQj/T+/R/sLxOLVAG4NlPZAAAAAElFTkSuQmCC', 'c4271629-1fa4-45d6-acc8-8a92a84521b1');
INSERT INTO `subcategories` (`maDanhMucNho`, `tenDanhMucNho`, `icon`, `maDanhMucChinh`) VALUES
('1b18100e-0b77-4729-b776-9883d259db71', 'permax', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAB5klEQVQ4y62U26riMBRAV9I0tahQsaL//20+KefBW00vyT4PQ0JbO4czMIGwScJe2Xd1Pp+F/7jM3x6UUiilFt9EBBH5HTCCxsAoIyQCl8BmDrter1hr6fueqqro+573+41SivV6jYjwer3I85z3+01d1xNPzNwy5xxd11GWJcMw4L2n6zr6vgcghJA+cc4lYLRUxaRorSdbKUWWZRPXo4ve+4kMIRBCAEDP46a1JssyjDET+Xw+OZ/PiAhZlqU9j7dZAo5l0zTcbje89xRFweVyoaoqiqJAa52sjm6bpewCPB4PnHMAdF1HCCGFo+97yrJMoElSxodxrC6XC8MwpGBHa6KrS3WolMKICFrrj4cIK8uSw+GQ7pqmAeD1elGW5URHRP4kZVywAG3bstvtJorW2uSmc47r9brYPWZ8EWVRFCkh9/sd7/1kO+eoqmqxW8yYHkJIQbbWcjweyfOcruvw3gOw3++p65osy1IdjqFm3psRqrXGWsvpdAJIiQghTIo5nifACL3f7zjnEBGstTRNw2azAWC73fL19UXbthhjWK1WPJ9P8jynruvPXhYR2radFKq1NiXJe49SitVqBUDTNBhjKIriM4Zx7Xa7j/E1n4nz0fXj+Bor/GYe/tPEHivNgT+tb8ELlnAdcxM8AAAAAElFTkSuQmCC', '5e5586fd-b560-4c12-b621-f511fc9873ec');
INSERT INTO `subcategories` (`maDanhMucNho`, `tenDanhMucNho`, `icon`, `maDanhMucChinh`) VALUES
('24009297-dec2-4d23-8cda-9d5dacd19602', 'hinota', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAA6UlEQVQ4y+3TsUpDQRAF0EMQi1dYWFiIVRCxEEllZeEHSIqIjYUEsbYVbP2OlNaWfoB25g9SWUhIIDaKYBNt5sHyQNyNpQ4M3F2Yu3dm7vKno4d7zL7JO1S5ZIf4zMguLnIIHzPIPnASeIC9qN1AJ3C1FGC7YDQvOMMU77jFJXZx/BuFsJUo3Y8zMZucGfZyZwineG0QjDFJtrxSYpsqimuyGxxEG6uL+LDfUNfHCOclJK0EHyX4DXNslpi52e5zou4ptncVPiuOnbBFTTgpXUCz5XUsJ/druF6EsP4pQzygHY/MQ+V//BxfxHhZeXlQa0YAAAAASUVORK5CYII=', '6498e419-5514-417d-b62f-a31d9ed3f56d');
INSERT INTO `subcategories` (`maDanhMucNho`, `tenDanhMucNho`, `icon`, `maDanhMucChinh`) VALUES
('25fd8ac0-925a-4b42-872f-67a6f958bbae', 'yuki', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAB5klEQVQ4y62U26riMBRAV9I0tahQsaL//20+KefBW00vyT4PQ0JbO4czMIGwScJe2Xd1Pp+F/7jM3x6UUiilFt9EBBH5HTCCxsAoIyQCl8BmDrter1hr6fueqqro+573+41SivV6jYjwer3I85z3+01d1xNPzNwy5xxd11GWJcMw4L2n6zr6vgcghJA+cc4lYLRUxaRorSdbKUWWZRPXo4ve+4kMIRBCAEDP46a1JssyjDET+Xw+OZ/PiAhZlqU9j7dZAo5l0zTcbje89xRFweVyoaoqiqJAa52sjm6bpewCPB4PnHMAdF1HCCGFo+97yrJMoElSxodxrC6XC8MwpGBHa6KrS3WolMKICFrrj4cIK8uSw+GQ7pqmAeD1elGW5URHRP4kZVywAG3bstvtJorW2uSmc47r9brYPWZ8EWVRFCkh9/sd7/1kO+eoqmqxW8yYHkJIQbbWcjweyfOcruvw3gOw3++p65osy1IdjqFm3psRqrXGWsvpdAJIiQghTIo5nifACL3f7zjnEBGstTRNw2azAWC73fL19UXbthhjWK1WPJ9P8jynruvPXhYR2radFKq1NiXJe49SitVqBUDTNBhjKIriM4Zx7Xa7j/E1n4nz0fXj+Bor/GYe/tPEHivNgT+tb8ELlnAdcxM8AAAAAElFTkSuQmCC', '5e5586fd-b560-4c12-b621-f511fc9873ec'),
('28b12fd5-3c2f-496d-8ca8-5e338c98ecfd', 'mitsuyama', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAABcUlEQVQ4y+XUsWsUURAG8F/OY4kaJFEi4RCRQyRlughCGkFSBEljIbaCf4FNsNVGUljb2dgFUqSzEOwsREiVRkSUGE3kiivCGi4234XHcR6eleDAsDPzZmfffPPN8t/JxIA/jSp2jU7sFTyP3UhOjR66uIFv0EwRSXpa+B08zIvnMJd4F3exiEc4xPnyAjs4iO5hN7qX2A7WcBxdS+Ht+Lt4mfyVJlqYGgFLhdOx3+MJVvEZVxM/g4u418hVR8ng+TO8xpsCb8Gzbo45xAV8Ctb3hyU0/4IZbdwu/MlxC1b4gheF/64472QOJzw8yNhHydeCk8PkUp4bf9ryXMHD30m3bLk3JKExZvwEwwpvw7FymteDVRm/hiV8wKsi3sKtfsEpfMRmceM+yD+wFfsId1LwaCB+M5OvTmE55L0QSrQxg5/4jrO4jCuYTbv72Z52tqWVwusTwWQSjzFfbEcdOKqBranTSZ9/h3iQj/T+/R/sLxOLVAG4NlPZAAAAAElFTkSuQmCC', 'c4271629-1fa4-45d6-acc8-8a92a84521b1'),
('2c4cba9e-0964-4060-91d2-b92647158080', 'makita', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAABK0lEQVQ4y93UIUtDYRTG8Z9zGJYWlkRERIuYDAZBMNgEm7BgMMjStfkF/ACmWUyGJYNhn2CgQQQFQbAZhzhFEERYUcsZXC+buq2IB264h/f533Pe55zLX4/RIfVlbKCFx2GB+wF7wDZucD8orIoGSvGeYA9yfYLGArYY1T1FfhkvPwmzUYg2L1KVwRHOemjASojqcWgycushLGZgjfgYGOkCrOMa0+HeO3axg4MMbAprePuu3U2cYzycS9BEO6pMt1n47eUfR9tJwJMAtlEJR0vdhPkewHw4eYvLuMtTrOIQsymHv0Suh8Odw1t4xivmI9fqZ84691aOefvIPE3M9QOs4yo1GtVhYGIvK5mZPIkdXRhkR2u4i/GoxR9kBhODLn0xKmpG60v+XXwC6K5FLotuIJEAAAAASUVORK5CYII=', 'c3582784-1e91-4b33-8998-ea93f284a424'),
('2e537c13-d71f-4be5-aff5-ac5121681269', 'shingu', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAABK0lEQVQ4y93UIUtDYRTG8Z9zGJYWlkRERIuYDAZBMNgEm7BgMMjStfkF/ACmWUyGJYNhn2CgQQQFQbAZhzhFEERYUcsZXC+buq2IB264h/f533Pe55zLX4/RIfVlbKCFx2GB+wF7wDZucD8orIoGSvGeYA9yfYLGArYY1T1FfhkvPwmzUYg2L1KVwRHOemjASojqcWgycushLGZgjfgYGOkCrOMa0+HeO3axg4MMbAprePuu3U2cYzycS9BEO6pMt1n47eUfR9tJwJMAtlEJR0vdhPkewHw4eYvLuMtTrOIQsymHv0Suh8Odw1t4xivmI9fqZ84691aOefvIPE3M9QOs4yo1GtVhYGIvK5mZPIkdXRhkR2u4i/GoxR9kBhODLn0xKmpG60v+XXwC6K5FLotuIJEAAAAASUVORK5CYII=', 'c3582784-1e91-4b33-8998-ea93f284a424'),
('30870ee2-a191-44c7-b307-c55643433b0a', 'mitsuyama', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAA6UlEQVQ4y+3TsUpDQRAF0EMQi1dYWFiIVRCxEEllZeEHSIqIjYUEsbYVbP2OlNaWfoB25g9SWUhIIDaKYBNt5sHyQNyNpQ4M3F2Yu3dm7vKno4d7zL7JO1S5ZIf4zMguLnIIHzPIPnASeIC9qN1AJ3C1FGC7YDQvOMMU77jFJXZx/BuFsJUo3Y8zMZucGfZyZwineG0QjDFJtrxSYpsqimuyGxxEG6uL+LDfUNfHCOclJK0EHyX4DXNslpi52e5zou4ptncVPiuOnbBFTTgpXUCz5XUsJ/druF6EsP4pQzygHY/MQ+V//BxfxHhZeXlQa0YAAAAASUVORK5CYII=', '6498e419-5514-417d-b62f-a31d9ed3f56d'),
('3d310a34-eef5-4271-ab49-9540335d91ea', 'echo', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAABa0lEQVQ4y+3UMWtUQRQF4I8gi0pIEUQMBIsUKiIpUoSgEBZLt0tlKShW6w/QViyCPyBVirRBCCks1CpNwEKLiIJgJQoqMYgRDIsmaU4xTPZlt7HzwjB3Zu45c+89bx7/0EbRajg7OSzJSOGfxnhGbedzYWnjaNdJjFRBlzDZh/RCRXgOy9hBr4nwJzoB3qgIr+BsUf5TfMDWcSXvBfQF1woCmMB0/MVk/HhQD+EHruMz7laCXcwlXazi2zCEb1L2Km5jrDg7g1vBrB2n8nSaDO8wg+2su5l72e9gH5vZn+qn8ifcj7qX84lM4QnuBfALs5hPPDxIIkdU3kmp6/gY8ByWAliIYGU/X+BUMh1NTLskbuE93kaQXTzEb7wM+UE1JnETr9KaI6+p2wd0gL/4Xu3t4lnOFpoEGsPXBtKmcWfQ214uMlgZQLYxzM+iXQCuBtRE2O1HcKJav8bzPK0WHsXfx5/Mvfjb/hscAupMbDTSWCY3AAAAAElFTkSuQmCC', '2f5518c8-0126-4ae8-824b-550f2b17c5a6'),
('4a8f9498-fbd0-4a3b-b295-6cc2e0dddcda', 'mitsubishi', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAABa0lEQVQ4y+3UMWtUQRQF4I8gi0pIEUQMBIsUKiIpUoSgEBZLt0tlKShW6w/QViyCPyBVirRBCCks1CpNwEKLiIJgJQoqMYgRDIsmaU4xTPZlt7HzwjB3Zu45c+89bx7/0EbRajg7OSzJSOGfxnhGbedzYWnjaNdJjFRBlzDZh/RCRXgOy9hBr4nwJzoB3qgIr+BsUf5TfMDWcSXvBfQF1woCmMB0/MVk/HhQD+EHruMz7laCXcwlXazi2zCEb1L2Km5jrDg7g1vBrB2n8nSaDO8wg+2su5l72e9gH5vZn+qn8ifcj7qX84lM4QnuBfALs5hPPDxIIkdU3kmp6/gY8ByWAliIYGU/X+BUMh1NTLskbuE93kaQXTzEb7wM+UE1JnETr9KaI6+p2wd0gL/4Xu3t4lnOFpoEGsPXBtKmcWfQ214uMlgZQLYxzM+iXQCuBtRE2O1HcKJav8bzPK0WHsXfx5/Mvfjb/hscAupMbDTSWCY3AAAAAElFTkSuQmCC', '2f5518c8-0126-4ae8-824b-550f2b17c5a6'),
('6ef8a5e0-479f-45ac-a1af-70f4d071cd7d', 'hitachi', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAABK0lEQVQ4y93UIUtDYRTG8Z9zGJYWlkRERIuYDAZBMNgEm7BgMMjStfkF/ACmWUyGJYNhn2CgQQQFQbAZhzhFEERYUcsZXC+buq2IB264h/f533Pe55zLX4/RIfVlbKCFx2GB+wF7wDZucD8orIoGSvGeYA9yfYLGArYY1T1FfhkvPwmzUYg2L1KVwRHOemjASojqcWgycushLGZgjfgYGOkCrOMa0+HeO3axg4MMbAprePuu3U2cYzycS9BEO6pMt1n47eUfR9tJwJMAtlEJR0vdhPkewHw4eYvLuMtTrOIQsymHv0Suh8Odw1t4xivmI9fqZ84691aOefvIPE3M9QOs4yo1GtVhYGIvK5mZPIkdXRhkR2u4i/GoxR9kBhODLn0xKmpG60v+XXwC6K5FLotuIJEAAAAASUVORK5CYII=', 'c3582784-1e91-4b33-8998-ea93f284a424'),
('7a9b293d-bc84-4dd5-8f35-db04037af8e6', 'maruyama', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAABa0lEQVQ4y+3UMWtUQRQF4I8gi0pIEUQMBIsUKiIpUoSgEBZLt0tlKShW6w/QViyCPyBVirRBCCks1CpNwEKLiIJgJQoqMYgRDIsmaU4xTPZlt7HzwjB3Zu45c+89bx7/0EbRajg7OSzJSOGfxnhGbedzYWnjaNdJjFRBlzDZh/RCRXgOy9hBr4nwJzoB3qgIr+BsUf5TfMDWcSXvBfQF1woCmMB0/MVk/HhQD+EHruMz7laCXcwlXazi2zCEb1L2Km5jrDg7g1vBrB2n8nSaDO8wg+2su5l72e9gH5vZn+qn8ifcj7qX84lM4QnuBfALs5hPPDxIIkdU3kmp6/gY8ByWAliIYGU/X+BUMh1NTLskbuE93kaQXTzEb7wM+UE1JnETr9KaI6+p2wd0gL/4Xu3t4lnOFpoEGsPXBtKmcWfQ214uMlgZQLYxzM+iXQCuBtRE2O1HcKJav8bzPK0WHsXfx5/Mvfjb/hscAupMbDTSWCY3AAAAAElFTkSuQmCC', '2f5518c8-0126-4ae8-824b-550f2b17c5a6'),
('9493e6f5-2ea4-4dcf-9b2e-08519c08de56', 'động cơ xăng yokohama', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAABcUlEQVQ4y+XUsWsUURAG8F/OY4kaJFEi4RCRQyRlughCGkFSBEljIbaCf4FNsNVGUljb2dgFUqSzEOwsREiVRkSUGE3kiivCGi4234XHcR6eleDAsDPzZmfffPPN8t/JxIA/jSp2jU7sFTyP3UhOjR66uIFv0EwRSXpa+B08zIvnMJd4F3exiEc4xPnyAjs4iO5hN7qX2A7WcBxdS+Ht+Lt4mfyVJlqYGgFLhdOx3+MJVvEZVxM/g4u418hVR8ng+TO8xpsCb8Gzbo45xAV8Ctb3hyU0/4IZbdwu/MlxC1b4gheF/64472QOJzw8yNhHydeCk8PkUp4bf9ryXMHD30m3bLk3JKExZvwEwwpvw7FymteDVRm/hiV8wKsi3sKtfsEpfMRmceM+yD+wFfsId1LwaCB+M5OvTmE55L0QSrQxg5/4jrO4jCuYTbv72Z52tqWVwusTwWQSjzFfbEcdOKqBranTSZ9/h3iQj/T+/R/sLxOLVAG4NlPZAAAAAElFTkSuQmCC', 'c4271629-1fa4-45d6-acc8-8a92a84521b1'),
('988990e6-3d3f-4afa-bab3-fc7e0fb7402e', 'stihl', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAABK0lEQVQ4y93UIUtDYRTG8Z9zGJYWlkRERIuYDAZBMNgEm7BgMMjStfkF/ACmWUyGJYNhn2CgQQQFQbAZhzhFEERYUcsZXC+buq2IB264h/f533Pe55zLX4/RIfVlbKCFx2GB+wF7wDZucD8orIoGSvGeYA9yfYLGArYY1T1FfhkvPwmzUYg2L1KVwRHOemjASojqcWgycushLGZgjfgYGOkCrOMa0+HeO3axg4MMbAprePuu3U2cYzycS9BEO6pMt1n47eUfR9tJwJMAtlEJR0vdhPkewHw4eYvLuMtTrOIQsymHv0Suh8Odw1t4xivmI9fqZ84691aOefvIPE3M9QOs4yo1GtVhYGIvK5mZPIkdXRhkR2u4i/GoxR9kBhODLn0xKmpG60v+XXwC6K5FLotuIJEAAAAASUVORK5CYII=', 'c3582784-1e91-4b33-8998-ea93f284a424'),
('9e64426f-d511-42e6-ae6b-2e87e2b003eb', 'bình xịt điện loại 2 bơm', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAACcUlEQVQ4y9WUMWgaURzG/xdfmhhP8zT12sajIVlMMJS7DKEQPUp0qKZdNLg2plS44UAuXRpuMDTgJpQKDimkIUMHKSoIoatCJUtjGlLbyUoGB0UjYqJy2g4lxRYHk3bJG//f+/78Pt7HA7h2JxQKYaPRuKNUKr8JgrDyzwutVutznU5XcLlc64ODg/VwODx+Gf/A3wONRnPWbrdRtVq9NTQ0JP+X2BzHbdA0vef3+xcv6/1NGA6Hx2mafrWwsCCOjY0dq9Xqrwih71emmpmZSVEUdaTT6QoEQZxPTEyk9Xp9PhqNaq5EmM1m5y0WyzMAeM2ybHJyctJeKpWow8ND+sqP0ul0WuVyuQUAUCwWEQDciMViG16vd0qSJPJSkTHGOaPRuEOS5HuGYeImk+kmQqiCMc4hhCqjo6NFmqb33G73vb4IfT7f00qlMtdsNh/K8q+2yLI87Ha7H6+urlqmp6c9JEl2otFommXZLUmS7vZFyvO8Q6VSNX0+3wOe5x3BYHC4W19eXrZhjI8Zhon3HZ9l2S2CIM49Hs+jXrooiigUCmGn0ylZrdb1bk3RyzA7O2ur1+t39vf3PWazuZXP5z926+l0umOz2UChUJyqVKovdrv9LJlMtnrSBYPBeYTQD7/fv8jzvIMgiLbX653q0dtIIBC4v7a2Nsdx3LuLOdF9aXt7mxME4YNWq31zcnIiAABQFHVkMBg+HRwcPAEAyGQyA7u7u4xWqz2VZXkYAAAh1Gg0GuTm5ubnP3qYSCRcIyMjby+WAQAsLS29qNVqt0VRRAAAuVyOjMfjAYxxuVAoOFKplMNkMpUikcjL6/FB/wRni9g963eawQAAAABJRU5ErkJggg==', 'ce9e10a9-52d9-4ac0-9dfe-0b269ed1b25b'),
('a554fe99-3e0c-4b3e-a6bd-4cf90f9a1f11', 'bosco', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAABK0lEQVQ4y93UIUtDYRTG8Z9zGJYWlkRERIuYDAZBMNgEm7BgMMjStfkF/ACmWUyGJYNhn2CgQQQFQbAZhzhFEERYUcsZXC+buq2IB264h/f533Pe55zLX4/RIfVlbKCFx2GB+wF7wDZucD8orIoGSvGeYA9yfYLGArYY1T1FfhkvPwmzUYg2L1KVwRHOemjASojqcWgycushLGZgjfgYGOkCrOMa0+HeO3axg4MMbAprePuu3U2cYzycS9BEO6pMt1n47eUfR9tJwJMAtlEJR0vdhPkewHw4eYvLuMtTrOIQsymHv0Suh8Odw1t4xivmI9fqZ84691aOefvIPE3M9QOs4yo1GtVhYGIvK5mZPIkdXRhkR2u4i/GoxR9kBhODLn0xKmpG60v+XXwC6K5FLotuIJEAAAAASUVORK5CYII=', 'c3582784-1e91-4b33-8998-ea93f284a424'),
('b9632521-d1a9-49df-a138-7408ed16311c', 'ryobi', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAABK0lEQVQ4y93UIUtDYRTG8Z9zGJYWlkRERIuYDAZBMNgEm7BgMMjStfkF/ACmWUyGJYNhn2CgQQQFQbAZhzhFEERYUcsZXC+buq2IB264h/f533Pe55zLX4/RIfVlbKCFx2GB+wF7wDZucD8orIoGSvGeYA9yfYLGArYY1T1FfhkvPwmzUYg2L1KVwRHOemjASojqcWgycushLGZgjfgYGOkCrOMa0+HeO3axg4MMbAprePuu3U2cYzycS9BEO6pMt1n47eUfR9tJwJMAtlEJR0vdhPkewHw4eYvLuMtTrOIQsymHv0Suh8Odw1t4xivmI9fqZ84691aOefvIPE3M9QOs4yo1GtVhYGIvK5mZPIkdXRhkR2u4i/GoxR9kBhODLn0xKmpG60v+XXwC6K5FLotuIJEAAAAASUVORK5CYII=', 'c3582784-1e91-4b33-8998-ea93f284a424'),
('bd7d5c8b-f394-4c0f-b571-eb3016e391dc', 'phụ tùng máy cắt cỏ', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAECklEQVQ4y71Ub0jidxh/TuXSH5RmZ9hpeq2S/o6s0TTiftiKtWxsYt7hOrn2YuSNLAYyBK0GLehVRaFpRzQu1uAm8zDqmnOBerVS7NpSKVcyLCqo7EgxM/mxN/OWW2y9GHtePd+H5/vheZ7P83wA/k8bGRkpYDAY7pKSklk+n//4On9wfw0olcq7SX9/f78IRdGl/v5+MYZhBcm4QqGgq9XqN68CxCcdt9uNRCKRwdXV1fcZDMa7LS0tcbvd/ml+fv6cUql8yeFw7hUVFRWXl5fnOp3OL/x+/3tCoTC6trbmu7JCl8v11sbGRonL5RJyudznZrO5nc1mf83n858CAEil0vazszMIBAIfdHV1fSKXyz+z2+39brcbubL3ubm5myKRaGJ0dPSj68xKLBaPqVSqB/+YpNfr71ZWVv6YfEskEk5zc/NYTU3NN01NTZ+bTCYiAMD4+DhTIBDMXoVxAwBArVZzotFo2fLy8iOhUPhYo9E8VavVHLPZPFZYWDiFw+E24vG4BI/HMzUazcdVVVXRxsbGyZycnGBaWtoil8t1tre3v3pNSiAQsOBwuASBQHiOoqjRZDJhLBZrAEXRZzqd7onP59vd3Ny0lJaWvhMKhSI2my2gVCp/XlpaemNnZ0dsNpsrwuHw969JIZFI0c7OTrXVap2WyWQJAIBgMEglkUgpDNLp9PV4PE4HAJDL5b8tLCwMCgSCib29vVspLNNotI3e3l4Tj8czzc/PZwMAcDicFY/HI7tM2tbWVkNFRcULAACNRnOPx+OZbDZbq1Qq/TZlhgAAw8PDiNPp7E1PTw8bDIYv3W430t3dPRmLxY7YbPavDodDjGEYUyKRGAAAZmdn77NYLH9ubu46mUyORiKRgE6ne3bjckt9fX0PLBaLyOFwiAEApqamCIuLi3VMJpMyMzPz6Ojo6DaJRIpiGAZEIjGUSCQyMAwjAAAuGAxSTk9P2YQkmM1mu61SqR4ODAw8RFEUFAoFXSaTHQCABQCgtbW1ITMz80VmZqYrFotRotEoH0GQn8LhcIJCoQCGYa0+n+/PS1lfX78ViURwLpeLXldXp7Xb7dqysjKDXq+/k8wpLi5+iSBIxsnJSRWbzbaZTKYnVqt12mg0Tufl5flTTq+jo+OX+vp6rVarnaRSqYtKpfJ+QUFBaGVl5cM/VusOjUZ7dXBwUEUkEm9mZ2djl8d1fn5O+JvaDA0NfTc4OPi20Wiclslkierq6h88Hk9DT09P/fb2dkU4HEYyMjKOj4+PWYeHh8i15EskEsWSflZW1iqLxQr6/X4ZmUw+ZTAYQSqVGqqtrZ0wGAxfpcgWHp+6Nv9mbW1tQ16vl0mn07cSiQTu4uICuQzm9XqLdnd3G/5zlf8dDjG3cZ0WnSoAAAAASUVORK5CYII=', '3526f4a4-9cc6-478e-ab8e-5d3f78fe13c5'),
('c4332e46-c89b-4ecb-a37c-57afe891778c', 'kawasaki', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAABa0lEQVQ4y+3UMWtUQRQF4I8gi0pIEUQMBIsUKiIpUoSgEBZLt0tlKShW6w/QViyCPyBVirRBCCks1CpNwEKLiIJgJQoqMYgRDIsmaU4xTPZlt7HzwjB3Zu45c+89bx7/0EbRajg7OSzJSOGfxnhGbedzYWnjaNdJjFRBlzDZh/RCRXgOy9hBr4nwJzoB3qgIr+BsUf5TfMDWcSXvBfQF1woCmMB0/MVk/HhQD+EHruMz7laCXcwlXazi2zCEb1L2Km5jrDg7g1vBrB2n8nSaDO8wg+2su5l72e9gH5vZn+qn8ifcj7qX84lM4QnuBfALs5hPPDxIIkdU3kmp6/gY8ByWAliIYGU/X+BUMh1NTLskbuE93kaQXTzEb7wM+UE1JnETr9KaI6+p2wd0gL/4Xu3t4lnOFpoEGsPXBtKmcWfQ214uMlgZQLYxzM+iXQCuBtRE2O1HcKJav8bzPK0WHsXfx5/Mvfjb/hscAupMbDTSWCY3AAAAAElFTkSuQmCC', '2f5518c8-0126-4ae8-824b-550f2b17c5a6'),
('c7b1538f-c916-46c5-9af3-9c81a9e46b02', 'kavi', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAABa0lEQVQ4y+3UMWtUQRQF4I8gi0pIEUQMBIsUKiIpUoSgEBZLt0tlKShW6w/QViyCPyBVirRBCCks1CpNwEKLiIJgJQoqMYgRDIsmaU4xTPZlt7HzwjB3Zu45c+89bx7/0EbRajg7OSzJSOGfxnhGbedzYWnjaNdJjFRBlzDZh/RCRXgOy9hBr4nwJzoB3qgIr+BsUf5TfMDWcSXvBfQF1woCmMB0/MVk/HhQD+EHruMz7laCXcwlXazi2zCEb1L2Km5jrDg7g1vBrB2n8nSaDO8wg+2su5l72e9gH5vZn+qn8ifcj7qX84lM4QnuBfALs5hPPDxIIkdU3kmp6/gY8ByWAliIYGU/X+BUMh1NTLskbuE93kaQXTzEb7wM+UE1JnETr9KaI6+p2wd0gL/4Xu3t4lnOFpoEGsPXBtKmcWfQ214uMlgZQLYxzM+iXQCuBtRE2O1HcKJav8bzPK0WHsXfx5/Mvfjb/hscAupMbDTSWCY3AAAAAElFTkSuQmCC', '2f5518c8-0126-4ae8-824b-550f2b17c5a6'),
('ca106ab5-4a07-4b00-8504-d8d9ab59b018', 'phụ tùng máy cưa xích', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAECklEQVQ4y71Ub0jidxh/TuXSH5RmZ9hpeq2S/o6s0TTiftiKtWxsYt7hOrn2YuSNLAYyBK0GLehVRaFpRzQu1uAm8zDqmnOBerVS7NpSKVcyLCqo7EgxM/mxN/OWW2y9GHtePd+H5/vheZ7P83wA/k8bGRkpYDAY7pKSklk+n//4On9wfw0olcq7SX9/f78IRdGl/v5+MYZhBcm4QqGgq9XqN68CxCcdt9uNRCKRwdXV1fcZDMa7LS0tcbvd/ml+fv6cUql8yeFw7hUVFRWXl5fnOp3OL/x+/3tCoTC6trbmu7JCl8v11sbGRonL5RJyudznZrO5nc1mf83n858CAEil0vazszMIBAIfdHV1fSKXyz+z2+39brcbubL3ubm5myKRaGJ0dPSj68xKLBaPqVSqB/+YpNfr71ZWVv6YfEskEk5zc/NYTU3NN01NTZ+bTCYiAMD4+DhTIBDMXoVxAwBArVZzotFo2fLy8iOhUPhYo9E8VavVHLPZPFZYWDiFw+E24vG4BI/HMzUazcdVVVXRxsbGyZycnGBaWtoil8t1tre3v3pNSiAQsOBwuASBQHiOoqjRZDJhLBZrAEXRZzqd7onP59vd3Ny0lJaWvhMKhSI2my2gVCp/XlpaemNnZ0dsNpsrwuHw969JIZFI0c7OTrXVap2WyWQJAIBgMEglkUgpDNLp9PV4PE4HAJDL5b8tLCwMCgSCib29vVspLNNotI3e3l4Tj8czzc/PZwMAcDicFY/HI7tM2tbWVkNFRcULAACNRnOPx+OZbDZbq1Qq/TZlhgAAw8PDiNPp7E1PTw8bDIYv3W430t3dPRmLxY7YbPavDodDjGEYUyKRGAAAZmdn77NYLH9ubu46mUyORiKRgE6ne3bjckt9fX0PLBaLyOFwiAEApqamCIuLi3VMJpMyMzPz6Ojo6DaJRIpiGAZEIjGUSCQyMAwjAAAuGAxSTk9P2YQkmM1mu61SqR4ODAw8RFEUFAoFXSaTHQCABQCgtbW1ITMz80VmZqYrFotRotEoH0GQn8LhcIJCoQCGYa0+n+/PS1lfX78ViURwLpeLXldXp7Xb7dqysjKDXq+/k8wpLi5+iSBIxsnJSRWbzbaZTKYnVqt12mg0Tufl5flTTq+jo+OX+vp6rVarnaRSqYtKpfJ+QUFBaGVl5cM/VusOjUZ7dXBwUEUkEm9mZ2djl8d1fn5O+JvaDA0NfTc4OPi20Wiclslkierq6h88Hk9DT09P/fb2dkU4HEYyMjKOj4+PWYeHh8i15EskEsWSflZW1iqLxQr6/X4ZmUw+ZTAYQSqVGqqtrZ0wGAxfpcgWHp+6Nv9mbW1tQ16vl0mn07cSiQTu4uICuQzm9XqLdnd3G/5zlf8dDjG3cZ0WnSoAAAAASUVORK5CYII=', '3526f4a4-9cc6-478e-ab8e-5d3f78fe13c5'),
('ced43aa1-2dea-4d57-b28a-ed81bd6d0c19', 'stihl', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAABa0lEQVQ4y+3UMWtUQRQF4I8gi0pIEUQMBIsUKiIpUoSgEBZLt0tlKShW6w/QViyCPyBVirRBCCks1CpNwEKLiIJgJQoqMYgRDIsmaU4xTPZlt7HzwjB3Zu45c+89bx7/0EbRajg7OSzJSOGfxnhGbedzYWnjaNdJjFRBlzDZh/RCRXgOy9hBr4nwJzoB3qgIr+BsUf5TfMDWcSXvBfQF1woCmMB0/MVk/HhQD+EHruMz7laCXcwlXazi2zCEb1L2Km5jrDg7g1vBrB2n8nSaDO8wg+2su5l72e9gH5vZn+qn8ifcj7qX84lM4QnuBfALs5hPPDxIIkdU3kmp6/gY8ByWAliIYGU/X+BUMh1NTLskbuE93kaQXTzEb7wM+UE1JnETr9KaI6+p2wd0gL/4Xu3t4lnOFpoEGsPXBtKmcWfQ214uMlgZQLYxzM+iXQCuBtRE2O1HcKJav8bzPK0WHsXfx5/Mvfjb/hscAupMbDTSWCY3AAAAAElFTkSuQmCC', '2f5518c8-0126-4ae8-824b-550f2b17c5a6'),
('d3775f49-9e57-404a-bee9-126705e45609', 'phụ tùng máy nổ', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAECklEQVQ4y71Ub0jidxh/TuXSH5RmZ9hpeq2S/o6s0TTiftiKtWxsYt7hOrn2YuSNLAYyBK0GLehVRaFpRzQu1uAm8zDqmnOBerVS7NpSKVcyLCqo7EgxM/mxN/OWW2y9GHtePd+H5/vheZ7P83wA/k8bGRkpYDAY7pKSklk+n//4On9wfw0olcq7SX9/f78IRdGl/v5+MYZhBcm4QqGgq9XqN68CxCcdt9uNRCKRwdXV1fcZDMa7LS0tcbvd/ml+fv6cUql8yeFw7hUVFRWXl5fnOp3OL/x+/3tCoTC6trbmu7JCl8v11sbGRonL5RJyudznZrO5nc1mf83n858CAEil0vazszMIBAIfdHV1fSKXyz+z2+39brcbubL3ubm5myKRaGJ0dPSj68xKLBaPqVSqB/+YpNfr71ZWVv6YfEskEk5zc/NYTU3NN01NTZ+bTCYiAMD4+DhTIBDMXoVxAwBArVZzotFo2fLy8iOhUPhYo9E8VavVHLPZPFZYWDiFw+E24vG4BI/HMzUazcdVVVXRxsbGyZycnGBaWtoil8t1tre3v3pNSiAQsOBwuASBQHiOoqjRZDJhLBZrAEXRZzqd7onP59vd3Ny0lJaWvhMKhSI2my2gVCp/XlpaemNnZ0dsNpsrwuHw969JIZFI0c7OTrXVap2WyWQJAIBgMEglkUgpDNLp9PV4PE4HAJDL5b8tLCwMCgSCib29vVspLNNotI3e3l4Tj8czzc/PZwMAcDicFY/HI7tM2tbWVkNFRcULAACNRnOPx+OZbDZbq1Qq/TZlhgAAw8PDiNPp7E1PTw8bDIYv3W430t3dPRmLxY7YbPavDodDjGEYUyKRGAAAZmdn77NYLH9ubu46mUyORiKRgE6ne3bjckt9fX0PLBaLyOFwiAEApqamCIuLi3VMJpMyMzPz6Ojo6DaJRIpiGAZEIjGUSCQyMAwjAAAuGAxSTk9P2YQkmM1mu61SqR4ODAw8RFEUFAoFXSaTHQCABQCgtbW1ITMz80VmZqYrFotRotEoH0GQn8LhcIJCoQCGYa0+n+/PS1lfX78ViURwLpeLXldXp7Xb7dqysjKDXq+/k8wpLi5+iSBIxsnJSRWbzbaZTKYnVqt12mg0Tufl5flTTq+jo+OX+vp6rVarnaRSqYtKpfJ+QUFBaGVl5cM/VusOjUZ7dXBwUEUkEm9mZ2djl8d1fn5O+JvaDA0NfTc4OPi20Wiclslkierq6h88Hk9DT09P/fb2dkU4HEYyMjKOj4+PWYeHh8i15EskEsWSflZW1iqLxQr6/X4ZmUw+ZTAYQSqVGqqtrZ0wGAxfpcgWHp+6Nv9mbW1tQ16vl0mn07cSiQTu4uICuQzm9XqLdnd3G/5zlf8dDjG3cZ0WnSoAAAAASUVORK5CYII=', '3526f4a4-9cc6-478e-ab8e-5d3f78fe13c5'),
('d403b810-0a70-4cfe-b21b-1cd179b7febb', 'phụ tùng bình xịt điện', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAECklEQVQ4y71Ub0jidxh/TuXSH5RmZ9hpeq2S/o6s0TTiftiKtWxsYt7hOrn2YuSNLAYyBK0GLehVRaFpRzQu1uAm8zDqmnOBerVS7NpSKVcyLCqo7EgxM/mxN/OWW2y9GHtePd+H5/vheZ7P83wA/k8bGRkpYDAY7pKSklk+n//4On9wfw0olcq7SX9/f78IRdGl/v5+MYZhBcm4QqGgq9XqN68CxCcdt9uNRCKRwdXV1fcZDMa7LS0tcbvd/ml+fv6cUql8yeFw7hUVFRWXl5fnOp3OL/x+/3tCoTC6trbmu7JCl8v11sbGRonL5RJyudznZrO5nc1mf83n858CAEil0vazszMIBAIfdHV1fSKXyz+z2+39brcbubL3ubm5myKRaGJ0dPSj68xKLBaPqVSqB/+YpNfr71ZWVv6YfEskEk5zc/NYTU3NN01NTZ+bTCYiAMD4+DhTIBDMXoVxAwBArVZzotFo2fLy8iOhUPhYo9E8VavVHLPZPFZYWDiFw+E24vG4BI/HMzUazcdVVVXRxsbGyZycnGBaWtoil8t1tre3v3pNSiAQsOBwuASBQHiOoqjRZDJhLBZrAEXRZzqd7onP59vd3Ny0lJaWvhMKhSI2my2gVCp/XlpaemNnZ0dsNpsrwuHw969JIZFI0c7OTrXVap2WyWQJAIBgMEglkUgpDNLp9PV4PE4HAJDL5b8tLCwMCgSCib29vVspLNNotI3e3l4Tj8czzc/PZwMAcDicFY/HI7tM2tbWVkNFRcULAACNRnOPx+OZbDZbq1Qq/TZlhgAAw8PDiNPp7E1PTw8bDIYv3W430t3dPRmLxY7YbPavDodDjGEYUyKRGAAAZmdn77NYLH9ubu46mUyORiKRgE6ne3bjckt9fX0PLBaLyOFwiAEApqamCIuLi3VMJpMyMzPz6Ojo6DaJRIpiGAZEIjGUSCQyMAwjAAAuGAxSTk9P2YQkmM1mu61SqR4ODAw8RFEUFAoFXSaTHQCABQCgtbW1ITMz80VmZqYrFotRotEoH0GQn8LhcIJCoQCGYa0+n+/PS1lfX78ViURwLpeLXldXp7Xb7dqysjKDXq+/k8wpLi5+iSBIxsnJSRWbzbaZTKYnVqt12mg0Tufl5flTTq+jo+OX+vp6rVarnaRSqYtKpfJ+QUFBaGVl5cM/VusOjUZ7dXBwUEUkEm9mZ2djl8d1fn5O+JvaDA0NfTc4OPi20Wiclslkierq6h88Hk9DT09P/fb2dkU4HEYyMjKOj4+PWYeHh8i15EskEsWSflZW1iqLxQr6/X4ZmUw+ZTAYQSqVGqqtrZ0wGAxfpcgWHp+6Nv9mbW1tQ16vl0mn07cSiQTu4uICuQzm9XqLdnd3G/5zlf8dDjG3cZ0WnSoAAAAASUVORK5CYII=', '3526f4a4-9cc6-478e-ab8e-5d3f78fe13c5'),
('d6ebfb68-b9a6-4dbe-a3c0-cd1ea1afa63a', 'robin', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAABa0lEQVQ4y+3UMWtUQRQF4I8gi0pIEUQMBIsUKiIpUoSgEBZLt0tlKShW6w/QViyCPyBVirRBCCks1CpNwEKLiIJgJQoqMYgRDIsmaU4xTPZlt7HzwjB3Zu45c+89bx7/0EbRajg7OSzJSOGfxnhGbedzYWnjaNdJjFRBlzDZh/RCRXgOy9hBr4nwJzoB3qgIr+BsUf5TfMDWcSXvBfQF1woCmMB0/MVk/HhQD+EHruMz7laCXcwlXazi2zCEb1L2Km5jrDg7g1vBrB2n8nSaDO8wg+2su5l72e9gH5vZn+qn8ifcj7qX84lM4QnuBfALs5hPPDxIIkdU3kmp6/gY8ByWAliIYGU/X+BUMh1NTLskbuE93kaQXTzEb7wM+UE1JnETr9KaI6+p2wd0gL/4Xu3t4lnOFpoEGsPXBtKmcWfQ214uMlgZQLYxzM+iXQCuBtRE2O1HcKJav8bzPK0WHsXfx5/Mvfjb/hscAupMbDTSWCY3AAAAAElFTkSuQmCC', '2f5518c8-0126-4ae8-824b-550f2b17c5a6'),
('e05bb07d-d9c3-4aa5-874e-95309fdaa601', 'phụ tùng máy khoan đất', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAECklEQVQ4y71Ub0jidxh/TuXSH5RmZ9hpeq2S/o6s0TTiftiKtWxsYt7hOrn2YuSNLAYyBK0GLehVRaFpRzQu1uAm8zDqmnOBerVS7NpSKVcyLCqo7EgxM/mxN/OWW2y9GHtePd+H5/vheZ7P83wA/k8bGRkpYDAY7pKSklk+n//4On9wfw0olcq7SX9/f78IRdGl/v5+MYZhBcm4QqGgq9XqN68CxCcdt9uNRCKRwdXV1fcZDMa7LS0tcbvd/ml+fv6cUql8yeFw7hUVFRWXl5fnOp3OL/x+/3tCoTC6trbmu7JCl8v11sbGRonL5RJyudznZrO5nc1mf83n858CAEil0vazszMIBAIfdHV1fSKXyz+z2+39brcbubL3ubm5myKRaGJ0dPSj68xKLBaPqVSqB/+YpNfr71ZWVv6YfEskEk5zc/NYTU3NN01NTZ+bTCYiAMD4+DhTIBDMXoVxAwBArVZzotFo2fLy8iOhUPhYo9E8VavVHLPZPFZYWDiFw+E24vG4BI/HMzUazcdVVVXRxsbGyZycnGBaWtoil8t1tre3v3pNSiAQsOBwuASBQHiOoqjRZDJhLBZrAEXRZzqd7onP59vd3Ny0lJaWvhMKhSI2my2gVCp/XlpaemNnZ0dsNpsrwuHw969JIZFI0c7OTrXVap2WyWQJAIBgMEglkUgpDNLp9PV4PE4HAJDL5b8tLCwMCgSCib29vVspLNNotI3e3l4Tj8czzc/PZwMAcDicFY/HI7tM2tbWVkNFRcULAACNRnOPx+OZbDZbq1Qq/TZlhgAAw8PDiNPp7E1PTw8bDIYv3W430t3dPRmLxY7YbPavDodDjGEYUyKRGAAAZmdn77NYLH9ubu46mUyORiKRgE6ne3bjckt9fX0PLBaLyOFwiAEApqamCIuLi3VMJpMyMzPz6Ojo6DaJRIpiGAZEIjGUSCQyMAwjAAAuGAxSTk9P2YQkmM1mu61SqR4ODAw8RFEUFAoFXSaTHQCABQCgtbW1ITMz80VmZqYrFotRotEoH0GQn8LhcIJCoQCGYa0+n+/PS1lfX78ViURwLpeLXldXp7Xb7dqysjKDXq+/k8wpLi5+iSBIxsnJSRWbzbaZTKYnVqt12mg0Tufl5flTTq+jo+OX+vp6rVarnaRSqYtKpfJ+QUFBaGVl5cM/VusOjUZ7dXBwUEUkEm9mZ2djl8d1fn5O+JvaDA0NfTc4OPi20Wiclslkierq6h88Hk9DT09P/fb2dkU4HEYyMjKOj4+PWYeHh8i15EskEsWSflZW1iqLxQr6/X4ZmUw+ZTAYQSqVGqqtrZ0wGAxfpcgWHp+6Nv9mbW1tQ16vl0mn07cSiQTu4uICuQzm9XqLdnd3G/5zlf8dDjG3cZ0WnSoAAAAASUVORK5CYII=', '3526f4a4-9cc6-478e-ab8e-5d3f78fe13c5'),
('e2daa254-3b9e-404d-ac8a-074862349025', 'echo', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAB5klEQVQ4y62U26riMBRAV9I0tahQsaL//20+KefBW00vyT4PQ0JbO4czMIGwScJe2Xd1Pp+F/7jM3x6UUiilFt9EBBH5HTCCxsAoIyQCl8BmDrter1hr6fueqqro+573+41SivV6jYjwer3I85z3+01d1xNPzNwy5xxd11GWJcMw4L2n6zr6vgcghJA+cc4lYLRUxaRorSdbKUWWZRPXo4ve+4kMIRBCAEDP46a1JssyjDET+Xw+OZ/PiAhZlqU9j7dZAo5l0zTcbje89xRFweVyoaoqiqJAa52sjm6bpewCPB4PnHMAdF1HCCGFo+97yrJMoElSxodxrC6XC8MwpGBHa6KrS3WolMKICFrrj4cIK8uSw+GQ7pqmAeD1elGW5URHRP4kZVywAG3bstvtJorW2uSmc47r9brYPWZ8EWVRFCkh9/sd7/1kO+eoqmqxW8yYHkJIQbbWcjweyfOcruvw3gOw3++p65osy1IdjqFm3psRqrXGWsvpdAJIiQghTIo5nifACL3f7zjnEBGstTRNw2azAWC73fL19UXbthhjWK1WPJ9P8jynruvPXhYR2radFKq1NiXJe49SitVqBUDTNBhjKIriM4Zx7Xa7j/E1n4nz0fXj+Bor/GYe/tPEHivNgT+tb8ELlnAdcxM8AAAAAElFTkSuQmCC', '5e5586fd-b560-4c12-b621-f511fc9873ec'),
('ea674462-246f-4cd0-8587-1d353cb36c0b', 'bình xịt điện loại 1 bơm', 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAACcUlEQVQ4y9WUMWgaURzG/xdfmhhP8zT12sajIVlMMJS7DKEQPUp0qKZdNLg2plS44UAuXRpuMDTgJpQKDimkIUMHKSoIoatCJUtjGlLbyUoGB0UjYqJy2g4lxRYHk3bJG//f+/78Pt7HA7h2JxQKYaPRuKNUKr8JgrDyzwutVutznU5XcLlc64ODg/VwODx+Gf/A3wONRnPWbrdRtVq9NTQ0JP+X2BzHbdA0vef3+xcv6/1NGA6Hx2mafrWwsCCOjY0dq9Xqrwih71emmpmZSVEUdaTT6QoEQZxPTEyk9Xp9PhqNaq5EmM1m5y0WyzMAeM2ybHJyctJeKpWow8ND+sqP0ul0WuVyuQUAUCwWEQDciMViG16vd0qSJPJSkTHGOaPRuEOS5HuGYeImk+kmQqiCMc4hhCqjo6NFmqb33G73vb4IfT7f00qlMtdsNh/K8q+2yLI87Ha7H6+urlqmp6c9JEl2otFommXZLUmS7vZFyvO8Q6VSNX0+3wOe5x3BYHC4W19eXrZhjI8Zhon3HZ9l2S2CIM49Hs+jXrooiigUCmGn0ylZrdb1bk3RyzA7O2ur1+t39vf3PWazuZXP5z926+l0umOz2UChUJyqVKovdrv9LJlMtnrSBYPBeYTQD7/fv8jzvIMgiLbX653q0dtIIBC4v7a2Nsdx3LuLOdF9aXt7mxME4YNWq31zcnIiAABQFHVkMBg+HRwcPAEAyGQyA7u7u4xWqz2VZXkYAAAh1Gg0GuTm5ubnP3qYSCRcIyMjby+WAQAsLS29qNVqt0VRRAAAuVyOjMfjAYxxuVAoOFKplMNkMpUikcjL6/FB/wRni9g963eawQAAAABJRU5ErkJggg==', 'ce9e10a9-52d9-4ac0-9dfe-0b269ed1b25b');

INSERT INTO `subNavLink` (`id`, `url`, `tenSubLink`, `maNavLink`) VALUES
('37483b82-6872-431e-aef6-83218c410cc2', '/accessary-stihl', 'phụ tùng stihl', 'ddfd065e-b736-4c35-9087-0d84e45f5cb0');







INSERT INTO `user` (`maNguoiDung`, `taiKhoan`, `matKhau`, `hinhAnh`, `hoTen`, `soDT`, `email`, `theme`, `maLoaiNguoiDung`, `createAt`, `updateAt`, `colorTheme`, `primaryColor`) VALUES
('f6d99c99-83f1-49ac-a685-0c959f86fedd', 'duyhaiserver', '$2b$10$ScykM5Og5PRVzpV8p1neFeXYocsK4RiRxF9G6AdyM0QtLc83i6trG', '1692517184506_hai-tra-tan-logo.png', 'Nguyễn Văn Pháp', '0788246979', 'thanhtien209411@gmail.com', 'dark', '5b40d537-3ecf-4305-b541-6171b2f2c546', '2023-08-20 07:39:44.564', '2023-08-20 07:39:44.564', NULL, '#39caf5');


INSERT INTO `user_type` (`maLoaiNguoiDung`, `loaiNguoiDung`) VALUES
('5b40d537-3ecf-4305-b541-6171b2f2c546', 'admin');
INSERT INTO `user_type` (`maLoaiNguoiDung`, `loaiNguoiDung`) VALUES
('df7c95b9-625a-4ab3-9d70-1c56c0aab336', 'user');
INSERT INTO `user_type` (`maLoaiNguoiDung`, `loaiNguoiDung`) VALUES
('feebefed-063a-4ce0-ae4d-dfdcc3f06f2a', 'staff');




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
