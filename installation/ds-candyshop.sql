CREATE TABLE IF NOT EXISTS `ds_candyshop` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `candyshopid` varchar(50) DEFAULT NULL,
  `owner` varchar(50) DEFAULT NULL,
  `rent` int(3) NOT NULL DEFAULT 0,
  `status` varchar(50) DEFAULT 'closed',
  `money` double(11,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `ds_candyshop_stock` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `candyshopid` varchar(50) DEFAULT NULL,
  `item` varchar(50) DEFAULT NULL,
  `stock` int(11) NOT NULL DEFAULT 0,
  `price` double(11,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `ds_candyshop` (`candyshopid`, `owner`, `money`) VALUES
('valcandyshop', 'vacant', 0.00),
('blacandyshop', 'vacant', 0.00),
('rhocandyshop', 'vacant', 0.00),
('doycandyshop', 'vacant', 0.00),
('strcandyshop', 'vacant', 0.00),
('oldcandyshop', 'vacant', 0.00),
('armcandyshop', 'vacant', 0.00),
('tumcandyshop', 'vacant', 0.00),
('guarcandyshop', 'vacant', 0.00);

INSERT INTO `management_funds` (`job_name`, `amount`, `type`) VALUES
('valcandyshop', 0, 'boss'),
('blacandyshop', 0, 'boss'),
('rhocandyshop', 0, 'boss'),
('doycandyshop', 0, 'boss'),
('strcandyshop', 0, 'boss'),
('oldcandyshop', 0, 'boss'),
('armcandyshop', 0, 'boss'),
('tumcandyshop', 0, 'boss'),
('guarcandyshop', 0, 'boss');