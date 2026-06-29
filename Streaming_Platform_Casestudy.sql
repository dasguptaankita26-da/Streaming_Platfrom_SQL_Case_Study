create database Streaming_Platforms;
use Streaming_Platforms;

create table Subscriptions(sub_id int primary key,
user_id int NOT NUll,
plan varchar(50) not null,
payment_date Date not null,
amount int not null,
end_date date not null);

INSERT INTO subscriptions (sub_id, user_id, plan, payment_date, amount, end_date)
VALUES 
    (1, 101, 'Premium', '2023-01-15', 799, '2024-01-19'),
    (2, 101, 'Basic', '2024-01-20', 499, '2025-07-05'),
    (3, 103, 'Premium', '2023-02-01', 799, '2023-03-01'),
    (4, 104, 'Standard', '2023-03-05', 599, '2023-04-05');
    
CREATE TABLE content (
    content_id VARCHAR(10) PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    genre VARCHAR(50),
    release_date DATE,
    content_type VARCHAR(50));
    
INSERT INTO content (content_id, title, genre, release_date, content_type)
VALUES 
    ('C001', 'Speed Chase', 'Action', '2022-12-01', 'Movie'),
    ('C002', 'Calm Waters', 'Drama', '2023-01-01', 'Series'),
    ('C003', 'Laugh Riot', 'Comedy', '2022-11-15', 'Standup');
    
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    signup_date DATE NOT NULL,
    country VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20),
    advertising_id VARCHAR(20)
);
INSERT INTO users (user_id, name, signup_date, country, email, phone, advertising_id)
VALUES 
    (101, 'Aditi Singh', '2023-01-15', 'India', 'aditi@email.com', '9999999999', 'ADV101'),
    (102, 'John Doe', '2023-01-20', 'USA', 'john@email.com', '8889990007', 'ADV102'),
    (103, 'Maria Chen', '2023-02-01', 'Singapore', 'maria@email.com', '1246789876', 'ADV103'),
    (104, 'Omar Ali', '2023-03-05', 'UAE', 'omar@email.com', '0009995543', 'ADV104');
CREATE TABLE viewing_history (
    view_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    content_id VARCHAR(10) NOT NULL,
    watch_date DATE NOT NULL,
    watch_time_minutes INT NOT NULL
);

INSERT INTO viewing_history (view_id, user_id, content_id, watch_date, watch_time_minutes)
VALUES 
    (1, 101, 'C001', '2023-01-16', 45),
    (2, 101, 'C002', '2023-01-17', 90),
    (3, 102, 'C001', '2023-01-20', 30),
    (4, 103, 'C003', '2023-02-02', 60),
    (5, 104, 'C002', '2023-03-06', 120);
    
    
-- Link viewing_history to users table
ALTER TABLE viewing_history 
ADD CONSTRAINT fk_viewing_user 
FOREIGN KEY (user_id) REFERENCES users(user_id);

-- Link viewing_history to content table  
ALTER TABLE viewing_history 
ADD CONSTRAINT fk_viewing_content 
FOREIGN KEY (content_id) REFERENCES content(content_id);

-- Link subscriptions to users table
ALTER TABLE subscriptions 
ADD CONSTRAINT fk_sub_user 
FOREIGN KEY (user_id) REFERENCES users(user_id);




-- 1. Write a query to return the number of movies and series watched by each user 
   -- who have watched more than 100 mins in total?
 select a.user_id,sum(case when b.content_type="Movie" then 1 else 0 end) as Movies,
sum(case when b.content_type="Series" then 1 else 0 end) as Series
from viewing_history a join content b on 
a.content_id=b.content_id
where a.user_id in (select user_id
from viewing_history
group by 1
having sum(watch_time_minutes)>100)
group by 1;

-- 2)Retrieve the latest subscription amount for each user.
with cte1 as (
select user_id,max(payment_date) as latest_subscription
from subscriptions
group by 1)

select a.user_id,a.latest_subscription,sum(b.amount) as TotalAmount
from cte1 a join subscriptions b on 
a.user_id=b.user_id
and a.latest_subscription=b.payment_date
group by 1,2;

-- 3) Find users who have both premium and basic subscriptions.
select user_id
from subscriptions
where plan in ("Premium","Basic")
group by user_id
having count(distinct plan) = 2;

-- 4)Calculate the number of users who were active in the month of January 2023
   -- and also active in the next month?
select count(distinct a.user_id)
from viewing_history a join viewing_history b on
a.user_id=b.user_id
where month(a.watch_date)=1 and year(a.watch_date)=2023
and month(b.watch_date)=2 and year(b.watch_date)=2023;

-- 5)For each user, identify the first piece of content they watched after signup
with cte1 as (
select user_id,min(watch_date) as First_join_date
 from viewing_history
 group by 1
 ),cte2 as(
 select user_id,content_id,watch_date
 from viewing_history)
 select a.user_id,b.content_id
 from cte1 a join cte2 b on 
 a.user_id=b.user_id and 
 a.first_join_date=b.watch_date;
 
 -- 6) Find new and renewed subscriptions
 select user_id,
case 
    when count(*) = 1 then 'New'
    else 'Renewed'
end as user_type
from subscriptions
group by user_id;

-- to find latest subscription
select *
from subscriptions s
where payment_date = (
    select min(payment_date)
    from subscriptions
    where user_id = s.user_id
);
 