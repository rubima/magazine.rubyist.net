----------------------------------------------------------------------
-- DDL for MySQL
--   generated at Sun Oct 02 02:49:28 JST 2005
----------------------------------------------------------------------

-- グループマスタテーブル
create table groups (
   id                   integer              auto_increment primary key,
   name                 varchar(63)          not null,
   `desc`               varchar(255)         ,
   created_on           timestamp            not null,
   updated_on           timestamp            not null
);

-- ユーザマスタテーブル
create table users (
   id                   integer              auto_increment primary key,
   name                 varchar(63)          not null,
   `desc`               varchar(255)         ,
   email                varchar(63)          not null,
   group_id             integer              not null,  -- references groups.id
   age                  integer              ,
   gender               enum('M', 'F')       ,
   created_on           timestamp            not null,
   updated_on           timestamp            not null
);
