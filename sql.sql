-- create table books
CREATE TABLE Books(
Book_id SERIAL PRIMARY KEY,
Title VARCHAR(100),
Author VARCHAR(100),
Genre VARCHAR(50),
Published_Year INT,
Price NUMERIC(10,2),
Stock INT
);
select * from Books;

-- create table customers
CREATE TABLE Customers(
Customer_id SERIAL PRIMARY KEY,
Name VARCHAR(100),
Email VARCHAR(100),
Phone VARCHAR(15),
City VARCHAR(50),
Country VARCHAR(150)
);
SELECT * FROM Customers;

-- create tables orders
CREATE TABLE Orders(
Order_id SERIAL PRIMARY KEY,
Customer_id INT REFERENCES Customers(Customer_id),
Book_id INT REFERENCES Books(Book_id),
Order_date DATE,
Quantity INT,
Total_amount NUMERIC(10,2)
);
SELECT * FROM Orders;

--Retrieve all books in the "Fiction" genre:
 select * from Books 
 where  genre = 'Fiction';

-- Find books published after the year 1950:
select * from Books
where published_year>1950;

-- List all customers from the Canada:
select * from Customers 
where country = 'Canada';

-- Show orders placed in November 2023:
select * from orders 
where order_date between '2023-11-01' AND '2023-11-30';

-- Retrieve the total stock of books available:
select sum(stock)
from Books;

-- Find the details of the most expensive book:
select * from Books 
order by price DESC
limit 1;

-- Show all customers who ordered more than 1 quantity of a book:
select * from Orders 
where quantity>1;

-- Retrieve all orders where the total amount exceeds $20:
select * from Orders 
where total_amount >20;

-- List all genres available in the Books table:
select genre from Books;

-- Find the book with the lowest stock:
select * from Books 
order by stock ASC
LIMIT 1;

-- Calculate the total revenue generated from all orders:
SELECT sum(total_amount) as total_revenue FROM Orders;

-- Retrieve the total number of books sold for each genre:
select * from Books;
select b.genre , sum(o.quantity) as total_book_sold
from Orders o
join Books b on b.book_id=o.book_id
group by b.genre;

-- Find the average price of books in the "Fantasy" genre:
select avg(price) from Books
where genre='Fantasy';

-- Show the top 3 most expensive books of 'Fantasy' Genre :
select * from Books 
where genre='Fantasy'
order by price desc
limit 3;

-- List customers who have placed at least 2 orders:
SELECT o.customer_id, c.name, COUNT(o.Order_id) AS ORDER_COUNT
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
GROUP BY o.customer_id, c.name
HAVING COUNT(Order_id) >=2;

-- Find the most frequently ordered book:
select * from Orders;
select * from Books;

SELECT o.Book_id, b.title, COUNT(o.order_id) AS ORDER_COUNT
FROM orders o
JOIN books b ON o.book_id=b.book_id
GROUP BY o.book_id, b.title
ORDER BY ORDER_COUNT DESC LIMIT 1;

-- Retrieve the total quantity of books sold by each author:
select sum(o.quantity) as total_qty_books, b.author
from  Orders o
join Books b on b.book_id=o.book_id
group by b.author;

-- List the cities where customers who spent over $30 are located:
select * from Customers;
select distinct c.city , total_amount 
from Orders o
join Customers c on o.customer_id=c.customer_id
where  o.total_amount >30;

-- Find the customer who spent the most on orders:
select c.customer_id,  c.name ,  sum(o.total_amount) as total_spent
from orders o
join customers c on c. customer_id=o.customer_id 
group by c.name , c.customer_id 
order by total_spent desc
limit 1;

