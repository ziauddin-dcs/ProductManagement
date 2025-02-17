USE [master]
GO
/****** Object:  Database [ProductDB]    Script Date: 29-11-2024 15:32:12 ******/
CREATE DATABASE [ProductDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ProductDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\ProductDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ProductDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\ProductDB_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [ProductDB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ProductDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ProductDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ProductDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ProductDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ProductDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ProductDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [ProductDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ProductDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ProductDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ProductDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ProductDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ProductDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ProductDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ProductDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ProductDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ProductDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ProductDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ProductDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ProductDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ProductDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ProductDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ProductDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ProductDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ProductDB] SET RECOVERY FULL 
GO
ALTER DATABASE [ProductDB] SET  MULTI_USER 
GO
ALTER DATABASE [ProductDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ProductDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ProductDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ProductDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ProductDB] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'ProductDB', N'ON'
GO
ALTER DATABASE [ProductDB] SET QUERY_STORE = OFF
GO
USE [ProductDB]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 29-11-2024 15:32:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 29-11-2024 15:32:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [varchar](100) NOT NULL,
	[CategoryID] [int] NULL,
	[SubcategoryID] [int] NULL,
	[Qty] [int] NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[Total] [decimal](18, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Subcategories]    Script Date: 29-11-2024 15:32:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Subcategories](
	[SubcategoryID] [int] IDENTITY(1,1) NOT NULL,
	[SubcategoryName] [varchar](100) NOT NULL,
	[CategoryID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[SubcategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([CategoryID], [CategoryName]) VALUES (1, N'Electronics')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName]) VALUES (2, N'Furniture')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName]) VALUES (3, N'Clothing')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName]) VALUES (4, N'Books')
SET IDENTITY_INSERT [dbo].[Categories] OFF
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SubcategoryID], [Qty], [Price], [Total]) VALUES (1, N'iPhone 13', 1, 1, 2, CAST(999.99 AS Decimal(18, 2)), CAST(1999.98 AS Decimal(18, 2)))
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SubcategoryID], [Qty], [Price], [Total]) VALUES (7, N'The Great Gatsby', 4, 7, 2, CAST(15.00 AS Decimal(18, 2)), CAST(30.00 AS Decimal(18, 2)))
INSERT [dbo].[Products] ([ProductID], [ProductName], [CategoryID], [SubcategoryID], [Qty], [Price], [Total]) VALUES (11, N'Test', 2, 4, 89, CAST(10.00 AS Decimal(18, 2)), CAST(890.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[Products] OFF
SET IDENTITY_INSERT [dbo].[Subcategories] ON 

INSERT [dbo].[Subcategories] ([SubcategoryID], [SubcategoryName], [CategoryID]) VALUES (1, N'Mobile Phones', 1)
INSERT [dbo].[Subcategories] ([SubcategoryID], [SubcategoryName], [CategoryID]) VALUES (2, N'Laptops', 1)
INSERT [dbo].[Subcategories] ([SubcategoryID], [SubcategoryName], [CategoryID]) VALUES (3, N'Sofas', 2)
INSERT [dbo].[Subcategories] ([SubcategoryID], [SubcategoryName], [CategoryID]) VALUES (4, N'Chairs', 2)
INSERT [dbo].[Subcategories] ([SubcategoryID], [SubcategoryName], [CategoryID]) VALUES (5, N'Men', 3)
INSERT [dbo].[Subcategories] ([SubcategoryID], [SubcategoryName], [CategoryID]) VALUES (6, N'Women', 3)
INSERT [dbo].[Subcategories] ([SubcategoryID], [SubcategoryName], [CategoryID]) VALUES (7, N'Fiction', 4)
INSERT [dbo].[Subcategories] ([SubcategoryID], [SubcategoryName], [CategoryID]) VALUES (8, N'Non-Fiction', 4)
SET IDENTITY_INSERT [dbo].[Subcategories] OFF
ALTER TABLE [dbo].[Products]  WITH CHECK ADD FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Categories] ([CategoryID])
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD FOREIGN KEY([SubcategoryID])
REFERENCES [dbo].[Subcategories] ([SubcategoryID])
GO
ALTER TABLE [dbo].[Subcategories]  WITH CHECK ADD FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Categories] ([CategoryID])
GO
USE [master]
GO
ALTER DATABASE [ProductDB] SET  READ_WRITE 
GO
