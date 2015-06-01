SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Zhou Kai>
-- Create date: <2015-05-29>, updated: <2015-06-01>
-- Description:	<Generate raw data for the Attendance report>
-- =============================================
ALTER PROCEDURE [dbo].[NTUCEldrcare_Sp_Attendance_test]( 
	-- Add the parameters for the stored procedure here
	@pCentreId varchar(20), 
	@pCentreName varchar(50), -- not ready
	@pProgramId varchar(10), 
	@pProgramName varchar(50), -- not ready
	@pClientId varchar(4), -- not ready
	@pClientName varchar(20),
	@pClientNRIC varchar(15),
	@pPeriodFrom varchar(6),
	@pPeriodTo varchar(6)
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	/*
	  (1) create a temporary report table, #Report, to store the final report
	  (2) create a temporary report table, #RawReportStatus1, to store raw data:
	     >> status = 1, group by period
	  (3) create a temporary report table, #RawReportStatus2, to store raw data:
	     >> status = 2, group by period  
	  (4) create a temporary report table, #RawReportStatus1Status2, to store raw data:
	    >> but the count of statu1 and status2 are contained in one row, and group by Period 
	  (4) inner join #RawReportStatus1 and #RawReportStatus2 on Period into #RawReportStatus1Status2 
	  (5) use a cursor to loop through #RawReportStatus1Status2, select three columns:
	      >> the count of status1 and status2
		  >> Period
		  and use @pClientName as it is
		  and use @pCentreId to select @pCentreName
		  and use @pProgrammeId to select @pProgrammeName
		  to form a row and insert into #Report
	  (6) format the data in #Report:
	      >> Period, e.g.: 201505 --> May 2015
		  >> ReasonForAbsence --> select   
	  (6) select * from #Report as the report(the remark column is ignored)
	*/

	select @pCentreName = (select top (1) name from centre where [id] = @pCentreId)
	select @pProgramName = (select top (1) name from dayCarePlan where id = @pProgramId)
	select @pClientId = (select top (1) id from client where [name] = @pClientName)

    create table #Report(
      Name varchar(20),
      CentreName varchar(50),
      Program varchar(50),
      Attended int,
	  Absent int,
      ReasonForAbsence varchar(100),
      Period varchar(10)
      )

 --   create table #RawReportStatus1(
	--  countStatus1 int,
	--  period varchar(6)
	--)

	--create table #RawReportStatus2(
	--  countStatus2 int,
	--  period varchar(6)
	--)

	--create table #RawReportStatus1Status2(
	--  countStatus1 int,
	--  countStatus2 int,
	--  period varchar(6)
	--)
	
	select count(case status when 1 then 1 else null end) as Attended, Period
	into #RawReportStatus1
	from Client_AttendanceView_zk20150529
	where 
	        CentreId = @pCentreId and
            ProgrammeId = @pProgramId and
            ClientId = @pClientId and
            NRIC = @pClientNRIC and
            Period >= @pPeriodFrom and
			Period <= @pPeriodTo
	group by Period

	-- select * from #RawReportStatus1

	select count(case status when 2 then 1 else null end) as Absent, Period
	into #RawReportStatus2
	from Client_AttendanceView_zk20150529
	where 
	        CentreId = @pCentreId and
            ProgrammeId = @pProgramId and
            ClientId = @pClientId and
            NRIC = @pClientNRIC and
            Period >= @pPeriodFrom and
			Period <= @pPeriodTo
	group by Period

	-- select * from #RawReportStatus2

	select Attended, Absent, #RawReportStatus1.period as Period  
	into #rawReportStatus1Status2
	from
	#RawReportStatus1 inner join #RawReportStatus2 on
	#RawReportStatus1.Period = #RawReportStatus2.Period

	-- select * from #RawReportStatus1Status2
	
	declare @nStatus1 int
	declare @nStatus2 int
	declare @period varchar(10)
    declare cursor_rawtable cursor for select Attended, Absent, Period from #RawReportStatus1Status2
	open cursor_rawtable
	declare @reason varchar(100)  

	fetch next from cursor_rawtable into @nStatus1, @nStatus2, @period  
	while @@fetch_status = 0
	begin
		  select @reason = ''
          select @reason = COALESCE(@reason + ', ', '') + Remark 
          from Client_AttendanceView_zk20150529
	      where 	   
	        CentreId = @pCentreId and
            ProgrammeId = @pProgramId and
            ClientId = @pClientId and
            NRIC = @pClientNRIC and
            Period = @period and
		    Status = 1
	   
	     if substring(@Period, 5,2) = '01'
			select @Period = 'Jan ' + substring(@Period, 1, 4) 
	     else if substring(@Period, 5,2) = '02'
			select @Period =  'Feb ' + substring(@Period, 1, 4) 
	     else if substring(@Period, 5,2) = '03'
			select @Period = + 'Mar ' + substring(@Period, 1, 4) 
		 else if substring(@Period, 5,2) = '04'
			select @Period = + 'Apr ' + substring(@Period, 1, 4) 
		 else if substring(@Period, 5,2) = '05'
			select @Period = + 'May ' + substring(@Period, 1, 4) 
		 else if substring(@Period, 5,2) = '06'
			select @Period = + 'Jun ' + substring(@Period, 1, 4) 
		 else if substring(@Period, 5,2) = '07'
			select @Period = + 'Jul ' + substring(@Period, 1, 4) 
		 else if substring(@Period, 5,2) = '08'
			select @Period = + 'Aug ' + substring(@Period, 1, 4) 
		 else if substring(@Period, 5,2) = '09'
			select @Period = 'Sep ' + substring(@Period, 1, 4)
		 else if substring(@Period, 5,2) = '10'
			select @Period = + 'Oct ' + substring(@Period, 1, 4) 
		 else if substring(@Period, 5,2) = '11'
			select @Period = + 'Nov ' + substring(@Period, 1, 4) 
	     else if substring(@Period, 5,2) = '12'
	        select @Period = + 'Dec ' + substring(@Period, 1, 4)
		
	  

	  insert into #report(Name, CentreName, Program, Attended, Absent, ReasonForAbsence, Period) values
	    (@pClientName, @pCentreName, @pProgramName, @nStatus1, @nStatus2, substring(@reason, 2, 90), @period)
	  fetch next from cursor_rawtable into @nStatus1, @nStatus2, @period  
	  
	end 

	close cursor_rawtable
	deallocate cursor_rawtable

	select * from #Report

end


exec [NTUCEldrcare_Sp_Attendance_test] '37', 'centre name', '99', '', '2038', 'Test Client 2038',
  'S12121222', '201403', '201505'

