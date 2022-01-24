Create Database MyLibrary1
 Use MyLibrary1

Create Table Books
(
	Id int primary key identity,
	Name nvarchar(25) Check(LEN(Name) between 2 and 100),
	PageCount int not null Check(PageCount >= 10)
)

Create Table Authors
(
	Id int primary key identity,
	FirstName nvarchar(25),
	SurName nvarchar(25)
)

Create Table BookAuthor
(
	BookId int references Books(Id),
	AuthorId int references Authors(Id)
)


-- View Authors
Create View usv_GetID_Name_Page_Author
As
Select 
b.Id,b.Name,b.PageCount,(a.FirstName + ' ' + a.SurName) 'AuthorFullName'
From Books b
Join BookAuthor ba
on b.Id = ba.BookId
Join Authors a
on a.Id = ba.AuthorId

Select * From usv_GetID_Name_Page_Author
----->



--Get Values of Authors
Create Procedure usp_Get_ID_Name_Page_Author
@Name nvarchar(25)
As
Begin 
Select 
b.Id,b.Name,b.PageCount,(a.FirstName + ' ' + a.SurName) 'AuthorFullName'
From Books b
Join BookAuthor ba
on b.Id = ba.BookId
Join Authors a
on a.Id = ba.AuthorId
Where a.FirstName Like '%' + @Name + '%' or a.SurName Like '%' + @Name + '%'
End

exec usp_Get_ID_Name_Page_Author a
----->



--Insert Authors
Create Procedure usp_Insert_Autohors
(@FirstName nvarchar(25),
@SurName nvarchar(25))
As
Begin
Insert Into Authors(FirstName,SurName)
Values(@FirstName,@SurName)
End

exec usp_Insert_Autohors Ad,Soyad
----->


--Update Authors
Create Procedure usp_Update_Authors
(@Firstname nvarchar(25),
@SurName nvarchar(25),
@ChangeFName nvarchar(25),
@ChangeSName nvarchar(25))
As
Begin
Update Authors
Set FirstName = @Firstname,SurName = @SurName
Where FirstName = @ChangeFName and SurName = @ChangeSName
End

exec usp_Update_Authors Ad,Soyad,Ad,Soyad
----->


--Delete Authors
Create Procedure usp_Delete_Authors
(@FirstName nvarchar(25),
@SurName nvarchar(25))
As
Begin
Delete from Authors 
where FirstName = @FirstName and SurName = @SurName
End

exec usp_Delete_Authors Ad,Soyad
----->


--View MaxPageCount
Create View usv_Get_Id_Name_Coun_MaxPage
As
Select
a.Id,(A.FirstName +  ' ' + a.SurName) 'FullName',Count(a.Id) 'BooksCount ',Max(b.PageCount) 'MaxPageCount'
From Books b
Join BookAuthor ba
on b.Id = ba.BookId
Join Authors a
on a.Id = ba.AuthorId
Group by a.Id,a.FirstName,a.SurName

Select * From usv_Get_Id_Name_Coun_MaxPage
--
