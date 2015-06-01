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
alter PROCEDURE [dbo].[NTUCEldrcare_Sp_Attendance]( 
	-- Add the parameters for the stored procedure here
	@pCentreId varchar(20),
	@pCentreName varchar(50),
	@pProgramId varchar(10),
	@pProgramName varchar(20),
	@pClientId varchar(4),
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

    create table #Report(
      Name varchar(20),
      CentreName varchar(50),
      Program varchar(20),
      Attended varchar(2),
      [Absent] varchar(2),
      ReasonForAbsence varchar(100),
      Period varchar(6)
      )
    
    --close cursor_atten_view
    --deallocate cursor_atten_view
    
    declare cursor_atten_view Cursor for
      select [Status], Remark, Period from Client_AttendanceView where
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
        --Period >= @pPeriodFrom and
        --Period <= @pPeriodTo 
              
     declare @Attended varchar(2) 
     declare @Absent varchar(2) 
     declare @nAttendence int -- local
     declare @nAbsence int -- local
     declare @reason varchar(100)
     declare @Period varchar(6)
     
     declare @ReasonForAbsence varchar(100)
     declare @Status varchar(1) 

     select @nAbsence = 0
     select @nAttendence = 0
     	     
     open cursor_atten_view 
     fetch next from cursor_atten_view into @Status, @reason, @Period
     while @@FETCH_STATUS = 0
     begin
    
       if @Status = '1'
         begin
           select @nAbsence = @nAbsence + 1
           select @reason = @Status + '\n' + @reason
         end
       else if @Status = '2'
         select @nAttendence = @nAttendence + 1
     end
     
     insert into #Report (Name, CentreName, Program, Attended, [Absent],
       ReasonForAbsence, Period)
     values
       (@pClientName, @pCentreName, @pProgramName, @nAttendence, @nAbsence,
          @reason, @Period)
          
     close cursor_atten_view
     deallocate cursor_atten_view
     
     select * from #Report

END
GO

exec NTUCEldrcare_Sp_Attendance   '16', 'Silver Circle (Fengshan)',
'83', 'program name', '1075', 'Client Name', 'S2083641E', '201504', '201505'
go

   
      --select [Status], Remark, Period from Client_AttendanceView where
      --  CentreId = '16' and
      --  ProgrammeId = '83' and
      --  ClientId = '1075' and
      --  NRIC = 'S2083641E' and
      --  Period >= '201504' and
      --  Period <= '201505' 
        
        -- and
         --Status = 1 -- absence