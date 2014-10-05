create database our_pintrest;
create table user (
    user_id varchar(20) primary key,
    fname varchar(20) not null,
    lname varchar(20) not null,
    email varchar(20) not null,
    password varchar(20) not null,
    gender char(1),
    profile_pic_path varchar(100),
    address varchar(30),
    city varchar(20),
    zip varchar(10),
    country varchar(50),
    dob datetime,
    occuption varchar(50),
    phone_no varchar(15),
    created_date timestamp
);

create table friend (
    user_id varchar(20) not null references user (user_id),
    friend_id varchar(20) not null references user (user_id),
    request_status char(1),
    Request_sent_date datetime,
    Request_accepted_date datetime
);

create table picture (
    picture_id int primary key,
    source char(1),
    url varchar(200),
    tags varchar(100),
    picture_path varchar(100),
    uploaded_by varchar(20) not null references user (user_id)
    on delete cascade,
    uploaded_date timestamp
);

create table board (
    board_id int primary key,
    name varchar(20) not null,
    description text,
    category varchar(20),
    only_friends boolean default false,
    created_by varchar(20) not null references user (user_id)
    on delete cascade,
    created_date timestamp
);

create table pin (
    pin_id int,
    picture_id int not null references picture (picture_id)
    ON DELETE CASCADE,
    parent_pin_id int not null references pin_id,
    board_id int references board (board_id),
    description text,
    pinned_date timestamp,
    primary key (pin_id , picture_id)
);


#sign up two users 
insert into user(user_id,fname,lname,email,password,created_date) values('vnk260','venkatesh','k','vnk@gm.com','passwd1',now());
insert into user(user_id,fname,lname,email,password,created_date) values('skn260','santhosh','kn','skn@gm.com','passwd2',now());
insert into user(user_id,fname,lname,email,password,created_date) values('spk260','sunay','s','sun@gm.com','passwd3',now());

#Login
select user_id from user where user_id = 'skn260' and password = 'passwd2';

#edit profie for user skn260
update user 
set gender= 'm' ,address = '111th street brooklyn' , city = 'new york' ,zip= '1111'
where user_id= 'skn262';

#create board
insert into board values(1,'daino','I love daino','interests',FALSE,'skn260',now());
insert into board values(2,'birds','I love birds','animals and birds',TRUE,'skn260',now());
insert into board values(3,'god','I love god','spiritual',FALSE,'vkn260',now());
insert into board values(4,'my stuff','yes this is mine','personal',FALSE,'spk260',now());


#Pin a picture
#user Id will be in a variable
#w is for from website and l for from local machine
insert into picture values(1,'w','http://www.google.com','web,serach,google','/images/1.jpg','skn260',now());
insert into pin values (1,1,1,1,'my first image',now());

insert into picture values(2,'l',NULL,'god,spiritual','/images/2.jpg','vkn260',now());
insert into pin values (2,2,2,3,'my god image',now());

insert into picture values(3,'w','http://www.gmail.com','web,serach,gmail','/images/3.jpg','skn260',now());
insert into pin values (3,3,3,1,'my second image',now());

insert into picture values(4,'w','http://www.birds.com','bird,dove,god','/images/4.jpg','skn260',now());
insert into pin values (4,4,4,2,'my bird image',now());


#delete a pin  
#if pin_id = parent_pin_id
select picture_id from pin where pin_id = {given pin_id};   
delete from picture where picture_id = {selected picture_id}; # all the pins will be deleted has we have delete on cascade
#end of if  
#else
delete from pin where pin_id = {given pin_id};
#end else
#When pin or picture is deleted all its comments and likes will be deleted as it is delete on cascade 






create table follows (
    user_id varchar(20) not null references user (user_id)
    ON DELETE CASCADE,
    board_id int not null references board (board_id)
    ON DELETE CASCADE,
    followed_date timestamp,
    primary key (user_id , board_id)
);

create table likes (
    user_id varchar(20) not null references user (user_id)
    ON DELETE CASCADE,
    picture_id int not null references picture (picture_id)
    ON DELETE CASCADE,
    liked_date timestamp,
    primary key (user_id , picture_id)
);

create table comments (
    comment_id int primary key,
    user_id varchar(20) not null references user (user_id),
    pin_id int not null references pin (pin_id) ON DELETE CASCADE,
    comment_txt varchar(200) not null,
    commented_date timestamp
);

create table follow_stream (
    stream_id int primary key,
    stream_name varchar(50) not null,
    created_by varchar(20) not null references user (user_id)
    ON DELETE CASCADE,
    created_date timestamp,
    modified_date datetime
);

create table stream_boards (
    stream_id int not null references follow_stream (stream_id)
    ON DELETE CASCADE,
    board_id int not null references board (board_id)
    ON DELETE CASCADE,
    primary key (stream_id , board_id)
);


#send friend request from skn260 to vnk260  
insert into friend values ('skn260','vnk260','P',now(),NULL);

#accept friend request
SET SQL_SAFE_UPDATES=0;
update friend set request_status = 'A' , request_accepted_date = now() where user_id='skn260' and friend_id= 'vnk260';
insert into friend values ('vnk260','skn260','A',NULL,now());

#send friend request from skn260 to spk260  
insert into friend values ('skn260','spk260','P',now(),NULL);

#decline
delete from friend where user_id='skn260' and friend_id = 'spk260';


#repin picture with pin_id=1 to board where board_id = 4 

select parent_pin_id,picture_id from pin where pin_id = 1; #i.e. both are 1

insert into pin(pin_id,picture_id,parent_pin_id,board_id,description,pinned_date) values(5,1,1,4,'my repin',now());

#Creating a follow stream

insert into follow_stream (stream_id,stream_name,created_by,created_date,modified_date) values (1,'all boards','skn260',now(),now());

#adding boards to stream 
insert into stream_boards values (1,1);
insert into stream_boards values(1,2);

#display the photos 'here I only display paths'


#like a pin_id =4
select Picture_id from pin where pin_id =4; #it is 1
insert into likes values('skn260','1',now());


#comment on pin_id=4
select only_friends 
from board,pin
where board.board_id = pin.board_id and pin_id = 4; #returns true 

#if only friends is true 
select request_status from friend where user_id= 'vnk260' and friend_id = 'skn260';
  #if request_status equal 'A' yes they are friends
    insert into comments values(1,'skn260',4,'this friend comment',now());


#comment on pin_id=1
select only_friends 
from board,pin
where board.board_id = pin.board_id and pin_id = 1; #returns false 
#add comment 
insert into comments values(2,'vnk260',1,'this my comment',now());

select pic.picture_path,p.pin_id
from picture pic,pin p,stream_boards s 
where pic.picture_id = p.picture_id and p.board_id = s.board_id and s.stream_id = 1
order by p.pinned_date desc
;

#Search Query for ‘god’ # we have stored tags a comma separated value in picture table # will handle from for search term not to contain comma
Select p.pin_id, pic.picture_path From pin p ,picture pic where p.picture_id = pic.picture_id and pic.tags like '%god%' ;


