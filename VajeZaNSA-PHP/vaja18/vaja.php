
/*
SERVER or HOST = 193.2.190.23
		PORT = 3306
		DATABASE=podatki
		USER=r4abcd
		PASSWORD=r4abcd_?#243

mysql -u r4abcd -h 193.2.190.23 -P 3306 -p
CALL createZbirka24('gasper2112','testtesttest');


CREATE TABLE obisk(
    id int PRIMARY KEY AUTO_INCREMENT,
    created_at timestamp DEFAULT now(),
    user varchar(50) DEFAULT current_user(),
    opomba varchar(50)    
)

insert into obisk(opomba) values('prvi poskus');

CREATE TABLE operacija(
    id int PRIMARY KEY AUTO_INCREMENT,
    operacija ENUM('sestej', 'odstej'),
    podatek1 int, 
    podatek2 int, 
    ob timestamp DEFAULT now()
);



*/
