----------------------------------------------------------------------
-- DDL for PostgreSQL
--   generated at Sun Oct 02 02:49:28 JST 2005
----------------------------------------------------------------------

-- グループマスタテーブル
create table groups (
   id                   serial               primary key,
   name                 varchar(63)          not null,
   "desc"               varchar(255)         ,
   created_on           timestamp            not null,
   updated_on           timestamp            not null
);

-- ユーザマスタテーブル
create table users (
   id                   serial               primary key,
   name                 varchar(63)          not null,
   "desc"               varchar(255)         ,
   email                varchar(63)          not null,
   group_id             integer              not null references groups(id),
   age                  integer              ,
   gender               varchar(1)           ,  -- M,F
   created_on           timestamp            not null,
   updated_on           timestamp            not null
);
