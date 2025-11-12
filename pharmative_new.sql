-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 12, 2025 at 07:13 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pharmative`
--

-- --------------------------------------------------------

--
-- Table structure for table `addresses`
--

CREATE TABLE `addresses` (
  `address_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `recipient_name` varchar(100) NOT NULL,
  `recipient_phone` varchar(15) NOT NULL,
  `street_address` varchar(255) NOT NULL,
  `ward` varchar(100) NOT NULL,
  `district` varchar(100) NOT NULL,
  `city` varchar(100) NOT NULL,
  `is_default` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `addresses`
--

INSERT INTO `addresses` (`address_id`, `user_id`, `recipient_name`, `recipient_phone`, `street_address`, `ward`, `district`, `city`, `is_default`) VALUES
(1, 2, 'Nguyễn Văn An', '0123456789', 'Số 123, Giải Phóng', 'Phương Mai', 'Đống Đa', 'Hà Nội', 1),
(2, 3, 'Trần Thị Bình', '0912345678', '456 Võ Văn Tần', 'Phường 5', 'Quận 3', 'Hồ Chí Minh', 1),
(3, 2, 'Nguyễn Văn An', '0123456789', 'Số 45, Trần Duy Hưng', 'Trung Hoà', 'Cầu Giấy', 'Hà Nội', 0),
(4, 3, 'Trần Thị Bình', '0912345678', '789 Lê Lợi', 'Bến Nghé', 'Quận 1', 'Hồ Chí Minh', 0),
(5, 11, 'Lê Văn Cường', '0934567890', '78 Trần Hưng Đạo', 'Hàng Bài', 'Hoàn Kiếm', 'Hà Nội', 1),
(6, 12, 'Phạm Thị Dung', '0945678901', '45 Nguyễn Văn Linh', 'Bình Thuận', 'Hải Châu', 'Đà Nẵng', 1),
(7, 13, 'Hoàng Minh Đức', '0956789012', '112 Lê Duẩn', 'Bến Nghé', 'Quận 1', 'Hồ Chí Minh', 1),
(8, 14, 'Vũ Thị Hương', '0967890123', '23 Hoàng Diệu', 'Linh Chiểu', 'Thủ Đức', 'Hồ Chí Minh', 1),
(9, 15, 'Nguyễn Quang Huy', '0978901234', '89 Phạm Văn Đồng', 'Xuân Đỉnh', 'Bắc Từ Liêm', 'Hà Nội', 1);

-- --------------------------------------------------------

--
-- Table structure for table `branches`
--

CREATE TABLE `branches` (
  `branch_id` smallint(5) UNSIGNED NOT NULL,
  `branch_code` varchar(20) NOT NULL,
  `branch_name` varchar(120) NOT NULL,
  `is_online_only` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `branches`
--

INSERT INTO `branches` (`branch_id`, `branch_code`, `branch_name`, `is_online_only`) VALUES
(1, 'ONLINE', 'Pharmative Online', 1);

-- --------------------------------------------------------

--
-- Table structure for table `brands`
--

CREATE TABLE `brands` (
  `brand_id` int(11) NOT NULL,
  `brand_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `brands`
--

INSERT INTO `brands` (`brand_id`, `brand_name`) VALUES
(1, 'Blackmores'),
(8, 'Centrum'),
(6, 'DHC'),
(9, 'GNC'),
(5, 'Herbalife'),
(7, 'Kirkland Signature'),
(2, 'Nature Made'),
(3, 'Now Foods'),
(4, 'Optimum Nutrition'),
(10, 'Solgar');

-- --------------------------------------------------------

--
-- Table structure for table `carts`
--

CREATE TABLE `carts` (
  `cart_id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `is_active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `carts`
--

INSERT INTO `carts` (`cart_id`, `customer_id`, `created_at`, `updated_at`, `is_active`) VALUES
(1, 2, '2025-11-10 01:00:00', '2025-11-10 08:30:00', 1),
(2, 3, '2025-11-10 02:15:00', '2025-11-10 09:45:00', 1),
(3, 11, '2025-11-09 03:30:00', '2025-11-10 07:20:00', 1);

-- --------------------------------------------------------

--
-- Table structure for table `cart_items`
--

CREATE TABLE `cart_items` (
  `cart_item_id` bigint(20) UNSIGNED NOT NULL,
  `cart_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `added_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cart_items`
--

INSERT INTO `cart_items` (`cart_item_id`, `cart_id`, `product_id`, `quantity`, `added_at`) VALUES
(1, 1, 1, 2, '2025-11-10 01:00:00'),
(2, 1, 6, 1, '2025-11-10 03:30:00'),
(3, 2, 11, 1, '2025-11-10 02:15:00'),
(4, 2, 28, 3, '2025-11-10 04:45:00'),
(5, 3, 15, 1, '2025-11-09 03:30:00'),
(6, 3, 19, 2, '2025-11-10 07:20:00');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(100) NOT NULL,
  `parent_category_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`category_id`, `category_name`, `parent_category_id`) VALUES
(1, 'Vitamins & Khoáng chất', NULL),
(2, 'Thảo dược & Bổ sung', NULL),
(3, 'Dinh dưỡng thể thao', NULL),
(4, 'Kiểm soát cân nặng', NULL),
(5, 'Hỗ trợ sắc đẹp', NULL),
(6, 'Vitamin tổng hợp', 1),
(7, 'Vitamin C', 1),
(8, 'Canxi & Vitamin D', 1),
(9, 'Bổ não & Trí nhớ', 2),
(10, 'Hỗ trợ tiêu hóa', 2),
(11, 'Whey Protein', 3),
(12, 'BCAA & Amino', 3),
(13, 'Cải thiện giấc ngủ', 3);

-- --------------------------------------------------------

--
-- Table structure for table `contact_messages`
--

CREATE TABLE `contact_messages` (
  `contact_id` bigint(20) UNSIGNED NOT NULL,
  `full_name` varchar(120) NOT NULL,
  `email` varchar(120) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `subject` varchar(160) NOT NULL,
  `message` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_processed` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `contact_messages`
--

INSERT INTO `contact_messages` (`contact_id`, `full_name`, `email`, `phone`, `subject`, `message`, `created_at`, `is_processed`) VALUES
(1, 'Nguyễn Thị Mai', 'mai.nguyen@example.com', '0987654321', 'Hỏi về sản phẩm Vitamin D3', 'Tôi muốn biết thêm thông tin về liều dùng Vitamin D3 cho người lớn tuổi.', '2025-10-25 02:15:00', 1),
(2, 'Trần Văn Hùng', 'hung.tran@example.com', '0976543210', 'Khiếu nại giao hàng', 'Đơn hàng #ORD-2024-0015 giao chậm 2 ngày so với dự kiến.', '2025-10-28 07:30:00', 1),
(3, 'Lê Thị Hoa', 'hoa.le@example.com', '0965432109', 'Tư vấn sản phẩm cho bà bầu', 'Xin tư vấn các sản phẩm bổ sung dinh dưỡng cho phụ nữ mang thai.', '2025-11-02 04:20:00', 0),
(4, 'Phạm Quốc Bảo', 'bao.pham@example.com', '0954321098', 'Đề xuất hợp tác', 'Tôi muốn hợp tác phân phối sản phẩm của Pharmative tại Đà Nẵng.', '2025-11-05 09:45:00', 0),
(5, 'Hoàng Minh Anh', 'anh.hoang@example.com', '0943210987', 'Hỏi về chính sách đổi trả', 'Sản phẩm tôi mua bị lỗi, xin hướng dẫn thủ tục đổi trả.', '2025-11-08 03:10:00', 1);

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `customer_id` int(11) NOT NULL,
  `date_of_birth` date DEFAULT NULL,
  `gender` enum('male','female','other') DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`customer_id`, `date_of_birth`, `gender`, `created_at`) VALUES
(2, NULL, NULL, '2025-10-26 07:40:41'),
(3, NULL, NULL, '2025-10-26 07:40:41'),
(11, '1990-05-15', 'male', '2025-09-10 01:15:22'),
(12, '1988-12-20', 'female', '2025-09-25 07:30:45'),
(13, '1995-03-08', 'male', '2025-10-08 03:20:33'),
(14, '1992-07-30', 'female', '2025-10-20 09:45:18'),
(15, '1987-11-12', 'male', '2025-11-03 02:10:27');

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE `inventory` (
  `product_id` int(11) NOT NULL,
  `branch_id` smallint(5) UNSIGNED NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inventory`
--

INSERT INTO `inventory` (`product_id`, `branch_id`, `quantity`) VALUES
(1, 1, 150),
(2, 1, 200),
(3, 1, 120),
(4, 1, 90),
(5, 1, 100),
(6, 1, 160),
(7, 1, 110),
(8, 1, 75),
(9, 1, 300),
(10, 1, 80),
(11, 1, 45),
(12, 1, 60),
(13, 1, 130),
(14, 1, 140),
(15, 1, 150),
(16, 1, 95),
(17, 1, 85),
(18, 1, 70),
(19, 1, 180),
(20, 1, 60),
(21, 1, 100),
(22, 1, 90),
(23, 1, 85),
(24, 1, 110),
(25, 1, 95),
(26, 1, 70),
(27, 1, 90),
(28, 1, 140),
(29, 1, 120),
(30, 1, 220),
(31, 1, 150),
(32, 1, 80);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `customer_name` varchar(100) DEFAULT NULL,
  `customer_email` varchar(100) DEFAULT NULL,
  `customer_phone` varchar(20) DEFAULT NULL,
  `shipping_address` text DEFAULT NULL,
  `payment_method` varchar(50) DEFAULT 'cod',
  `note` text DEFAULT NULL,
  `order_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `total_amount` decimal(15,2) NOT NULL,
  `status` enum('pending','processing','shipped','delivered','cancelled','payment_failed') NOT NULL DEFAULT 'pending',
  `shipping_address_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `user_id`, `customer_name`, `customer_email`, `customer_phone`, `shipping_address`, `payment_method`, `note`, `order_date`, `total_amount`, `status`, `shipping_address_id`) VALUES
(1, 2, 'Nguyễn Văn An', 'nguyen.an@example.com', '0123456789', 'Số 123, Giải Phóng, Phương Mai, Đống Đa, Hà Nội', 'cod', NULL, '2025-10-26 07:40:41', 970000.00, 'delivered', 1),
(2, 2, 'Nguyễn Văn An', 'nguyen.an@example.com', '0123456789', 'Số 45, Trần Duy Hưng, Trung Hoà, Cầu Giấy, Hà Nội', 'cod', NULL, '2025-10-27 02:15:22', 1250000.00, 'processing', 3),
(3, 3, 'Trần Thị Bình', 'tran.binh@example.com', '0912345678', '789 Lê Lợi, Bến Nghé, Quận 1, Hồ Chí Minh', 'cod', NULL, '2025-10-27 03:30:45', 890000.00, 'pending', 4),
(4, 2, 'Nguyễn Văn An', 'nguyen.an@example.com', '0123456789', 'Số 123, Giải Phóng, Phương Mai, Đống Đa, Hà Nội', 'cod', NULL, '2025-10-28 07:20:33', 2100000.00, 'shipped', 1),
(5, 3, 'Trần Thị Bình', 'tran.binh@example.com', '0912345678', '456 Võ Văn Tần, Phường 5, Quận 3, Hồ Chí Minh', 'cod', NULL, '2025-10-29 09:45:12', 540000.00, 'delivered', 2),
(6, 2, 'Nguyễn Văn An', 'nguyen.an@example.com', '0123456789', 'Số 45, Trần Duy Hưng, Trung Hoà, Cầu Giấy, Hà Nội', 'cod', NULL, '2025-10-30 04:05:18', 720000.00, 'cancelled', 3),
(7, 3, 'Trần Thị Bình', 'tran.binh@example.com', '0912345678', '456 Võ Văn Tần, Phường 5, Quận 3, Hồ Chí Minh', 'vnpay', 'Giao hàng giờ hành chính', '2025-11-01 03:20:15', 1850000.00, 'processing', 2),
(8, 2, 'Nguyễn Văn An', 'nguyen.an@example.com', '0123456789', 'Số 123, Giải Phóng, Phương Mai, Đống Đa, Hà Nội', 'momo', 'Cần giao trước 17h', '2025-11-02 07:35:42', 920000.00, 'shipped', 1),
(9, 3, 'Trần Thị Bình', 'tran.binh@example.com', '0912345678', '789 Lê Lợi, Bến Nghé, Quận 1, Hồ Chí Minh', 'cod', 'Gọi điện trước khi giao', '2025-11-03 02:15:28', 1340000.00, 'pending', 4),
(10, 2, 'Nguyễn Văn An', 'nguyen.an@example.com', '0123456789', 'Số 45, Trần Duy Hưng, Trung Hoà, Cầu Giấy, Hà Nội', 'bank', 'Quà tặng sinh nhật', '2025-11-04 09:45:33', 780000.00, 'delivered', 3),
(11, 10, 'Trần Thị Bình', 'gmquan.dhti16a1cl@sv.uneti.edu.vn', '091234567845', '456 Võ Văn Tần, Phường 5, Quận 3, Hồ Chí Minh', 'cod', 'Mua cho mẹ dùng', '2025-11-05 04:30:19', 1560000.00, 'processing', 2),
(12, 2, 'Nguyễn Văn An', 'nguyen.an@example.com', '0123456789', 'Số 123, Giải Phóng, Phương Mai, Đống Đa, Hà Nội', 'vnpay', NULL, '2025-11-06 06:25:47', 2100000.00, 'payment_failed', 1),
(13, 11, 'Lê Văn Cường', 'le.cuong@example.com', '0934567890', '78 Trần Hưng Đạo, Hàng Bài, Hoàn Kiếm, Hà Nội', 'cod', NULL, '2025-05-15 01:20:10', 1850000.00, 'delivered', 5),
(14, 12, 'Phạm Thị Dung', 'pham.dung@example.com', '0945678901', '45 Nguyễn Văn Linh, Bình Thuận, Hải Châu, Đà Nẵng', 'vnpay', NULL, '2025-05-22 07:35:45', 920000.00, 'delivered', 6),
(15, 13, 'Hoàng Minh Đức', 'hoang.duc@example.com', '0956789012', '112 Lê Duẩn, Bến Nghé, Quận 1, Hồ Chí Minh', 'cod', NULL, '2025-06-05 03:15:30', 1560000.00, 'delivered', 7),
(16, 14, 'Vũ Thị Hương', 'vu.huong@example.com', '0967890123', '23 Hoàng Diệu, Linh Chiểu, Thủ Đức, Hồ Chí Minh', 'momo', NULL, '2025-06-12 09:40:22', 780000.00, 'delivered', 8),
(17, 15, 'Nguyễn Quang Huy', 'nguyen.huy@example.com', '0978901234', '89 Phạm Văn Đồng, Xuân Đỉnh, Bắc Từ Liêm, Hà Nội', 'bank', NULL, '2025-07-18 02:25:18', 2100000.00, 'delivered', 9),
(18, 11, 'Lê Văn Cường', 'le.cuong@example.com', '0934567890', '78 Trần Hưng Đạo, Hàng Bài, Hoàn Kiếm, Hà Nội', 'cod', NULL, '2025-07-25 04:30:55', 1350000.00, 'delivered', 5),
(19, 12, 'Phạm Thị Dung', 'pham.dung@example.com', '0945678901', '45 Nguyễn Văn Linh, Bình Thuận, Hải Châu, Đà Nẵng', 'vnpay', NULL, '2025-08-05 06:45:33', 980000.00, 'delivered', 6),
(20, 13, 'Hoàng Minh Đức', 'hoang.duc@example.com', '0956789012', '112 Lê Duẩn, Bến Nghé, Quận 1, Hồ Chí Minh', 'cod', NULL, '2025-08-15 08:20:47', 1670000.00, 'delivered', 7),
(21, 14, 'Vũ Thị Hương', 'vu.huong@example.com', '0967890123', '23 Hoàng Diệu, Linh Chiểu, Thủ Đức, Hồ Chí Minh', 'momo', NULL, '2025-09-08 10:35:12', 1240000.00, 'delivered', 8),
(22, 15, 'Nguyễn Quang Huy', 'nguyen.huy@example.com', '0978901234', '89 Phạm Văn Đồng, Xuân Đỉnh, Bắc Từ Liêm, Hà Nội', 'bank', NULL, '2025-09-20 12:50:28', 1890000.00, 'delivered', 9),
(23, 11, 'Lê Văn Cường', 'le.cuong@example.com', '0934567890', '78 Trần Hưng Đạo, Hàng Bài, Hoàn Kiếm, Hà Nội', 'cod', NULL, '2025-10-03 14:05:44', 1120000.00, 'delivered', 5),
(24, 12, 'Phạm Thị Dung', 'pham.dung@example.com', '0945678901', '45 Nguyễn Văn Linh, Bình Thuận, Hải Châu, Đà Nẵng', 'vnpay', NULL, '2025-10-18 15:15:59', 1450000.00, 'delivered', 6);

-- --------------------------------------------------------

--
-- Table structure for table `order_details`
--

CREATE TABLE `order_details` (
  `order_detail_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price_per_unit` decimal(12,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_details`
--

INSERT INTO `order_details` (`order_detail_id`, `order_id`, `product_id`, `quantity`, `price_per_unit`) VALUES
(1, 1, 1, 1, 350000.00),
(2, 1, 6, 1, 480000.00),
(3, 1, 30, 1, 140000.00),
(4, 2, 11, 1, 1990000.00),
(5, 2, 9, 2, 220000.00),
(6, 3, 24, 1, 690000.00),
(7, 3, 30, 1, 210000.00),
(8, 4, 2, 2, 420000.00),
(9, 4, 15, 1, 520000.00),
(10, 4, 22, 2, 620000.00),
(11, 5, 13, 1, 540000.00),
(12, 6, 10, 1, 720000.00),
(13, 7, 8, 1, 690000.00),
(14, 7, 17, 1, 650000.00),
(15, 7, 28, 3, 350000.00),
(16, 8, 19, 2, 390000.00),
(17, 8, 30, 2, 210000.00),
(18, 9, 12, 1, 890000.00),
(19, 9, 23, 1, 610000.00),
(20, 9, 32, 1, 640000.00),
(21, 10, 25, 1, 780000.00),
(22, 11, 7, 1, 590000.00),
(23, 11, 14, 2, 360000.00),
(24, 11, 21, 1, 670000.00),
(25, 12, 4, 2, 620000.00),
(26, 12, 11, 1, 1990000.00),
(27, 12, 29, 1, 490000.00),
(28, 13, 3, 2, 550000.00),
(29, 13, 8, 1, 690000.00),
(30, 14, 12, 1, 890000.00),
(31, 15, 5, 1, 620000.00),
(32, 15, 17, 1, 650000.00),
(33, 15, 25, 1, 780000.00),
(34, 16, 20, 1, 780000.00),
(35, 17, 11, 1, 1990000.00),
(36, 17, 28, 2, 350000.00),
(37, 18, 4, 1, 620000.00),
(38, 18, 14, 2, 360000.00),
(39, 19, 7, 1, 590000.00),
(40, 19, 19, 1, 390000.00),
(41, 20, 2, 3, 420000.00),
(42, 20, 16, 1, 410000.00),
(43, 21, 9, 4, 220000.00),
(44, 21, 30, 2, 210000.00),
(45, 22, 15, 2, 520000.00),
(46, 22, 23, 1, 610000.00),
(47, 23, 13, 2, 540000.00),
(48, 24, 21, 1, 670000.00),
(49, 24, 27, 1, 520000.00),
(50, 24, 32, 1, 640000.00);

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `payment_id` bigint(20) UNSIGNED NOT NULL,
  `order_id` int(11) NOT NULL,
  `method` enum('COD','VNPAY','MOMO','BANK') NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `status` enum('INIT','SUCCESS','FAILED','REFUNDED') NOT NULL DEFAULT 'INIT',
  `txn_ref` varchar(120) DEFAULT NULL,
  `paid_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`payment_id`, `order_id`, `method`, `amount`, `status`, `txn_ref`, `paid_at`) VALUES
(1, 7, 'VNPAY', 1850000.00, 'SUCCESS', 'VNP123456789', '2025-11-01 10:25:30'),
(2, 8, 'MOMO', 920000.00, 'SUCCESS', 'MOMO987654321', '2025-11-02 14:40:15'),
(3, 9, 'COD', 1340000.00, 'INIT', NULL, NULL),
(4, 10, 'BANK', 780000.00, 'SUCCESS', 'BANK456789123', '2025-11-04 17:00:00'),
(5, 11, 'COD', 1560000.00, 'INIT', NULL, NULL),
(6, 12, 'VNPAY', 2100000.00, 'FAILED', 'VNP999888777', NULL),
(7, 13, 'COD', 1850000.00, 'SUCCESS', NULL, '2025-05-15 15:30:00'),
(8, 14, 'VNPAY', 920000.00, 'SUCCESS', 'VNP222333444', '2025-05-22 16:45:00'),
(9, 15, 'COD', 1560000.00, 'SUCCESS', NULL, '2025-06-05 18:20:00'),
(10, 16, 'MOMO', 780000.00, 'SUCCESS', 'MOMO555666777', '2025-06-12 19:35:00'),
(11, 17, 'BANK', 2100000.00, 'SUCCESS', 'BANK888999000', '2025-07-18 20:50:00'),
(12, 18, 'COD', 1350000.00, 'SUCCESS', NULL, '2025-07-25 21:15:00'),
(13, 19, 'VNPAY', 980000.00, 'SUCCESS', 'VNP111222333', '2025-08-05 22:30:00'),
(14, 20, 'COD', 1670000.00, 'SUCCESS', NULL, '2025-08-15 23:45:00'),
(15, 21, 'MOMO', 1240000.00, 'SUCCESS', 'MOMO444555666', '2025-09-08 10:20:00'),
(16, 22, 'BANK', 1890000.00, 'SUCCESS', 'BANK777888999', '2025-09-20 11:35:00'),
(17, 23, 'COD', 1120000.00, 'SUCCESS', NULL, '2025-10-03 12:50:00'),
(18, 24, 'VNPAY', 1450000.00, 'SUCCESS', 'VNP666777888', '2025-10-18 14:05:00');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(12,2) NOT NULL,
  `stock_quantity` int(11) NOT NULL DEFAULT 0,
  `image_url` varchar(255) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `brand_id` int(11) DEFAULT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `product_name`, `description`, `price`, `stock_quantity`, `image_url`, `category_id`, `brand_id`, `supplier_id`, `created_at`) VALUES
(1, 'Blackmores Vitamin C 500mg', 'Bổ sung Vitamin C tăng đề kháng', 350000.00, 150, 'images/p01.jpg', 7, 1, 1, '2025-10-26 07:40:41'),
(2, 'Nature Made Vitamin D3 2000IU', 'Hỗ trợ xương & miễn dịch', 420000.00, 200, 'images/p02.jpg', 8, 2, 2, '2025-10-26 07:40:41'),
(3, 'Kirkland Signature Daily Multi', 'Vitamin tổng hợp', 550000.00, 120, 'images/p03.jpg', 6, 7, 3, '2025-10-26 07:40:41'),
(4, 'Centrum Men Multivitamin', 'Vitamin tổng hợp cho nam', 620000.00, 90, 'images/p04.jpg', 6, 8, 2, '2025-10-26 07:40:41'),
(5, 'Centrum Women Multivitamin', 'Vitamin tổng hợp cho nữ', 620000.00, 100, 'images/p05.jpg', 6, 8, 2, '2025-10-26 07:40:41'),
(6, 'Now Foods Omega-3 1000mg', 'Dầu cá EPA/DHA', 480000.00, 160, 'images/p06.jpg', 2, 3, 3, '2025-10-26 07:40:41'),
(7, 'Solgar Calcium Magnesium Zinc', 'Bổ sung xương khớp', 590000.00, 110, 'images/p07.jpg', 8, 10, 1, '2025-10-26 07:40:41'),
(8, 'GNC Mega Men Sport', 'Đa vitamin thể thao', 690000.00, 75, 'images/p08.jpg', 6, 9, 2, '2025-10-26 07:40:41'),
(9, 'DHC Vitamin C 1000mg', 'Viên uống đẹp da', 220000.00, 300, 'images/p09.jpg', 7, 6, 1, '2025-10-26 07:40:41'),
(10, 'Herbalife Protein Drink Mix', 'Bổ sung đạm', 720000.00, 80, 'images/p10.jpg', 11, 5, 1, '2025-10-26 07:40:41'),
(11, 'ON Gold Standard Whey 5lbs', 'Whey protein isolate/concentrate', 1990000.00, 45, 'images/p11.jpg', 11, 4, 2, '2025-10-26 07:40:41'),
(12, 'ON Gold Standard BCAA', 'BCAA phục hồi cơ', 890000.00, 60, 'images/p12.jpg', 12, 4, 2, '2025-10-26 07:40:41'),
(13, 'Now Foods Probiotic-10', 'Men vi sinh đường ruột', 540000.00, 130, 'images/p13.jpg', 10, 3, 3, '2025-10-26 07:40:41'),
(14, 'Kirkland Vitamin E 400 IU', 'Chống oxy hóa', 360000.00, 140, 'images/p14.jpg', 1, 7, 3, '2025-10-26 07:40:41'),
(15, 'Blackmores Fish Oil 1000', 'Dầu cá hỗ trợ tim mạch', 520000.00, 150, 'images/p15.jpg', 2, 1, 1, '2025-10-26 07:40:41'),
(16, 'Nature Made Magnesium 250mg', 'Giảm căng cơ, ngủ ngon', 410000.00, 95, 'images/p16.jpg', 1, 2, 2, '2025-10-26 07:40:41'),
(17, 'Solgar Biotin 5000mcg', 'Tóc–da–móng', 650000.00, 85, 'images/p17.jpg', 5, 10, 1, '2025-10-26 07:40:41'),
(18, 'GNC L-Carnitine 500', 'Hỗ trợ chuyển hóa mỡ', 730000.00, 70, 'images/p18.jpg', 4, 9, 2, '2025-10-26 07:40:41'),
(19, 'DHC Collagen 2050mg', 'Hỗ trợ đàn hồi da', 390000.00, 180, 'images/p19.jpg', 5, 6, 1, '2025-10-26 07:40:41'),
(20, 'Now Foods CoQ10 100mg', 'Tăng năng lượng tế bào', 780000.00, 60, 'images/p20.jpg', 1, 3, 3, '2025-10-26 07:40:41'),
(21, 'Centrum Silver 50+', 'Đa vitamin người lớn tuổi', 670000.00, 100, 'images/p21.jpg', 6, 8, 2, '2025-10-26 07:40:41'),
(22, 'Kirkland Glucosamine 1500', 'Khớp – sụn', 620000.00, 90, 'images/p22.jpg', 1, 7, 3, '2025-10-26 07:40:41'),
(23, 'Blackmores Evening Primrose Oil', 'Da & nội tiết nữ', 610000.00, 85, 'images/p23.jpg', 5, 1, 1, '2025-10-26 07:40:41'),
(24, 'ON Creatine Monohydrate', 'Sức mạnh & hiệu suất', 690000.00, 110, 'images/p24.jpg', 3, 4, 2, '2025-10-26 07:40:41'),
(25, 'Herbalife Formula 1 Shake', 'Bữa ăn lành mạnh', 780000.00, 95, 'images/p25.jpg', 4, 5, 1, '2025-10-26 07:40:41'),
(26, 'Now Foods Vitamin K2 MK-7', 'Hỗ trợ xương mạch máu', 620000.00, 70, 'images/p26.jpg', 8, 3, 3, '2025-10-26 07:40:41'),
(27, 'Solgar Vitamin B12 1000mcg', 'Hồng cầu–thần kinh', 520000.00, 90, 'images/p27.jpg', 1, 10, 1, '2025-10-26 07:40:41'),
(28, 'GNC Zinc 50mg', 'Miễn dịch–da', 350000.00, 140, 'images/p28.jpg', 1, 9, 2, '2025-10-26 07:40:41'),
(29, 'Centrum Kids Gummies', 'Đa vitamin cho trẻ', 490000.00, 120, 'images/p29.jpg', 6, 8, 2, '2025-10-26 07:40:41'),
(30, 'DHC Vitamin B-Mix', 'Chuyển hóa năng lượng', 210000.00, 220, 'images/p30.jpg', 1, 6, 1, '2025-10-26 07:40:41'),
(31, 'Blackmores Odourless Garlic', 'Tỏi không mùi – miễn dịch', 330000.00, 150, 'images/p31.jpg', 2, 1, 1, '2025-10-26 07:40:41'),
(32, 'Now Foods GABA 750mg', 'Thư giãn–giấc ngủ', 640000.00, 80, 'images/p32.jpg', 2, 3, 3, '2025-10-26 07:40:41');

-- --------------------------------------------------------

--
-- Table structure for table `product_images`
--

CREATE TABLE `product_images` (
  `image_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` int(11) NOT NULL,
  `image_url` varchar(500) NOT NULL,
  `is_primary` tinyint(1) NOT NULL DEFAULT 0,
  `sort_order` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_images`
--

INSERT INTO `product_images` (`image_id`, `product_id`, `image_url`, `is_primary`, `sort_order`) VALUES
(1, 1, 'images/p01.jpg', 1, 1),
(2, 2, 'images/p02.jpg', 1, 1),
(3, 3, 'images/p03.jpg', 1, 1),
(4, 4, 'images/p04.jpg', 1, 1),
(5, 5, 'images/p05.jpg', 1, 1),
(6, 6, 'images/p06.jpg', 1, 1),
(7, 7, 'images/p07.jpg', 1, 1),
(8, 8, 'images/p08.jpg', 1, 1),
(9, 9, 'images/p09.jpg', 1, 1),
(10, 10, 'images/p10.jpg', 1, 1),
(11, 11, 'images/p11.jpg', 1, 1),
(12, 12, 'images/p12.jpg', 1, 1),
(13, 13, 'images/p13.jpg', 1, 1),
(14, 14, 'images/p14.jpg', 1, 1),
(15, 15, 'images/p15.jpg', 1, 1),
(16, 16, 'images/p16.jpg', 1, 1),
(17, 17, 'images/p17.jpg', 1, 1),
(18, 18, 'images/p18.jpg', 1, 1),
(19, 19, 'images/p19.jpg', 1, 1),
(20, 20, 'images/p20.jpg', 1, 1),
(21, 21, 'images/p21.jpg', 1, 1),
(22, 22, 'images/p22.jpg', 1, 1),
(23, 23, 'images/p23.jpg', 1, 1),
(24, 24, 'images/p24.jpg', 1, 1),
(25, 25, 'images/p25.jpg', 1, 1),
(26, 26, 'images/p26.jpg', 1, 1),
(27, 27, 'images/p27.jpg', 1, 1),
(28, 28, 'images/p28.jpg', 1, 1),
(29, 29, 'images/p29.jpg', 1, 1),
(30, 30, 'images/p30.jpg', 1, 1),
(31, 31, 'images/p31.jpg', 1, 1),
(32, 32, 'images/p32.jpg', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `product_prices`
--

CREATE TABLE `product_prices` (
  `product_id` int(11) NOT NULL,
  `price` decimal(12,2) NOT NULL,
  `compare_at` decimal(12,2) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_prices`
--

INSERT INTO `product_prices` (`product_id`, `price`, `compare_at`, `updated_at`) VALUES
(1, 350000.00, NULL, '2025-10-26 07:40:41'),
(2, 420000.00, NULL, '2025-10-26 07:40:41'),
(3, 550000.00, NULL, '2025-10-26 07:40:41'),
(4, 620000.00, NULL, '2025-10-26 07:40:41'),
(5, 620000.00, NULL, '2025-10-26 07:40:41'),
(6, 480000.00, NULL, '2025-10-26 07:40:41'),
(7, 590000.00, NULL, '2025-10-26 07:40:41'),
(8, 690000.00, NULL, '2025-10-26 07:40:41'),
(9, 220000.00, NULL, '2025-10-26 07:40:41'),
(10, 720000.00, NULL, '2025-10-26 07:40:41'),
(11, 1990000.00, NULL, '2025-10-26 07:40:41'),
(12, 890000.00, NULL, '2025-10-26 07:40:41'),
(13, 540000.00, NULL, '2025-10-26 07:40:41'),
(14, 360000.00, NULL, '2025-10-26 07:40:41'),
(15, 520000.00, NULL, '2025-10-26 07:40:41'),
(16, 410000.00, NULL, '2025-10-26 07:40:41'),
(17, 650000.00, NULL, '2025-10-26 07:40:41'),
(18, 730000.00, NULL, '2025-10-26 07:40:41'),
(19, 390000.00, NULL, '2025-10-26 07:40:41'),
(20, 780000.00, NULL, '2025-10-26 07:40:41'),
(21, 670000.00, NULL, '2025-10-26 07:40:41'),
(22, 620000.00, NULL, '2025-10-26 07:40:41'),
(23, 610000.00, NULL, '2025-10-26 07:40:41'),
(24, 690000.00, NULL, '2025-10-26 07:40:41'),
(25, 780000.00, NULL, '2025-10-26 07:40:41'),
(26, 620000.00, NULL, '2025-10-26 07:40:41'),
(27, 520000.00, NULL, '2025-10-26 07:40:41'),
(28, 350000.00, NULL, '2025-10-26 07:40:41'),
(29, 490000.00, NULL, '2025-10-26 07:40:41'),
(30, 210000.00, NULL, '2025-10-26 07:40:41'),
(31, 330000.00, NULL, '2025-10-26 07:40:41'),
(32, 640000.00, NULL, '2025-10-26 07:40:41');

-- --------------------------------------------------------

--
-- Table structure for table `promotions`
--

CREATE TABLE `promotions` (
  `promo_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(11) NOT NULL,
  `title` varchar(160) NOT NULL,
  `percent_off` tinyint(3) UNSIGNED DEFAULT NULL,
  `amount_off` decimal(12,2) DEFAULT NULL,
  `starts_at` datetime NOT NULL,
  `ends_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `review_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `rating` tinyint(4) NOT NULL CHECK (`rating` between 1 and 5),
  `comment` text DEFAULT NULL,
  `review_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `reviews`
--

INSERT INTO `reviews` (`review_id`, `product_id`, `user_id`, `rating`, `comment`, `review_date`) VALUES
(1, 1, 2, 5, 'Rất ưng, giao nhanh', '2025-10-26 07:40:41'),
(2, 11, 2, 4, 'Whey ngon, dễ tan', '2025-10-26 07:40:41'),
(4, 2, 3, 5, 'Sản phẩm tốt, giao hàng nhanh', '2025-10-28 03:15:22'),
(5, 5, 11, 5, 'Vitamin tổng hợp cho nữ rất hiệu quả', '2025-11-02 02:20:33'),
(6, 8, 12, 4, 'Đa vitamin thể thao tốt, nên mua', '2025-11-05 09:45:18'),
(7, 15, 13, 5, 'Dầu cá chất lượng, hỗ trợ tim mạch tốt', '2025-11-07 04:10:27'),
(8, 22, 14, 4, 'Glucosamine hiệu quả cho xương khớp', '2025-11-09 06:25:44'),
(9, 30, 15, 5, 'Vitamin B-Mix giá tốt, hiệu quả cao', '2025-11-10 08:40:19'),
(10, 3, 14, 5, 'Vitamin tổng hợp Kirkland rất tốt', '2025-10-15 01:30:00'),
(11, 7, 15, 4, 'Canxi magie zin hấp thụ tốt', '2025-10-20 03:45:00'),
(12, 12, 11, 5, 'BCAA phục hồi cơ nhanh', '2025-10-25 05:15:00'),
(13, 18, 12, 4, 'L-Carnitine hỗ trợ giảm cân hiệu quả', '2025-11-01 07:30:00'),
(14, 25, 13, 5, 'Shake Herbalife ngon, dễ uống', '2025-11-05 09:45:00'),
(15, 29, 14, 4, 'Vitamin cho trẻ con thích ăn', '2025-11-08 11:20:00');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `role_id` tinyint(3) UNSIGNED NOT NULL,
  `role_name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `shipments`
--

CREATE TABLE `shipments` (
  `shipment_id` bigint(20) UNSIGNED NOT NULL,
  `order_id` int(11) NOT NULL,
  `carrier` varchar(60) NOT NULL,
  `tracking_no` varchar(100) DEFAULT NULL,
  `status` enum('CREATED','PICKED','IN_TRANSIT','DELIVERED','FAILED','RETURNED') NOT NULL DEFAULT 'CREATED',
  `shipped_at` datetime DEFAULT NULL,
  `delivered_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `shipments`
--

INSERT INTO `shipments` (`shipment_id`, `order_id`, `carrier`, `tracking_no`, `status`, `shipped_at`, `delivered_at`) VALUES
(1, 4, 'GHTK', 'GHTK123456789', 'IN_TRANSIT', '2025-10-29 08:00:00', NULL),
(2, 8, 'VNPOST', 'VNPOST987654321', 'IN_TRANSIT', '2025-11-03 09:00:00', NULL),
(3, 1, 'GHTK', 'GHTK555666777', 'DELIVERED', '2025-10-27 10:00:00', '2025-10-28 15:30:00'),
(4, 5, 'VNPOST', 'VNPOST111222333', 'DELIVERED', '2025-10-30 14:00:00', '2025-10-31 11:20:00'),
(5, 10, 'GHTK', 'GHTK444555666', 'DELIVERED', '2025-11-05 08:30:00', '2025-11-06 16:45:00'),
(6, 13, 'GHTK', 'GHTK888999001', 'DELIVERED', '2025-05-16 08:00:00', '2025-05-17 15:30:00'),
(7, 14, 'VNPOST', 'VNPOST444555667', 'DELIVERED', '2025-05-23 09:00:00', '2025-05-24 11:20:00'),
(8, 15, 'GHTK', 'GHTK777888990', 'DELIVERED', '2025-06-06 10:00:00', '2025-06-07 14:45:00'),
(9, 16, 'VNPOST', 'VNPOST333444556', 'DELIVERED', '2025-06-13 11:00:00', '2025-06-14 16:30:00'),
(10, 17, 'GHTK', 'GHTK666777889', 'DELIVERED', '2025-07-19 12:00:00', '2025-07-20 13:15:00'),
(11, 18, 'VNPOST', 'VNPOST222333445', 'DELIVERED', '2025-07-26 13:00:00', '2025-07-27 10:45:00'),
(12, 19, 'GHTK', 'GHTK555666778', 'DELIVERED', '2025-08-06 14:00:00', '2025-08-07 17:20:00'),
(13, 20, 'VNPOST', 'VNPOST111222334', 'DELIVERED', '2025-08-16 15:00:00', '2025-08-17 12:30:00'),
(14, 21, 'GHTK', 'GHTK444555667', 'DELIVERED', '2025-09-09 16:00:00', '2025-09-10 14:15:00'),
(15, 22, 'VNPOST', 'VNPOST000111223', 'DELIVERED', '2025-09-21 17:00:00', '2025-09-22 11:45:00'),
(16, 23, 'GHTK', 'GHTK333444556', 'DELIVERED', '2025-10-04 18:00:00', '2025-10-05 16:20:00'),
(17, 24, 'VNPOST', 'VNPOST999000112', 'DELIVERED', '2025-10-19 19:00:00', '2025-10-20 13:30:00');

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `supplier_id` int(11) NOT NULL,
  `supplier_name` varchar(150) NOT NULL,
  `contact_person` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone_number` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`supplier_id`, `supplier_name`, `contact_person`, `email`, `phone_number`) VALUES
(1, 'Công ty Dược An Khang', 'Lê Minh', 'contact@ankhang.com', '0243111222'),
(2, 'Nhà phân phối Toàn Cầu', 'Phạm Hùng', 'info@toancau.vn', '0283999888'),
(3, 'Nature Vietnam Imports', 'Jane Doe', 'support@nature-vn.com', '0243555666');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `fullname` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone_number` varchar(15) DEFAULT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('customer','admin') NOT NULL DEFAULT 'customer',
  `address` text NOT NULL,
  `is_verified` tinyint(1) DEFAULT 0,
  `verification_code` varchar(64) DEFAULT NULL,
  `reset_token` varchar(64) DEFAULT NULL,
  `reset_token_expiry` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `fullname`, `email`, `phone_number`, `password_hash`, `role`, `address`, `is_verified`, `verification_code`, `reset_token`, `reset_token_expiry`, `created_at`) VALUES
(1, 'Admin Pharmative', 'admin@pharmative.com', '0987654333', '$2a$10$L0AhVh.3jVcmh/pHHwf5AOgrQZQ5M7R5Oh5oDItLGn316T8XiMDHu', 'admin', '', 1, NULL, NULL, NULL, '2025-10-26 07:40:41'),
(2, 'Nguyễn Văn An', 'nguyen.an@example.com', '0123456789', '$2a$10$Y.a4J4O./eJ4.W2mKBc.a.p./ZgajLh/gqX.UaK.Z2m8.I0.4z/G.', 'customer', '', 1, NULL, NULL, NULL, '2025-10-26 07:40:41'),
(3, 'Trần Thị Bình', 'tran.binh@example.com', '0912345678', '$2a$10$Y.a4J4O./eJ4.W2mKBc.a.p./ZgajLh/gqX.UaK.Z2m8.I0.4z/G.', 'customer', '', 1, NULL, NULL, NULL, '2025-10-26 07:40:41'),
(10, 'Trần Thị Bình', 'gmquan.dhti16a1cl@sv.uneti.edu.vn', '091234567845', '$2a$10$FrzvetBRP.E0FuB4sJg3neWH4jqwBFejIu6U0nUa5oHz/K3BhwFTu', 'customer', '', 1, NULL, NULL, NULL, '2025-11-07 06:04:05'),
(11, 'Lê Văn Cường', 'le.cuong@example.com', '0934567890', '$2a$10$Y.a4J4O./eJ4.W2mKBc.a.p./ZgajLh/gqX.UaK.Z2m8.I0.4z/G.', 'customer', '', 1, NULL, NULL, NULL, '2025-09-10 01:15:22'),
(12, 'Phạm Thị Dung', 'pham.dung@example.com', '0945678901', '$2a$10$Y.a4J4O./eJ4.W2mKBc.a.p./ZgajLh/gqX.UaK.Z2m8.I0.4z/G.', 'customer', '', 1, NULL, NULL, NULL, '2025-09-25 07:30:45'),
(13, 'Hoàng Minh Đức', 'hoang.duc@example.com', '0956789012', '$2a$10$Y.a4J4O./eJ4.W2mKBc.a.p./ZgajLh/gqX.UaK.Z2m8.I0.4z/G.', 'customer', '', 1, NULL, NULL, NULL, '2025-10-08 03:20:33'),
(14, 'Vũ Thị Hương', 'vu.huong@example.com', '0967890123', '$2a$10$Y.a4J4O./eJ4.W2mKBc.a.p./ZgajLh/gqX.UaK.Z2m8.I0.4z/G.', 'customer', '', 1, NULL, NULL, NULL, '2025-10-20 09:45:18'),
(15, 'Nguyễn Quang Huy', 'nguyen.huy@example.com', '0978901234', '$2a$10$Y.a4J4O./eJ4.W2mKBc.a.p./ZgajLh/gqX.UaK.Z2m8.I0.4z/G.', 'customer', '', 1, NULL, NULL, NULL, '2025-11-03 02:10:27');

-- --------------------------------------------------------

--
-- Table structure for table `vnpay_transactions`
--

CREATE TABLE `vnpay_transactions` (
  `transaction_id` bigint(20) UNSIGNED NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `vnp_txn_ref` varchar(100) NOT NULL,
  `vnp_transaction_no` varchar(100) DEFAULT NULL,
  `vnp_amount` bigint(20) NOT NULL,
  `vnp_bank_code` varchar(20) DEFAULT NULL,
  `vnp_card_type` varchar(20) DEFAULT NULL,
  `vnp_response_code` varchar(10) NOT NULL,
  `vnp_transaction_status` varchar(10) DEFAULT NULL,
  `vnp_secure_hash` varchar(256) NOT NULL,
  `is_valid_signature` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `addresses`
--
ALTER TABLE `addresses`
  ADD PRIMARY KEY (`address_id`),
  ADD KEY `fk_addresses_users` (`user_id`);

--
-- Indexes for table `branches`
--
ALTER TABLE `branches`
  ADD PRIMARY KEY (`branch_id`),
  ADD UNIQUE KEY `branch_code` (`branch_code`);

--
-- Indexes for table `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`brand_id`),
  ADD UNIQUE KEY `brand_name` (`brand_name`);

--
-- Indexes for table `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`cart_id`),
  ADD KEY `fk_carts_customer` (`customer_id`);

--
-- Indexes for table `cart_items`
--
ALTER TABLE `cart_items`
  ADD PRIMARY KEY (`cart_item_id`),
  ADD UNIQUE KEY `uq_cart_product` (`cart_id`,`product_id`),
  ADD KEY `fk_cartitems_product` (`product_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`),
  ADD KEY `fk_categories_parent` (`parent_category_id`);

--
-- Indexes for table `contact_messages`
--
ALTER TABLE `contact_messages`
  ADD PRIMARY KEY (`contact_id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `fk_inventory_branch` (`branch_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `fk_orders_user` (`user_id`),
  ADD KEY `fk_orders_address` (`shipping_address_id`);

--
-- Indexes for table `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`order_detail_id`),
  ADD UNIQUE KEY `order_id` (`order_id`,`product_id`),
  ADD KEY `fk_od_product` (`product_id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`payment_id`),
  ADD UNIQUE KEY `txn_ref` (`txn_ref`),
  ADD KEY `fk_payments_order` (`order_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `fk_products_category` (`category_id`),
  ADD KEY `fk_products_brand` (`brand_id`),
  ADD KEY `fk_products_supplier` (`supplier_id`);

--
-- Indexes for table `product_images`
--
ALTER TABLE `product_images`
  ADD PRIMARY KEY (`image_id`),
  ADD KEY `fk_images_products` (`product_id`);

--
-- Indexes for table `product_prices`
--
ALTER TABLE `product_prices`
  ADD PRIMARY KEY (`product_id`);

--
-- Indexes for table `promotions`
--
ALTER TABLE `promotions`
  ADD PRIMARY KEY (`promo_id`),
  ADD KEY `fk_promotions_product` (`product_id`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`review_id`),
  ADD UNIQUE KEY `product_id` (`product_id`,`user_id`),
  ADD KEY `fk_reviews_user` (`user_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`role_id`),
  ADD UNIQUE KEY `role_name` (`role_name`);

--
-- Indexes for table `shipments`
--
ALTER TABLE `shipments`
  ADD PRIMARY KEY (`shipment_id`),
  ADD UNIQUE KEY `tracking_no` (`tracking_no`),
  ADD KEY `fk_shipments_order` (`order_id`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`supplier_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `phone_number` (`phone_number`);

--
-- Indexes for table `vnpay_transactions`
--
ALTER TABLE `vnpay_transactions`
  ADD PRIMARY KEY (`transaction_id`),
  ADD UNIQUE KEY `vnp_txn_ref` (`vnp_txn_ref`),
  ADD KEY `fk_vnpay_order` (`order_id`),
  ADD KEY `idx_vnpay_txn_ref` (`vnp_txn_ref`),
  ADD KEY `idx_vnpay_response_code` (`vnp_response_code`),
  ADD KEY `idx_vnpay_created_at` (`created_at`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `addresses`
--
ALTER TABLE `addresses`
  MODIFY `address_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `branches`
--
ALTER TABLE `branches`
  MODIFY `branch_id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `brand_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `carts`
--
ALTER TABLE `carts`
  MODIFY `cart_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `cart_items`
--
ALTER TABLE `cart_items`
  MODIFY `cart_item_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `contact_messages`
--
ALTER TABLE `contact_messages`
  MODIFY `contact_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `order_details`
--
ALTER TABLE `order_details`
  MODIFY `order_detail_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `payment_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `product_images`
--
ALTER TABLE `product_images`
  MODIFY `image_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `promotions`
--
ALTER TABLE `promotions`
  MODIFY `promo_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `review_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `role_id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `shipments`
--
ALTER TABLE `shipments`
  MODIFY `shipment_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `supplier_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `vnpay_transactions`
--
ALTER TABLE `vnpay_transactions`
  MODIFY `transaction_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `addresses`
--
ALTER TABLE `addresses`
  ADD CONSTRAINT `fk_addresses_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `carts`
--
ALTER TABLE `carts`
  ADD CONSTRAINT `fk_carts_customer` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `cart_items`
--
ALTER TABLE `cart_items`
  ADD CONSTRAINT `fk_cartitems_cart` FOREIGN KEY (`cart_id`) REFERENCES `carts` (`cart_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_cartitems_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON UPDATE CASCADE;

--
-- Constraints for table `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `fk_categories_parent` FOREIGN KEY (`parent_category_id`) REFERENCES `categories` (`category_id`) ON DELETE SET NULL;

--
-- Constraints for table `customers`
--
ALTER TABLE `customers`
  ADD CONSTRAINT `fk_customers_users` FOREIGN KEY (`customer_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `inventory`
--
ALTER TABLE `inventory`
  ADD CONSTRAINT `fk_inventory_branch` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`branch_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_inventory_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `fk_orders_address` FOREIGN KEY (`shipping_address_id`) REFERENCES `addresses` (`address_id`),
  ADD CONSTRAINT `fk_orders_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `order_details`
--
ALTER TABLE `order_details`
  ADD CONSTRAINT `fk_od_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_od_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `fk_payments_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `fk_products_brand` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`brand_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_products_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_products_supplier` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`supplier_id`) ON DELETE SET NULL;

--
-- Constraints for table `product_images`
--
ALTER TABLE `product_images`
  ADD CONSTRAINT `fk_images_products` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `product_prices`
--
ALTER TABLE `product_prices`
  ADD CONSTRAINT `fk_prices_products` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `promotions`
--
ALTER TABLE `promotions`
  ADD CONSTRAINT `fk_promotions_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `fk_reviews_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_reviews_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `shipments`
--
ALTER TABLE `shipments`
  ADD CONSTRAINT `fk_shipments_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `vnpay_transactions`
--
ALTER TABLE `vnpay_transactions`
  ADD CONSTRAINT `fk_vnpay_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
