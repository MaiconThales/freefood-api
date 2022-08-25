use heroku_a0fc310850ff765;

CREATE TABLE `role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) DEFAULT NULL,
  `language` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `pic_byte` blob,
  `username` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `address` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `complement` varchar(255) DEFAULT NULL,
  `district` varchar(255) NOT NULL,
  `is_default` bit(1) NOT NULL,
  `number` bigint(20) NOT NULL,
  `street` varchar(255) NOT NULL,
  `id_user` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKpmtr515lcs96s5mnrhbakm097` (`id_user`),
  CONSTRAINT `FKpmtr515lcs96s5mnrhbakm097` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `restaurant` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `address` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `menu` (
  `id_menu` bigint(20) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `pic_byte` blob,
  `id_restaurant` bigint(20) NOT NULL,
  PRIMARY KEY (`id_menu`),
  KEY `FKccora8vcocfjwbkfwldqt7au2` (`id_restaurant`),
  CONSTRAINT `FKccora8vcocfjwbkfwldqt7au2` FOREIGN KEY (`id_restaurant`) REFERENCES `restaurant` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `refreshtoken` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `expiry_date` datetime NOT NULL,
  `token` varchar(255) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_or156wbneyk8noo4jstv55ii3` (`token`),
  KEY `FKfr75ge3iecdx26qe8afh1srf6` (`user_id`),
  CONSTRAINT `FKfr75ge3iecdx26qe8afh1srf6` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `request` (
  `id_request` bigint(20) NOT NULL AUTO_INCREMENT,
  `amount` bigint(20) NOT NULL,
  `observation` varchar(255) DEFAULT NULL,
  `id_address` bigint(20) NOT NULL,
  `id_menu` bigint(20) NOT NULL,
  PRIMARY KEY (`id_request`),
  KEY `FKogpce3xplpchc5166k8u4ydns` (`id_address`),
  KEY `FKse4bukqqu6q5uxpxsxdsasmae` (`id_menu`),
  CONSTRAINT `FKogpce3xplpchc5166k8u4ydns` FOREIGN KEY (`id_address`) REFERENCES `address` (`id`),
  CONSTRAINT `FKse4bukqqu6q5uxpxsxdsasmae` FOREIGN KEY (`id_menu`) REFERENCES `menu` (`id_menu`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `restaurant_user` (
  `restaurant_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`restaurant_id`,`user_id`),
  KEY `FK1575fj821kdil92areygq3mos` (`user_id`),
  CONSTRAINT `FK1575fj821kdil92areygq3mos` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FKld1n3fnv5cvi26j5kx5axs1uk` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurant` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `user_roles` (
  `user_id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `FKrhfovtciq1l558cw6udg0h0d3` (`role_id`),
  CONSTRAINT `FK55itppkw3i07do3h7qoclqd4k` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FKrhfovtciq1l558cw6udg0h0d3` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;