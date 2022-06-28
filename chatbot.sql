-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jun 21, 2022 at 10:44 AM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 7.4.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `chatbot`
--

-- --------------------------------------------------------

--
-- Table structure for table `history`
--

CREATE TABLE `history` (
  `id` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  `staff` varchar(50) NOT NULL,
  `customer` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`customer`)),
  `json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`json`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `history`
--

INSERT INTO `history` (`id`, `date`, `staff`, `customer`, `json`) VALUES
(275, '2022-06-17 04:33:43', 'TD', '{\"name\":\"Tran van a\",\"email\":\"tranvana@pavietnam.vn\",\"tel\":\"\",\"address\":\"\",\"company\":\"\",\"note\":\"\"}', '[{\"time\":1655440288519,\"text\":\"Quý khách cần mua sản phẩm nào?\",\"author\":\"Chatbot\"},{\"time\":1655440324242,\"text\":\"Tôi cần mua Iphone\",\"author\":\"Tran van a\"},{\"time\":1655440325072,\"text\":\"Tôi cần mua Iphone X\",\"author\":\"Tran van a\"},{\"time\":1655440325728,\"text\":\"Tôi cần phiên bản 128GB\",\"author\":\"Tran van a\"},{\"time\":1655440327880,\"text\":\"Gặp nhân viên tư vấn\",\"author\":\"Tran van a\"},{\"time\":1655440327880,\"text\":\"Quý khách đã được kết nối tới nhân viên tư vấn: TD\",\"author\":\"Chatbot\"},{\"time\":1655440336182,\"text\":\"xin chào\",\"author\":\"Tran van a\"},{\"time\":1655440339096,\"text\":\"Vâng, Anh/Chị cần em hỗ trợ gì ạ ?\",\"author\":\"TD\"},{\"time\":1655440371303,\"text\":\"iphone đang có khuyễn mãi gì không ?\",\"author\":\"Tran van a\"},{\"time\":1655440394616,\"text\":\"Bên em đang có chương trình khuyến mãi iphone X giảm giá lên đến 50%.\",\"author\":\"TD\"},{\"time\":1655440407752,\"text\":\"có được trả góp không ?\",\"author\":\"Tran van a\"},{\"time\":1655440411096,\"text\":\"Bên em trả góp 0% ạ.\",\"author\":\"TD\"},{\"time\":1655440419530,\"text\":\"ok cám ơn, tạm biệt\",\"author\":\"Tran van a\"}]'),
(276, '2022-06-17 04:51:41', 'Thanh Duy', '{\"name\":\"Tran van a\",\"email\":\"tranvana@pavietnam.vn\",\"tel\":\"\",\"address\":\"\",\"company\":\"\",\"note\":\"\"}', '[{\"time\":1655441390672,\"text\":\"Quý khách cần mua sản phẩm nào?\",\"author\":\"Chatbot\"},{\"time\":1655441409823,\"text\":\"Tôi cần mua Iphone\",\"author\":\"Tran van a\"},{\"time\":1655441411230,\"text\":\"Tôi cần mua Iphone 11\",\"author\":\"Tran van a\"},{\"time\":1655441412382,\"text\":\"Gặp nhân viên tư vấn\",\"author\":\"Tran van a\"},{\"time\":1655441412383,\"text\":\"Quý khách đã được kết nối tới nhân viên tư vấn: Thanh Duy\",\"author\":\"Chatbot\"},{\"time\":1655441424085,\"text\":\"xin chào\",\"author\":\"Tran van a\"},{\"time\":1655441426131,\"text\":\"Vâng, Anh/Chị cần em hỗ trợ gì ạ ?\",\"author\":\"Thanh Duy\"},{\"time\":1655441439749,\"text\":\"tôi cần tới cửa hàng\",\"author\":\"Tran van a\"},{\"time\":1655441455971,\"text\":\"Vâng, anh/chị vui lòng tới 22 Cao Thắng để xem trực tiếp sản phẩm. cửa hàng bên em làm việc từ 8h00 - 20h00 tất cả các ngày trong tuần.\",\"author\":\"Thanh Duy\"},{\"time\":1655441497654,\"text\":\"ok\",\"author\":\"Tran van a\"}]'),
(277, '2022-06-17 06:39:53', 'Duy Nguyễn', '{\"name\":\"Nguyễn Thị B\",\"email\":\"nguyenthib@pavietnam.vn\",\"tel\":\"\",\"address\":\"\",\"company\":\"\",\"note\":\"\"}', '[{\"time\":1655447945021,\"text\":\"Quý khách cần mua sản phẩm nào?\",\"author\":\"Chatbot\"},{\"time\":1655447958472,\"text\":\"Tôi cần mua điện thoại SamSung\",\"author\":\"Nguyễn Thị B\"},{\"time\":1655447960439,\"text\":\"Tôi muốn mua Note 9\",\"author\":\"Nguyễn Thị B\"},{\"time\":1655447963312,\"text\":\"Gặp nhân viên tư vấn\",\"author\":\"Nguyễn Thị B\"},{\"time\":1655447963312,\"text\":\"Quý khách đã được kết nối tới nhân viên tư vấn: Duy Nguyễn\",\"author\":\"Chatbot\"},{\"time\":1655447974451,\"text\":\"123\",\"author\":\"Nguyễn Thị B\"},{\"time\":1655447978072,\"text\":\"234\",\"author\":\"Duy Nguyễn\"},{\"time\":1655447985110,\"text\":\"456\",\"author\":\"Nguyễn Thị B\"},{\"time\":1655447988734,\"text\":\"678\",\"author\":\"Duy Nguyễn\"}]'),
(278, '2022-06-17 06:44:14', 'Thanh Duy', '{\"name\":\"Tran Van D\",\"email\":\"tranvand@pavietnam.vn\",\"tel\":\"\",\"address\":\"\",\"company\":\"\",\"note\":\"\"}', '[{\"time\":1655448209175,\"text\":\"Quý khách cần mua sản phẩm nào?\",\"author\":\"Chatbot\"},{\"time\":1655448219279,\"text\":\"Tôi cần mua Iphone\",\"author\":\"Tran Van D\"},{\"time\":1655448220638,\"text\":\"Tôi cần mua Iphone X\",\"author\":\"Tran Van D\"},{\"time\":1655448221278,\"text\":\"Tôi cần phiên bản 128GB\",\"author\":\"Tran Van D\"},{\"time\":1655448222031,\"text\":\"Gặp nhân viên tư vấn\",\"author\":\"Tran Van D\"},{\"time\":1655448222031,\"text\":\"Quý khách đã được kết nối tới nhân viên tư vấn: Thanh Duy\",\"author\":\"Chatbot\"},{\"time\":1655448228353,\"text\":\"hello\",\"author\":\"Tran Van D\"},{\"time\":1655448231170,\"text\":\"hi\",\"author\":\"Thanh Duy\"},{\"time\":1655448247727,\"text\":\"test tin nhắn dài 1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111\",\"author\":\"Tran Van D\"}]'),
(279, '2022-06-17 06:49:50', 'Nguyễn Duy', '{\"name\":\"Nguyễn Việt Thanh Duy\",\"email\":\"nvtd@gmail.com\",\"tel\":\"\",\"address\":\"\",\"company\":\"\",\"note\":\"\"}', '[{\"time\":1655448457413,\"text\":\"Quý khách cần mua sản phẩm nào?\",\"author\":\"Chatbot\"},{\"time\":1655448471562,\"text\":\"Gặp nhân viên tư vấn\",\"author\":\"Nguyễn Việt Thanh Duy\"},{\"time\":1655448471563,\"text\":\"Xin lỗi hiện tại không có nhân viên nào online!\",\"author\":\"Chatbot\"},{\"time\":1655448471563,\"text\":\"Quý khách cần mua sản phẩm nào?\",\"author\":\"Chatbot\"},{\"time\":1655448569535,\"text\":\"Tôi cần mua Iphone\",\"author\":\"Nguyễn Việt Thanh Duy\"},{\"time\":1655448570525,\"text\":\"Tôi cần mua Iphone X\",\"author\":\"Nguyễn Việt Thanh Duy\"},{\"time\":1655448571046,\"text\":\"Tôi cần phiên bản 128GB\",\"author\":\"Nguyễn Việt Thanh Duy\"},{\"time\":1655448571526,\"text\":\"Gặp nhân viên tư vấn\",\"author\":\"Nguyễn Việt Thanh Duy\"},{\"time\":1655448571526,\"text\":\"Quý khách đã được kết nối tới nhân viên tư vấn: Nguyễn Duy\",\"author\":\"Chatbot\"},{\"time\":1655448580167,\"text\":\"xin chào\",\"author\":\"Nguyễn Việt Thanh Duy\"},{\"time\":1655448585978,\"text\":\"xin chào\",\"author\":\"Nguyễn Duy\"}]'),
(280, '2022-06-17 06:49:50', 'Nguyễn Duy', '{\"name\":\"Nguyễn Việt Thanh Duy\",\"email\":\"nvtd@gmail.com\",\"tel\":\"\",\"address\":\"\",\"company\":\"\",\"note\":\"\"}', '[{\"time\":1655448457413,\"text\":\"Quý khách cần mua sản phẩm nào?\",\"author\":\"Chatbot\"},{\"time\":1655448471562,\"text\":\"Gặp nhân viên tư vấn\",\"author\":\"Nguyễn Việt Thanh Duy\"},{\"time\":1655448471563,\"text\":\"Xin lỗi hiện tại không có nhân viên nào online!\",\"author\":\"Chatbot\"},{\"time\":1655448471563,\"text\":\"Quý khách cần mua sản phẩm nào?\",\"author\":\"Chatbot\"},{\"time\":1655448569535,\"text\":\"Tôi cần mua Iphone\",\"author\":\"Nguyễn Việt Thanh Duy\"},{\"time\":1655448570525,\"text\":\"Tôi cần mua Iphone X\",\"author\":\"Nguyễn Việt Thanh Duy\"},{\"time\":1655448571046,\"text\":\"Tôi cần phiên bản 128GB\",\"author\":\"Nguyễn Việt Thanh Duy\"},{\"time\":1655448571526,\"text\":\"Gặp nhân viên tư vấn\",\"author\":\"Nguyễn Việt Thanh Duy\"},{\"time\":1655448571526,\"text\":\"Quý khách đã được kết nối tới nhân viên tư vấn: Nguyễn Duy\",\"author\":\"Chatbot\"},{\"time\":1655448580167,\"text\":\"xin chào\",\"author\":\"Nguyễn Việt Thanh Duy\"},{\"time\":1655448585978,\"text\":\"xin chào\",\"author\":\"Nguyễn Duy\"}]'),
(281, '2022-06-17 06:44:14', 'Thanh Duy', '{\"name\":\"Tran Van D\",\"email\":\"tranvand@pavietnam.vn\",\"tel\":\"\",\"address\":\"\",\"company\":\"\",\"note\":\"\"}', '[{\"time\":1655448209175,\"text\":\"Quý khách cần mua sản phẩm nào?\",\"author\":\"Chatbot\"},{\"time\":1655448219279,\"text\":\"Tôi cần mua Iphone\",\"author\":\"Tran Van D\"},{\"time\":1655448220638,\"text\":\"Tôi cần mua Iphone X\",\"author\":\"Tran Van D\"},{\"time\":1655448221278,\"text\":\"Tôi cần phiên bản 128GB\",\"author\":\"Tran Van D\"},{\"time\":1655448222031,\"text\":\"Gặp nhân viên tư vấn\",\"author\":\"Tran Van D\"},{\"time\":1655448222031,\"text\":\"Quý khách đã được kết nối tới nhân viên tư vấn: Thanh Duy\",\"author\":\"Chatbot\"},{\"time\":1655448228353,\"text\":\"hello\",\"author\":\"Tran Van D\"},{\"time\":1655448231170,\"text\":\"hi\",\"author\":\"Thanh Duy\"},{\"time\":1655448247727,\"text\":\"test tin nhắn dài 1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111\",\"author\":\"Tran Van D\"}]'),
(282, '2022-06-17 06:39:53', 'Duy Nguyễn', '{\"name\":\"Nguyễn Thị B\",\"email\":\"nguyenthib@pavietnam.vn\",\"tel\":\"\",\"address\":\"\",\"company\":\"\",\"note\":\"\"}', '[{\"time\":1655447945021,\"text\":\"Quý khách cần mua sản phẩm nào?\",\"author\":\"Chatbot\"},{\"time\":1655447958472,\"text\":\"Tôi cần mua điện thoại SamSung\",\"author\":\"Nguyễn Thị B\"},{\"time\":1655447960439,\"text\":\"Tôi muốn mua Note 9\",\"author\":\"Nguyễn Thị B\"},{\"time\":1655447963312,\"text\":\"Gặp nhân viên tư vấn\",\"author\":\"Nguyễn Thị B\"},{\"time\":1655447963312,\"text\":\"Quý khách đã được kết nối tới nhân viên tư vấn: Duy Nguyễn\",\"author\":\"Chatbot\"},{\"time\":1655447974451,\"text\":\"123\",\"author\":\"Nguyễn Thị B\"},{\"time\":1655447978072,\"text\":\"234\",\"author\":\"Duy Nguyễn\"},{\"time\":1655447985110,\"text\":\"456\",\"author\":\"Nguyễn Thị B\"},{\"time\":1655447988734,\"text\":\"678\",\"author\":\"Duy Nguyễn\"}]'),
(283, '2022-06-17 04:51:41', 'Thanh Duy', '{\"name\":\"Tran van a\",\"email\":\"tranvana@pavietnam.vn\",\"tel\":\"\",\"address\":\"\",\"company\":\"\",\"note\":\"\"}', '[{\"time\":1655441390672,\"text\":\"Quý khách cần mua sản phẩm nào?\",\"author\":\"Chatbot\"},{\"time\":1655441409823,\"text\":\"Tôi cần mua Iphone\",\"author\":\"Tran van a\"},{\"time\":1655441411230,\"text\":\"Tôi cần mua Iphone 11\",\"author\":\"Tran van a\"},{\"time\":1655441412382,\"text\":\"Gặp nhân viên tư vấn\",\"author\":\"Tran van a\"},{\"time\":1655441412383,\"text\":\"Quý khách đã được kết nối tới nhân viên tư vấn: Thanh Duy\",\"author\":\"Chatbot\"},{\"time\":1655441424085,\"text\":\"xin chào\",\"author\":\"Tran van a\"},{\"time\":1655441426131,\"text\":\"Vâng, Anh/Chị cần em hỗ trợ gì ạ ?\",\"author\":\"Thanh Duy\"},{\"time\":1655441439749,\"text\":\"tôi cần tới cửa hàng\",\"author\":\"Tran van a\"},{\"time\":1655441455971,\"text\":\"Vâng, anh/chị vui lòng tới 22 Cao Thắng để xem trực tiếp sản phẩm. cửa hàng bên em làm việc từ 8h00 - 20h00 tất cả các ngày trong tuần.\",\"author\":\"Thanh Duy\"},{\"time\":1655441497654,\"text\":\"ok\",\"author\":\"Tran van a\"}]'),
(284, '2022-06-17 04:33:43', 'TD', '{\"name\":\"Tran van a\",\"email\":\"tranvana@pavietnam.vn\",\"tel\":\"\",\"address\":\"\",\"company\":\"\",\"note\":\"\"}', '[{\"time\":1655440288519,\"text\":\"Quý khách cần mua sản phẩm nào?\",\"author\":\"Chatbot\"},{\"time\":1655440324242,\"text\":\"Tôi cần mua Iphone\",\"author\":\"Tran van a\"},{\"time\":1655440325072,\"text\":\"Tôi cần mua Iphone X\",\"author\":\"Tran van a\"},{\"time\":1655440325728,\"text\":\"Tôi cần phiên bản 128GB\",\"author\":\"Tran van a\"},{\"time\":1655440327880,\"text\":\"Gặp nhân viên tư vấn\",\"author\":\"Tran van a\"},{\"time\":1655440327880,\"text\":\"Quý khách đã được kết nối tới nhân viên tư vấn: TD\",\"author\":\"Chatbot\"},{\"time\":1655440336182,\"text\":\"xin chào\",\"author\":\"Tran van a\"},{\"time\":1655440339096,\"text\":\"Vâng, Anh/Chị cần em hỗ trợ gì ạ ?\",\"author\":\"TD\"},{\"time\":1655440371303,\"text\":\"iphone đang có khuyễn mãi gì không ?\",\"author\":\"Tran van a\"},{\"time\":1655440394616,\"text\":\"Bên em đang có chương trình khuyến mãi iphone X giảm giá lên đến 50%.\",\"author\":\"TD\"},{\"time\":1655440407752,\"text\":\"có được trả góp không ?\",\"author\":\"Tran van a\"},{\"time\":1655440411096,\"text\":\"Bên em trả góp 0% ạ.\",\"author\":\"TD\"},{\"time\":1655440419530,\"text\":\"ok cám ơn, tạm biệt\",\"author\":\"Tran van a\"}]'),
(285, '2022-06-17 06:53:42', 'Nguyễn Duy', '{\"name\":\"Lê Văn E\",\"email\":\"LeVanE@yahoo.com\",\"tel\":\"\",\"address\":\"\",\"company\":\"\",\"note\":\"\"}', '[{\"time\":1655448749707,\"text\":\"Quý khách cần mua sản phẩm nào?\",\"author\":\"Chatbot\"},{\"time\":1655448752084,\"text\":\"Tôi cần mua Iphone\",\"author\":\"Lê Văn E\"},{\"time\":1655448753162,\"text\":\"Tôi cần mua Iphone 11\",\"author\":\"Lê Văn E\"},{\"time\":1655448754195,\"text\":\"Gặp nhân viên tư vấn\",\"author\":\"Lê Văn E\"},{\"time\":1655448754195,\"text\":\"Quý khách đã được kết nối tới nhân viên tư vấn: Nguyễn Duy\",\"author\":\"Chatbot\"},{\"time\":1655448760928,\"text\":\"xin chào\",\"author\":\"Lê Văn E\"},{\"time\":1655448770781,\"text\":\"Vâng, Anh/Chị cần em hỗ trợ gì ạ ?\",\"author\":\"Nguyễn Duy\"}]'),
(286, '2022-06-17 06:53:42', 'Nguyễn Duy', '{\"name\":\"Lê Văn E\",\"email\":\"LeVanE@yahoo.com\",\"tel\":\"\",\"address\":\"\",\"company\":\"\",\"note\":\"\"}', '[{\"time\":1655448749707,\"text\":\"Quý khách cần mua sản phẩm nào?\",\"author\":\"Chatbot\"},{\"time\":1655448752084,\"text\":\"Tôi cần mua Iphone\",\"author\":\"Lê Văn E\"},{\"time\":1655448753162,\"text\":\"Tôi cần mua Iphone 11\",\"author\":\"Lê Văn E\"},{\"time\":1655448754195,\"text\":\"Gặp nhân viên tư vấn\",\"author\":\"Lê Văn E\"},{\"time\":1655448754195,\"text\":\"Quý khách đã được kết nối tới nhân viên tư vấn: Nguyễn Duy\",\"author\":\"Chatbot\"},{\"time\":1655448760928,\"text\":\"xin chào\",\"author\":\"Lê Văn E\"},{\"time\":1655448770781,\"text\":\"Vâng, Anh/Chị cần em hỗ trợ gì ạ ?\",\"author\":\"Nguyễn Duy\"}]'),
(287, '2022-06-17 06:59:21', 'Nguyễn Duy', '{\"name\":\"test\",\"email\":\"test@gmail.com\",\"tel\":\"\",\"address\":\"\",\"company\":\"\",\"note\":\"test ghi chú rất dài spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam \"}', '[{\"time\":1655449129366,\"text\":\"Quý khách cần mua sản phẩm nào?\",\"author\":\"Chatbot\"},{\"time\":1655449133990,\"text\":\"Tôi cần mua Iphone\",\"author\":\"test\"},{\"time\":1655449134885,\"text\":\"Tôi cần mua Iphone X\",\"author\":\"test\"},{\"time\":1655449135541,\"text\":\"Tôi cần phiên bản 128GB\",\"author\":\"test\"},{\"time\":1655449136012,\"text\":\"Gặp nhân viên tư vấn\",\"author\":\"test\"},{\"time\":1655449136012,\"text\":\"Quý khách đã được kết nối tới nhân viên tư vấn: Nguyễn Duy\",\"author\":\"Chatbot\"},{\"time\":1655449143215,\"text\":\"test chat bot\",\"author\":\"test\"},{\"time\":1655449150351,\"text\":\"ok\",\"author\":\"Nguyễn Duy\"}]'),
(288, '2022-06-17 07:18:02', 'TD', '{\"name\":\"Lê Văn T\",\"email\":\"lvt@yahoo.com\",\"tel\":\"0101010101\",\"address\":\"344 Huỳnh Tấn Phát\",\"company\":\"\",\"note\":\"Khách hàng cần giao hàng tận nơi\"}', '[{\"time\":1655450002275,\"text\":\"Quý khách cần mua sản phẩm nào?\",\"author\":\"Chatbot\"},{\"time\":1655450009812,\"text\":\"Tôi cần mua Iphone\",\"author\":\"Lê Văn T\"},{\"time\":1655450010762,\"text\":\"Tôi cần mua Iphone X\",\"author\":\"Lê Văn T\"},{\"time\":1655450011266,\"text\":\"Tôi cần phiên bản 128GB\",\"author\":\"Lê Văn T\"},{\"time\":1655450011714,\"text\":\"Gặp nhân viên tư vấn\",\"author\":\"Lê Văn T\"},{\"time\":1655450011715,\"text\":\"Quý khách đã được kết nối tới nhân viên tư vấn: TD\",\"author\":\"Chatbot\"},{\"time\":1655450038392,\"text\":\"tôi cần mua iphone giao hàng tận nơi\",\"author\":\"Lê Văn T\"},{\"time\":1655450069782,\"text\":\"anh/chị có thể cho em xin địa chỉ và số điện thoại được không ạ ?\",\"author\":\"TD\"},{\"time\":1655450238798,\"text\":\"địa chỉ là 344 Huỳnh Tấn Phát\",\"author\":\"Lê Văn T\"},{\"time\":1655450258462,\"text\":\"số điện thoại là 0101010101\",\"author\":\"Lê Văn T\"}]');

-- --------------------------------------------------------

--
-- Table structure for table `scenario`
--

CREATE TABLE `scenario` (
  `scenario_id` bigint(20) NOT NULL,
  `title` varchar(100) NOT NULL,
  `content` varchar(500) NOT NULL,
  `type_id` smallint(6) NOT NULL DEFAULT 0 COMMENT 'via scenario_type tabel',
  `url` varchar(500) DEFAULT NULL,
  `image` varchar(500) DEFAULT NULL,
  `file_name` varchar(100) DEFAULT NULL,
  `action` varchar(10) DEFAULT NULL,
  `phong_ban` smallint(6) NOT NULL DEFAULT 0,
  `nhan_vien` smallint(6) NOT NULL DEFAULT 0,
  `next_jump` bigint(20) NOT NULL DEFAULT 0,
  `parent_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `scenario`
--

INSERT INTO `scenario` (`scenario_id`, `title`, `content`, `type_id`, `url`, `image`, `file_name`, `action`, `phong_ban`, `nhan_vien`, `next_jump`, `parent_id`) VALUES
(1559123198812, 'Welcome', 'Quý khách cần mua sản phẩm nào?', 1, '', '', '', '0', 0, 0, 0, 0),
(1559124272653219, 'mua iphone', 'Tôi cần mua Iphone', 2, '', '', '', '0', 0, 0, 0, 1559123198812),
(1559124303469813, 'mua samsung', 'Tôi cần mua điện thoại SamSung', 2, '', '', '', '0', 0, 0, 0, 1559123198812),
(1559124351501525, 'S8', 'S8 Giảm giá 50%', 1, '', 'https://didongviet.vn/pub/media/catalog/product//s/a/samsung-galaxy-s8-cong-ty-didongviet.jpg', '', '0', 28, 254, 0, 1559124303469813),
(1559124364551494, 'Mua S8', 'Tôi muốn mua S8', 2, 'http://topgia.vn/ca-dien-thoai-samsung-9319', '', '', '0', 0, 0, 1559200800391247, 1559124303469813),
(1559124388561310, 'iphone 11', 'Tôi cần mua Iphone 11', 2, '', '', '', 'jump', 0, 0, 1559200800391247, 1559124272653219),
(1559124397681687, 'iphone X', 'Tôi cần mua iphone 10', 2, '', '', '', '0', 0, 0, 0, 1559124272653219),
(1559200800391247, 'Gặp nhân viên', 'Gặp nhân viên tư vấn', 3, '', '', '', '0', 28, 0, 0, 1559123198812),
(1560479664609837, 'Note 9', 'Note 9 giảm giá 60%', 1, '', 'https://a.ipricegroup.com/media/1Ly/5cc370906539ab4bb90c4c1c61208270.jpg', '', '0', 28, 254, 0, 1559124303469813),
(1560479676898262, 'Mua Note9', 'Tôi muốn mua Note 9', 2, 'http://topgia.vn/ca-dien-thoai-samsung-9319', '', '', '0', 0, 0, 1559200800391247, 1559124303469813),
(1592212290542055, 'bản 128GB', 'Tôi cần phiên bản 128GB', 2, '', '', '', 'jump', 0, 0, 1559200800391247, 1559124397681687),
(1592212290542112, 'iphone 13', 'Tôi cần mua iphone 13', 2, '', '', '0', '0', 0, 0, 0, 1559124272653219),
(1592212290542113, 'iphone 13 pro', 'Phiên bản pro', 2, '', 'https://cdn.tgdd.vn/Products/Images/42/230521/iphone-13-pro-gold-1-600x600.jpg', '', '0', 0, 0, 1559200800391247, 1592212290542112),
(1592212290542114, 'iphone 13 mini', 'Phiên bản mini', 2, '', 'https://cdn.tgdd.vn/Products/Images/42/236780/iphone-13-mini-pink-1-600x600.jpg', '', '0', 0, 0, 1559200800391247, 1592212290542112),
(1592212290542115, 'iphone 13 pro max', 'Phiên bản pro max', 2, '', 'https://didongviet.vn/pub/media/catalog/product/i/p/iphone-13-pro-max-128gb-didongviet.jpg', '', '0', 0, 0, 1559200800391247, 1592212290542112);

-- --------------------------------------------------------

--
-- Table structure for table `scenario_type`
--

CREATE TABLE `scenario_type` (
  `type_id` int(11) NOT NULL,
  `type` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `scenario_type`
--

INSERT INTO `scenario_type` (`type_id`, `type`) VALUES
(1, 'Text'),
(2, 'Button'),
(3, 'Staff');

-- --------------------------------------------------------

--
-- Table structure for table `suggested_answers`
--

CREATE TABLE `suggested_answers` (
  `id` int(11) NOT NULL,
  `keyword` varchar(50) NOT NULL,
  `answer` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `suggested_answers`
--

INSERT INTO `suggested_answers` (`id`, `keyword`, `answer`) VALUES
(1, 'toi cua hang', 'Vâng, anh/chị vui lòng tới 22 Cao Thắng để xem trực tiếp sản phẩm. cửa hàng bên em làm việc từ 8h00 - 20h00 tất cả các ngày trong tuần.'),
(2, 'tra gop', 'Bên em trả góp 0% ạ.'),
(3, 'xin chao', 'Vâng, Anh/Chị cần em hỗ trợ gì ạ ?'),
(4, 'thu phi tan noi', 'dạ. Anh cho em địa chỉ để bên em tới thu phí tận nơi ạ.'),
(5, 'khuyen mai', 'Bên em đang có chương trình khuyến mãi iphone X giảm giá lên đến 50%.'),
(8, 'tam biet', 'Xin chào tạm biệt, rất mong chúng tôi đã giúp ích được cho quý khách.'),
(9, 'iphone x', 'Bên em đang có chương trình khuyến mãi tặng kèm sạc dự phòng 10.000mAh khi mua sản phẩm Iphone X ạ.');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `history`
--
ALTER TABLE `history`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `scenario`
--
ALTER TABLE `scenario`
  ADD PRIMARY KEY (`scenario_id`);

--
-- Indexes for table `scenario_type`
--
ALTER TABLE `scenario_type`
  ADD PRIMARY KEY (`type_id`);

--
-- Indexes for table `suggested_answers`
--
ALTER TABLE `suggested_answers`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `history`
--
ALTER TABLE `history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=289;

--
-- AUTO_INCREMENT for table `scenario`
--
ALTER TABLE `scenario`
  MODIFY `scenario_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1592212290542118;

--
-- AUTO_INCREMENT for table `scenario_type`
--
ALTER TABLE `scenario_type`
  MODIFY `type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `suggested_answers`
--
ALTER TABLE `suggested_answers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
