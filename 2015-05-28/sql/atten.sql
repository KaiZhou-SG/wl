/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [ID]
      ,[CentreId]
      ,[ProgrammeId]
      ,[Period]
      ,[Day]
      ,[ClientDayCarePlanId]
      ,[Status]
      ,[Remark]
      ,[CreatedDate]
      ,[CreatedBy]
      ,[UpdatedDate]
      ,[UpdatedBy]
  FROM [NTUCEldercare_17042015_NEW].[dbo].[Client_Attendance]
  
  -- select * from Client_Attendance where id = 1075
  select * from Client_Attendance where id = 1061
