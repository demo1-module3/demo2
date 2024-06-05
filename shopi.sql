
CREATE DATABASE Shopi;

use Shopi;

drop database Shopi;

CREATE TABLE Role(
	RoleID INT PRIMARY KEY AUTO_INCREMENT,
	RoleName VARCHAR(50) NOT NULL UNIQUE,
	Description VARCHAR(255)
);

CREATE TABLE User (
    UserID INT PRIMARY KEY AUTO_INCREMENT,
    Username VARCHAR(50) NOT NULL UNIQUE,
    Password VARCHAR(30) NOT NULL,
    FullName VARCHAR(100) NOT NULL,
    RoleID INT NOT NULL,
    DateOfBirth DATE,
    Gender ENUM('Male', 'Female'),
    Email VARCHAR(100) NOT NULL UNIQUE,
    PhoneNumber double,
    Address VARCHAR(255),
    Wallet DECIMAL(10, 2) DEFAULT 0.00,
    Status ENUM('Active', 'Inactive') DEFAULT 'Active',
    
    foreign key (RoleID) references role (RoleID)
);

CREATE TABLE VerityMoney(
	VerityMoneyID INT PRIMARY KEY AUTO_INCREMENT,
	UserID INT NOT NULL,
	Money DECIMAL(10, 2) DEFAULT 0.00,
	Status ENUM('Active', 'Inactive') DEFAULT 'Active',
    
    foreign key (UserID) references User (userID)
);

CREATE TABLE Supplier(
	SupplierID INT PRIMARY KEY AUTO_INCREMENT,
	SupplierName VARCHAR(50) NOT NULL UNIQUE,
	Address VARCHAR(255),
	Status ENUM('Active', 'Inactive') DEFAULT 'Active'
);

CREATE TABLE CategoryProduct(
 CategoryID INT PRIMARY KEY AUTO_INCREMENT,
 CategoryName VARCHAR(50) NOT NULL UNIQUE,
 Description VARCHAR(255),
 Status ENUM('Active', 'Inactive') DEFAULT 'Active'
);

CREATE TABLE VerityProduct(
	VerityProductID INT PRIMARY KEY AUTO_INCREMENT,
	UserID INT NOT NULL,
	SupplierID INT NOT NULL,
	CategoryID INT NOT NULL,
	ProductName VARCHAR(50) NOT NULL UNIQUE,
	Status ENUM('Active', 'Inactive') DEFAULT 'Active',
    
    foreign key (UserID) references User (UserID),
    foreign key (SupplierID) references Supplier (SupplierID),
    foreign key (CategoryID) references CategoryProduct (CategoryID)

);

CREATE TABLE Products(
	ProductID INT PRIMARY KEY AUTO_INCREMENT,
	ProductName VARCHAR(50) NOT NULL UNIQUE,
	CategoryID INT NOT NULL,
	SupplierID INT NOT NULL,
	Price DECIMAL(10, 2) DEFAULT 0.00,
	Quantity INT NOT NULL CHECK (Quantity >= 0),
	Description VARCHAR(255),
	Status ENUM('Active', 'Inactive') DEFAULT 'Active',
    
    foreign key (SupplierID) references Supplier (SupplierID),
    foreign key (CategoryID) references CategoryProduct (CategoryID)
);

CREATE TABLE Cart(
	CartID INT PRIMARY KEY AUTO_INCREMENT,
	UserID INT NOT NULL,
	QuantityProduct INT NOT NULL CHECK (Quantity > 0),
	TotalPrice DECIMAL(10, 2) DEFAULT 0.00,
    
    foreign key (UserID) references User (UserID)
);

CREATE TABLE CartDetails(
	CartDetailID INT PRIMARY KEY AUTO_INCREMENT,
	CartID INT NOT NULL,
	ProductID INT NOT NULL,
	Quantity INT NOT NULL CHECK (Quantity >= 0),
	Price DECIMAL(10, 2) DEFAULT 0.00,
    
    foreign key (CartID) references Cart (CartID),
    foreign key (ProductID) references Products (ProductID)
);

CREATE TABLE Bill(
	BillID INT PRIMARY KEY AUTO_INCREMENT,
	UserID INT NOT NULL,
	TotalAmount DECIMAL(10, 2) DEFAULT 0.00,
	BillDate DATE,
    
    foreign key (UserID) references User (UserID)
);

CREATE TABLE BillDetail(
	BillDetailID  INT PRIMARY KEY AUTO_INCREMENT,
	BillID INT NOT NULL,
	ProductID INT NOT NULL,
	Quantity INT NOT NULL CHECK (Quantity >= 0),
	Price DECIMAL(10, 2) DEFAULT 0.00,
	TotalPrice DECIMAL(10, 2) DEFAULT 0.00,
    
    foreign key (BillID) references Bill (BillID),
    foreign key (ProductID) references Products (ProductID)
);

