/*!40101 SET NAMES binary*/;
/*!40014 SET FOREIGN_KEY_CHECKS=0*/;

CREATE TABLE `TEST` (
  `id` int(11) NOT NULL,
  `str` varchar(100) DEFAULT NULL,
  `One More Field` varchar(20) DEFAULT NULL,
  `Final Field` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `Composite` (`One More Field`,`id`) USING BTREE,
  KEY `strkey` (`str`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
