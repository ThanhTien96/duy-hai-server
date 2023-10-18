-- MySQL dump 10.13  Distrib 8.0.34, for Linux (x86_64)
--
-- Host: localhost    Database: duyhaiserver
-- ------------------------------------------------------
-- Server version	8.0.34-0ubuntu0.20.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `about_image`
--

DROP TABLE IF EXISTS `about_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `about_image` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `hinhAnh` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `maHinhAnh` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `about_image_maHinhAnh_fkey` (`maHinhAnh`),
  CONSTRAINT `about_image_maHinhAnh_fkey` FOREIGN KEY (`maHinhAnh`) REFERENCES `about_page` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `about_image`
--

LOCK TABLES `about_image` WRITE;
/*!40000 ALTER TABLE `about_image` DISABLE KEYS */;
/*!40000 ALTER TABLE `about_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `about_page`
--

DROP TABLE IF EXISTS `about_page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `about_page` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `noiDung` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `about_page`
--

LOCK TABLES `about_page` WRITE;
/*!40000 ALTER TABLE `about_page` DISABLE KEYS */;
/*!40000 ALTER TABLE `about_page` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `banner`
--

DROP TABLE IF EXISTS `banner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `banner` (
  `maBanner` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `hinhAnh` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`maBanner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `banner`
--

LOCK TABLES `banner` WRITE;
/*!40000 ALTER TABLE `banner` DISABLE KEYS */;
/*!40000 ALTER TABLE `banner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commune`
--

DROP TABLE IF EXISTS `commune`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commune`
--

LOCK TABLES `commune` WRITE;
/*!40000 ALTER TABLE `commune` DISABLE KEYS */;
/*!40000 ALTER TABLE `commune` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact_page`
--

DROP TABLE IF EXISTS `contact_page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contact_page` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact_page`
--

LOCK TABLES `contact_page` WRITE;
/*!40000 ALTER TABLE `contact_page` DISABLE KEYS */;
INSERT INTO `contact_page` VALUES ('2996aaa6-70af-4102-891c-c366627240aa','NÔNG NGƯ CƠ DUY HẢI','<p>Địa chỉ: Ấp Bàu Lâm, Xuyên Mộc, Bà Rịa- Vũng Tàu</p>\n<p>Điện thoại: 0974 644 973</p>\n<p>Email: <a href=\"mailto:&#x74;&#104;&#97;&#110;&#x67;&#x6d;&#97;&#x79;&#99;&#117;&#x61;&#120;&#x69;&#99;&#x68;&#x40;&#x67;&#109;&#x61;&#x69;&#108;&#46;&#x63;&#x6f;&#x6d;\">&#x74;&#104;&#97;&#110;&#x67;&#x6d;&#97;&#x79;&#99;&#117;&#x61;&#120;&#x69;&#99;&#x68;&#x40;&#x67;&#109;&#x61;&#x69;&#108;&#46;&#x63;&#x6f;&#x6d;</a></p>\n<p>Website: <a href=\"http://nongcoduyhai.com/\">http://nongcoduyhai.com/</a></p>\n');
/*!40000 ALTER TABLE `contact_page` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact_status`
--

DROP TABLE IF EXISTS `contact_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contact_status` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` int NOT NULL,
  `trangThai` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `contact_status_role_key` (`role`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact_status`
--

LOCK TABLES `contact_status` WRITE;
/*!40000 ALTER TABLE `contact_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `contact_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contacts`
--

DROP TABLE IF EXISTS `contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contacts`
--

LOCK TABLES `contacts` WRITE;
/*!40000 ALTER TABLE `contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `country` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` int NOT NULL,
  `codeName` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `country_code_key` (`code`),
  UNIQUE KEY `country_codeName_key` (`codeName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country`
--

LOCK TABLES `country` WRITE;
/*!40000 ALTER TABLE `country` DISABLE KEYS */;
/*!40000 ALTER TABLE `country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `credit`
--

DROP TABLE IF EXISTS `credit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `credit` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `chuTaiKhoan` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `soTaiKhoan` int NOT NULL,
  `chiNhanh` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `soDT` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credit`
--

LOCK TABLES `credit` WRITE;
/*!40000 ALTER TABLE `credit` DISABLE KEYS */;
/*!40000 ALTER TABLE `credit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `district`
--

DROP TABLE IF EXISTS `district`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `district`
--

LOCK TABLES `district` WRITE;
/*!40000 ALTER TABLE `district` DISABLE KEYS */;
/*!40000 ALTER TABLE `district` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fixpost`
--

DROP TABLE IF EXISTS `fixpost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fixpost` (
  `maBaiViet` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tieuDe` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `noiDung` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tenKySu` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updateAt` datetime(3) NOT NULL,
  PRIMARY KEY (`maBaiViet`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fixpost`
--

LOCK TABLES `fixpost` WRITE;
/*!40000 ALTER TABLE `fixpost` DISABLE KEYS */;
/*!40000 ALTER TABLE `fixpost` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fixpost_image`
--

DROP TABLE IF EXISTS `fixpost_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fixpost_image` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `hinhAnh` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `maBaiViet` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fixpost_image_maBaiViet_fkey` (`maBaiViet`),
  CONSTRAINT `fixpost_image_maBaiViet_fkey` FOREIGN KEY (`maBaiViet`) REFERENCES `fixpost` (`maBaiViet`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fixpost_image`
--

LOCK TABLES `fixpost_image` WRITE;
/*!40000 ALTER TABLE `fixpost_image` DISABLE KEYS */;
/*!40000 ALTER TABLE `fixpost_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `footer`
--

DROP TABLE IF EXISTS `footer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `footer`
--

LOCK TABLES `footer` WRITE;
/*!40000 ALTER TABLE `footer` DISABLE KEYS */;
INSERT INTO `footer` VALUES ('b781d57e-455d-42c5-9098-3ef265d65711','THÔNG TIN LIÊN HỆ','<p>NÔNG NGƯ CƠ DUY HẢI\nNÔNG CƠ DUY HẢI \nĐịa chỉ: Ấp Bàu Lâm, Xuyên Mộc, Bà Rịa- Vũng Tàu</p>\n<p>NÔNG CƠ DUY HẢI Điện thoại: 0974 644 973</p>\n<p>NÔNG CƠ DUY HẢI Email: <a href=\"mailto:&#116;&#104;&#97;&#x6e;&#x67;&#109;&#x61;&#x79;&#x63;&#117;&#x61;&#x78;&#105;&#x63;&#x68;&#x40;&#x67;&#109;&#x61;&#x69;&#x6c;&#46;&#x63;&#x6f;&#109;\">&#116;&#104;&#97;&#x6e;&#x67;&#109;&#x61;&#x79;&#x63;&#117;&#x61;&#x78;&#105;&#x63;&#x68;&#x40;&#x67;&#109;&#x61;&#x69;&#x6c;&#46;&#x63;&#x6f;&#109;</a></p>\n<p>NÔNG CƠ DUY HẢI Website: <a href=\"http://nongcohaitratan.com/\">http://nongcohaitratan.com/</a></p>\n','https://www.facebook.com/hainongco0932871994','https://www.youtube.com/@NONGCOHAITRATAN0932871994','/zalo.com','DANH MỤC','CHÍNH SÁCH HỖ TRỢ','<iframe src=\"https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d5537.564523326425!2d107.48146479448583!3d11.064888861754955!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3174453f2dae489b%3A0x306d6b8021dc331c!2zTsOUTkcgQ8agIEjhuqJJIFRSw4AgVMOCTg!5e0!3m2!1svi!2s!4v1693067837651!5m2!1svi!2s\" width=\"600\" height=\"450\" style=\"border:0;\" allowfullscreen=\"\" loading=\"lazy\" referrerpolicy=\"no-referrer-when-downgrade\"></iframe>');
/*!40000 ALTER TABLE `footer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `footerLink`
--

DROP TABLE IF EXISTS `footerLink`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `footerLink` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `link` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `footerId` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `footerLink_footerId_fkey` (`footerId`),
  CONSTRAINT `footerLink_footerId_fkey` FOREIGN KEY (`footerId`) REFERENCES `footer` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `footerLink`
--

LOCK TABLES `footerLink` WRITE;
/*!40000 ALTER TABLE `footerLink` DISABLE KEYS */;
INSERT INTO `footerLink` VALUES ('b4f62b2c-7d40-4902-a46c-bf9de0068d65','chính sách bảo hành','chinh-sach-bao-hanh','b781d57e-455d-42c5-9098-3ef265d65711');
/*!40000 ALTER TABLE `footerLink` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `image_product`
--

DROP TABLE IF EXISTS `image_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `image_product` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `maSanPham` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `hinhAnh` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `image_product_maSanPham_fkey` (`maSanPham`),
  CONSTRAINT `image_product_maSanPham_fkey` FOREIGN KEY (`maSanPham`) REFERENCES `products` (`maSanPham`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `image_product`
--

LOCK TABLES `image_product` WRITE;
/*!40000 ALTER TABLE `image_product` DISABLE KEYS */;
INSERT INTO `image_product` VALUES ('00b0a1c0-a09c-4e71-acf4-2a10d8621def','66a24485-7a98-460c-ba47-c77d9dcd725d','1697431980104_images-(3).jpg'),('03de1c19-5b85-4d20-b228-657269c4e1ea','ada6f830-ece3-4bf3-975d-26b72e7c8317','1697431978637_images-(4).jpg'),('0d8221e5-d7f8-43f9-9ecb-4869901eb0f1','66a24485-7a98-460c-ba47-c77d9dcd725d','1697431980104_images-(4).jpg'),('0f3a18a9-702c-4ddc-b919-8aec7609d0d8','14839948-2131-4eb9-96e8-bc3d60c448ca','1697431985606_images.jpg'),('110563e9-8d11-404c-b3fd-5d257c420439','fbd05323-90d5-437e-b187-583076f9cd36','1697617618782_images-(3).jfif'),('1173e462-b4dc-4285-8da2-a455d0ebec7d','fbd05323-90d5-437e-b187-583076f9cd36','1697617618782_images-(1).jfif'),('13680b24-0694-40b7-8656-30d701a5e805','e39bcccf-6bcc-45fc-a062-939e9c00ad29','1697431988910_images-(3).jpg'),('1533bda1-61c8-4aa0-9b75-4219d459deef','ab82e0f6-1d2a-42f5-81e1-42a87812f23a','1697431993133_images-(3).jpg'),('217bee56-529f-406e-b4c6-cbd9414b53ce','ab82e0f6-1d2a-42f5-81e1-42a87812f23a','1697431993133_images-(4).jpg'),('2232fdee-7a3d-4a00-871a-09125d579540','76855b41-f307-40d4-9b76-84d4217e99fb','1697431991707_images-(1).jpg'),('22b826d1-b505-4cb2-87b9-8296182d3c6a','5f0b9c34-8e6c-4f5b-b67b-28e6dde7438d','1697431987414_images-(4).jpg'),('289f8620-9d2d-47e1-953c-3f84b8e012ba','ab82e0f6-1d2a-42f5-81e1-42a87812f23a','1697431993133_images-(1).jpg'),('2935c7f7-97a5-4913-b04c-c1f46cdd99e8','5f0b9c34-8e6c-4f5b-b67b-28e6dde7438d','1697431987414_images.jpg'),('2c1450ae-b7b2-4897-ab2b-c7e4e5ed77ce','86166f1b-a5ff-490d-9bc8-82151715eb02','1697431981439_images-(3).jpg'),('2c944ae1-a1ba-47dd-8569-875e72220054','86166f1b-a5ff-490d-9bc8-82151715eb02','1697431981439_images.jpg'),('2cf658bd-5f36-4e2e-a545-b88b65e9de06','883fc672-9112-4e07-93dc-b8f8ca03c802','1697431982822_images.jpg'),('2dcb0e65-0207-4ecb-a513-5cc858248584','660a4b4d-c87e-499c-a9ee-b1180605c34e','1697447488555_images-(2).jpg'),('31752798-4845-4d04-9eb8-05b029dd5593','fbd05323-90d5-437e-b187-583076f9cd36','1697617618782_images-(2).jfif'),('3a56ab2a-507c-437f-aefd-012277114bd0','66a24485-7a98-460c-ba47-c77d9dcd725d','1697431980104_images-(2).jpg'),('3cbf2a1c-25e4-405c-b79b-9df5ac11fc73','e39bcccf-6bcc-45fc-a062-939e9c00ad29','1697431988910_images-(2).jpg'),('3e04bc92-2402-4452-83ee-44387109470f','2732ee92-ee56-4bbe-97a6-252145bc68ad','1697431984293_images-(3).jpg'),('44c7e8af-59c9-4c26-b27b-13e4250e612e','e39bcccf-6bcc-45fc-a062-939e9c00ad29','1697431988910_images-(1).jpg'),('45cbf9ff-aeb0-424e-bef9-96ac3814a44a','b00a3c0d-aaa9-4e47-8bbd-ff9560466e32','1697619368001_images-(2).jfif'),('4642132f-cf23-40e0-8989-5303b9319b95','b00a3c0d-aaa9-4e47-8bbd-ff9560466e32','1697619368000_images-(4).jfif'),('46641ae7-4eb2-4c14-a185-784535004343','879c6092-83b9-47e3-85ce-7ebe8bca42fc','1697431975474_images-(4).jpg'),('4fe621c0-0917-4a65-b13d-fea2b6b151ca','5f0b9c34-8e6c-4f5b-b67b-28e6dde7438d','1697431987414_images-(1).jpg'),('542a58ee-217d-4c1b-b222-ad348e12ed76','7e36080f-47aa-45c5-afb7-003366a46b1e','1697431977024_images-(1).jpg'),('584e4c2f-7b77-4232-8d8b-63b74a8764e3','7e36080f-47aa-45c5-afb7-003366a46b1e','1697431977024_images-(4).jpg'),('59f029b2-dff4-4649-af8a-fc4e123aa39f','14839948-2131-4eb9-96e8-bc3d60c448ca','1697431985605_images-(3).jpg'),('6045e19b-9d25-4acb-afd0-3b0063af64bf','7e36080f-47aa-45c5-afb7-003366a46b1e','1697431977025_images.jpg'),('64e223a3-cfa4-4713-a99f-bb7c53fac47f','76855b41-f307-40d4-9b76-84d4217e99fb','1697431991707_images.jpg'),('65b9adaa-e47c-443d-a9c7-470d90ff4e34','9aae0fc9-73ff-4eb2-872e-6dfae5e040dc','1697621395785_images-(2).jfif'),('6b97f4ab-6714-47f2-a0d1-a028ad32e01a','883fc672-9112-4e07-93dc-b8f8ca03c802','1697431982822_images-(4).jpg'),('6dc023df-d375-4486-9dc9-385093f940e1','66a24485-7a98-460c-ba47-c77d9dcd725d','1697431980105_images.jpg'),('6ecc3412-ea7f-445e-98aa-313072aec28d','879c6092-83b9-47e3-85ce-7ebe8bca42fc','1697431975475_images-(2).jpg'),('70f72055-708d-439c-af51-e4ff10ac6b3d','501df66f-c95d-40a8-9510-4c4b9605a292','1697431961944_images-(4).jpg'),('78c86753-c319-4d5f-a866-5124e1b08e88','ab82e0f6-1d2a-42f5-81e1-42a87812f23a','1697431993133_images-(2).jpg'),('7ce2024f-41d1-4c2c-ab8a-32e40c83f6bb','86166f1b-a5ff-490d-9bc8-82151715eb02','1697431981439_images-(2).jpg'),('7dcefd62-279b-4826-b3b7-7a95f562b528','501df66f-c95d-40a8-9510-4c4b9605a292','1697431961945_images-(3).jpg'),('860d7b5d-3a44-4302-b61e-b01fb232dc28','501df66f-c95d-40a8-9510-4c4b9605a292','1697431961945_images-(1).jpg'),('8c530952-8070-48b9-befe-a3a5c92dfa7b','660a4b4d-c87e-499c-a9ee-b1180605c34e','1697447488555_images.jpg'),('8cda236c-217b-4c25-aa2c-46391449b5f0','b00a3c0d-aaa9-4e47-8bbd-ff9560466e32','1697619368002_images-(1).jfif'),('909f59c8-2008-4dac-a973-f4b67b073c79','76855b41-f307-40d4-9b76-84d4217e99fb','1697431991707_images-(2).jpg'),('94011448-ba34-4ec6-b77b-4401702fbd05','501df66f-c95d-40a8-9510-4c4b9605a292','1697431961945_images-(2).jpg'),('96fb7f8f-7fab-42f4-a0d5-d90c4a370e47','86166f1b-a5ff-490d-9bc8-82151715eb02','1697431981439_images-(4).jpg'),('98fcd08b-6fe0-41cb-8569-07c5f5149875','2732ee92-ee56-4bbe-97a6-252145bc68ad','1697431984293_images-(4).jpg'),('9927f943-9f5a-4734-b30f-f3dacc66e0d5','b00a3c0d-aaa9-4e47-8bbd-ff9560466e32','1697619368001_images-(3).jfif'),('9aa7e8ce-efd1-4dc6-b208-df7a556cd773','879c6092-83b9-47e3-85ce-7ebe8bca42fc','1697431975476_images.jpg'),('9b167c08-f056-42c2-8642-95184f24f0a2','2732ee92-ee56-4bbe-97a6-252145bc68ad','1697431984293_images-(1).jpg'),('a3678074-5f44-475f-9eda-4d4044309c2f','ada6f830-ece3-4bf3-975d-26b72e7c8317','1697431978637_images-(2).jpg'),('ade79658-3ada-494a-a86d-50b5ce0a1c7e','14839948-2131-4eb9-96e8-bc3d60c448ca','1697431985606_images-(1).jpg'),('b4e9ae19-e733-498b-808e-462f1791e603','883fc672-9112-4e07-93dc-b8f8ca03c802','1697431982822_images-(1).jpg'),('b59c8e0a-c59c-4d7e-8fc3-f28f5e4e9e1c','ada6f830-ece3-4bf3-975d-26b72e7c8317','1697431978637_images-(3).jpg'),('b797279b-c36f-4bf3-9d2f-08defd2a3c51','fbd05323-90d5-437e-b187-583076f9cd36','1697617618781_images-(4).jfif'),('bcea1bae-ecdd-46e2-87be-6c9f57b7fe27','879c6092-83b9-47e3-85ce-7ebe8bca42fc','1697431975475_images-(3).jpg'),('be5a0fa1-c5bc-42aa-be6f-8cd5eaa2196f','14839948-2131-4eb9-96e8-bc3d60c448ca','1697431985606_images-(2).jpg'),('c0043dc8-e677-4330-9d58-f38361a1c8f4','fbd05323-90d5-437e-b187-583076f9cd36','1697617618783_images.jfif'),('c33fb672-0ade-4717-8b44-9908e180aff0','2732ee92-ee56-4bbe-97a6-252145bc68ad','1697431984293_images-(2).jpg'),('c48bd526-687b-4720-bd3f-83e0b4e00132','76855b41-f307-40d4-9b76-84d4217e99fb','1697431991707_images-(4).jpg'),('c66911c4-6bea-4278-b704-603ed7d005a5','9aae0fc9-73ff-4eb2-872e-6dfae5e040dc','1697621395785_images-(1).jfif'),('c7f137b9-5da3-42a0-8481-03c364b3d79f','e39bcccf-6bcc-45fc-a062-939e9c00ad29','1697431988910_images-(4).jpg'),('c939260e-abd6-418b-a1e1-29285364f896','fbd05323-90d5-437e-b187-583076f9cd36','1697617618783_download.jfif'),('ca68447e-40e0-4970-bf15-54656af61922','7e36080f-47aa-45c5-afb7-003366a46b1e','1697431977024_images-(3).jpg'),('d4c4a74c-c772-4916-b168-f40a560ce4a4','879c6092-83b9-47e3-85ce-7ebe8bca42fc','1697431975475_images-(1).jpg'),('d7939d40-e5dd-4d7b-8b0d-472b99d797bd','501df66f-c95d-40a8-9510-4c4b9605a292','1697431961945_images.jpg'),('d7f5be55-2803-4596-80ca-3fe21acb0376','66a24485-7a98-460c-ba47-c77d9dcd725d','1697431980105_images-(1).jpg'),('d90a5214-bc06-4931-a536-cc471722c2df','883fc672-9112-4e07-93dc-b8f8ca03c802','1697431982822_images-(2).jpg'),('dbcc4b78-447b-4697-ae5f-938cda075800','5f0b9c34-8e6c-4f5b-b67b-28e6dde7438d','1697431987414_images-(2).jpg'),('dc25805d-b0be-46df-8b19-8bfd3f75e176','2732ee92-ee56-4bbe-97a6-252145bc68ad','1697431984293_images.jpg'),('e1a34696-ba0a-47a3-9a04-d4da8f034faa','660a4b4d-c87e-499c-a9ee-b1180605c34e','1697447488554_images-(3).jpg'),('e6194281-0a24-4fc2-a152-6369986df903','ab82e0f6-1d2a-42f5-81e1-42a87812f23a','1697431993133_images.jpg'),('ea077014-65e7-4d59-a432-57439bd1cc5d','ada6f830-ece3-4bf3-975d-26b72e7c8317','1697431978638_images-(1).jpg'),('ecad5c6c-eaa9-4aeb-aca4-f1bf1df60560','14839948-2131-4eb9-96e8-bc3d60c448ca','1697431985605_images-(4).jpg'),('ed1ab4ce-1a2e-4765-a205-a3da7f955660','5f0b9c34-8e6c-4f5b-b67b-28e6dde7438d','1697431987414_images-(3).jpg'),('efe28f0f-7cd6-4388-9c1a-986cbbf5c056','9aae0fc9-73ff-4eb2-872e-6dfae5e040dc','1697621395784_images-(4).jfif'),('f0f5f851-6b96-494a-a7bd-384658df49d0','ada6f830-ece3-4bf3-975d-26b72e7c8317','1697431978638_images.jpg'),('f112d0f8-55a7-4cd1-b3be-bd1441caa589','7e36080f-47aa-45c5-afb7-003366a46b1e','1697431977024_images-(2).jpg'),('f2960453-4505-492c-b8e6-4e9e09843171','76855b41-f307-40d4-9b76-84d4217e99fb','1697431991707_images-(3).jpg'),('f3a8629c-0eec-4639-92a2-7ca09ff4c70b','9aae0fc9-73ff-4eb2-872e-6dfae5e040dc','1697621395785_images-(3).jfif'),('f3e7fa10-4674-4969-beaa-421632acaa67','86166f1b-a5ff-490d-9bc8-82151715eb02','1697431981439_images-(1).jpg'),('f6c54e68-2efa-4f08-9e03-f67c75d0b4bd','660a4b4d-c87e-499c-a9ee-b1180605c34e','1697447488555_images-(1).jpg'),('fb173298-feda-4b84-8b7a-e56330d9ea75','883fc672-9112-4e07-93dc-b8f8ca03c802','1697431982822_images-(3).jpg'),('fc5b45d0-de97-43dc-95ae-09c2a1147afc','e39bcccf-6bcc-45fc-a062-939e9c00ad29','1697431988910_images.jpg');
/*!40000 ALTER TABLE `image_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location_type`
--

DROP TABLE IF EXISTS `location_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `location_type` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location_type`
--

LOCK TABLES `location_type` WRITE;
/*!40000 ALTER TABLE `location_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `location_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maincategories`
--

DROP TABLE IF EXISTS `maincategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `maincategories` (
  `maDanhMucChinh` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tenDanhMuc` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` int NOT NULL,
  `icon` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`maDanhMucChinh`),
  UNIQUE KEY `maincategories_role_key` (`role`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maincategories`
--

LOCK TABLES `maincategories` WRITE;
/*!40000 ALTER TABLE `maincategories` DISABLE KEYS */;
INSERT INTO `maincategories` VALUES ('2f5518c8-0126-4ae8-824b-550f2b17c5a6','máy cắt cỏ',2,'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAABa0lEQVQ4y+3UMWtUQRQF4I8gi0pIEUQMBIsUKiIpUoSgEBZLt0tlKShW6w/QViyCPyBVirRBCCks1CpNwEKLiIJgJQoqMYgRDIsmaU4xTPZlt7HzwjB3Zu45c+89bx7/0EbRajg7OSzJSOGfxnhGbedzYWnjaNdJjFRBlzDZh/RCRXgOy9hBr4nwJzoB3qgIr+BsUf5TfMDWcSXvBfQF1woCmMB0/MVk/HhQD+EHruMz7laCXcwlXazi2zCEb1L2Km5jrDg7g1vBrB2n8nSaDO8wg+2su5l72e9gH5vZn+qn8ifcj7qX84lM4QnuBfALs5hPPDxIIkdU3kmp6/gY8ByWAliIYGU/X+BUMh1NTLskbuE93kaQXTzEb7wM+UE1JnETr9KaI6+p2wd0gL/4Xu3t4lnOFpoEGsPXBtKmcWfQ214uMlgZQLYxzM+iXQCuBtRE2O1HcKJav8bzPK0WHsXfx5/Mvfjb/hscAupMbDTSWCY3AAAAAElFTkSuQmCC'),('3526f4a4-9cc6-478e-ab8e-5d3f78fe13c5','phụ tùng các loại',7,'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAECklEQVQ4y71Ub0jidxh/TuXSH5RmZ9hpeq2S/o6s0TTiftiKtWxsYt7hOrn2YuSNLAYyBK0GLehVRaFpRzQu1uAm8zDqmnOBerVS7NpSKVcyLCqo7EgxM/mxN/OWW2y9GHtePd+H5/vheZ7P83wA/k8bGRkpYDAY7pKSklk+n//4On9wfw0olcq7SX9/f78IRdGl/v5+MYZhBcm4QqGgq9XqN68CxCcdt9uNRCKRwdXV1fcZDMa7LS0tcbvd/ml+fv6cUql8yeFw7hUVFRWXl5fnOp3OL/x+/3tCoTC6trbmu7JCl8v11sbGRonL5RJyudznZrO5nc1mf83n858CAEil0vazszMIBAIfdHV1fSKXyz+z2+39brcbubL3ubm5myKRaGJ0dPSj68xKLBaPqVSqB/+YpNfr71ZWVv6YfEskEk5zc/NYTU3NN01NTZ+bTCYiAMD4+DhTIBDMXoVxAwBArVZzotFo2fLy8iOhUPhYo9E8VavVHLPZPFZYWDiFw+E24vG4BI/HMzUazcdVVVXRxsbGyZycnGBaWtoil8t1tre3v3pNSiAQsOBwuASBQHiOoqjRZDJhLBZrAEXRZzqd7onP59vd3Ny0lJaWvhMKhSI2my2gVCp/XlpaemNnZ0dsNpsrwuHw969JIZFI0c7OTrXVap2WyWQJAIBgMEglkUgpDNLp9PV4PE4HAJDL5b8tLCwMCgSCib29vVspLNNotI3e3l4Tj8czzc/PZwMAcDicFY/HI7tM2tbWVkNFRcULAACNRnOPx+OZbDZbq1Qq/TZlhgAAw8PDiNPp7E1PTw8bDIYv3W430t3dPRmLxY7YbPavDodDjGEYUyKRGAAAZmdn77NYLH9ubu46mUyORiKRgE6ne3bjckt9fX0PLBaLyOFwiAEApqamCIuLi3VMJpMyMzPz6Ojo6DaJRIpiGAZEIjGUSCQyMAwjAAAuGAxSTk9P2YQkmM1mu61SqR4ODAw8RFEUFAoFXSaTHQCABQCgtbW1ITMz80VmZqYrFotRotEoH0GQn8LhcIJCoQCGYa0+n+/PS1lfX78ViURwLpeLXldXp7Xb7dqysjKDXq+/k8wpLi5+iSBIxsnJSRWbzbaZTKYnVqt12mg0Tufl5flTTq+jo+OX+vp6rVarnaRSqYtKpfJ+QUFBaGVl5cM/VusOjUZ7dXBwUEUkEm9mZ2djl8d1fn5O+JvaDA0NfTc4OPi20Wiclslkierq6h88Hk9DT09P/fb2dkU4HEYyMjKOj4+PWYeHh8i15EskEsWSflZW1iqLxQr6/X4ZmUw+ZTAYQSqVGqqtrZ0wGAxfpcgWHp+6Nv9mbW1tQ16vl0mn07cSiQTu4uICuQzm9XqLdnd3G/5zlf8dDjG3cZ0WnSoAAAAASUVORK5CYII='),('5e5586fd-b560-4c12-b621-f511fc9873ec','máy xịt thuốc',3,'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAB5klEQVQ4y62U26riMBRAV9I0tahQsaL//20+KefBW00vyT4PQ0JbO4czMIGwScJe2Xd1Pp+F/7jM3x6UUiilFt9EBBH5HTCCxsAoIyQCl8BmDrter1hr6fueqqro+573+41SivV6jYjwer3I85z3+01d1xNPzNwy5xxd11GWJcMw4L2n6zr6vgcghJA+cc4lYLRUxaRorSdbKUWWZRPXo4ve+4kMIRBCAEDP46a1JssyjDET+Xw+OZ/PiAhZlqU9j7dZAo5l0zTcbje89xRFweVyoaoqiqJAa52sjm6bpewCPB4PnHMAdF1HCCGFo+97yrJMoElSxodxrC6XC8MwpGBHa6KrS3WolMKICFrrj4cIK8uSw+GQ7pqmAeD1elGW5URHRP4kZVywAG3bstvtJorW2uSmc47r9brYPWZ8EWVRFCkh9/sd7/1kO+eoqmqxW8yYHkJIQbbWcjweyfOcruvw3gOw3++p65osy1IdjqFm3psRqrXGWsvpdAJIiQghTIo5nifACL3f7zjnEBGstTRNw2azAWC73fL19UXbthhjWK1WPJ9P8jynruvPXhYR2radFKq1NiXJe49SitVqBUDTNBhjKIriM4Zx7Xa7j/E1n4nz0fXj+Bor/GYe/tPEHivNgT+tb8ELlnAdcxM8AAAAAElFTkSuQmCC'),('6498e419-5514-417d-b62f-a31d9ed3f56d','máy khoan đất',4,'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAA6UlEQVQ4y+3TsUpDQRAF0EMQi1dYWFiIVRCxEEllZeEHSIqIjYUEsbYVbP2OlNaWfoB25g9SWUhIIDaKYBNt5sHyQNyNpQ4M3F2Yu3dm7vKno4d7zL7JO1S5ZIf4zMguLnIIHzPIPnASeIC9qN1AJ3C1FGC7YDQvOMMU77jFJXZx/BuFsJUo3Y8zMZucGfZyZwineG0QjDFJtrxSYpsqimuyGxxEG6uL+LDfUNfHCOclJK0EHyX4DXNslpi52e5zou4ptncVPiuOnbBFTTgpXUCz5XUsJ/druF6EsP4pQzygHY/MQ+V//BxfxHhZeXlQa0YAAAAASUVORK5CYII='),('c3582784-1e91-4b33-8998-ea93f284a424','máy cưa xích',1,'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAABK0lEQVQ4y93UIUtDYRTG8Z9zGJYWlkRERIuYDAZBMNgEm7BgMMjStfkF/ACmWUyGJYNhn2CgQQQFQbAZhzhFEERYUcsZXC+buq2IB264h/f533Pe55zLX4/RIfVlbKCFx2GB+wF7wDZucD8orIoGSvGeYA9yfYLGArYY1T1FfhkvPwmzUYg2L1KVwRHOemjASojqcWgycushLGZgjfgYGOkCrOMa0+HeO3axg4MMbAprePuu3U2cYzycS9BEO6pMt1n47eUfR9tJwJMAtlEJR0vdhPkewHw4eYvLuMtTrOIQsymHv0Suh8Odw1t4xivmI9fqZ84691aOefvIPE3M9QOs4yo1GtVhYGIvK5mZPIkdXRhkR2u4i/GoxR9kBhODLn0xKmpG60v+XXwC6K5FLotuIJEAAAAASUVORK5CYII='),('c4271629-1fa4-45d6-acc8-8a92a84521b1','động cơ máy nổ',5,'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAABcUlEQVQ4y+XUsWsUURAG8F/OY4kaJFEi4RCRQyRlughCGkFSBEljIbaCf4FNsNVGUljb2dgFUqSzEOwsREiVRkSUGE3kiivCGi4234XHcR6eleDAsDPzZmfffPPN8t/JxIA/jSp2jU7sFTyP3UhOjR66uIFv0EwRSXpa+B08zIvnMJd4F3exiEc4xPnyAjs4iO5hN7qX2A7WcBxdS+Ht+Lt4mfyVJlqYGgFLhdOx3+MJVvEZVxM/g4u418hVR8ng+TO8xpsCb8Gzbo45xAV8Ctb3hyU0/4IZbdwu/MlxC1b4gheF/64472QOJzw8yNhHydeCk8PkUp4bf9ryXMHD30m3bLk3JKExZvwEwwpvw7FymteDVRm/hiV8wKsi3sKtfsEpfMRmceM+yD+wFfsId1LwaCB+M5OvTmE55L0QSrQxg5/4jrO4jCuYTbv72Z52tqWVwusTwWQSjzFfbEcdOKqBranTSZ9/h3iQj/T+/R/sLxOLVAG4NlPZAAAAAElFTkSuQmCC'),('ce9e10a9-52d9-4ac0-9dfe-0b269ed1b25b','bình xịt điện',6,'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAACcUlEQVQ4y9WUMWgaURzG/xdfmhhP8zT12sajIVlMMJS7DKEQPUp0qKZdNLg2plS44UAuXRpuMDTgJpQKDimkIUMHKSoIoatCJUtjGlLbyUoGB0UjYqJy2g4lxRYHk3bJG//f+/78Pt7HA7h2JxQKYaPRuKNUKr8JgrDyzwutVutznU5XcLlc64ODg/VwODx+Gf/A3wONRnPWbrdRtVq9NTQ0JP+X2BzHbdA0vef3+xcv6/1NGA6Hx2mafrWwsCCOjY0dq9Xqrwih71emmpmZSVEUdaTT6QoEQZxPTEyk9Xp9PhqNaq5EmM1m5y0WyzMAeM2ybHJyctJeKpWow8ND+sqP0ul0WuVyuQUAUCwWEQDciMViG16vd0qSJPJSkTHGOaPRuEOS5HuGYeImk+kmQqiCMc4hhCqjo6NFmqb33G73vb4IfT7f00qlMtdsNh/K8q+2yLI87Ha7H6+urlqmp6c9JEl2otFommXZLUmS7vZFyvO8Q6VSNX0+3wOe5x3BYHC4W19eXrZhjI8Zhon3HZ9l2S2CIM49Hs+jXrooiigUCmGn0ylZrdb1bk3RyzA7O2ur1+t39vf3PWazuZXP5z926+l0umOz2UChUJyqVKovdrv9LJlMtnrSBYPBeYTQD7/fv8jzvIMgiLbX653q0dtIIBC4v7a2Nsdx3LuLOdF9aXt7mxME4YNWq31zcnIiAABQFHVkMBg+HRwcPAEAyGQyA7u7u4xWqz2VZXkYAAAh1Gg0GuTm5ubnP3qYSCRcIyMjby+WAQAsLS29qNVqt0VRRAAAuVyOjMfjAYxxuVAoOFKplMNkMpUikcjL6/FB/wRni9g963eawQAAAABJRU5ErkJggg==');
/*!40000 ALTER TABLE `maincategories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu` (
  `maMenu` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `logo` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`maMenu`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES ('1991bf6b-ad50-4c7f-bdbc-6ef6e5de3238','1693038496459_hai-tra-tan-logo.png',1);
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `navlink`
--

DROP TABLE IF EXISTS `navlink`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `navlink`
--

LOCK TABLES `navlink` WRITE;
/*!40000 ALTER TABLE `navlink` DISABLE KEYS */;
INSERT INTO `navlink` VALUES ('0ffb6d76-9e2f-4b26-80ad-1a00e86a5e4d','sửa chữa','/repair','1991bf6b-ad50-4c7f-bdbc-6ef6e5de3238',4),('13963d06-bf9b-4414-b3a6-aa8dc7f44651','giới thiệu','/about','1991bf6b-ad50-4c7f-bdbc-6ef6e5de3238',2),('3f4a62eb-cffb-481f-b01e-714e3e7a3455','liên hệ','/contact','1991bf6b-ad50-4c7f-bdbc-6ef6e5de3238',6),('6fe96686-7011-430c-97d9-3fb22c7ed524','tin tức','/news','1991bf6b-ad50-4c7f-bdbc-6ef6e5de3238',5),('ddfd065e-b736-4c35-9087-0d84e45f5cb0','phụ tùng chính hãng','/accessary','1991bf6b-ad50-4c7f-bdbc-6ef6e5de3238',3),('f434ed54-d023-4078-9184-10b3b3daea78','trang chủ','/','1991bf6b-ad50-4c7f-bdbc-6ef6e5de3238',1);
/*!40000 ALTER TABLE `navlink` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `news`
--

DROP TABLE IF EXISTS `news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `news`
--

LOCK TABLES `news` WRITE;
/*!40000 ALTER TABLE `news` DISABLE KEYS */;
/*!40000 ALTER TABLE `news` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `news_image`
--

DROP TABLE IF EXISTS `news_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `news_image` (
  `hinhAnh` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `maTinTuc` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `news_image_maTinTuc_fkey` (`maTinTuc`),
  CONSTRAINT `news_image_maTinTuc_fkey` FOREIGN KEY (`maTinTuc`) REFERENCES `news` (`maTinTuc`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `news_image`
--

LOCK TABLES `news_image` WRITE;
/*!40000 ALTER TABLE `news_image` DISABLE KEYS */;
/*!40000 ALTER TABLE `news_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `news_type`
--

DROP TABLE IF EXISTS `news_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `news_type` (
  `maLoaiTinTuc` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `loaiTinTuc` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`maLoaiTinTuc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `news_type`
--

LOCK TABLES `news_type` WRITE;
/*!40000 ALTER TABLE `news_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `news_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_products`
--

DROP TABLE IF EXISTS `orders_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_products` (
  `maDonHang` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `maSanPham` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `soLuongSanPham` int NOT NULL,
  PRIMARY KEY (`maDonHang`,`maSanPham`),
  KEY `orders_products_maSanPham_fkey` (`maSanPham`),
  CONSTRAINT `orders_products_maDonHang_fkey` FOREIGN KEY (`maDonHang`) REFERENCES `orders` (`maDonHang`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `orders_products_maSanPham_fkey` FOREIGN KEY (`maSanPham`) REFERENCES `products` (`maSanPham`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_products`
--

LOCK TABLES `orders_products` WRITE;
/*!40000 ALTER TABLE `orders_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `otp_auth`
--

DROP TABLE IF EXISTS `otp_auth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `otp_auth` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `otp` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleteAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `otp_auth`
--

LOCK TABLES `otp_auth` WRITE;
/*!40000 ALTER TABLE `otp_auth` DISABLE KEYS */;
/*!40000 ALTER TABLE `otp_auth` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `priority`
--

DROP TABLE IF EXISTS `priority`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `priority` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `doUuTien` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `priority_role_key` (`role`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `priority`
--

LOCK TABLES `priority` WRITE;
/*!40000 ALTER TABLE `priority` DISABLE KEYS */;
/*!40000 ALTER TABLE `priority` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `maSanPham` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tenSanPham` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `moTa` longtext COLLATE utf8mb4_unicode_ci,
  `giaGoc` int NOT NULL,
  `giaGiam` int NOT NULL,
  `tongSoLuong` int NOT NULL,
  `maDanhMucNho` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `createAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updateAt` datetime(3) NOT NULL,
  `hot` tinyint(1) NOT NULL DEFAULT '0',
  `seo` tinyint(1) NOT NULL DEFAULT '0',
  `seoDetail` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `seoTitle` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `moTaNgan` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `youtubeVideo` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`maSanPham`),
  KEY `products_maDanhMucNho_fkey` (`maDanhMucNho`),
  CONSTRAINT `products_maDanhMucNho_fkey` FOREIGN KEY (`maDanhMucNho`) REFERENCES `subcategories` (`maDanhMucNho`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES ('14839948-2131-4eb9-96e8-bc3d60c448ca','product 4','mo ta san pham',3300000,3000000,10,'2c4cba9e-0964-4060-91d2-b92647158080','2023-10-16 04:53:05.608','2023-10-16 04:53:05.608',0,0,'mo ta san pham','mo ta san pham','mo ta san pham',NULL),('2732ee92-ee56-4bbe-97a6-252145bc68ad','product 4','mo ta san pham',3300000,3000000,10,'2c4cba9e-0964-4060-91d2-b92647158080','2023-10-16 04:53:04.295','2023-10-16 04:53:04.295',0,0,'mo ta san pham','mo ta san pham','mo ta san pham',NULL),('501df66f-c95d-40a8-9510-4c4b9605a292','product 4','mo ta san pham',3300000,3000000,10,'2c4cba9e-0964-4060-91d2-b92647158080','2023-10-16 04:52:41.949','2023-10-16 04:52:41.949',0,0,'mo ta san pham','mo ta san pham','mo ta san pham',NULL),('5f0b9c34-8e6c-4f5b-b67b-28e6dde7438d','product 4','mo ta san pham',3300000,3000000,10,'2c4cba9e-0964-4060-91d2-b92647158080','2023-10-16 04:53:07.417','2023-10-16 04:53:07.417',0,0,'mo ta san pham','mo ta san pham','mo ta san pham',NULL),('660a4b4d-c87e-499c-a9ee-b1180605c34e','product 1','mo ta san pham',3300000,3000000,10,'2c4cba9e-0964-4060-91d2-b92647158080','2023-10-16 09:11:28.560','2023-10-16 09:11:28.560',0,0,'mo ta san pham','mo ta san pham','mo ta san pham',NULL),('66a24485-7a98-460c-ba47-c77d9dcd725d','product 4','mo ta san pham',3300000,3000000,10,'2c4cba9e-0964-4060-91d2-b92647158080','2023-10-16 04:53:00.116','2023-10-16 04:53:00.116',0,0,'mo ta san pham','mo ta san pham','mo ta san pham',NULL),('76855b41-f307-40d4-9b76-84d4217e99fb','product 4','mo ta san pham',3300000,3000000,10,'2c4cba9e-0964-4060-91d2-b92647158080','2023-10-16 04:53:11.709','2023-10-16 04:53:11.709',0,0,'mo ta san pham','mo ta san pham','mo ta san pham',NULL),('7e36080f-47aa-45c5-afb7-003366a46b1e','product 4','mo ta san pham',3300000,3000000,10,'2c4cba9e-0964-4060-91d2-b92647158080','2023-10-16 04:52:57.030','2023-10-16 04:52:57.030',0,0,'mo ta san pham','mo ta san pham','mo ta san pham',NULL),('86166f1b-a5ff-490d-9bc8-82151715eb02','product 4','mo ta san pham',3300000,3000000,10,'2c4cba9e-0964-4060-91d2-b92647158080','2023-10-16 04:53:01.442','2023-10-16 04:53:01.442',0,0,'mo ta san pham','mo ta san pham','mo ta san pham',NULL),('879c6092-83b9-47e3-85ce-7ebe8bca42fc','product 4','mo ta san pham',3300000,3000000,10,'2c4cba9e-0964-4060-91d2-b92647158080','2023-10-16 04:52:55.480','2023-10-16 04:52:55.480',0,0,'mo ta san pham','mo ta san pham','mo ta san pham',NULL),('883fc672-9112-4e07-93dc-b8f8ca03c802','product 4','mo ta san pham',3300000,3000000,10,'2c4cba9e-0964-4060-91d2-b92647158080','2023-10-16 04:53:02.836','2023-10-16 04:53:02.836',0,0,'mo ta san pham','mo ta san pham','mo ta san pham',NULL),('9aae0fc9-73ff-4eb2-872e-6dfae5e040dc','product 11','mo ta san pham',300000,3000000,10,'2c4cba9e-0964-4060-91d2-b92647158080','2023-10-18 09:29:55.864','2023-10-18 09:29:55.864',0,0,'mo ta san pham','mo ta san pham','mo ta san pham',NULL),('ab82e0f6-1d2a-42f5-81e1-42a87812f23a','product 4','mo ta san pham',3300000,3000000,10,'2c4cba9e-0964-4060-91d2-b92647158080','2023-10-16 04:53:13.136','2023-10-16 04:53:13.136',0,0,'mo ta san pham','mo ta san pham','mo ta san pham',NULL),('ada6f830-ece3-4bf3-975d-26b72e7c8317','product 4','mo ta san pham',3300000,3000000,10,'2c4cba9e-0964-4060-91d2-b92647158080','2023-10-16 04:52:58.640','2023-10-16 04:52:58.640',0,0,'mo ta san pham','mo ta san pham','mo ta san pham',NULL),('b00a3c0d-aaa9-4e47-8bbd-ff9560466e32','product 10','mo ta san pham',3300000,3000000,10,'2c4cba9e-0964-4060-91d2-b92647158080','2023-10-18 08:56:08.077','2023-10-18 08:56:08.077',0,0,'mo ta san pham','mo ta san pham','mo ta san pham',NULL),('e39bcccf-6bcc-45fc-a062-939e9c00ad29','product 4','mo ta san pham',3300000,3000000,10,'2c4cba9e-0964-4060-91d2-b92647158080','2023-10-16 04:53:08.920','2023-10-16 04:53:08.920',0,0,'mo ta san pham','mo ta san pham','mo ta san pham',NULL),('fbd05323-90d5-437e-b187-583076f9cd36','Eos minima culpa ut ','',345343,342954,345,'2c4cba9e-0964-4060-91d2-b92647158080','2023-10-18 08:26:58.790','2023-10-18 08:26:58.790',0,0,'Tempor sed magnam pr','Quasi consequat Ver','Quis velit eveniet ','Velit vitae irure op');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `province`
--

DROP TABLE IF EXISTS `province`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `province`
--

LOCK TABLES `province` WRITE;
/*!40000 ALTER TABLE `province` DISABLE KEYS */;
/*!40000 ALTER TABLE `province` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rates`
--

DROP TABLE IF EXISTS `rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rates` (
  `maDanhGia` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `soSao` int NOT NULL,
  `soLuotDanhGia` int NOT NULL,
  `maSanPham` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`maDanhGia`),
  KEY `rates_maSanPham_fkey` (`maSanPham`),
  CONSTRAINT `rates_maSanPham_fkey` FOREIGN KEY (`maSanPham`) REFERENCES `products` (`maSanPham`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rates`
--

LOCK TABLES `rates` WRITE;
/*!40000 ALTER TABLE `rates` DISABLE KEYS */;
/*!40000 ALTER TABLE `rates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `status`
--

DROP TABLE IF EXISTS `status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `status` (
  `maTrangThai` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `trangThai` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` int NOT NULL,
  PRIMARY KEY (`maTrangThai`),
  UNIQUE KEY `status_role_key` (`role`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `status`
--

LOCK TABLES `status` WRITE;
/*!40000 ALTER TABLE `status` DISABLE KEYS */;
/*!40000 ALTER TABLE `status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subNavLink`
--

DROP TABLE IF EXISTS `subNavLink`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subNavLink` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tenSubLink` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `maNavLink` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `subNavLink_maNavLink_fkey` (`maNavLink`),
  CONSTRAINT `subNavLink_maNavLink_fkey` FOREIGN KEY (`maNavLink`) REFERENCES `navlink` (`maNavLink`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subNavLink`
--

LOCK TABLES `subNavLink` WRITE;
/*!40000 ALTER TABLE `subNavLink` DISABLE KEYS */;
INSERT INTO `subNavLink` VALUES ('37483b82-6872-431e-aef6-83218c410cc2','/accessary-stihl','phụ tùng stihl','ddfd065e-b736-4c35-9087-0d84e45f5cb0');
/*!40000 ALTER TABLE `subNavLink` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subcategories`
--

DROP TABLE IF EXISTS `subcategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subcategories` (
  `maDanhMucNho` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tenDanhMucNho` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `maDanhMucChinh` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`maDanhMucNho`),
  KEY `subCategories_maDanhMucChinh_fkey` (`maDanhMucChinh`),
  CONSTRAINT `subCategories_maDanhMucChinh_fkey` FOREIGN KEY (`maDanhMucChinh`) REFERENCES `maincategories` (`maDanhMucChinh`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subcategories`
--

LOCK TABLES `subcategories` WRITE;
/*!40000 ALTER TABLE `subcategories` DISABLE KEYS */;
INSERT INTO `subcategories` VALUES ('0325f20c-cb7d-4525-9bf4-809fdc41bde8','động cơ xăng roman','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAABcUlEQVQ4y+XUsWsUURAG8F/OY4kaJFEi4RCRQyRlughCGkFSBEljIbaCf4FNsNVGUljb2dgFUqSzEOwsREiVRkSUGE3kiivCGi4234XHcR6eleDAsDPzZmfffPPN8t/JxIA/jSp2jU7sFTyP3UhOjR66uIFv0EwRSXpa+B08zIvnMJd4F3exiEc4xPnyAjs4iO5hN7qX2A7WcBxdS+Ht+Lt4mfyVJlqYGgFLhdOx3+MJVvEZVxM/g4u418hVR8ng+TO8xpsCb8Gzbo45xAV8Ctb3hyU0/4IZbdwu/MlxC1b4gheF/64472QOJzw8yNhHydeCk8PkUp4bf9ryXMHD30m3bLk3JKExZvwEwwpvw7FymteDVRm/hiV8wKsi3sKtfsEpfMRmceM+yD+wFfsId1LwaCB+M5OvTmE55L0QSrQxg5/4jrO4jCuYTbv72Z52tqWVwusTwWQSjzFfbEcdOKqBranTSZ9/h3iQj/T+/R/sLxOLVAG4NlPZAAAAAElFTkSuQmCC','c4271629-1fa4-45d6-acc8-8a92a84521b1'),('1b18100e-0b77-4729-b776-9883d259db71','permax','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAB5klEQVQ4y62U26riMBRAV9I0tahQsaL//20+KefBW00vyT4PQ0JbO4czMIGwScJe2Xd1Pp+F/7jM3x6UUiilFt9EBBH5HTCCxsAoIyQCl8BmDrter1hr6fueqqro+573+41SivV6jYjwer3I85z3+01d1xNPzNwy5xxd11GWJcMw4L2n6zr6vgcghJA+cc4lYLRUxaRorSdbKUWWZRPXo4ve+4kMIRBCAEDP46a1JssyjDET+Xw+OZ/PiAhZlqU9j7dZAo5l0zTcbje89xRFweVyoaoqiqJAa52sjm6bpewCPB4PnHMAdF1HCCGFo+97yrJMoElSxodxrC6XC8MwpGBHa6KrS3WolMKICFrrj4cIK8uSw+GQ7pqmAeD1elGW5URHRP4kZVywAG3bstvtJorW2uSmc47r9brYPWZ8EWVRFCkh9/sd7/1kO+eoqmqxW8yYHkJIQbbWcjweyfOcruvw3gOw3++p65osy1IdjqFm3psRqrXGWsvpdAJIiQghTIo5nifACL3f7zjnEBGstTRNw2azAWC73fL19UXbthhjWK1WPJ9P8jynruvPXhYR2radFKq1NiXJe49SitVqBUDTNBhjKIriM4Zx7Xa7j/E1n4nz0fXj+Bor/GYe/tPEHivNgT+tb8ELlnAdcxM8AAAAAElFTkSuQmCC','5e5586fd-b560-4c12-b621-f511fc9873ec'),('24009297-dec2-4d23-8cda-9d5dacd19602','hinota','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAA6UlEQVQ4y+3TsUpDQRAF0EMQi1dYWFiIVRCxEEllZeEHSIqIjYUEsbYVbP2OlNaWfoB25g9SWUhIIDaKYBNt5sHyQNyNpQ4M3F2Yu3dm7vKno4d7zL7JO1S5ZIf4zMguLnIIHzPIPnASeIC9qN1AJ3C1FGC7YDQvOMMU77jFJXZx/BuFsJUo3Y8zMZucGfZyZwineG0QjDFJtrxSYpsqimuyGxxEG6uL+LDfUNfHCOclJK0EHyX4DXNslpi52e5zou4ptncVPiuOnbBFTTgpXUCz5XUsJ/druF6EsP4pQzygHY/MQ+V//BxfxHhZeXlQa0YAAAAASUVORK5CYII=','6498e419-5514-417d-b62f-a31d9ed3f56d'),('25fd8ac0-925a-4b42-872f-67a6f958bbae','yuki','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAB5klEQVQ4y62U26riMBRAV9I0tahQsaL//20+KefBW00vyT4PQ0JbO4czMIGwScJe2Xd1Pp+F/7jM3x6UUiilFt9EBBH5HTCCxsAoIyQCl8BmDrter1hr6fueqqro+573+41SivV6jYjwer3I85z3+01d1xNPzNwy5xxd11GWJcMw4L2n6zr6vgcghJA+cc4lYLRUxaRorSdbKUWWZRPXo4ve+4kMIRBCAEDP46a1JssyjDET+Xw+OZ/PiAhZlqU9j7dZAo5l0zTcbje89xRFweVyoaoqiqJAa52sjm6bpewCPB4PnHMAdF1HCCGFo+97yrJMoElSxodxrC6XC8MwpGBHa6KrS3WolMKICFrrj4cIK8uSw+GQ7pqmAeD1elGW5URHRP4kZVywAG3bstvtJorW2uSmc47r9brYPWZ8EWVRFCkh9/sd7/1kO+eoqmqxW8yYHkJIQbbWcjweyfOcruvw3gOw3++p65osy1IdjqFm3psRqrXGWsvpdAJIiQghTIo5nifACL3f7zjnEBGstTRNw2azAWC73fL19UXbthhjWK1WPJ9P8jynruvPXhYR2radFKq1NiXJe49SitVqBUDTNBhjKIriM4Zx7Xa7j/E1n4nz0fXj+Bor/GYe/tPEHivNgT+tb8ELlnAdcxM8AAAAAElFTkSuQmCC','5e5586fd-b560-4c12-b621-f511fc9873ec'),('28b12fd5-3c2f-496d-8ca8-5e338c98ecfd','mitsuyama','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAABcUlEQVQ4y+XUsWsUURAG8F/OY4kaJFEi4RCRQyRlughCGkFSBEljIbaCf4FNsNVGUljb2dgFUqSzEOwsREiVRkSUGE3kiivCGi4234XHcR6eleDAsDPzZmfffPPN8t/JxIA/jSp2jU7sFTyP3UhOjR66uIFv0EwRSXpa+B08zIvnMJd4F3exiEc4xPnyAjs4iO5hN7qX2A7WcBxdS+Ht+Lt4mfyVJlqYGgFLhdOx3+MJVvEZVxM/g4u418hVR8ng+TO8xpsCb8Gzbo45xAV8Ctb3hyU0/4IZbdwu/MlxC1b4gheF/64472QOJzw8yNhHydeCk8PkUp4bf9ryXMHD30m3bLk3JKExZvwEwwpvw7FymteDVRm/hiV8wKsi3sKtfsEpfMRmceM+yD+wFfsId1LwaCB+M5OvTmE55L0QSrQxg5/4jrO4jCuYTbv72Z52tqWVwusTwWQSjzFfbEcdOKqBranTSZ9/h3iQj/T+/R/sLxOLVAG4NlPZAAAAAElFTkSuQmCC','c4271629-1fa4-45d6-acc8-8a92a84521b1'),('2c4cba9e-0964-4060-91d2-b92647158080','makita','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAABK0lEQVQ4y93UIUtDYRTG8Z9zGJYWlkRERIuYDAZBMNgEm7BgMMjStfkF/ACmWUyGJYNhn2CgQQQFQbAZhzhFEERYUcsZXC+buq2IB264h/f533Pe55zLX4/RIfVlbKCFx2GB+wF7wDZucD8orIoGSvGeYA9yfYLGArYY1T1FfhkvPwmzUYg2L1KVwRHOemjASojqcWgycushLGZgjfgYGOkCrOMa0+HeO3axg4MMbAprePuu3U2cYzycS9BEO6pMt1n47eUfR9tJwJMAtlEJR0vdhPkewHw4eYvLuMtTrOIQsymHv0Suh8Odw1t4xivmI9fqZ84691aOefvIPE3M9QOs4yo1GtVhYGIvK5mZPIkdXRhkR2u4i/GoxR9kBhODLn0xKmpG60v+XXwC6K5FLotuIJEAAAAASUVORK5CYII=','c3582784-1e91-4b33-8998-ea93f284a424'),('2e537c13-d71f-4be5-aff5-ac5121681269','shingu','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAABK0lEQVQ4y93UIUtDYRTG8Z9zGJYWlkRERIuYDAZBMNgEm7BgMMjStfkF/ACmWUyGJYNhn2CgQQQFQbAZhzhFEERYUcsZXC+buq2IB264h/f533Pe55zLX4/RIfVlbKCFx2GB+wF7wDZucD8orIoGSvGeYA9yfYLGArYY1T1FfhkvPwmzUYg2L1KVwRHOemjASojqcWgycushLGZgjfgYGOkCrOMa0+HeO3axg4MMbAprePuu3U2cYzycS9BEO6pMt1n47eUfR9tJwJMAtlEJR0vdhPkewHw4eYvLuMtTrOIQsymHv0Suh8Odw1t4xivmI9fqZ84691aOefvIPE3M9QOs4yo1GtVhYGIvK5mZPIkdXRhkR2u4i/GoxR9kBhODLn0xKmpG60v+XXwC6K5FLotuIJEAAAAASUVORK5CYII=','c3582784-1e91-4b33-8998-ea93f284a424'),('30870ee2-a191-44c7-b307-c55643433b0a','mitsuyama','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAA6UlEQVQ4y+3TsUpDQRAF0EMQi1dYWFiIVRCxEEllZeEHSIqIjYUEsbYVbP2OlNaWfoB25g9SWUhIIDaKYBNt5sHyQNyNpQ4M3F2Yu3dm7vKno4d7zL7JO1S5ZIf4zMguLnIIHzPIPnASeIC9qN1AJ3C1FGC7YDQvOMMU77jFJXZx/BuFsJUo3Y8zMZucGfZyZwineG0QjDFJtrxSYpsqimuyGxxEG6uL+LDfUNfHCOclJK0EHyX4DXNslpi52e5zou4ptncVPiuOnbBFTTgpXUCz5XUsJ/druF6EsP4pQzygHY/MQ+V//BxfxHhZeXlQa0YAAAAASUVORK5CYII=','6498e419-5514-417d-b62f-a31d9ed3f56d'),('3d310a34-eef5-4271-ab49-9540335d91ea','echo','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAABa0lEQVQ4y+3UMWtUQRQF4I8gi0pIEUQMBIsUKiIpUoSgEBZLt0tlKShW6w/QViyCPyBVirRBCCks1CpNwEKLiIJgJQoqMYgRDIsmaU4xTPZlt7HzwjB3Zu45c+89bx7/0EbRajg7OSzJSOGfxnhGbedzYWnjaNdJjFRBlzDZh/RCRXgOy9hBr4nwJzoB3qgIr+BsUf5TfMDWcSXvBfQF1woCmMB0/MVk/HhQD+EHruMz7laCXcwlXazi2zCEb1L2Km5jrDg7g1vBrB2n8nSaDO8wg+2su5l72e9gH5vZn+qn8ifcj7qX84lM4QnuBfALs5hPPDxIIkdU3kmp6/gY8ByWAliIYGU/X+BUMh1NTLskbuE93kaQXTzEb7wM+UE1JnETr9KaI6+p2wd0gL/4Xu3t4lnOFpoEGsPXBtKmcWfQ214uMlgZQLYxzM+iXQCuBtRE2O1HcKJav8bzPK0WHsXfx5/Mvfjb/hscAupMbDTSWCY3AAAAAElFTkSuQmCC','2f5518c8-0126-4ae8-824b-550f2b17c5a6'),('4a8f9498-fbd0-4a3b-b295-6cc2e0dddcda','mitsubishi','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAABa0lEQVQ4y+3UMWtUQRQF4I8gi0pIEUQMBIsUKiIpUoSgEBZLt0tlKShW6w/QViyCPyBVirRBCCks1CpNwEKLiIJgJQoqMYgRDIsmaU4xTPZlt7HzwjB3Zu45c+89bx7/0EbRajg7OSzJSOGfxnhGbedzYWnjaNdJjFRBlzDZh/RCRXgOy9hBr4nwJzoB3qgIr+BsUf5TfMDWcSXvBfQF1woCmMB0/MVk/HhQD+EHruMz7laCXcwlXazi2zCEb1L2Km5jrDg7g1vBrB2n8nSaDO8wg+2su5l72e9gH5vZn+qn8ifcj7qX84lM4QnuBfALs5hPPDxIIkdU3kmp6/gY8ByWAliIYGU/X+BUMh1NTLskbuE93kaQXTzEb7wM+UE1JnETr9KaI6+p2wd0gL/4Xu3t4lnOFpoEGsPXBtKmcWfQ214uMlgZQLYxzM+iXQCuBtRE2O1HcKJav8bzPK0WHsXfx5/Mvfjb/hscAupMbDTSWCY3AAAAAElFTkSuQmCC','2f5518c8-0126-4ae8-824b-550f2b17c5a6'),('6ef8a5e0-479f-45ac-a1af-70f4d071cd7d','hitachi','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAABK0lEQVQ4y93UIUtDYRTG8Z9zGJYWlkRERIuYDAZBMNgEm7BgMMjStfkF/ACmWUyGJYNhn2CgQQQFQbAZhzhFEERYUcsZXC+buq2IB264h/f533Pe55zLX4/RIfVlbKCFx2GB+wF7wDZucD8orIoGSvGeYA9yfYLGArYY1T1FfhkvPwmzUYg2L1KVwRHOemjASojqcWgycushLGZgjfgYGOkCrOMa0+HeO3axg4MMbAprePuu3U2cYzycS9BEO6pMt1n47eUfR9tJwJMAtlEJR0vdhPkewHw4eYvLuMtTrOIQsymHv0Suh8Odw1t4xivmI9fqZ84691aOefvIPE3M9QOs4yo1GtVhYGIvK5mZPIkdXRhkR2u4i/GoxR9kBhODLn0xKmpG60v+XXwC6K5FLotuIJEAAAAASUVORK5CYII=','c3582784-1e91-4b33-8998-ea93f284a424'),('7a9b293d-bc84-4dd5-8f35-db04037af8e6','maruyama','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAABa0lEQVQ4y+3UMWtUQRQF4I8gi0pIEUQMBIsUKiIpUoSgEBZLt0tlKShW6w/QViyCPyBVirRBCCks1CpNwEKLiIJgJQoqMYgRDIsmaU4xTPZlt7HzwjB3Zu45c+89bx7/0EbRajg7OSzJSOGfxnhGbedzYWnjaNdJjFRBlzDZh/RCRXgOy9hBr4nwJzoB3qgIr+BsUf5TfMDWcSXvBfQF1woCmMB0/MVk/HhQD+EHruMz7laCXcwlXazi2zCEb1L2Km5jrDg7g1vBrB2n8nSaDO8wg+2su5l72e9gH5vZn+qn8ifcj7qX84lM4QnuBfALs5hPPDxIIkdU3kmp6/gY8ByWAliIYGU/X+BUMh1NTLskbuE93kaQXTzEb7wM+UE1JnETr9KaI6+p2wd0gL/4Xu3t4lnOFpoEGsPXBtKmcWfQ214uMlgZQLYxzM+iXQCuBtRE2O1HcKJav8bzPK0WHsXfx5/Mvfjb/hscAupMbDTSWCY3AAAAAElFTkSuQmCC','2f5518c8-0126-4ae8-824b-550f2b17c5a6'),('9493e6f5-2ea4-4dcf-9b2e-08519c08de56','động cơ xăng yokohama','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAABcUlEQVQ4y+XUsWsUURAG8F/OY4kaJFEi4RCRQyRlughCGkFSBEljIbaCf4FNsNVGUljb2dgFUqSzEOwsREiVRkSUGE3kiivCGi4234XHcR6eleDAsDPzZmfffPPN8t/JxIA/jSp2jU7sFTyP3UhOjR66uIFv0EwRSXpa+B08zIvnMJd4F3exiEc4xPnyAjs4iO5hN7qX2A7WcBxdS+Ht+Lt4mfyVJlqYGgFLhdOx3+MJVvEZVxM/g4u418hVR8ng+TO8xpsCb8Gzbo45xAV8Ctb3hyU0/4IZbdwu/MlxC1b4gheF/64472QOJzw8yNhHydeCk8PkUp4bf9ryXMHD30m3bLk3JKExZvwEwwpvw7FymteDVRm/hiV8wKsi3sKtfsEpfMRmceM+yD+wFfsId1LwaCB+M5OvTmE55L0QSrQxg5/4jrO4jCuYTbv72Z52tqWVwusTwWQSjzFfbEcdOKqBranTSZ9/h3iQj/T+/R/sLxOLVAG4NlPZAAAAAElFTkSuQmCC','c4271629-1fa4-45d6-acc8-8a92a84521b1'),('988990e6-3d3f-4afa-bab3-fc7e0fb7402e','stihl','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAABK0lEQVQ4y93UIUtDYRTG8Z9zGJYWlkRERIuYDAZBMNgEm7BgMMjStfkF/ACmWUyGJYNhn2CgQQQFQbAZhzhFEERYUcsZXC+buq2IB264h/f533Pe55zLX4/RIfVlbKCFx2GB+wF7wDZucD8orIoGSvGeYA9yfYLGArYY1T1FfhkvPwmzUYg2L1KVwRHOemjASojqcWgycushLGZgjfgYGOkCrOMa0+HeO3axg4MMbAprePuu3U2cYzycS9BEO6pMt1n47eUfR9tJwJMAtlEJR0vdhPkewHw4eYvLuMtTrOIQsymHv0Suh8Odw1t4xivmI9fqZ84691aOefvIPE3M9QOs4yo1GtVhYGIvK5mZPIkdXRhkR2u4i/GoxR9kBhODLn0xKmpG60v+XXwC6K5FLotuIJEAAAAASUVORK5CYII=','c3582784-1e91-4b33-8998-ea93f284a424'),('9e64426f-d511-42e6-ae6b-2e87e2b003eb','bình xịt điện loại 2 bơm','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAACcUlEQVQ4y9WUMWgaURzG/xdfmhhP8zT12sajIVlMMJS7DKEQPUp0qKZdNLg2plS44UAuXRpuMDTgJpQKDimkIUMHKSoIoatCJUtjGlLbyUoGB0UjYqJy2g4lxRYHk3bJG//f+/78Pt7HA7h2JxQKYaPRuKNUKr8JgrDyzwutVutznU5XcLlc64ODg/VwODx+Gf/A3wONRnPWbrdRtVq9NTQ0JP+X2BzHbdA0vef3+xcv6/1NGA6Hx2mafrWwsCCOjY0dq9Xqrwih71emmpmZSVEUdaTT6QoEQZxPTEyk9Xp9PhqNaq5EmM1m5y0WyzMAeM2ybHJyctJeKpWow8ND+sqP0ul0WuVyuQUAUCwWEQDciMViG16vd0qSJPJSkTHGOaPRuEOS5HuGYeImk+kmQqiCMc4hhCqjo6NFmqb33G73vb4IfT7f00qlMtdsNh/K8q+2yLI87Ha7H6+urlqmp6c9JEl2otFommXZLUmS7vZFyvO8Q6VSNX0+3wOe5x3BYHC4W19eXrZhjI8Zhon3HZ9l2S2CIM49Hs+jXrooiigUCmGn0ylZrdb1bk3RyzA7O2ur1+t39vf3PWazuZXP5z926+l0umOz2UChUJyqVKovdrv9LJlMtnrSBYPBeYTQD7/fv8jzvIMgiLbX653q0dtIIBC4v7a2Nsdx3LuLOdF9aXt7mxME4YNWq31zcnIiAABQFHVkMBg+HRwcPAEAyGQyA7u7u4xWqz2VZXkYAAAh1Gg0GuTm5ubnP3qYSCRcIyMjby+WAQAsLS29qNVqt0VRRAAAuVyOjMfjAYxxuVAoOFKplMNkMpUikcjL6/FB/wRni9g963eawQAAAABJRU5ErkJggg==','ce9e10a9-52d9-4ac0-9dfe-0b269ed1b25b'),('a554fe99-3e0c-4b3e-a6bd-4cf90f9a1f11','bosco','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAABK0lEQVQ4y93UIUtDYRTG8Z9zGJYWlkRERIuYDAZBMNgEm7BgMMjStfkF/ACmWUyGJYNhn2CgQQQFQbAZhzhFEERYUcsZXC+buq2IB264h/f533Pe55zLX4/RIfVlbKCFx2GB+wF7wDZucD8orIoGSvGeYA9yfYLGArYY1T1FfhkvPwmzUYg2L1KVwRHOemjASojqcWgycushLGZgjfgYGOkCrOMa0+HeO3axg4MMbAprePuu3U2cYzycS9BEO6pMt1n47eUfR9tJwJMAtlEJR0vdhPkewHw4eYvLuMtTrOIQsymHv0Suh8Odw1t4xivmI9fqZ84691aOefvIPE3M9QOs4yo1GtVhYGIvK5mZPIkdXRhkR2u4i/GoxR9kBhODLn0xKmpG60v+XXwC6K5FLotuIJEAAAAASUVORK5CYII=','c3582784-1e91-4b33-8998-ea93f284a424'),('b9632521-d1a9-49df-a138-7408ed16311c','ryobi','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAABK0lEQVQ4y93UIUtDYRTG8Z9zGJYWlkRERIuYDAZBMNgEm7BgMMjStfkF/ACmWUyGJYNhn2CgQQQFQbAZhzhFEERYUcsZXC+buq2IB264h/f533Pe55zLX4/RIfVlbKCFx2GB+wF7wDZucD8orIoGSvGeYA9yfYLGArYY1T1FfhkvPwmzUYg2L1KVwRHOemjASojqcWgycushLGZgjfgYGOkCrOMa0+HeO3axg4MMbAprePuu3U2cYzycS9BEO6pMt1n47eUfR9tJwJMAtlEJR0vdhPkewHw4eYvLuMtTrOIQsymHv0Suh8Odw1t4xivmI9fqZ84691aOefvIPE3M9QOs4yo1GtVhYGIvK5mZPIkdXRhkR2u4i/GoxR9kBhODLn0xKmpG60v+XXwC6K5FLotuIJEAAAAASUVORK5CYII=','c3582784-1e91-4b33-8998-ea93f284a424'),('bd7d5c8b-f394-4c0f-b571-eb3016e391dc','phụ tùng máy cắt cỏ','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAECklEQVQ4y71Ub0jidxh/TuXSH5RmZ9hpeq2S/o6s0TTiftiKtWxsYt7hOrn2YuSNLAYyBK0GLehVRaFpRzQu1uAm8zDqmnOBerVS7NpSKVcyLCqo7EgxM/mxN/OWW2y9GHtePd+H5/vheZ7P83wA/k8bGRkpYDAY7pKSklk+n//4On9wfw0olcq7SX9/f78IRdGl/v5+MYZhBcm4QqGgq9XqN68CxCcdt9uNRCKRwdXV1fcZDMa7LS0tcbvd/ml+fv6cUql8yeFw7hUVFRWXl5fnOp3OL/x+/3tCoTC6trbmu7JCl8v11sbGRonL5RJyudznZrO5nc1mf83n858CAEil0vazszMIBAIfdHV1fSKXyz+z2+39brcbubL3ubm5myKRaGJ0dPSj68xKLBaPqVSqB/+YpNfr71ZWVv6YfEskEk5zc/NYTU3NN01NTZ+bTCYiAMD4+DhTIBDMXoVxAwBArVZzotFo2fLy8iOhUPhYo9E8VavVHLPZPFZYWDiFw+E24vG4BI/HMzUazcdVVVXRxsbGyZycnGBaWtoil8t1tre3v3pNSiAQsOBwuASBQHiOoqjRZDJhLBZrAEXRZzqd7onP59vd3Ny0lJaWvhMKhSI2my2gVCp/XlpaemNnZ0dsNpsrwuHw969JIZFI0c7OTrXVap2WyWQJAIBgMEglkUgpDNLp9PV4PE4HAJDL5b8tLCwMCgSCib29vVspLNNotI3e3l4Tj8czzc/PZwMAcDicFY/HI7tM2tbWVkNFRcULAACNRnOPx+OZbDZbq1Qq/TZlhgAAw8PDiNPp7E1PTw8bDIYv3W430t3dPRmLxY7YbPavDodDjGEYUyKRGAAAZmdn77NYLH9ubu46mUyORiKRgE6ne3bjckt9fX0PLBaLyOFwiAEApqamCIuLi3VMJpMyMzPz6Ojo6DaJRIpiGAZEIjGUSCQyMAwjAAAuGAxSTk9P2YQkmM1mu61SqR4ODAw8RFEUFAoFXSaTHQCABQCgtbW1ITMz80VmZqYrFotRotEoH0GQn8LhcIJCoQCGYa0+n+/PS1lfX78ViURwLpeLXldXp7Xb7dqysjKDXq+/k8wpLi5+iSBIxsnJSRWbzbaZTKYnVqt12mg0Tufl5flTTq+jo+OX+vp6rVarnaRSqYtKpfJ+QUFBaGVl5cM/VusOjUZ7dXBwUEUkEm9mZ2djl8d1fn5O+JvaDA0NfTc4OPi20Wiclslkierq6h88Hk9DT09P/fb2dkU4HEYyMjKOj4+PWYeHh8i15EskEsWSflZW1iqLxQr6/X4ZmUw+ZTAYQSqVGqqtrZ0wGAxfpcgWHp+6Nv9mbW1tQ16vl0mn07cSiQTu4uICuQzm9XqLdnd3G/5zlf8dDjG3cZ0WnSoAAAAASUVORK5CYII=','3526f4a4-9cc6-478e-ab8e-5d3f78fe13c5'),('c4332e46-c89b-4ecb-a37c-57afe891778c','kawasaki','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAABa0lEQVQ4y+3UMWtUQRQF4I8gi0pIEUQMBIsUKiIpUoSgEBZLt0tlKShW6w/QViyCPyBVirRBCCks1CpNwEKLiIJgJQoqMYgRDIsmaU4xTPZlt7HzwjB3Zu45c+89bx7/0EbRajg7OSzJSOGfxnhGbedzYWnjaNdJjFRBlzDZh/RCRXgOy9hBr4nwJzoB3qgIr+BsUf5TfMDWcSXvBfQF1woCmMB0/MVk/HhQD+EHruMz7laCXcwlXazi2zCEb1L2Km5jrDg7g1vBrB2n8nSaDO8wg+2su5l72e9gH5vZn+qn8ifcj7qX84lM4QnuBfALs5hPPDxIIkdU3kmp6/gY8ByWAliIYGU/X+BUMh1NTLskbuE93kaQXTzEb7wM+UE1JnETr9KaI6+p2wd0gL/4Xu3t4lnOFpoEGsPXBtKmcWfQ214uMlgZQLYxzM+iXQCuBtRE2O1HcKJav8bzPK0WHsXfx5/Mvfjb/hscAupMbDTSWCY3AAAAAElFTkSuQmCC','2f5518c8-0126-4ae8-824b-550f2b17c5a6'),('c7b1538f-c916-46c5-9af3-9c81a9e46b02','kavi','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAABa0lEQVQ4y+3UMWtUQRQF4I8gi0pIEUQMBIsUKiIpUoSgEBZLt0tlKShW6w/QViyCPyBVirRBCCks1CpNwEKLiIJgJQoqMYgRDIsmaU4xTPZlt7HzwjB3Zu45c+89bx7/0EbRajg7OSzJSOGfxnhGbedzYWnjaNdJjFRBlzDZh/RCRXgOy9hBr4nwJzoB3qgIr+BsUf5TfMDWcSXvBfQF1woCmMB0/MVk/HhQD+EHruMz7laCXcwlXazi2zCEb1L2Km5jrDg7g1vBrB2n8nSaDO8wg+2su5l72e9gH5vZn+qn8ifcj7qX84lM4QnuBfALs5hPPDxIIkdU3kmp6/gY8ByWAliIYGU/X+BUMh1NTLskbuE93kaQXTzEb7wM+UE1JnETr9KaI6+p2wd0gL/4Xu3t4lnOFpoEGsPXBtKmcWfQ214uMlgZQLYxzM+iXQCuBtRE2O1HcKJav8bzPK0WHsXfx5/Mvfjb/hscAupMbDTSWCY3AAAAAElFTkSuQmCC','2f5518c8-0126-4ae8-824b-550f2b17c5a6'),('ca106ab5-4a07-4b00-8504-d8d9ab59b018','phụ tùng máy cưa xích','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAECklEQVQ4y71Ub0jidxh/TuXSH5RmZ9hpeq2S/o6s0TTiftiKtWxsYt7hOrn2YuSNLAYyBK0GLehVRaFpRzQu1uAm8zDqmnOBerVS7NpSKVcyLCqo7EgxM/mxN/OWW2y9GHtePd+H5/vheZ7P83wA/k8bGRkpYDAY7pKSklk+n//4On9wfw0olcq7SX9/f78IRdGl/v5+MYZhBcm4QqGgq9XqN68CxCcdt9uNRCKRwdXV1fcZDMa7LS0tcbvd/ml+fv6cUql8yeFw7hUVFRWXl5fnOp3OL/x+/3tCoTC6trbmu7JCl8v11sbGRonL5RJyudznZrO5nc1mf83n858CAEil0vazszMIBAIfdHV1fSKXyz+z2+39brcbubL3ubm5myKRaGJ0dPSj68xKLBaPqVSqB/+YpNfr71ZWVv6YfEskEk5zc/NYTU3NN01NTZ+bTCYiAMD4+DhTIBDMXoVxAwBArVZzotFo2fLy8iOhUPhYo9E8VavVHLPZPFZYWDiFw+E24vG4BI/HMzUazcdVVVXRxsbGyZycnGBaWtoil8t1tre3v3pNSiAQsOBwuASBQHiOoqjRZDJhLBZrAEXRZzqd7onP59vd3Ny0lJaWvhMKhSI2my2gVCp/XlpaemNnZ0dsNpsrwuHw969JIZFI0c7OTrXVap2WyWQJAIBgMEglkUgpDNLp9PV4PE4HAJDL5b8tLCwMCgSCib29vVspLNNotI3e3l4Tj8czzc/PZwMAcDicFY/HI7tM2tbWVkNFRcULAACNRnOPx+OZbDZbq1Qq/TZlhgAAw8PDiNPp7E1PTw8bDIYv3W430t3dPRmLxY7YbPavDodDjGEYUyKRGAAAZmdn77NYLH9ubu46mUyORiKRgE6ne3bjckt9fX0PLBaLyOFwiAEApqamCIuLi3VMJpMyMzPz6Ojo6DaJRIpiGAZEIjGUSCQyMAwjAAAuGAxSTk9P2YQkmM1mu61SqR4ODAw8RFEUFAoFXSaTHQCABQCgtbW1ITMz80VmZqYrFotRotEoH0GQn8LhcIJCoQCGYa0+n+/PS1lfX78ViURwLpeLXldXp7Xb7dqysjKDXq+/k8wpLi5+iSBIxsnJSRWbzbaZTKYnVqt12mg0Tufl5flTTq+jo+OX+vp6rVarnaRSqYtKpfJ+QUFBaGVl5cM/VusOjUZ7dXBwUEUkEm9mZ2djl8d1fn5O+JvaDA0NfTc4OPi20Wiclslkierq6h88Hk9DT09P/fb2dkU4HEYyMjKOj4+PWYeHh8i15EskEsWSflZW1iqLxQr6/X4ZmUw+ZTAYQSqVGqqtrZ0wGAxfpcgWHp+6Nv9mbW1tQ16vl0mn07cSiQTu4uICuQzm9XqLdnd3G/5zlf8dDjG3cZ0WnSoAAAAASUVORK5CYII=','3526f4a4-9cc6-478e-ab8e-5d3f78fe13c5'),('ced43aa1-2dea-4d57-b28a-ed81bd6d0c19','stihl','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAABa0lEQVQ4y+3UMWtUQRQF4I8gi0pIEUQMBIsUKiIpUoSgEBZLt0tlKShW6w/QViyCPyBVirRBCCks1CpNwEKLiIJgJQoqMYgRDIsmaU4xTPZlt7HzwjB3Zu45c+89bx7/0EbRajg7OSzJSOGfxnhGbedzYWnjaNdJjFRBlzDZh/RCRXgOy9hBr4nwJzoB3qgIr+BsUf5TfMDWcSXvBfQF1woCmMB0/MVk/HhQD+EHruMz7laCXcwlXazi2zCEb1L2Km5jrDg7g1vBrB2n8nSaDO8wg+2su5l72e9gH5vZn+qn8ifcj7qX84lM4QnuBfALs5hPPDxIIkdU3kmp6/gY8ByWAliIYGU/X+BUMh1NTLskbuE93kaQXTzEb7wM+UE1JnETr9KaI6+p2wd0gL/4Xu3t4lnOFpoEGsPXBtKmcWfQ214uMlgZQLYxzM+iXQCuBtRE2O1HcKJav8bzPK0WHsXfx5/Mvfjb/hscAupMbDTSWCY3AAAAAElFTkSuQmCC','2f5518c8-0126-4ae8-824b-550f2b17c5a6'),('d3775f49-9e57-404a-bee9-126705e45609','phụ tùng máy nổ','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAECklEQVQ4y71Ub0jidxh/TuXSH5RmZ9hpeq2S/o6s0TTiftiKtWxsYt7hOrn2YuSNLAYyBK0GLehVRaFpRzQu1uAm8zDqmnOBerVS7NpSKVcyLCqo7EgxM/mxN/OWW2y9GHtePd+H5/vheZ7P83wA/k8bGRkpYDAY7pKSklk+n//4On9wfw0olcq7SX9/f78IRdGl/v5+MYZhBcm4QqGgq9XqN68CxCcdt9uNRCKRwdXV1fcZDMa7LS0tcbvd/ml+fv6cUql8yeFw7hUVFRWXl5fnOp3OL/x+/3tCoTC6trbmu7JCl8v11sbGRonL5RJyudznZrO5nc1mf83n858CAEil0vazszMIBAIfdHV1fSKXyz+z2+39brcbubL3ubm5myKRaGJ0dPSj68xKLBaPqVSqB/+YpNfr71ZWVv6YfEskEk5zc/NYTU3NN01NTZ+bTCYiAMD4+DhTIBDMXoVxAwBArVZzotFo2fLy8iOhUPhYo9E8VavVHLPZPFZYWDiFw+E24vG4BI/HMzUazcdVVVXRxsbGyZycnGBaWtoil8t1tre3v3pNSiAQsOBwuASBQHiOoqjRZDJhLBZrAEXRZzqd7onP59vd3Ny0lJaWvhMKhSI2my2gVCp/XlpaemNnZ0dsNpsrwuHw969JIZFI0c7OTrXVap2WyWQJAIBgMEglkUgpDNLp9PV4PE4HAJDL5b8tLCwMCgSCib29vVspLNNotI3e3l4Tj8czzc/PZwMAcDicFY/HI7tM2tbWVkNFRcULAACNRnOPx+OZbDZbq1Qq/TZlhgAAw8PDiNPp7E1PTw8bDIYv3W430t3dPRmLxY7YbPavDodDjGEYUyKRGAAAZmdn77NYLH9ubu46mUyORiKRgE6ne3bjckt9fX0PLBaLyOFwiAEApqamCIuLi3VMJpMyMzPz6Ojo6DaJRIpiGAZEIjGUSCQyMAwjAAAuGAxSTk9P2YQkmM1mu61SqR4ODAw8RFEUFAoFXSaTHQCABQCgtbW1ITMz80VmZqYrFotRotEoH0GQn8LhcIJCoQCGYa0+n+/PS1lfX78ViURwLpeLXldXp7Xb7dqysjKDXq+/k8wpLi5+iSBIxsnJSRWbzbaZTKYnVqt12mg0Tufl5flTTq+jo+OX+vp6rVarnaRSqYtKpfJ+QUFBaGVl5cM/VusOjUZ7dXBwUEUkEm9mZ2djl8d1fn5O+JvaDA0NfTc4OPi20Wiclslkierq6h88Hk9DT09P/fb2dkU4HEYyMjKOj4+PWYeHh8i15EskEsWSflZW1iqLxQr6/X4ZmUw+ZTAYQSqVGqqtrZ0wGAxfpcgWHp+6Nv9mbW1tQ16vl0mn07cSiQTu4uICuQzm9XqLdnd3G/5zlf8dDjG3cZ0WnSoAAAAASUVORK5CYII=','3526f4a4-9cc6-478e-ab8e-5d3f78fe13c5'),('d403b810-0a70-4cfe-b21b-1cd179b7febb','phụ tùng bình xịt điện','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAECklEQVQ4y71Ub0jidxh/TuXSH5RmZ9hpeq2S/o6s0TTiftiKtWxsYt7hOrn2YuSNLAYyBK0GLehVRaFpRzQu1uAm8zDqmnOBerVS7NpSKVcyLCqo7EgxM/mxN/OWW2y9GHtePd+H5/vheZ7P83wA/k8bGRkpYDAY7pKSklk+n//4On9wfw0olcq7SX9/f78IRdGl/v5+MYZhBcm4QqGgq9XqN68CxCcdt9uNRCKRwdXV1fcZDMa7LS0tcbvd/ml+fv6cUql8yeFw7hUVFRWXl5fnOp3OL/x+/3tCoTC6trbmu7JCl8v11sbGRonL5RJyudznZrO5nc1mf83n858CAEil0vazszMIBAIfdHV1fSKXyz+z2+39brcbubL3ubm5myKRaGJ0dPSj68xKLBaPqVSqB/+YpNfr71ZWVv6YfEskEk5zc/NYTU3NN01NTZ+bTCYiAMD4+DhTIBDMXoVxAwBArVZzotFo2fLy8iOhUPhYo9E8VavVHLPZPFZYWDiFw+E24vG4BI/HMzUazcdVVVXRxsbGyZycnGBaWtoil8t1tre3v3pNSiAQsOBwuASBQHiOoqjRZDJhLBZrAEXRZzqd7onP59vd3Ny0lJaWvhMKhSI2my2gVCp/XlpaemNnZ0dsNpsrwuHw969JIZFI0c7OTrXVap2WyWQJAIBgMEglkUgpDNLp9PV4PE4HAJDL5b8tLCwMCgSCib29vVspLNNotI3e3l4Tj8czzc/PZwMAcDicFY/HI7tM2tbWVkNFRcULAACNRnOPx+OZbDZbq1Qq/TZlhgAAw8PDiNPp7E1PTw8bDIYv3W430t3dPRmLxY7YbPavDodDjGEYUyKRGAAAZmdn77NYLH9ubu46mUyORiKRgE6ne3bjckt9fX0PLBaLyOFwiAEApqamCIuLi3VMJpMyMzPz6Ojo6DaJRIpiGAZEIjGUSCQyMAwjAAAuGAxSTk9P2YQkmM1mu61SqR4ODAw8RFEUFAoFXSaTHQCABQCgtbW1ITMz80VmZqYrFotRotEoH0GQn8LhcIJCoQCGYa0+n+/PS1lfX78ViURwLpeLXldXp7Xb7dqysjKDXq+/k8wpLi5+iSBIxsnJSRWbzbaZTKYnVqt12mg0Tufl5flTTq+jo+OX+vp6rVarnaRSqYtKpfJ+QUFBaGVl5cM/VusOjUZ7dXBwUEUkEm9mZ2djl8d1fn5O+JvaDA0NfTc4OPi20Wiclslkierq6h88Hk9DT09P/fb2dkU4HEYyMjKOj4+PWYeHh8i15EskEsWSflZW1iqLxQr6/X4ZmUw+ZTAYQSqVGqqtrZ0wGAxfpcgWHp+6Nv9mbW1tQ16vl0mn07cSiQTu4uICuQzm9XqLdnd3G/5zlf8dDjG3cZ0WnSoAAAAASUVORK5CYII=','3526f4a4-9cc6-478e-ab8e-5d3f78fe13c5'),('d6ebfb68-b9a6-4dbe-a3c0-cd1ea1afa63a','robin','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAABa0lEQVQ4y+3UMWtUQRQF4I8gi0pIEUQMBIsUKiIpUoSgEBZLt0tlKShW6w/QViyCPyBVirRBCCks1CpNwEKLiIJgJQoqMYgRDIsmaU4xTPZlt7HzwjB3Zu45c+89bx7/0EbRajg7OSzJSOGfxnhGbedzYWnjaNdJjFRBlzDZh/RCRXgOy9hBr4nwJzoB3qgIr+BsUf5TfMDWcSXvBfQF1woCmMB0/MVk/HhQD+EHruMz7laCXcwlXazi2zCEb1L2Km5jrDg7g1vBrB2n8nSaDO8wg+2su5l72e9gH5vZn+qn8ifcj7qX84lM4QnuBfALs5hPPDxIIkdU3kmp6/gY8ByWAliIYGU/X+BUMh1NTLskbuE93kaQXTzEb7wM+UE1JnETr9KaI6+p2wd0gL/4Xu3t4lnOFpoEGsPXBtKmcWfQ214uMlgZQLYxzM+iXQCuBtRE2O1HcKJav8bzPK0WHsXfx5/Mvfjb/hscAupMbDTSWCY3AAAAAElFTkSuQmCC','2f5518c8-0126-4ae8-824b-550f2b17c5a6'),('e05bb07d-d9c3-4aa5-874e-95309fdaa601','phụ tùng máy khoan đất','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAECklEQVQ4y71Ub0jidxh/TuXSH5RmZ9hpeq2S/o6s0TTiftiKtWxsYt7hOrn2YuSNLAYyBK0GLehVRaFpRzQu1uAm8zDqmnOBerVS7NpSKVcyLCqo7EgxM/mxN/OWW2y9GHtePd+H5/vheZ7P83wA/k8bGRkpYDAY7pKSklk+n//4On9wfw0olcq7SX9/f78IRdGl/v5+MYZhBcm4QqGgq9XqN68CxCcdt9uNRCKRwdXV1fcZDMa7LS0tcbvd/ml+fv6cUql8yeFw7hUVFRWXl5fnOp3OL/x+/3tCoTC6trbmu7JCl8v11sbGRonL5RJyudznZrO5nc1mf83n858CAEil0vazszMIBAIfdHV1fSKXyz+z2+39brcbubL3ubm5myKRaGJ0dPSj68xKLBaPqVSqB/+YpNfr71ZWVv6YfEskEk5zc/NYTU3NN01NTZ+bTCYiAMD4+DhTIBDMXoVxAwBArVZzotFo2fLy8iOhUPhYo9E8VavVHLPZPFZYWDiFw+E24vG4BI/HMzUazcdVVVXRxsbGyZycnGBaWtoil8t1tre3v3pNSiAQsOBwuASBQHiOoqjRZDJhLBZrAEXRZzqd7onP59vd3Ny0lJaWvhMKhSI2my2gVCp/XlpaemNnZ0dsNpsrwuHw969JIZFI0c7OTrXVap2WyWQJAIBgMEglkUgpDNLp9PV4PE4HAJDL5b8tLCwMCgSCib29vVspLNNotI3e3l4Tj8czzc/PZwMAcDicFY/HI7tM2tbWVkNFRcULAACNRnOPx+OZbDZbq1Qq/TZlhgAAw8PDiNPp7E1PTw8bDIYv3W430t3dPRmLxY7YbPavDodDjGEYUyKRGAAAZmdn77NYLH9ubu46mUyORiKRgE6ne3bjckt9fX0PLBaLyOFwiAEApqamCIuLi3VMJpMyMzPz6Ojo6DaJRIpiGAZEIjGUSCQyMAwjAAAuGAxSTk9P2YQkmM1mu61SqR4ODAw8RFEUFAoFXSaTHQCABQCgtbW1ITMz80VmZqYrFotRotEoH0GQn8LhcIJCoQCGYa0+n+/PS1lfX78ViURwLpeLXldXp7Xb7dqysjKDXq+/k8wpLi5+iSBIxsnJSRWbzbaZTKYnVqt12mg0Tufl5flTTq+jo+OX+vp6rVarnaRSqYtKpfJ+QUFBaGVl5cM/VusOjUZ7dXBwUEUkEm9mZ2djl8d1fn5O+JvaDA0NfTc4OPi20Wiclslkierq6h88Hk9DT09P/fb2dkU4HEYyMjKOj4+PWYeHh8i15EskEsWSflZW1iqLxQr6/X4ZmUw+ZTAYQSqVGqqtrZ0wGAxfpcgWHp+6Nv9mbW1tQ16vl0mn07cSiQTu4uICuQzm9XqLdnd3G/5zlf8dDjG3cZ0WnSoAAAAASUVORK5CYII=','3526f4a4-9cc6-478e-ab8e-5d3f78fe13c5'),('e2daa254-3b9e-404d-ac8a-074862349025','echo','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAB5klEQVQ4y62U26riMBRAV9I0tahQsaL//20+KefBW00vyT4PQ0JbO4czMIGwScJe2Xd1Pp+F/7jM3x6UUiilFt9EBBH5HTCCxsAoIyQCl8BmDrter1hr6fueqqro+573+41SivV6jYjwer3I85z3+01d1xNPzNwy5xxd11GWJcMw4L2n6zr6vgcghJA+cc4lYLRUxaRorSdbKUWWZRPXo4ve+4kMIRBCAEDP46a1JssyjDET+Xw+OZ/PiAhZlqU9j7dZAo5l0zTcbje89xRFweVyoaoqiqJAa52sjm6bpewCPB4PnHMAdF1HCCGFo+97yrJMoElSxodxrC6XC8MwpGBHa6KrS3WolMKICFrrj4cIK8uSw+GQ7pqmAeD1elGW5URHRP4kZVywAG3bstvtJorW2uSmc47r9brYPWZ8EWVRFCkh9/sd7/1kO+eoqmqxW8yYHkJIQbbWcjweyfOcruvw3gOw3++p65osy1IdjqFm3psRqrXGWsvpdAJIiQghTIo5nifACL3f7zjnEBGstTRNw2azAWC73fL19UXbthhjWK1WPJ9P8jynruvPXhYR2radFKq1NiXJe49SitVqBUDTNBhjKIriM4Zx7Xa7j/E1n4nz0fXj+Bor/GYe/tPEHivNgT+tb8ELlnAdcxM8AAAAAElFTkSuQmCC','5e5586fd-b560-4c12-b621-f511fc9873ec'),('ea674462-246f-4cd0-8587-1d353cb36c0b','bình xịt điện loại 1 bơm','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAACcUlEQVQ4y9WUMWgaURzG/xdfmhhP8zT12sajIVlMMJS7DKEQPUp0qKZdNLg2plS44UAuXRpuMDTgJpQKDimkIUMHKSoIoatCJUtjGlLbyUoGB0UjYqJy2g4lxRYHk3bJG//f+/78Pt7HA7h2JxQKYaPRuKNUKr8JgrDyzwutVutznU5XcLlc64ODg/VwODx+Gf/A3wONRnPWbrdRtVq9NTQ0JP+X2BzHbdA0vef3+xcv6/1NGA6Hx2mafrWwsCCOjY0dq9Xqrwih71emmpmZSVEUdaTT6QoEQZxPTEyk9Xp9PhqNaq5EmM1m5y0WyzMAeM2ybHJyctJeKpWow8ND+sqP0ul0WuVyuQUAUCwWEQDciMViG16vd0qSJPJSkTHGOaPRuEOS5HuGYeImk+kmQqiCMc4hhCqjo6NFmqb33G73vb4IfT7f00qlMtdsNh/K8q+2yLI87Ha7H6+urlqmp6c9JEl2otFommXZLUmS7vZFyvO8Q6VSNX0+3wOe5x3BYHC4W19eXrZhjI8Zhon3HZ9l2S2CIM49Hs+jXrooiigUCmGn0ylZrdb1bk3RyzA7O2ur1+t39vf3PWazuZXP5z926+l0umOz2UChUJyqVKovdrv9LJlMtnrSBYPBeYTQD7/fv8jzvIMgiLbX653q0dtIIBC4v7a2Nsdx3LuLOdF9aXt7mxME4YNWq31zcnIiAABQFHVkMBg+HRwcPAEAyGQyA7u7u4xWqz2VZXkYAAAh1Gg0GuTm5ubnP3qYSCRcIyMjby+WAQAsLS29qNVqt0VRRAAAuVyOjMfjAYxxuVAoOFKplMNkMpUikcjL6/FB/wRni9g963eawQAAAABJRU5ErkJggg==','ce9e10a9-52d9-4ac0-9dfe-0b269ed1b25b');
/*!40000 ALTER TABLE `subcategories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `support_comment`
--

DROP TABLE IF EXISTS `support_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `support_comment`
--

LOCK TABLES `support_comment` WRITE;
/*!40000 ALTER TABLE `support_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `support_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `support_post`
--

DROP TABLE IF EXISTS `support_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `support_post` (
  `id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tieuDe` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `noiDung` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `createAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updateAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `support_post`
--

LOCK TABLES `support_post` WRITE;
/*!40000 ALTER TABLE `support_post` DISABLE KEYS */;
/*!40000 ALTER TABLE `support_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `maNguoiDung` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `taiKhoan` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `matKhau` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `hinhAnh` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hoTen` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `soDT` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `theme` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'dark',
  `maLoaiNguoiDung` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `createAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updateAt` datetime(3) NOT NULL,
  `colorTheme` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `primaryColor` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '#39caf5',
  PRIMARY KEY (`maNguoiDung`),
  UNIQUE KEY `user_taiKhoan_key` (`taiKhoan`),
  UNIQUE KEY `user_email_key` (`email`),
  KEY `user_maLoaiNguoiDung_fkey` (`maLoaiNguoiDung`),
  CONSTRAINT `user_maLoaiNguoiDung_fkey` FOREIGN KEY (`maLoaiNguoiDung`) REFERENCES `user_type` (`maLoaiNguoiDung`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('f6d99c99-83f1-49ac-a685-0c959f86fed7','admin','$2b$10$ScykM5Og5PRVzpV8p1neFeXYocsK4RiRxF9G6AdyM0QtLc83i6trG','1692517184506_hai-tra-tan-logo.png','Nguyễn Văn Pháp','0788246979','thanhtien2094@gmail.com','dark','5b40d537-3ecf-4305-b541-6171b2f2c546','2023-08-20 07:39:44.564','2023-08-20 07:39:44.564',NULL,'#39caf5'),('f6d99c99-83f1-49ac-a685-0c959f86fedd','duyhaiserver','$2b$10$ScykM5Og5PRVzpV8p1neFeXYocsK4RiRxF9G6AdyM0QtLc83i6trG','1692517184506_hai-tra-tan-logo.png','Nguyễn Văn Pháp','0788246979','thanhtien209411@gmail.com','dark','5b40d537-3ecf-4305-b541-6171b2f2c546','2023-08-20 07:39:44.564','2023-08-20 07:39:44.564',NULL,'#39caf5');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_type`
--

DROP TABLE IF EXISTS `user_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_type` (
  `maLoaiNguoiDung` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `loaiNguoiDung` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`maLoaiNguoiDung`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_type`
--

LOCK TABLES `user_type` WRITE;
/*!40000 ALTER TABLE `user_type` DISABLE KEYS */;
INSERT INTO `user_type` VALUES ('5b40d537-3ecf-4305-b541-6171b2f2c546','admin'),('df7c95b9-625a-4ab3-9d70-1c56c0aab336','user'),('feebefed-063a-4ce0-ae4d-dfdcc3f06f2a','staff');
/*!40000 ALTER TABLE `user_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ytview`
--

DROP TABLE IF EXISTS `ytview`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ytview`
--

LOCK TABLES `ytview` WRITE;
/*!40000 ALTER TABLE `ytview` DISABLE KEYS */;
/*!40000 ALTER TABLE `ytview` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-10-18 16:05:04
