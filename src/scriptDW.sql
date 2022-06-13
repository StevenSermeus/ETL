USE [BI_PROJET]

-- Verify if the fact table already exists
IF OBJECT_ID('dbo.FactSell','U') IS NOT NULL
DROP TABLE dbo.FactSell
GO

-- DimDate
-- Verify if the table already exists
IF OBJECT_ID('dbo.DimDate','U') IS NOT NULL
DROP TABLE dbo.DimDate
GO
-- Create the table
CREATE TABLE dbo.DimDate (
	[DateKey] [int] NOT NULL,
	[DayFrenchName] [nvarchar](100) NOT NULL,
	[DayEnglishName] [nvarchar](100) NOT NULL,
	[MonthFrenchName] [nvarchar](100) NOT NULL,
	[MonthEnglishName] [nvarchar](100) NOT NULL,
	[WeekNumber] [int] NOT NULL,
	[DayOfWeekNumber] [int] NOT NULL,
	[DayOfYearNumber] [int] NOT NULL,
 CONSTRAINT [PK_DimDate] PRIMARY KEY CLUSTERED 
(
	[DateKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

-- DimPerson
-- Verify if the table already exists
IF OBJECT_ID('dbo.DimPerson','U') IS NOT NULL
DROP TABLE dbo.DimPerson
GO
-- Create the table
CREATE TABLE dbo.DimPerson (
	PersonId [NVARCHAR](50) NOT NULL,
	OriginalId INT NOT NULL,
	LastName [NVARCHAR](20) NOT NULL,
	FirstName [NVARCHAR](10) NOT NULL,
 CONSTRAINT [PK_DimPerson] PRIMARY KEY CLUSTERED 
(
	[PersonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

--DimCompany
-- Verify if the table already exists
IF OBJECT_ID('dbo.DimCompany','U') IS NOT NULL
DROP TABLE dbo.DimCompany
GO
-- Create the table
CREATE TABLE dbo.DimCompany (
	CompanyId [NVARCHAR](50) NOT NULL,
	OriginalId [NVARCHAR](5) NOT NULL,
	CompanyName [NVARCHAR](40) NOT NULL,
	ContactName [NVARCHAR](30) NOT NULL,
 CONSTRAINT [PK_DimCompany] PRIMARY KEY CLUSTERED 
(
	[CompanyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]


-- DimLocation
-- Verify if the table already exists
IF OBJECT_ID('dbo.DimLocation','U') IS NOT NULL
DROP TABLE dbo.DimLocation
GO
-- Create the table
CREATE TABLE dbo.DimLocation (
	LocationId [NVARCHAR](20) NOT NULL,
	City [NVARCHAR](15) NOT NULL,
	Region [NVARCHAR](15) NOT NULL,
	PostalCode [NVARCHAR](10) NOT NULL,
	Country [NVARCHAR](15) NOT NULL, 
CONSTRAINT 
[PK_DimLocation] PRIMARY KEY CLUSTERED 
(
	[LocationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]


-- DimProduct
-- Verify if the table already exists
IF OBJECT_ID('dbo.DimProduct','U') IS NOT NULL
DROP TABLE dbo.DimProduct
GO
-- Create the table
CREATE TABLE dbo.DimProduct (
	ProductId [NVARCHAR](50) NOT NULL,
	OriginalId INT NOT NULL,
	ProductName [NVARCHAR](40) NOT NULL,
	QuantityPerUnit [NVARCHAR](20) NOT NULL,
	UnitPrice [MONEY] NOT NULL,
 CONSTRAINT [PK_DimProduct] PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

-- DimCategory
-- Verify if the table already exists
IF OBJECT_ID('dbo.DimCategory','U') IS NOT NULL
DROP TABLE dbo.DimCategory
GO
-- Create the table
CREATE TABLE dbo.DimCategory (
	CategoryId [NVARCHAR](50) NOT NULL,
	OriginalId INT NOT NULL,
	CategoryName [NVARCHAR](15) NOT NULL,
 CONSTRAINT [PK_DimCategory] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

-- FactSell
-- Create the table
CREATE TABLE dbo.FactSell (
	Id INT NOT NULL IDENTITY(1,1),
	DBOrigin [NVARCHAR](25) NOT NULL,
	OrderId INT NOT NULL,
	OrderDate INT NOT NULL,
	RequiredDate INT NOT NULL,
	ShippedDate INT NOT NULL,
	Customer [NVARCHAR](50) NOT NULL,
	CustomerLocation [NVARCHAR](20) NOT NULL,
	ShipLocation [NVARCHAR](20) NOT NULL,
	Product [NVARCHAR](50) NOT NULL,
	Category [NVARCHAR](50) NOT NULL,
	Seller [NVARCHAR](50) NOT NULL,
	Discount REAL NOT NULL,
	Quantity smallint NOT NULL,
	TotalPrice REAL NOT NULL,
	IsOnline [bit] NOT NULL,
 CONSTRAINT [PK_FactSell] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[FactSell]  WITH CHECK ADD  CONSTRAINT [FK_OrderDate] FOREIGN KEY([OrderDate])
REFERENCES [dbo].[DimDate] ([DateKey])

GO
ALTER TABLE [dbo].[FactSell]  WITH CHECK ADD  CONSTRAINT [FK_RequiredDate] FOREIGN KEY([RequiredDate])
REFERENCES [dbo].[DimDate] ([DateKey])

GO
ALTER TABLE [dbo].[FactSell]  WITH CHECK ADD  CONSTRAINT [FK_ShippedDate] FOREIGN KEY([ShippedDate])
REFERENCES [dbo].[DimDate] ([DateKey])

GO
ALTER TABLE [dbo].[FactSell]  WITH CHECK ADD  CONSTRAINT [FK_Customer] FOREIGN KEY([Customer])
REFERENCES [dbo].[DimCompany] ([CompanyId])

GO
ALTER TABLE [dbo].[FactSell]  WITH CHECK ADD  CONSTRAINT [FK_CustomerLocation] FOREIGN KEY([CustomerLocation])
REFERENCES [dbo].[DimLocation] ([LocationId])

GO
ALTER TABLE [dbo].[FactSell]  WITH CHECK ADD  CONSTRAINT [FK_ShipLocation] FOREIGN KEY([ShipLocation])
REFERENCES [dbo].[DimLocation] ([LocationId])

GO
ALTER TABLE [dbo].[FactSell]  WITH CHECK ADD  CONSTRAINT [FK_Product] FOREIGN KEY([Product])
REFERENCES [dbo].[DimProduct] ([ProductId])

GO
ALTER TABLE [dbo].[FactSell]  WITH CHECK ADD  CONSTRAINT [FK_Seller] FOREIGN KEY([Seller])
REFERENCES [dbo].[DimPerson] ([PersonId])

GO
ALTER TABLE [dbo].[FactSell] WITH CHECK ADD  CONSTRAINT [FK_Category] FOREIGN KEY([Category])
REFERENCES [dbo].[DimCategory] ([CategoryId])

GO

-- Dummy rows for Company
INSERT INTO dbo.DimCompany 
	([CompanyId],[CompanyName],[ContactName],[OriginalId])
VALUES 
	('-1', N'Dummy',N'Company',N'-1')
GO

-- Dummy rows for Product
INSERT INTO dbo.DimProduct 
	([ProductId],[ProductName],[QuantityPerUnit],[UnitPrice],[OriginalId])
VALUES 
	('-1', N'Dummy',N'Product',0.0,-1)
GO
-- Dummy rows for Person
INSERT INTO dbo.DimPerson 
	([PersonId],[LastName],[FirstName],[OriginalId])
VALUES 
	('-1', N'Dummy',N'Person',-1)
GO
-- Dummy rows for Category
INSERT INTO dbo.DimCategory 
	([CategoryId],[CategoryName],[OriginalId])
VALUES 
	('-1', N'DummyCategory',-1)
GO
-- Dummy rows for Date
INSERT INTO dbo.DimDate
	([DateKey],[DayFrenchName],[DayEnglishName],[MonthFrenchName],[MonthEnglishName],[WeekNumber],[DayOfWeekNumber],[DayOfYearNumber])
VALUES
	(10000101,'Aucun', 'None', 'Aucun', 'None', 1,1,1)
GO