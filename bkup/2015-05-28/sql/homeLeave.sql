/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [ID]
      ,[ClientId]
      ,[StartDate]
      ,[EndDate]
      ,[Reason]
      ,[MC]
      ,[DCCFees]
      ,[TransportFees]
      ,[IsDeleted]
      ,[CreatedDate]
      ,[CreatedBy]
      ,[UpdatedDate]
      ,[UpdatedBy]
      ,[IsProcessed]
      ,[serviceGroup]
  FROM [NTUCEldercare_17042015_NEW].[dbo].[Client_HomeLeave]
  -- where clientid = 1061
  