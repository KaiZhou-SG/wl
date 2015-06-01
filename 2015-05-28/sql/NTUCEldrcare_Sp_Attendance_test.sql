-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Zhou Kai>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
alter PROCEDURE [dbo].[NTUCEldrcare_Sp_Attendance_test]( 
	-- Add the parameters for the stored procedure here
	@pCentreId varchar(20),
	@pCentreName varchar(50),
	@pProgramId varchar(10),
	@pProgramName varchar(20),
	@pClientId varchar(4),
	@pClientName varchar(20),
	@pClientNRIC varchar(15),
	@pYearFrom varchar(4),
	@pMonthFrom varchar(2),
	@pYearTo varchar(4),
	@pMonthTo varchar(2)
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Create temporary report table
    create table #Report(
      Name varchar(20) null,
      CentreName varchar(50) null,
      Program varchar(20) null,
      [Status]  tinyint null,
      ReasonForAbsence varchar(100) null,
      Period varchar(6) null
      )
    
    declare @periodFrom varchar(6) 
	declare @periodTo varchar(6)
	select @periodFrom = @pYearFrom + @pMonthFrom
	select @periodTo = @pYearTo + @pMonthTo

    declare cursor_atten_view Cursor for
      select [Status], Remark, Period from Client_AttendanceView 
      where
        CentreId = 16 and
        ProgrammeId = 83 and
        ClientId = 1075 and
        NRIC = 'S2083641E' and
        Period >= '201504' and
        Period <= '201505' 
        
        --CentreId = @pCentreId and
        --ProgrammeId = @pProgramId and
        --ClientId = @pClientId and
        --NRIC = @pClientNRIC and
        --Period >= @periodFrom and
        --Period <= @periodTo 
              
     declare @Period varchar(6)
     declare @reason varchar(100)
     declare @Status tinyint
     	     
     open cursor_atten_view 
     fetch next from cursor_atten_view into @Status, @reason, @Period
     while @@FETCH_STATUS = 0
     begin
       insert into #Report (Name, CentreName, Program, [status],
           ReasonForAbsence, Period)
       values
           (@pClientName, @pCentreName, @pProgramName, @Status,
              @reason, @Period)
    
       fetch next from cursor_atten_view into @Status, @reason, @Period
     end
          
     close cursor_atten_view
     deallocate cursor_atten_view
     
     select * from #Report

END
GO

exec NTUCEldrcare_Sp_Attendance_test   '16', 'Silver Circle (Fengshan)',
'83', 'program name', '1075', 'Client Name', 'S2083641E', '201504', '201505'
go