/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [ID]
      ,[Name]
      ,[CentreId]
      ,[ChineseName]
      ,[NRIC]
      ,[DOB]
      ,[GenderId]
      ,[MaritalStatusId]
      ,[DialectId]
      ,[ReligionId]
      ,[RaceId]
      ,[LanguageId]
      ,[IsDeleted]
      ,[CreatedDate]
      ,[CreatedBy]
      ,[UpdatedDate]
      ,[UpdatedBy]
      ,[Catagory]
  FROM [NTUCEldercare_17042015_NEW].[dbo].[Client] where ID = 1075--1061
  
  select * from Client where NRIC = 'S2083641E'
  select * from Client where NRIC = 'S0257151Z'