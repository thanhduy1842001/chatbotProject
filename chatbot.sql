-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jul 30, 2022 at 03:16 AM
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
(288, '2022-06-17 07:18:02', 'TD', '{\"name\":\"Lê Văn T\",\"email\":\"lvt@yahoo.com\",\"tel\":\"0101010101\",\"address\":\"344 Huỳnh Tấn Phát\",\"company\":\"\",\"note\":\"Khách hàng cần giao hàng tận nơi\"}', '[{\"time\":1655450002275,\"text\":\"Quý khách cần mua sản phẩm nào?\",\"author\":\"Chatbot\"},{\"time\":1655450009812,\"text\":\"Tôi cần mua Iphone\",\"author\":\"Lê Văn T\"},{\"time\":1655450010762,\"text\":\"Tôi cần mua Iphone X\",\"author\":\"Lê Văn T\"},{\"time\":1655450011266,\"text\":\"Tôi cần phiên bản 128GB\",\"author\":\"Lê Văn T\"},{\"time\":1655450011714,\"text\":\"Gặp nhân viên tư vấn\",\"author\":\"Lê Văn T\"},{\"time\":1655450011715,\"text\":\"Quý khách đã được kết nối tới nhân viên tư vấn: TD\",\"author\":\"Chatbot\"},{\"time\":1655450038392,\"text\":\"tôi cần mua iphone giao hàng tận nơi\",\"author\":\"Lê Văn T\"},{\"time\":1655450069782,\"text\":\"anh/chị có thể cho em xin địa chỉ và số điện thoại được không ạ ?\",\"author\":\"TD\"},{\"time\":1655450238798,\"text\":\"địa chỉ là 344 Huỳnh Tấn Phát\",\"author\":\"Lê Văn T\"},{\"time\":1655450258462,\"text\":\"số điện thoại là 0101010101\",\"author\":\"Lê Văn T\"}]'),
(289, '2022-06-22 02:30:04', 'TD', '{\"name\":\"Tran van a\",\"email\":\"tranvana@pavietnam.vn\",\"tel\":\"\",\"address\":\"\",\"company\":\"\",\"note\":\"\"}', '[{\"time\":1655863813403,\"text\":\"Quý khách cần mua sản phẩm nào?\",\"author\":\"Chatbot\"},{\"time\":1655863827168,\"text\":\"Gặp nhân viên tư vấn\",\"author\":\"Tran van a\"},{\"time\":1655863827169,\"text\":\"Quý khách đã được kết nối tới nhân viên tư vấn: TD\",\"author\":\"Chatbot\"},{\"time\":1655864082887,\"text\":\"test tin nhắn có xuống hàng\\n123\\n456\\n789\",\"author\":\"Tran van a\"}]'),
(290, '2022-06-24 08:59:49', 'TD', '{\"name\":\"Tran van a\",\"email\":\"tranvana@pavietnam.vn\",\"tel\":\"\",\"address\":\"\",\"company\":\"\",\"note\":\"\"}', '[{\"time\":1656059349314,\"text\":\"Quý khách cần mua sản phẩm nào?\",\"author\":\"Chatbot\"},{\"time\":1656059350201,\"text\":\"Gặp nhân viên tư vấn\",\"author\":\"Tran van a\"},{\"time\":1656059350203,\"text\":\"Xin lỗi hiện tại không có nhân viên nào online!\",\"author\":\"Chatbot\"},{\"time\":1656059350203,\"text\":\"Quý khách cần mua sản phẩm nào?\",\"author\":\"Chatbot\"},{\"time\":1656059359781,\"text\":\"Gặp nhân viên tư vấn\",\"author\":\"Tran van a\"},{\"time\":1656059359782,\"text\":\"Quý khách đã được kết nối tới nhân viên tư vấn: TD\",\"author\":\"Chatbot\"},{\"time\":1656059370821,\"text\":\"123\",\"author\":\"Tran van a\"},{\"time\":1656059375381,\"text\":\"123\",\"author\":\"Tran van a\"},{\"time\":1656059434532,\"text\":\"123\",\"author\":\"Tran van a\"},{\"time\":1656059437316,\"text\":\"123\",\"author\":\"Tran van a\"},{\"time\":1656059438036,\"text\":\"123\",\"author\":\"Tran van a\"},{\"time\":1656059442325,\"text\":\"123\\n123\\n123\",\"author\":\"Tran van a\"},{\"time\":1656059695110,\"text\":\"123\",\"author\":\"TD\"},{\"time\":1656059715397,\"text\":\"123\",\"author\":\"TD\"}]'),
(291, '2022-06-24 09:19:03', '', '{\"name\":\"Lê Văn C\",\"email\":\"lvc@pavietnam.vn\",\"tel\":\"\",\"address\":\"\",\"company\":\"\",\"note\":\"\"}', '[{\"time\":1656062289961,\"text\":\"Quý khách cần mua sản phẩm nào?\",\"author\":\"Chatbot\"},{\"time\":1656062333011,\"text\":\"test không gặp nhân viên tư vấn\",\"author\":\"Lê Văn C\"}]'),
(292, '2022-06-27 01:35:18', 'Thanh Duy', '{\"name\":\"Tran van a\",\"email\":\"\",\"tel\":\"\",\"address\":\"\",\"company\":\"\",\"note\":\"\"}', '[{\"time\":1656293275182,\"text\":\"Quý khách cần mua sản phẩm nào?\",\"author\":\"Chatbot\"},{\"time\":1656293311967,\"text\":\"Gặp nhân viên tư vấn\",\"author\":\"Tran van a\"},{\"time\":1656293311967,\"text\":\"Quý khách đã được kết nối tới nhân viên tư vấn: Thanh Duy\",\"author\":\"Chatbot\"},{\"time\":1656293331681,\"text\":\"xin chào\",\"author\":\"Tran van a\"},{\"time\":1656293337393,\"text\":\"Vâng, Anh/Chị cần em hỗ trợ gì ạ ?\",\"author\":\"Thanh Duy\"},{\"time\":1656293358277,\"text\":\"hello\",\"author\":\"Thanh Duy\"},{\"time\":1656293368067,\"text\":\"mua khuyến mãi\",\"author\":\"Tran van a\"},{\"time\":1656293373521,\"text\":\"Bên em đang có chương trình khuyến mãi iphone X giảm giá lên đến 50%.\",\"author\":\"Thanh Duy\"},{\"time\":1656293424931,\"text\":\"123\\n123\\n123\\n123\",\"author\":\"Tran van a\"},{\"time\":1656293468065,\"text\":\"345\\n345\\n345\\n345\",\"author\":\"Thanh Duy\"}]'),
(293, '2022-06-27 02:02:21', 'Thanh Duy', '{\"name\":\"Tran van a\",\"email\":\"tranvana@pavietnam.vn\",\"tel\":\"\",\"address\":\"\",\"company\":\"\",\"note\":\"\"}', '[{\"time\":1656295170097,\"text\":\"Quý khách cần mua sản phẩm nào?\",\"author\":\"Chatbot\"},{\"time\":1656295171322,\"text\":\"Tôi cần mua Iphone\",\"author\":\"Tran van a\"},{\"time\":1656295176969,\"text\":\"Tôi cần mua iphone 10\",\"author\":\"Tran van a\"},{\"time\":1656295179553,\"text\":\"Tôi cần phiên bản 128GB\",\"author\":\"Tran van a\"},{\"time\":1656295185721,\"text\":\"Gặp nhân viên tư vấn\",\"author\":\"Tran van a\"},{\"time\":1656295185722,\"text\":\"Xin lỗi hiện tại không có nhân viên nào online!\",\"author\":\"Chatbot\"},{\"time\":1656295185722,\"text\":\"Quý khách cần mua sản phẩm nào?\",\"author\":\"Chatbot\"},{\"time\":1656295197329,\"text\":\"Gặp nhân viên tư vấn\",\"author\":\"Tran van a\"},{\"time\":1656295197330,\"text\":\"Quý khách đã được kết nối tới nhân viên tư vấn: Thanh Duy\",\"author\":\"Chatbot\"},{\"time\":1656295222638,\"text\":\"xin chào\",\"author\":\"Tran van a\"},{\"time\":1656295224669,\"text\":\"Vâng, Anh/Chị cần em hỗ trợ gì ạ ?\",\"author\":\"Thanh Duy\"}]'),
(295, '2022-06-28 02:42:30', 'Thanh Duy', '{\"name\":\"Tran van a\",\"email\":\"tranvana@pavietnam.vn\",\"tel\":\"\",\"address\":\"\",\"company\":\"\",\"note\":\"\"}', '[{\"time\":1656382967092,\"text\":\"Quý khách cần mua sản phẩm nào?\",\"author\":\"Chatbot\"},{\"time\":1656383026164,\"text\":\"Gặp nhân viên tư vấn\",\"author\":\"Tran van a\"},{\"time\":1656383026165,\"text\":\"Xin lỗi hiện tại không có nhân viên nào online!\",\"author\":\"Chatbot\"},{\"time\":1656383026165,\"text\":\"Quý khách cần mua sản phẩm nào?\",\"author\":\"Chatbot\"},{\"time\":1656383027642,\"text\":\"Tôi cần mua Iphone\",\"author\":\"Tran van a\"},{\"time\":1656383314254,\"text\":\"Tôi cần mua Iphone 11\",\"author\":\"Tran van a\"},{\"time\":1656383314933,\"text\":\"Gặp nhân viên tư vấn\",\"author\":\"Tran van a\"},{\"time\":1656383314933,\"text\":\"Quý khách đã được kết nối tới nhân viên tư vấn: Thanh Duy\",\"author\":\"Chatbot\"},{\"time\":1656383335045,\"text\":\"xin chào\",\"author\":\"Tran van a\"},{\"time\":1656383337763,\"text\":\"Vâng, Anh/Chị cần em hỗ trợ gì ạ ?\",\"author\":\"Thanh Duy\"}]'),
(296, '2022-06-28 03:16:16', 'Thanh Duy', '{\"name\":\"Trần Văn B\",\"email\":\"tranvanb@pavietnam.vn\",\"tel\":\"\",\"address\":\"\",\"company\":\"\",\"note\":\"\"}', '[{\"time\":1656385502129,\"text\":\"Quý khách cần mua sản phẩm nào?\",\"author\":\"Chatbot\"},{\"time\":1656385504299,\"text\":\"Gặp nhân viên tư vấn\",\"author\":\"Trần Văn B\"},{\"time\":1656385504299,\"text\":\"Quý khách đã được kết nối tới nhân viên tư vấn: Thanh Duy\",\"author\":\"Chatbot\"},{\"time\":1656385705427,\"text\":\"xin chào\",\"author\":\"Trần Văn B\"},{\"time\":1656385709425,\"text\":\"Vâng, Anh/Chị cần em hỗ trợ gì ạ ?\",\"author\":\"Thanh Duy\"},{\"time\":1656385742087,\"text\":\"mua điện thoại\",\"author\":\"Trần Văn B\"},{\"time\":1656385767927,\"text\":\"iphone x\",\"author\":\"Trần Văn B\"},{\"time\":1656385915636,\"text\":\"có khuyến mãi không ?\",\"author\":\"Trần Văn B\"},{\"time\":1656385923492,\"text\":\"Bên em đang có chương trình khuyến mãi iphone X giảm giá lên đến 50%.\",\"author\":\"Thanh Duy\"},{\"time\":1656385953080,\"text\":\"làm sao để tới cửa hàng\",\"author\":\"Trần Văn B\"},{\"time\":1656385955797,\"text\":\"Vâng, anh/chị vui lòng tới 22 Cao Thắng để xem trực tiếp sản phẩm. cửa hàng bên em làm việc từ 8h00 - 20h00 tất cả các ngày trong tuần.\",\"author\":\"Thanh Duy\"},{\"time\":1656386138304,\"text\":\"có được trả góp không ?\",\"author\":\"Trần Văn B\"},{\"time\":1656386142514,\"text\":\"Bên em trả góp 0% ạ.\",\"author\":\"Thanh Duy\"},{\"time\":1656386162947,\"text\":\"ok cám ơn, tạm biệt\",\"author\":\"Trần Văn B\"},{\"time\":1656386165922,\"text\":\"Xin chào tạm biệt, rất mong chúng tôi đã giúp ích được cho quý khách.\",\"author\":\"Thanh Duy\"}]'),
(297, '2022-06-28 04:37:21', 'Thanh Duy', '{\"name\":\"Tran Van C\",\"email\":\"tranvanc@pavietnam.vn\",\"tel\":\"\",\"address\":\"\",\"company\":\"\",\"note\":\"\"}', '[{\"time\":1656390208213,\"text\":\"Quý khách cần mua sản phẩm nào?\",\"author\":\"Chatbot\"},{\"time\":1656390210709,\"text\":\"Gặp nhân viên tư vấn\",\"author\":\"Tran Van C\"},{\"time\":1656390210710,\"text\":\"Quý khách đã được kết nối tới nhân viên tư vấn: Thanh Duy\",\"author\":\"Chatbot\"},{\"time\":1656390220757,\"text\":\"xin chào\",\"author\":\"Tran Van C\"},{\"time\":1656390235347,\"text\":\"Vâng, Anh/Chị cần em hỗ trợ gì ạ ?\",\"author\":\"Thanh Duy\"},{\"time\":1656390286552,\"text\":\"xin chào\",\"author\":\"Thanh Duy\"},{\"time\":1656390303508,\"text\":\"123\",\"author\":\"Thanh Duy\"}]'),
(300, '2022-06-29 04:46:57', 'Thanh Duy', '{\"name\":\"Tran van a\",\"email\":\"tranvana@pavietnam.vn\",\"tel\":\"\",\"address\":\"\",\"company\":\"\",\"note\":\"\"}', '[{\"time\":1656477937428,\"text\":\"Quý khách cần mua sản phẩm nào?\",\"author\":\"Chatbot\"},{\"time\":1656477939277,\"text\":\"Tôi cần mua Iphone\",\"author\":\"Tran van a\"},{\"time\":1656477940653,\"text\":\"Tôi cần mua iphone 13\",\"author\":\"Tran van a\"},{\"time\":1656477941667,\"text\":\"Phiên bản pro\",\"author\":\"Tran van a\"},{\"time\":1656477943155,\"text\":\"Gặp nhân viên tư vấn\",\"author\":\"Tran van a\"},{\"time\":1656477943156,\"text\":\"Quý khách đã được kết nối tới nhân viên tư vấn: Thanh Duy\",\"author\":\"Chatbot\"},{\"time\":1656477950891,\"text\":\"xin chào\",\"author\":\"Tran van a\"},{\"time\":1656477955370,\"text\":\"Vâng, Anh/Chị cần em hỗ trợ gì ạ ?\",\"author\":\"Thanh Duy\"},{\"time\":1656477982636,\"text\":\"tôi muốn mua iphone X khuyến mãi\",\"author\":\"Tran van a\"},{\"time\":1656477986699,\"text\":\"Bên em đang có chương trình khuyến mãi tặng kèm sạc dự phòng 10.000mAh khi mua sản phẩm Iphone X ạ.\",\"author\":\"Thanh Duy\"},{\"time\":1656478003149,\"text\":\"làm sao để tới cửa hàng\",\"author\":\"Tran van a\"},{\"time\":1656478008827,\"text\":\"Vâng, anh/chị vui lòng tới 22 Cao Thắng để xem trực tiếp sản phẩm. cửa hàng bên em làm việc từ 8h00 - 20h00 tất cả các ngày trong tuần.\",\"author\":\"Thanh Duy\"}]'),
(301, '2022-06-29 04:51:11', '', '{\"name\":\"Lê Văn D\",\"email\":\"levand@gmail.com\",\"tel\":\"\",\"address\":\"\",\"company\":\"\",\"note\":\"\"}', '[{\"time\":1656478257274,\"text\":\"Quý khách cần mua sản phẩm nào?\",\"author\":\"Chatbot\"},{\"time\":1656478260562,\"text\":\"Tôi cần mua Iphone\",\"author\":\"Lê Văn D\"},{\"time\":1656478261409,\"text\":\"Tôi cần mua iphone 13\",\"author\":\"Lê Văn D\"},{\"time\":1656478262744,\"text\":\"Phiên bản pro\",\"author\":\"Lê Văn D\"}]'),
(302, '2022-06-29 06:52:24', '', '{\"name\":\"Lê Văn E\",\"email\":\"levane@gmail.com\",\"tel\":\"\",\"address\":\"\",\"company\":\"\",\"note\":\"\"}', '[{\"time\":1656485454889,\"text\":\"Quý khách cần mua sản phẩm nào?\",\"author\":\"Chatbot\"},{\"time\":1656485464728,\"text\":\"Tôi cần mua Iphone\",\"author\":\"Lê Văn E\"},{\"time\":1656485466046,\"text\":\"Tôi cần mua Iphone 11\",\"author\":\"Lê Văn E\"},{\"time\":1656485467111,\"text\":\"Gặp nhân viên tư vấn\",\"author\":\"Lê Văn E\"},{\"time\":1656485467111,\"text\":\"Xin lỗi hiện tại không có nhân viên nào online!\",\"author\":\"Chatbot\"},{\"time\":1656485467111,\"text\":\"Quý khách cần mua sản phẩm nào?\",\"author\":\"Chatbot\"},{\"time\":1656485518645,\"text\":\"liên hệ tư vấn với tôi qua email sớm nhất có thể\",\"author\":\"Lê Văn E\"}]'),
(304, '2022-07-02 03:37:54', 'Thanh Duy', '{\"name\":\"Lê Văn D\",\"email\":\"levand@gmail.com\",\"tel\":\"\",\"address\":\"\",\"company\":\"\",\"note\":\"\"}', '[{\"time\":1656728422666,\"text\":\"Quý khách cần mua sản phẩm nào?\",\"author\":\"Chatbot\"},{\"time\":1656728450333,\"text\":\"Tôi cần mua điện thoại SamSung\",\"author\":\"Lê Văn D\"},{\"time\":1656729000295,\"text\":\"Tôi muốn mua Note 9\",\"author\":\"Lê Văn D\"},{\"time\":1656729004494,\"text\":\"Gặp nhân viên tư vấn\",\"author\":\"Lê Văn D\"},{\"time\":1656729004495,\"text\":\"Quý khách đã được kết nối tới nhân viên tư vấn: Thanh Duy\",\"author\":\"Chatbot\"},{\"time\":1656729187326,\"text\":\"123\",\"author\":\"Lê Văn D\"},{\"time\":1656729206717,\"text\":\"123\",\"author\":\"Lê Văn D\"},{\"time\":1656729302734,\"text\":\"123\",\"author\":\"Lê Văn D\"},{\"time\":1656730523913,\"text\":\"xin chào\",\"author\":\"Lê Văn D\"},{\"time\":1656730527145,\"text\":\"Vâng, Anh/Chị cần em hỗ trợ gì ạ ?\",\"author\":\"Thanh Duy\"},{\"time\":1656731792446,\"text\":\"xin chào\",\"author\":\"Lê Văn D\"},{\"time\":1656731845584,\"text\":\"khuyễn mãi\",\"author\":\"Lê Văn D\"},{\"time\":1656731854444,\"text\":\"Bên em đang có chương trình khuyến mãi iphone X giảm giá lên đến 50%.\",\"author\":\"Thanh Duy\"},{\"time\":1656731866188,\"text\":\"123\\n123\\n123\",\"author\":\"Thanh Duy\"}]'),
(305, '2022-07-06 07:11:39', 'Thanh Duy', '{\"name\":\"Lê Văn D\",\"email\":\"levand@gmail.com\",\"tel\":\"\",\"address\":\"\",\"company\":\"\",\"note\":\"\"}', '[{\"time\":1657091365418,\"text\":\"Quý khách cần mua sản phẩm nào?\",\"author\":\"Chatbot\"},{\"time\":1657091379640,\"text\":\"Tôi cần mua điện thoại SamSung\",\"author\":\"Lê Văn D\"},{\"time\":1657091382062,\"text\":\"Tôi muốn mua Note 9\",\"author\":\"Lê Văn D\"},{\"time\":1657091409665,\"text\":\"Gặp nhân viên tư vấn\",\"author\":\"Lê Văn D\"},{\"time\":1657091409668,\"text\":\"Xin lỗi hiện tại không có nhân viên nào online!\",\"author\":\"Chatbot\"},{\"time\":1657091409668,\"text\":\"Quý khách cần mua sản phẩm nào?\",\"author\":\"Chatbot\"},{\"time\":1657091419285,\"text\":\"Gặp nhân viên tư vấn\",\"author\":\"Lê Văn D\"},{\"time\":1657091419285,\"text\":\"Quý khách đã được kết nối tới nhân viên tư vấn: Thanh Duy\",\"author\":\"Chatbot\"},{\"time\":1657091430001,\"text\":\"xin chào\",\"author\":\"Lê Văn D\"},{\"time\":1657091434034,\"text\":\"Vâng, Anh/Chị cần em hỗ trợ gì ạ ?\",\"author\":\"Thanh Duy\"},{\"time\":1657091471022,\"text\":\"bên mình có trả góp không ?\",\"author\":\"Lê Văn D\"},{\"time\":1657091474110,\"text\":\"Bên em trả góp 0% ạ.\",\"author\":\"Thanh Duy\"}]'),
(323, '2022-07-18 01:31:48', 'Thanh Duy', '{\"name\":\"Lê Văn D\",\"email\":\"levand@gmail.com\",\"tel\":\"\",\"address\":\"\",\"company\":\"\",\"note\":\"\"}', '[{\"time\":1658107498551,\"text\":\"Quý khách cần mua sản phẩm nào?\",\"author\":\"Chatbot\"},{\"time\":1658107548534,\"text\":\"Tôi cần mua Iphone\",\"author\":\"Lê Văn D\"},{\"time\":1658107550468,\"text\":\"Tôi cần mua iphone 13\",\"author\":\"Lê Văn D\"},{\"time\":1658107565949,\"text\":\"Phiên bản pro max\",\"author\":\"Lê Văn D\"},{\"time\":1658107567564,\"text\":\"Gặp nhân viên tư vấn\",\"author\":\"Lê Văn D\"},{\"time\":1658107567564,\"text\":\"Quý khách đã được kết nối tới nhân viên tư vấn: Thanh Duy\",\"author\":\"Chatbot\"},{\"time\":1658107578782,\"text\":\"xin chào\",\"author\":\"Lê Văn D\"},{\"time\":1658107608724,\"text\":\"khuyến mãi\",\"author\":\"Lê Văn D\"},{\"time\":1658107616350,\"text\":\"Bên em đang có chương trình khuyến mãi iphone X giảm giá lên đến 50%.\",\"author\":\"Thanh Duy\"}]'),
(326, '2022-07-19 04:20:49', 'Thanh Duy', '{\"name\":\"Lê Văn E\",\"email\":\"levane@gmail.com\",\"tel\":\"\",\"address\":\"\",\"company\":\"\",\"note\":\"\"}', '[{\"time\":1658204064057,\"text\":\"Xin chào, quý khách cần mua sản phẩm nào?\",\"author\":\"Chatbot\"},{\"time\":1658204188940,\"text\":\"Tôi cần mua điện thoại SamSung\",\"author\":\"Lê Văn E\"},{\"time\":1658204193522,\"text\":\"Tôi muốn mua Note 9\",\"author\":\"Lê Văn E\"},{\"time\":1658204197170,\"text\":\"Gặp nhân viên tư vấn\",\"author\":\"Lê Văn E\"},{\"time\":1658204197170,\"text\":\"Quý khách đã được kết nối tới nhân viên tư vấn: Thanh Duy\",\"author\":\"Chatbot\"},{\"time\":1658204228458,\"text\":\"Note 9 có đang khuyến mãi không ?\",\"author\":\"Lê Văn E\"},{\"time\":1658204268524,\"text\":\"Hiện tại, Note 9 không có khuyến mãi\",\"author\":\"Thanh Duy\"},{\"time\":1658204387185,\"text\":\"có hỗ trợ mua trả góp không\",\"author\":\"Lê Văn E\"},{\"time\":1658204391578,\"text\":\"Bên em trả góp 0% ạ.\",\"author\":\"Thanh Duy\"},{\"time\":1658204405836,\"text\":\"làm sao để tới cửa hàng\",\"author\":\"Lê Văn E\"},{\"time\":1658204409739,\"text\":\"Vâng, anh/chị vui lòng tới 22 Cao Thắng để xem trực tiếp sản phẩm. cửa hàng bên em làm việc từ 8h00 - 20h00 tất cả các ngày trong tuần.\",\"author\":\"Thanh Duy\"},{\"time\":1658204436301,\"text\":\"ok tạm biệt\",\"author\":\"Lê Văn E\"},{\"time\":1658204439531,\"text\":\"Xin chào tạm biệt, rất mong chúng tôi đã giúp ích được cho quý khách.\",\"author\":\"Thanh Duy\"}]'),
(329, '2022-07-20 04:23:14', 'Thanh Duy', '{\"name\":\"Tran Van A\",\"email\":\"tranvana@pavietnam.vn\",\"tel\":\"\",\"address\":\"\",\"company\":\"\",\"note\":\"\"}', '[{\"time\":1658290686911,\"text\":\"Xin chào, quý khách cần mua sản phẩm nào?\",\"author\":\"Chatbot\"},{\"time\":1658290733912,\"text\":\"Tôi cần mua Iphone\",\"author\":\"Tran Van A\"},{\"time\":1658290735129,\"text\":\"Tôi cần mua iphone 13\",\"author\":\"Tran Van A\"},{\"time\":1658290736739,\"text\":\"Phiên bản pro max\",\"author\":\"Tran Van A\"},{\"time\":1658290738073,\"text\":\"Gặp nhân viên tư vấn\",\"author\":\"Tran Van A\"},{\"time\":1658290738074,\"text\":\"Xin lỗi hiện tại không có nhân viên nào online!\",\"author\":\"Chatbot\"},{\"time\":1658290738074,\"text\":\"Xin chào, quý khách cần mua sản phẩm nào?\",\"author\":\"Chatbot\"},{\"time\":1658290787332,\"text\":\"Gặp nhân viên tư vấn\",\"author\":\"Tran Van A\"},{\"time\":1658290787332,\"text\":\"Quý khách đã được kết nối tới nhân viên tư vấn: Thanh Duy\",\"author\":\"Chatbot\"},{\"time\":1658290801465,\"text\":\"xin chào \",\"author\":\"Tran Van A\"},{\"time\":1658290812637,\"text\":\"Vâng, Anh/Chị cần em hỗ trợ gì ạ ?\",\"author\":\"Thanh Duy\"},{\"time\":1658290838573,\"text\":\"tôi cần bảo hành điện thoại\",\"author\":\"Tran Van A\"},{\"time\":1658290841961,\"text\":\"Thời hạn bảo hành tiêu chuẩn là 01 năm (12 tháng) áp dụng cho điện thoại và phụ kiện kèm theo.\",\"author\":\"Thanh Duy\"},{\"time\":1658290867853,\"text\":\"giờ làm việc như thế nào ?\",\"author\":\"Tran Van A\"},{\"time\":1658290870794,\"text\":\"Bên em làm việc từ 8h00 - 20h00 tất cả các ngày trong tuần.\",\"author\":\"Thanh Duy\"},{\"time\":1658290970818,\"text\":\"ok tạm biệt\",\"author\":\"Tran Van A\"},{\"time\":1658290982332,\"text\":\"Xin chào tạm biệt, rất mong chúng tôi đã giúp ích được cho quý khách.\",\"author\":\"Thanh Duy\"}]'),
(335, '2022-07-25 02:24:31', '', '{\"name\":\"Lê Văn D\",\"email\":\"levand@gmail.com\",\"tel\":\"\",\"address\":\"\",\"company\":\"\",\"note\":\"Hệ thống tự động kết thúc cuộc chat vì sau 5 phút không nhận được tin nhắn mới từ khách hàng\"}', '[{\"time\":1658715856763,\"text\":\"Xin chào, quý khách cần mua sản phẩm nào?\",\"author\":\"Chatbot\"},{\"time\":1658715862541,\"text\":\"Tôi cần mua Iphone\",\"author\":\"Lê Văn D\"}]'),
(337, '2022-07-25 02:38:14', 'Thanh Duy', '{\"name\":\"Lê Văn E\",\"email\":\"levane@gmail.com\",\"tel\":\"\",\"address\":\"\",\"company\":\"\",\"note\":\"Hệ thống tự động kết thúc cuộc chat vì sau 5 phút không nhận được tin nhắn mới từ khách hàng\"}', '[{\"time\":1658716663708,\"text\":\"Xin chào, quý khách cần mua sản phẩm nào?\",\"author\":\"Chatbot\"},{\"time\":1658716665132,\"text\":\"Gặp nhân viên tư vấn\",\"author\":\"Lê Văn E\"},{\"time\":1658716665133,\"text\":\"Quý khách đã được kết nối tới nhân viên tư vấn: Thanh Duy\",\"author\":\"Chatbot\"},{\"time\":1658716672457,\"text\":\"xin chào\",\"author\":\"Thanh Duy\"}]'),
(339, '2022-07-25 07:16:31', 'Thanh Duy', '{\"name\":\"Lê Văn E\",\"email\":\"levane@gmail.com\",\"tel\":\"\",\"address\":\"\",\"company\":\"\",\"note\":\"\"}', '[{\"time\":1658733336375,\"text\":\"Xin chào, quý khách cần mua sản phẩm nào?\",\"author\":\"Chatbot\"},{\"time\":1658733354819,\"text\":\"Gặp nhân viên tư vấn\",\"author\":\"Lê Văn E\"},{\"time\":1658733354820,\"text\":\"Quý khách đã được kết nối tới nhân viên tư vấn: Thanh Duy\",\"author\":\"Chatbot\"},{\"time\":1658733365013,\"text\":\"test\",\"author\":\"Lê Văn E\"},{\"time\":1658733373092,\"text\":\"mua điện thoại\",\"author\":\"Lê Văn E\"}]'),
(340, '2022-07-25 07:58:53', 'Thanh Duy', '{\"name\":\"Lê Văn E\",\"email\":\"levane@gmail.com\",\"tel\":\"\",\"address\":\"\",\"company\":\"\",\"note\":\"\"}', '[{\"time\":1658735899941,\"text\":\"Xin chào, quý khách cần mua sản phẩm nào?\",\"author\":\"Chatbot\"},{\"time\":1658735905842,\"text\":\"Gặp nhân viên tư vấn\",\"author\":\"Lê Văn E\"},{\"time\":1658735905843,\"text\":\"Quý khách đã được kết nối tới nhân viên tư vấn: Thanh Duy\",\"author\":\"Chatbot\"},{\"time\":1658735929393,\"text\":\"tôi gập sự cố cần hỗ trợ gấp\",\"author\":\"Lê Văn E\"}]'),
(345, '2022-07-26 03:16:02', 'Thanh Duy', '{\"name\":\"Lê Văn D\",\"email\":\"levand@gmail.com\",\"tel\":\"\",\"address\":\"\",\"company\":\"\",\"note\":\"\"}', '[{\"time\":1658805344890,\"text\":\"Xin chào, quý khách cần mua sản phẩm nào?\",\"author\":\"Chatbot\"},{\"time\":1658805345787,\"text\":\"Gặp nhân viên tư vấn\",\"author\":\"Lê Văn D\"},{\"time\":1658805345788,\"text\":\"Quý khách đã được kết nối tới nhân viên tư vấn: Thanh Duy\",\"author\":\"Chatbot\"},{\"time\":1658805354427,\"text\":\"test gửi mail khẩn cấp\",\"author\":\"Lê Văn D\"}]'),
(346, '2022-07-26 03:24:16', 'Thanh Duy', '{\"name\":\"Lê Văn E\",\"email\":\"levane@gmail.com\",\"tel\":\"\",\"address\":\"\",\"company\":\"\",\"note\":\"\"}', '[{\"time\":1658805810328,\"text\":\"Xin chào, quý khách cần mua sản phẩm nào?\",\"author\":\"Chatbot\"},{\"time\":1658805811695,\"text\":\"Gặp nhân viên tư vấn\",\"author\":\"Lê Văn E\"},{\"time\":1658805811698,\"text\":\"Quý khách đã được kết nối tới nhân viên tư vấn: Thanh Duy\",\"author\":\"Chatbot\"},{\"time\":1658805851044,\"text\":\"test nhiều từ khóa hỗ trợ gấp khẩn cấp\",\"author\":\"Lê Văn E\"}]');

-- --------------------------------------------------------

--
-- Table structure for table `scenario`
--

CREATE TABLE `scenario` (
  `scenario_id` bigint(20) NOT NULL,
  `title` varchar(100) NOT NULL,
  `content` varchar(500) NOT NULL,
  `type_id` smallint(6) NOT NULL COMMENT 'via scenario_type tabel',
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
(1559123198812, 'Welcome', 'Xin chào, quý khách cần mua sản phẩm nào?', 2, '', '', '', '0', 0, 0, 0, -1),
(1559124272653219, 'mua iphone', 'Tôi cần mua Iphone', 2, '', '', '', '0', 0, 0, 0, 1559123198812),
(1559124303469813, 'mua samsung', 'Tôi cần mua điện thoại SamSung', 2, '', '', '', '0', 0, 0, 0, 1559123198812),
(1559124351501525, 'S8', 'S8 Giảm giá 50%', 1, '', 'https://didongviet.vn/pub/media/catalog/product//s/a/samsung-galaxy-s8-cong-ty-didongviet.jpg', '', '0', 28, 254, 0, 1559124303469813),
(1559124364551494, 'Mua S8', 'Tôi muốn mua S8', 2, 'http://topgia.vn/ca-dien-thoai-samsung-9319', '', '', 'jump', 0, 0, 1559200800391247, 1559124303469813),
(1559124388561310, 'iphone 11', 'Tôi cần mua Iphone 11', 2, '', '', '', 'jump', 0, 0, 1559200800391247, 1559124272653219),
(1559124397681687, 'iphone X', 'Tôi cần mua iphone 10', 2, '', '', '', '0', 0, 0, 0, 1559124272653219),
(1559200800391247, 'Gặp nhân viên', 'Gặp nhân viên tư vấn', 3, '', '', '', '0', 28, 0, 0, 1559123198812),
(1560479664609837, 'Note 9', 'Tôi cần mua Note 9', 1, '', 'https://a.ipricegroup.com/media/1Ly/5cc370906539ab4bb90c4c1c61208270.jpg', '', '0', 28, 254, 0, 1559124303469813),
(1560479676898262, 'Mua Note9', 'Tôi muốn mua Note 9', 2, 'http://topgia.vn/ca-dien-thoai-samsung-9319', '', '', 'jump', 0, 0, 1559200800391247, 1559124303469813),
(1592212290542055, 'bản 128GB', 'Tôi cần phiên bản 128GB', 2, '', '', '', 'jump', 0, 0, 1559200800391247, 1559124397681687),
(1592212290542112, 'iphone 13', 'Tôi cần mua iphone 13', 2, '', '', '0', '0', 0, 0, 0, 1559124272653219),
(1592212290542113, 'iphone 13 pro', 'Phiên bản pro', 2, '', 'https://cdn.tgdd.vn/Products/Images/42/230521/iphone-13-pro-gold-1-600x600.jpg', '', 'jump', 0, 0, 1559200800391247, 1592212290542112),
(1592212290542114, 'iphone 13 mini', 'Phiên bản mini', 2, '', 'https://cdn.tgdd.vn/Products/Images/42/236780/iphone-13-mini-pink-1-600x600.jpg', '', 'jump', 0, 0, 1559200800391247, 1592212290542112),
(1592212290542115, 'iphone 13 pro max', 'Phiên bản pro max', 2, '', 'https://didongviet.vn/pub/media/catalog/product/i/p/iphone-13-pro-max-128gb-didongviet.jpg', '', 'jump', 0, 0, 1559200800391247, 1592212290542112);

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
-- Table structure for table `setting`
--

CREATE TABLE `setting` (
  `id` int(11) NOT NULL,
  `email_send` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `email_receive` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`email_receive`)),
  `keyword` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`keyword`)),
  `timeout` int(11) NOT NULL COMMENT 'unit: seconds'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `setting`
--

INSERT INTO `setting` (`id`, `email_send`, `password`, `email_receive`, `keyword`, `timeout`) VALUES
(1, 'chatbotpavietnam@gmail.com', 'zibldokwsrhaalzd', '[\"thanhduynguyen1842001@gmail.com\",\"thanhduyguyen@gmail.com\"]', '[\"su co\",\"ho tro gap\",\"khan cap\"]', 300);

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
(4, 'thu phi tan noi', 'Dạ, anh cho em địa chỉ để bên em tới thu phí tận nơi ạ.'),
(5, 'khuyen mai', 'Bên em đang có chương trình khuyến mãi iphone X giảm giá lên đến 50%.'),
(8, 'tam biet', 'Xin chào tạm biệt, rất mong chúng tôi đã giúp ích được cho quý khách.'),
(9, 'iphone x', 'Bên em đang có chương trình khuyến mãi tặng kèm sạc dự phòng 10.000mAh khi mua sản phẩm Iphone X ạ.'),
(10, 'thanh toan', 'Bên em hỗ trợ thanh toán cả bằng tiền mặt lẫn chuyển khoản.'),
(16, 'bao hanh', 'Thời hạn bảo hành tiêu chuẩn là 01 năm (12 tháng) áp dụng cho điện thoại và phụ kiện kèm theo.'),
(17, 'giao hang', 'Miễn phí giao hàng tận nơi trên toàn quốc. Anh/chị có thể cho em xin địa chỉ và số điện thoại liên lạc được không ạ?'),
(18, 'tra hang', 'Bên em không giải quyết đổi và trả hàng ạ.'),
(21, 'gio lam viec', 'Bên em làm việc từ 8h00 - 20h00 tất cả các ngày trong tuần.');

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
-- Indexes for table `setting`
--
ALTER TABLE `setting`
  ADD PRIMARY KEY (`id`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=348;

--
-- AUTO_INCREMENT for table `scenario`
--
ALTER TABLE `scenario`
  MODIFY `scenario_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1592212290542139;

--
-- AUTO_INCREMENT for table `scenario_type`
--
ALTER TABLE `scenario_type`
  MODIFY `type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `setting`
--
ALTER TABLE `setting`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `suggested_answers`
--
ALTER TABLE `suggested_answers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
