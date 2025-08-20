create user 'david1'@'localhost' identified by 'senha';
select * from mysql.user;
grant all privileges on *.* to 'david1'@'localhost';
flush privileges;

use biblioteca;


select * from livros;

