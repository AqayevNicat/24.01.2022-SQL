Create Database MyDatabase

use MyDatabase

Create Table Brands
(
	Id int primary key identity,
	Name nvarchar(25)
)
-- 1)
Create Table Notebooks
(
	Id int primary key identity,
	Name nvarchar(25),
	Price money,
	NoteBookBrandId int references Brands(Id)
)
-- 2)
Create Table Phones
(
	Id int primary key identity,
	Name nvarchar(25),
	Price money,
	PhonesBrandId int references Brands(Id)
)
-- 3)
Select
n.Name,b.Name 'BrandName',n.Price
From Notebooks n
Right Join Brands b
on n.NoteBookBrandId = b.Id

-- 4)
Select
p.Name,b.Name 'BrandName',p.Price
From Phones p
Join Brands b
on p.PhonesBrandId = b.Id

-- 5)
Select 
n.Name,n.Price,b.Name 'BrandName'
From Notebooks n
Join Brands b
on n.NoteBookBrandId = b.Id
Where b.Name Like '%s%'

--6)
Select
*
From Notebooks n
Where n.Price between 2000 and 5000 or n.Price > 5000

Select
*
From Notebooks n
Where n.Price >= 2000

--7)
Select
*
From Phones p
Where p.Price between 1000 and 1500 or p.Price > 1500

Select
*
From Phones p
Where p.Price >= 1000

-- 8)
Select
b.Name,COUNT(b.Name) 'Count of NoteBook'
From Notebooks n
Join Brands b
on n.NoteBookBrandId = b.Id
Group  by b.Name

--9)
Select 
b.Name,COUNT(b.Name) 'Count of Phones'
From Phones p
Join Brands b
on p.PhonesBrandId = b.Id
Group by b.Name

-- 10)
Select n.Name,n.NoteBookBrandId 'BrandId' From Notebooks n
union
Select p.Name,p.PhonesBrandId From Phones p

--11)
Select n.Id,n.Name,n.Price,n.NoteBookBrandId 'BrandId' From Notebooks n
union
Select p.Id,p.Name,p.Price,p.PhonesBrandId From Phones p

-- 12)
Select n.Id,n.Name,n.Price,n.NoteBookBrandId,b.Name 'BrandsName' From Notebooks n
Join Brands b
on n.NoteBookBrandId = b.Id
union
Select p.Id,p.Name,p.Price,p.PhonesBrandId,b.Name From Phones p
Join Brands b
on p.PhonesBrandId = b.Id

-- 13)
Select * from (
	Select n.Id,n.Name,n.NoteBookBrandId,n.Price,b.Name 'BrandsName' From Notebooks n
	Join Brands b
	on n.NoteBookBrandId = b.Id
	union
	Select p.Id,p.Name,p.PhonesBrandId,p.Price,b.Name From Phones p
	Join Brands b
	on p.PhonesBrandId = b.Id
) as [s] Where Price > 1000

-- 14)
Select
 b.Name 'BrandName',SUM(p.Price) 'TotalPrice ', Count(b.Name) 'ProductCount'
From Brands b
Join Phones p
on p.PhonesBrandId = b.Id
Group by b.Name

-- 15)
Select
 b.Name 'BrandName',SUM(n.Price) 'TotalPrice ', Count(b.Name) 'ProductCount'
From Brands b
Join Notebooks n
on n.NoteBookBrandId = b.Id
Group by b.Name
Having Count(b.Name) > 2