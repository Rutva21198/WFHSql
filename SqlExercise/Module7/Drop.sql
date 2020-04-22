SET STATISTICS TIME OFF

DROP INDEX ON [dbo].[FactInternetSales];

DROP INDEX ON [dbo].[FactInternetSales] WITH ( ONLINE = OFF )
DROP INDEX ON [dbo].[FactInternetSales]
