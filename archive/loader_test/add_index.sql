ALTER TABLE `TEST` ADD INDEX `Composite` USING BTREE(`One More Field`, `id`);
ALTER TABLE `TEST` ADD INDEX `strkey` USING BTREE(`str`);
