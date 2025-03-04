create database HotelManagement_OOP
go
use HotelManagement_OOP
go

create table Staff
(
	StaffId varchar(10),
	StaffName nvarchar(max),
	PhoneNumber nvarchar(max),
	StaffAddress nvarchar(max),  -- moi thêm 
	Email varchar(max),
	CCCD varchar(12),
	DateOfBirth DateTime,	
	Gender nvarchar(10),
	Position nvarchar(max),
	Username nvarchar(max),
	Password nvarchar(max),
	Avatar varbinary(max),-- moi
	dateOfStart DateTime,	-- mới thêm
	IsDeleted bit		-- mới

	constraint PK_Staff primary key (StaffId),
)
go



create table RoomType (
	RoomTypeId varchar(10),
	RoomTypeName nvarchar(max), /* sua */
	Price float,
	MaxNumberGuest int,
	NumberGuestForUnitPrice int,
	constraint PK_RoomType primary key (RoomTypeId)
)
go



create table Room 
(
	RoomId varchar(10),
	RoomNumber int,
    RoomTypeId varchar(10),
	Note nvarchar(max),
	RoomStatus nvarchar(max),

	constraint PK_Room primary key(RoomId),
	constraint FK_Room_RoomType foreign key(RoomTypeId) references RoomType(RoomTypeId) 
)
go

create table Furniture 
(
	FurnitureId varchar(10),
	FurnitureName nvarchar(max),
	FurnitureType nvarchar(max),
	FurnitureAvatar varbinary(max),
	QuantityOfStorage int,
	constraint PK_Furniture primary key(FurnitureId),
)
go

create table RoomTypeFurniture
(
	RoomTypeFurnitureId varchar(10),
	FurnitureId varchar(10),
	RoomTypeId varchar(10),
	Quantity int,
	constraint PK_RoomTypeFurniture primary key(RoomTypeFurnitureId),
	constraint FK_RoomTypeFurniture_Furniture foreign key(FurnitureId) references Furniture(FurnitureId), 
	constraint FK_RoomTypeFurniture_RoomType foreign key(RoomTypeId) references RoomType(RoomTypeId)

)
go


create table FurnitureReceipt (
	FurnitureReceiptId varchar(10),
	StaffId varchar(10),
	Price float default 0,
	CreateAt DateTime,

	constraint PK_FurnitureReceipt primary key (FurnitureReceiptId),
	constraint FK_FurnitureReceipt_Staff foreign key (StaffId) references Staff(StaffId)

)
go

create table FurnitureReceiptDetail (
	FurnitureReceiptDetailId varchar(10),
	FurnitureReceiptId varchar(10),
	FurnitureId varchar(10),
	ImportPrice float,
	Quantity int,
	constraint PK_FurnitureReceiptDetail primary key (FurnitureReceiptDetailId),
	constraint FK_FurnitureReceiptDetail_FurnitureReceipt foreign key (FurnitureReceiptId) references FurnitureReceipt(FurnitureReceiptId),
	constraint FK_FurnitureReceiptDetail_Furniture foreign key (FurnitureId) references Furniture(FurnitureId)
)
go


create table RentalContract (
	RentalContractId varchar(10),
	StaffId varchar(10),
	RoomId varchar(10),
	StartDate datetime,
	EndDate datetime,
	RentalPrice float,
	Validated bit,

	constraint PK_RentalContract primary key (RentalContractId),
	constraint FK_RentalContract_Staff foreign key (StaffId) references Staff(StaffId),
	constraint FK_RentalContract_Room foreign key (RoomId) references Room(RoomId),
)
go

create table RentalContractDetail (
	RentalContractDetailId int identity(1,1),
	RentalContractId varchar(10),
	CustomerName nvarchar(max),
	CustomerId varchar(12)


	constraint PK_RentalContractDetail primary key (RentalContractDetailId),
	constraint FK_RentalContractDetail_RentalContract foreign key (RentalContractId) references RentalContract(RentalContractId),
	
)
go



create table Product (
	ProductId varchar(10),
	ProductName nvarchar(max),
	ProductType nvarchar(max),
	Price float,
	QuantityOfStorage int,
	ProductAvatar varbinary(max),
	constraint PK_Product primary key (ProductId)
)
go



create table ProductReceipt (
	ProductReceiptId varchar(10),
	StaffId varchar(10),
	Price float default 0,
	CreateAt DateTime,

	constraint PK_ProductReceipt primary key (ProductReceiptId),
	constraint FK_ProductReceipt_Staff foreign key (StaffId) references Staff(StaffId)

)
go


create table ProductReceiptDetail (
	ProductReceiptDetailId varchar(10),
	ProductReceiptId varchar(10),
	ProductId varchar(10),
	ImportPrice float,
	Quantity int,
	constraint PK_ProductReceiptDetail primary key (ProductReceiptDetailId),
	constraint FK_ProductReceiptDetail_ProductReceipt foreign key (ProductReceiptId) references ProductReceipt(ProductReceiptId),
	constraint FK_ProductReceiptDetail_Product foreign key (ProductId) references Product(ProductId)
)
go

create table ProductUsing (
	ProductUsingId int identity(1,1),
	ProductId varchar(10),
	RentalContractId varchar(10),
	UnitPrice float,
	Quantity int,

	constraint PK_ProductUsing primary key (ProductUsingId),

	constraint FK_ProductUsing_Product foreign key(ProductId) references Product(ProductId),
	constraint FK_ProductUsing_RentalContract foreign key(RentalContractId) references RentalContract(RentalContractId)
)
go

create table Trouble (
	TroubleId varchar(10),
	StaffId varchar(10),
	Title nvarchar(max),
	Avatar varbinary(max),  -- mois
	Description nvarchar(max),
	StartDate datetime,
	FixedDate datetime,
	FinishDate datetime,
	Status nvarchar(max),
	Price float,	
	Level nvarchar(max),

	constraint PK_Trouble primary key (TroubleId),
	constraint FK_Trouble_Staff foreign key(StaffId) references Staff(StaffId),
)
go




create table Bill (
	BillId varchar(10),
	RentalContractId varchar(10),
	StaffId varchar(10),
	TotalPrice float,
	CreateDate datetime,

	constraint PK_Bill primary key (BillId),
	constraint FK_Bill_RentalContract foreign key (RentalContractId) references RentalContract(RentalContractId),
	constraint FK_Bill_Staff foreign key (StaffId) references Staff(StaffId),
)
go


create table Parameter (
	ParameterId int identity(1,1),
	ParameterKey varchar(max),
	ParameterValue float,
	constraint PK_Parameter primary key (ParameterId),
)
go

insert into Parameter values ('TiLeGiuaGiaBanVaGiaNhap',1)
go

create table SurchargeRate (
	SurchargeRateId int identity(1,1),
	RoomTypeId varchar(10),
	CustomerOutIndex int,
	Rate float
	constraint PK_SurchargeRate primary key (SurchargeRateId),
	constraint FK_PK_SurchargeRate_RoomType foreign key (RoomTypeId) references RoomType(RoomTypeId),

)
go

create table Revenue (
	RevenueId int identity(1,1),
	Month int,
	Year int,
	constraint PK_Revenue primary key (RevenueId),
)
go

create table RevenueRoomType (
	RevenueRoomTypeId int identity(1,1),
	RevenueId int,
	RoomTypeId varchar(10),
	Revenue float,
	Ratio float,
	
	constraint PK_RevenueRoomTypeId primary key (RevenueRoomTypeId),
	constraint FK_RevenueRoomType_Revenue foreign key (RevenueId) references Revenue(RevenueId),
	constraint FK_RevenueRoomType_RoomType foreign key (RoomTypeId) references RoomType(RoomTypeId),

)
go




create table RevenueProduct (
	RevenueProductId int identity(1,1),
	RevenueId int,
	ProductId varchar(10),
	Revenue float,
	Ratio float,
	
	constraint PK_RevenueProduct primary key (RevenueProductId),
	constraint FK_RevenueProduct_Revenue foreign key (RevenueId) references Revenue(RevenueId),
	constraint FK_RevenueProduct_Product foreign key (ProductId) references Product(ProductId),

)
go






