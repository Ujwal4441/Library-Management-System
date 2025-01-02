create database LMS;
use LMS;

CREATE TABLE Authors (
    AuthorID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Country VARCHAR(50)
);

CREATE TABLE Books (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(100) NOT NULL,
    AuthorID INT,
    Genre VARCHAR(50),
    PublishedYear INT,
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
);

CREATE TABLE Members (
    MemberID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    JoinDate DATE,
    Email VARCHAR(100)
);

CREATE TABLE Loans (
    LoanID INT AUTO_INCREMENT PRIMARY KEY,
    BookID INT,
    MemberID INT,
    LoanDate DATE,
    ReturnDate DATE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);


INSERT INTO Authors (Name, Country) VALUES
('Munna Micheal', 'UK'),
('Gujju Gangster', 'USA'),
('Mittu Don', 'UK'),
('Robin Hood','RUSSIA'),
('Gajni Bhai','INDIA'),
('Bachhan Pandey','INDIA'),
('Thomas Shelby','MEXICO'),
('John Wick','IRAN'),
('Vladimir Putin','EGYPT'),
('Pablo Escobar','PAKISTAN');

INSERT INTO Books (Title, AuthorID, Genre, PublishedYear) VALUES
('Harry Potter and the Philosopher\'s Stone', 1, 'Fantasy', 1997),
('A Game of Thrones', 2, 'Fantasy', 1996),
('The Hobbit', 3, 'Fantasy', 1937),
('The 5 AM Club',4,'Motivational',2013),
('Panchtrant',5,'Timepass',2022),
('Linear Algebra',6,'Math',2010),
('Doglapan',7,'Reality',2023),
('Rich Dad Poor Dad',8,'Inspiration',2015),
('GTA Vice City',9,'Entertainment',2003),
('Red Dead Redemption',10,'Gaming',2018);

INSERT INTO Members (Name, JoinDate, Email) VALUES
('Alice Johnson', '2023-01-15', 'alice@example.com'),
('Bob Smith', '2023-02-20', 'bob@example.com'),
('Charlie Brown', '2023-03-10', 'charlie@example.com'),
('David Williams', '2023-04-05', 'david@example.com'),
('Eve Davis', '2023-05-12', 'eve@example.com'),
('Frank Miller', '2023-06-18', 'frank@example.com'),
('Grace Lee', '2023-07-22', 'grace@example.com'),
('Hannah Wilson', '2023-08-30', 'hannah@example.com'),
('Ian Clark', '2023-09-15', 'ian@example.com'),
('Jack White', '2023-10-10', 'jack@example.com');

INSERT INTO Loans (BookID, MemberID, LoanDate, ReturnDate) VALUES
(1, 1, '2023-04-01', '2023-04-15'),
(2, 2, '2023-04-05', '2023-04-20'),
(3, 3, '2023-04-10', '2023-04-25'),
(4, 4, '2023-05-01', '2023-05-15'),
(5, 5, '2023-05-10', '2023-05-25'),
(6, 6, '2023-06-01', '2023-06-15'),
(7, 7, '2023-06-10', '2023-06-25'),
(8, 8, '2023-07-01', '2023-07-15'),
(9, 9, '2023-07-10', '2023-07-25'),
(10, 10, '2023-08-01', '2023-08-15');

-- 10 BASIC QUESTION ON LIBRARY MANAGEMENT SYSTEM

-- 1. List all the books in the library
select * from books;

-- 2. Find all the authors from India
select * from authors where country="INDIA";

-- 3. Get the details of all members who joined on the 15th date.
select * from members where day(JoinDate)=15;

-- 4.List all loans that have not been returned yet.
select * from Loans where ReturnDate is null;

-- 5.Find all the books which are published after the year 2002.
select * from books where PublishedYear > 2002;

-- 6. order the books by thier published year
select * from books order by PublishedYear;

-- 7.list all the members where second letter of the name is 'a'
select * from members where Name like '_a%';

-- 8.Get the details of all books in the ‘Fantasy’ genre.
select * from Books where Genre = 'Fantasy';

-- 9.Sort the Names of Authors by Ascensing Order
select * from authors order by Name;

-- 10.List all the books which are Publish between year 2000 to 2010.
select * from books where PublishedYear between 2000 and 2010;


-- 40 ADVANCED QUESTION ON LIBRARY MANAGEMENT SYSTEM

-- 1.FIND THE BOOK WHICH HAVE THE HIGHEST PRICE WITH NAME
select * from books order by Price desc limit 1;

-- 2.FIND THE BOOK WHICH HAVE THE LOWEST PRICE WITH NAME
select * from books order by Price limit 1;

-- 3.FIND THE TOTAL NUMBER OF BOOKS
select count(*) from books;

-- 4.FIND THE TOTAL NUMBER OF BOOKS IN EACH GENRE
select Genre, COUNT(*) as TotalBooks from Books group by Genre;

-- 5.LIST ALL BOOKS THAT HAVE NEVER BEEN BORROWED.
select Title FROM Books
where BookID not in (select BookID from Loans);

-- 6.FIND THE AVERAGE LOAN PERIOD FOR ALL BOOKS
select avg(DATEDIFF(ReturnDate, LoanDate)) as AvgLoanPeriod from Loans;

-- 7.GET THE DETAILS OF THE MOST RECENT LOAN
select * from Loans order by LoanDate desc limit 1;

-- 8.FIND THE TOTAL NUMBER OF LOANS FOR EACH MEMBER
select Members.Name, COUNT(Loans.LoanID) AS TotalLoans from Members join Loans on Members.MemberID = Loans.MemberID group by Members.Name;

-- 9. LIST ALL BOOKS THAT HAVE BEEN BORROWED MORE THAN ONCE
select Books.Title, count(Loans.LoanID) as TotalLoans
from Loans join Books on Loans.BookID = Books.BookID group by Books.Title having TotalLoans > 1;

-- 10. RETRIEVE ALL DATA FROM AUTHORS AND BOOKS TABLE
select * from authors as a join books as b on a.AuthorID=b.AuthorID;

-- 11. CONCATE AUTHOR NAME AND TITLE FROM BOOKS TABLE
select concat(a.Name,' = ',b.Title) As Author_And_Book from authors as a join books as b on a.AuthorID=b.AuthorID;

-- 12.RETRIVE MEMBERS AND THIER LOAN DATE 
select m.Name,l.LoanDate from members as m join loans as l on m.MemberID=l.MemberID;

-- 13.RETRIVE AUTHOR NAME, TITLE NAME AND ITS PRICE WHO HAVE PRICE > 2000
select a.Name,b.Price from authors as a join books as b on a.AuthorID=b.AuthorID where b.price>2000;

-- 14.FIND TOTAL NUMBER OF MEMBERS WHO JOINED EACH MONTH IN 2023
select month(JoinDate) as month, COUNT(*) as TotalMembers from Members where year(JoinDate) = 2023 group BY month(JoinDate);

-- 15.GET THE DETAILS OF ALL BOOKS WRITTEN BY AUTHORS FROM USA
select b.Title, a.Name, a.Country from Books as b join Authors as a on b.AuthorID = a.AuthorID where a.Country = 'USA';

-- 16. RETRIVE BOOKS AND GROUP THEM ON THE GENRE
select genre,count(genre) from books group by genre;

-- 17. Find average price of books
select avg(Price) from books;

-- 18. FIND ALL TOTAL NUMBER OF BOOKS BORROWED IN EACH GENRE IN LAST 2 MONTHS.
select Books.Genre, count(Loans.LoanID), Loans.LoanDate AS TotalBorrowed from Loans join Books on Loans.BookID = Books.BookID 
group by Loans.LoanID order by Loans.LoanDate Desc limit 2;

-- 19. FIND THE 5TH EXPENSIVE BOOK.
select * from books order by Price desc limit 4,1;

-- 20. CREATE A VIEW OF AUTHORS TABLE
create view Books_and_Authors as select * from authors;

-- 21. EXTARCT ONLY MONTHS FROM LOANS TABLE
select month(loandate) from loans;

-- 22. RETIRVE AUTHORS GROUP BY THIER COUNTRY AND THIER COUNTRY
select Country ,count(*) from authors group by Country;

-- 23. FIND THE DIFFERENCE OF DAYS BETWEEN LOAN DATE AND RETURN DATE FROM THE LOANS TABLE
select datediff(loandate,returndate) as Time_Period from loans;

-- 24. JOIN 3 TABLES AUTHORS, BOOKS AND MEMBERS
select * from Books as b join Authors as a on b.AuthorID = a.AuthorID join members as m on a.AuthorID=m.MemberID;

-- 25. RETRIE ALL TE REORDS FROM AUTORS TABLE WEERE NAME STARTS WITH 'M' OR 'G' LETTER
select * from authors where name like 'M%' OR name LIKE 'G%';

-- 26. RETRIVE THE NAMES OF MEMBERS FROM THE INDEX 5 TO 7 CHARACTERS
select substr(name,5,7) from members;

-- 27.CONVERT ALL THE COUNTRY NAME TO LOWER CASE
select lower(country) from authors;

-- 28.FIND THE SECOND HIGHEST PRICE OF A BOOK USING SUBQUERY
select max(price) from books where price < (select max(price) from books);

-- 29.RETRIVE NAMES OF MEMBERS WHERE NAME CONSIST OF ONLY 9 LETTERS
select * from members where name like '_________';

-- 30. RETRIVE AUTHOR,BOOK TITLE AND PUBLISHED YEAR
select a.name,b.title,b.publishedyear from Books as b join Authors as a on b.AuthorID = a.AuthorID;

-- 31. ORDER THE BOOK TITLES ACCORDING TO LATEST YEAR
select * from books order by publishedyear desc;

-- 32. RETRIVE BOOKS WHERE GENRE SECOND LETTER IS 'a'
select * from books where Genre like '_a%';

-- 33. RETRIVE BOOKS WHERE PRICE PRICE IS BETWEEN 1000 TO 2000 and BETWEEN 3000 TO 4000
select * from books where price between 1000 and 2000 or price between 3000 and 4000;

-- 34. SELECT ALL RECORDS FROM LOANS TABLE WHERE RETURNDATE IS 15th
select * from loans where day(returndate)=15;

-- 35.RETRIVE ALL RECORDS FROM MEMBERS TABLE WHERE MEMBERS JOINED IN FIRST 6 MONTHS
select * from members where joindate between '2023-01-01' and '2023-06-01';

-- 36. RETRIVE COUNTRIES WHERE COUNTRY NAME ENDS WITH LETTER '%A'
select * from authors where country like '%A';

-- 37. UPDATE TABLE AUTHORS CHNAGE COUNTRY USA TO UKRAINE
update authors
set country='UKRAINE'
where country='USA';

-- 38. RETRIVE LAST 5 RECORDS FROM AUTHORS AND BOOKS TABLE
select * from Books as b join Authors as a on b.AuthorID = a.AuthorID order by a.AuthorID desc limit 5;

-- 39. PRINT TITLES AND GENRES FROM AUTHOR TABLE
select Title,Genre from books;

-- 40. RETRIVE RECORDS ORDER BY PRICE IN ASC ORDER
select * from books order by price;





