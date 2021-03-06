USE [PAP_Eldercare_Demo]
GO
/****** Object:  StoredProcedure [dbo].[NTUCEldrcare_Sp_Attendance_test]    Script Date: 5/29/2015 6:28:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Zhou Kai>
-- Create date: <2015-05-29>
-- Description:	<Generate raw data for the Attendance report>
-- =============================================
ALTER PROCEDURE [dbo].[NTUCEldrcare_Sp_Attendance_test]( 
	-- Add the parameters for the stored procedure here
	@pCentreId varchar(20), -- not ready
	@pCentreName varchar(50),
	@pProgramId varchar(10), -- not ready
	@pProgramName varchar(50),
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

	--select @pCentreId = (select top (1) id from centre where [name] = @pCentreName)
	--select @pProgramId = (select top (1) id from dayCarePlan where [name] = @pProgramName)
	select @pClientId = (select top (1) id from client where [name] = @pClientName)

    create table #Report(
      Name varchar(20),
      CentreName varchar(50),
      Program varchar(50),
      [Status]  tinyint,
      ReasonForAbsence varchar(100),
      Period varchar(6)
      )

    declare cursor_atten_view Cursor for
      select [Status], Remark, Period from Client_AttendanceView where
        CentreId = @pCentreId and
        ProgrammeId = @pProgramId and
        ClientId = @pClientId and
        NRIC = @pClientNRIC and
        Period >= @pPeriodFrom and
        Period <= @pPeriodTo 

     declare @reason varchar(100)
     declare @Period varchar(6)
     declare @ReasonForAbsence varchar(100)
     declare @Status tinyint
	 --declare @nAttendance int
	 --declare @nAbsence int
	 --select @nAttendance = 0
	 --select @nAbsence = 0

     open cursor_atten_view 
     fetch next from cursor_atten_view into @Status, @reason, @Period

     while @@FETCH_STATUS = 0
     begin
       insert into #Report (Name, CentreName, Program, [status],
           ReasonForAbsence, Period)
       values
           (@pClientName, @pCentreName, @pProgramName, @Status,
              @reason, @Period)
       --if @Status = 1
       --  begin
       --    select @nAbsence = @nAbsence + 1
       --    select @reason = @Status + '\n' + @reason
       --  end
       --else if @Status = 2
       --    select @nAttendance = @nAttendance + 1
	   fetch next from cursor_atten_view into @Status, @reason, @Period
     end

     close cursor_atten_view
     deallocate cursor_atten_view
     
     select * from #Report
END
