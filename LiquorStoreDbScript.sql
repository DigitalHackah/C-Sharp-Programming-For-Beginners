--Database creation
use master
go
create database LiquorStoreDB
go


--Table creation
use LiquorStoreDB
go
create table Products
(
  Barcode varchar(30) not null primary key,
	ProductName varchar(50) not null,			  -- NOT NULL=value cannot be empty/you have provide
	[Description] varchar(50) not null,			-- Square brackets because Description is a keyword in sql server
	CostPrice money default(0) not null,		  -- DEFAULT=value will be persisted to database if none is provided
	RetailPrice money default(0) not null,
	Quantity int default(0) not null
)
go


--Create stored procedure 
use LiquorStoreDB
go
create procedure sp_AddNewProduct			    -- procedure name
@Barcode varchar(30)						            -- 6 parameters expected
,@ProductName varchar(50)
,@Description varchar(50)
,@CostPrice money
,@RetailPrice money
,@Quantity int
as
begin try									                  -- Begin error handling
	begin tran                                -- Begin transaction
		insert into Products
		(Barcode, ProductName, [Description], CostPrice, RetailPrice, Quantity)
		values(@Barcode, @ProductName, @Description, @CostPrice, @RetailPrice, @Quantity);
	commit tran
end try
begin catch
	print error_message();
	if @@trancount > 0 begin
		rollback tran;
		end;                                     -- End transaction 
end catch;                                   -- End error handling 


