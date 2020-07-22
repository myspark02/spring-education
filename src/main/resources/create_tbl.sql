 CREATE TABLE tbl_board (
 	bno INT primary key AUTO_INCREMENT, 
 	title VARCHAR(200) NOT NULL, 
 	content VARCHAR(20000) NOT NULL,
 	writer VARCHAR(50) NOT NULL, 
 	regdate DATETIME DEFAULT NOW(), 
 	updatedate DATETIME DEFAULT NOW()
 	);
 	
 	
 	create table tbl_reply (
 		rno int primary key auto_increment,
 		bno int references tbl_board(bno), 
 		reply varchar(1000) not null,
 		replyer varchar(50) not null,
 		replyDate datetime default now(),
 		updateDate datetime default now()
 	)