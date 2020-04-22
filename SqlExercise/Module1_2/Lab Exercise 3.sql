---------------------------------------------------------------------
-- LAB 02
--
-- Exercise 3
---------------------------------------------------------------------

USE TSQL;
GO

---------------------------------------------------------------------
-- Task 1
-- 
-- Write a script to create a table to store the Competitor data.
---------------------------------------------------------------------
CREATE TABLE DesignMarketing.Competitors(
	CompetitorId int primary key identity (1, 1),
	CompetitorCode nvarchar(6) NOT NULL,
	 CompetitorName varchar(30) NOT NULL,
	 Address varchar(MAX) NULL,
	 DateEntered varchar(10) NOT NULL,
	 StrengthOfCompetition varchar(8) NULL,
	 Comments varchar(MAX) NULL
);

DROP TABLE DesignMarketing.Competitors;






---------------------------------------------------------------------
-- Task 2
-- 
-- Write a script to create a table to store the TVAdvertisement data.
---------------------------------------------------------------------

CREATE TABLE DesignMarketing.TVAdvertisement(
	TVAdvertisementId int primary key identity (1, 1),
    TV_Station nvarchar(15) Not Null,
	City nvarchar(25)	Not Null,
	CostPerAdvertisement float	Not Null,
	TotalCostOfAllAdvertisements float	Null,
	NumberOfAdvertisements varchar(4)	Not Null,
	DateOfAdvertisement varchar(12)	Not Null,
	TimeOfAdvertisement	int	Not Null

);





---------------------------------------------------------------------
-- Task 3
-- 
-- Write a script to create a table to store the CampaignResponse data.
---------------------------------------------------------------------
CREATE TABLE DesignMarketing.CampaignResponse(
	CampaignId INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	ResponseOccurredWhen datetime Not null,
	RelevantProspect int Not null,
	RespondedHow varchar(8) check(RespondedHow in ('phone', 'email', 'fax', 'letter')) Not null,
	ChargeFromReferrer float Not null,
	RevenueFromResponse	float Not null,
	ResponseProfit float Not null
);


