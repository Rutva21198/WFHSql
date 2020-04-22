CREATE TABLE [dbo].[FactInternetSales]
(
	[ProductKey] [int] NOT NULL,
	[OrderDateKey] [int] NOT NULL,
	[DueDateKey] [int] NOT NULL,
	[ShipDateKey] [int] NOT NULL,
	[CustomerKey] [int] NOT NULL,
	[PromotionKey] [int] NOT NULL,
	[CurrencyKey] [int] NOT NULL,
	[SalesTerritoryKey] [int] NOT NULL,
	[SalesOrderNumber] [nvarchar](20) NOT NULL,
	[SalesOrderLineNumber] [tinyint] NOT NULL,
	[RevisionNumber] [tinyint] NOT NULL,
	[OrderQuantity] [smallint] NOT NULL,
	[UnitPrice] [money] NOT NULL,
	[ExtendedAmount] [money] NOT NULL,
	[UnitPriceDiscountPct] [float](53) NOT NULL,
	[DiscountAmount] [float](53) NOT NULL,
	[ProductStandardCost] [money] NOT NULL,
	[TotalProductCost] [money] NOT NULL,
	[SalesAmount] [money] NOT NULL,
	[TaxAmt] [money] NOT NULL,
	[Freight] [money] NOT NULL,
	[CarrierTrackingNumber] [nvarchar](25) NULL,
	[CustomerPONumber] [nvarchar](25) NULL,
	[OrderDate] [datetime] NULL,
	[DueDate] [datetime] NULL,
	[ShipDate] [datetime] NULL,

 CONSTRAINT [FactInternetSales_primaryKey]  PRIMARY KEY NONCLUSTERED HASH ([SalesOrderNumber],[SalesOrderLineNumber]),INDEX CLUSTERED COLUMNSTORE)

INSERT INTO FactInternetSales ([ProductKey], [OrderDateKey], [DueDateKey], [ShipDateKey], [CustomerKey], [PromotionKey], [CurrencyKey], [SalesTerritoryKey], [SalesOrderNumber], [SalesOrderLineNumber], [RevisionNumber], [OrderQuantity], [UnitPrice], [ExtendedAmount], [UnitPriceDiscountPct], [DiscountAmount], [ProductStandardCost], [TotalProductCost], [SalesAmount], [TaxAmt], [Freight], [CarrierTrackingNumber], [CustomerPONumber], [OrderDate], [DueDate], [ShipDate]) SELECT [ProductKey], [OrderDateKey], [DueDateKey], [ShipDateKey], [CustomerKey], [PromotionKey], [CurrencyKey], [SalesTerritoryKey], [SalesOrderNumber], [SalesOrderLineNumber], [RevisionNumber], [OrderQuantity], [UnitPrice], [ExtendedAmount], [UnitPriceDiscountPct], [DiscountAmount], [ProductStandardCost], [TotalProductCost], [SalesAmount], [TaxAmt], [Freight], [CarrierTrackingNumber], [CustomerPONumber], [OrderDate], [DueDate], [ShipDate] FROM [AdventureWorksDW].[dbo].[FactInternetSales_old] 

--------------------------------------------------------------------------------------------

CREATE CLUSTERED COLUMNSTORE INDEX CCI_FactInternetSales ON FactInternetSales

CREATE NONCLUSTERED INDEX [IX_FactInternetSales_PromotionKey] ON FactInternetSales (PromotionKey)
CREATE NONCLUSTERED INDEX [IX_FactIneternetSales_ShipDateKey] ON FactInternetSales (ShipDateKey)
CREATE NONCLUSTERED INDEX [IX_FactInternetSales_CurrencyKey] ON FactInternetSales (CurrencyKey)
CREATE NONCLUSTERED INDEX [IX_FactInternetSales_CustomerKey] ON FactInternetSales (CustomerKey)
CREATE NONCLUSTERED INDEX [IX_FactInternetSales_DueDateKey] ON FactInternetSales (DueDateKey )
CREATE NONCLUSTERED INDEX [IX_FactInternetSales_OrderDateKey] ON FactInternetSales (OrderDateKey)
CREATE NONCLUSTERED INDEX [IX_FactInternetSales_ProductKey] ON FactInternetSales (ProductKey)
CREATE UNIQUE NONCLUSTERED INDEX [PK_FactInternetSales_SalesOrderNumber_SalesOrderLineNumber] ON FactInternetSales (alesOrderNumber,SalesOrderLineNumber)

ALTER TABLE FactInternetSales  WITH CHECK ADD  FOREIGN KEY(CustomerKey) REFERENCES DimCustomer (CustomerKey)

ALTER TABLE FactInternetSales  WITH CHECK ADD FOREIGN KEY(CurrencyKey) REFERENCES DimCurrency (CurrencyKey)

ALTER TABLE FactInternetSales  WITH CHECK ADD  FOREIGN KEY(OrderDateKey) REFERENCES DimDate (DateKey)

ALTER TABLE FactInternetSales  WITH CHECK ADD   FOREIGN KEY(DueDateKey) REFERENCES DimDate (DateKey)

ALTER TABLE FactInternetSales  WITH CHECK ADD FOREIGN KEY(ShipDateKey) REFERENCES DimDate (DateKey)

ALTER TABLE FactInternetSales  WITH CHECK ADD FOREIGN KEY(ProductKey) REFERENCES DimProduct (ProductKey)

ALTER TABLE FactInternetSales  WITH CHECK ADD  CONSTRAINT [FK_FactInternetSales_DimPromotion] FOREIGN KEY(PromotionKey) REFERENCES DimPromotion (PromotionKey)

ALTER TABLE FactInternetSales  WITH CHECK ADD  CONSTRAINT [FK_FactInternetSales_DimSalesTerritory] FOREIGN KEY(SalesTerritoryKey) REFERENCES DimSalesTerritory (SalesTerritoryKey)

sp_spaceused 'dbo.FactInternetSales'

SET STATISTICS TIME ON

SELECT SalesTerritoryRegion,p.EnglishProductName,d.WeekNumberOfYear,d.CalendarYear,SUM(fi.SalesAmount) Revenue,AVG(OrderQuantity) AverageQuantity,STDEV(UnitPrice) PriceStandardDeviation,SUM(TaxAmt) TotalTaxPayable
FROM dbo.FactInternetSales as fi
INNER JOIN dbo.DimProduct as p ON fi.ProductKey = p.ProductKey
INNER JOIN dbo.DimDate as d ON fi.OrderDate = d.FullDateAlternateKey
INNER JOIN dbo.DimSalesTerritory as st on fi.SalesTerritoryKey = st.SalesTerritoryKey
	AND fi.OrderDate BETWEEN '21/1/2020' AND '12/2/2020'
GROUP BY SalesTerritoryRegion, d.CalendarYear, d.WeekNumberOfYear, p.EnglishProductName
ORDER BY SalesTerritoryRegion, SUM(fi.SalesAmount) desc;

