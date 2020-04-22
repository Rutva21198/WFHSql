USE tempdb;

CREATE PRIMARY XML INDEX IX_ProductImport_ProductDetails ON ProductImport(ProductDetails);

CREATE XML INDEX IX_ProductImport_ProductDetails_Value ON ProductImport(ProductDetails) USING XML 
INDEX IX_ProductImport_ProductDetails FOR VALUE;

SELECT * FROM sys.xml_indexes;

DROP TABLE ProductImport;

CREATE TABLE ProductImport (ProductImportID int IDENTITY(1,1),ProductDetails xml (CONTENT ProductDetailsSchema));

CREATE PRIMARY XML INDEX IX_ProductImport_ProductDetails ON ProductImport (ProductDetails);


