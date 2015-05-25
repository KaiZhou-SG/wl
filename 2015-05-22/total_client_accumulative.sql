USE [NTUCEldercare_17042015_NEW]
GO
/****** Object:  StoredProcedure [dbo].[NTUCEldercare_Sp_DCC_TotalAccumulatedClients]    Script Date: 05/22/2015 15:53:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[NTUCEldercare_Sp_DCC_TotalAccumulatedClients](@pOption int, @pCentreID int, @stDate datetime, @endDate datetime)
AS
BEGIN
    DECLARE @TempDayCareServicePlan TABLE -- 19 columns
    (
        ID BIGINT,
        ClientId BIGINT, 
		ServicePlanIdDelimit NVARCHAR(50),
        DayCarePlanId BIGINT,
        EffectiveDate DATETIME,
        CentreId BIGINT,
        TransportFee DECIMAL,
        CompanionMeal DECIMAL,
        FrequencyDelimit NVARCHAR(50),
        CreatedDate DATETIME,
        CreatedBy BIGINT,
        UpdatedDate DATETIME,
        UpdatedBy BIGINT,
        IsInvoiceProcessed BIT,
        NoOfDays INT,
        IsCurrentPlan BIT,
        PreviousPlanId BIGINT,
        ServiceGroupId INT, -- added new column
        EndDate DATETIME
    )

    INSERT INTO @TempDayCareServicePlan
    SELECT * FROM
    (
		SELECT P1.*, DATEADD(DAY, -1, P2.EffectiveDate) AS EndDate
		FROM dbo.Client_DayCareServicePlan P1
		INNER JOIN dbo.Client_DayCareServicePlan P2 ON P1.ID = P2.PreviousPlanId    
		UNION     
		SELECT P1.*, GETDATE() AS EndDate
		FROM dbo.Client_DayCareServicePlan P1
		WHERE P1.IsCurrentPlan = 1
    ) AS T
    WHERE 
    T.EndDate >= T.EffectiveDate  
    
    
    DECLARE @servicegroupId INT
    SET @servicegroupId = 1

    CREATE TABLE #Report
    (    CentreId BIGINT,
        CentreName nvarchar(150),    
        TotalRegisteredClients int null,
        AccumulatedTotalRegisteredClients int null,
    )   

    DECLARE  Curr_Centre CURSOR FOR
    SELECT Id, name FROM Centre
    WHERE Name != '-' and IsDeleted = 0 and ServiceGroupId = @servicegroupId

    DECLARE @CentreId INT
    DECLARE @name nvarchar(150)

    OPEN Curr_Centre
    FETCH NEXT FROM Curr_Centre INTO @CentreId, @name
    WHILE    @@fetch_status = 0
    BEGIN
   
        ---- start Tota/Accumulated Clients -----
        DECLARE @AssignedDate DATETIME
        SET @AssignedDate = CONVERT(DATETIME, '2010-12-31')
       
        DECLARE @AssignedCountForTotalRegistered int
        SET @AssignedCountForTotalRegistered = 0;
       
        DECLARE @AssignedCountForTotalAccumulated int
        SET @AssignedCountForTotalAccumulated = 0;
        IF(@AssignedDate <= @stDate OR @AssignedDate <= @endDate)
        BEGIN
            if(@CentreId = 1)
                set @AssignedCountForTotalAccumulated = 29
            else if(@CentreId = 2)
                set @AssignedCountForTotalAccumulated = 42
            else if(@CentreId = 3)
                set @AssignedCountForTotalAccumulated = 255
            else if(@CentreId = 4)
                set @AssignedCountForTotalAccumulated = 99
            else if(@CentreId = 5)
                set @AssignedCountForTotalAccumulated = 29
            else if(@CentreId = 12)
                set @AssignedCountForTotalAccumulated = 2
            else if(@CentreId = 14)
                set @AssignedCountForTotalAccumulated = 0
        END   

        INSERT INTO #Report
        SELECT @CentreId AS CentreId, @name AS CentreName, R.Total AS TotalRegisteredClients, A.Total AS AccumulatedTotalRegisteredClients
        FROM
        (
            SELECT @CentreId AS CentreId, (ISNULL(COUNT(DISTINCT dcc.ClientId), 0)) AS Total FROM @TempDayCareServicePlan dcc
			INNER JOIN dbo.Client c ON dcc.ClientId = c.ID AND c.IsDeleted = 0
			INNER JOIN dbo.DayCarePlan dc ON dcc.DayCarePlanId = dc.ID AND dc.IsDeleted = 0
			INNER JOIN dbo.Client_ServicePlan sp ON sp.ClientId = dcc.ClientId AND sp.IsDeleted = 0
			INNER JOIN dbo.ServiceGroup sg ON sg.ID = sp.ServiceGroupId AND sg.Name = 'DayCare'
			INNER JOIN (SELECT ID FROM dbo.Lookup_Data WHERE Lookup_Data.Category in ('DayCarePlanType')
			AND dbo.Lookup_Data.Name IN ('Regular')
			) lk ON lk.ID = dc.PlanType
			WHERE dcc.CentreId = @CentreId
			AND 
			(
				(dcc.IsCurrentPlan = 1 AND dcc.EffectiveDate <= @endDate) 
				OR (dcc.EffectiveDate <= dcc.EndDate AND dcc.EndDate >= @stDate AND dcc.EndDate <= @endDate AND (dcc.IsCurrentPlan = 0 OR dcc.IsCurrentPlan IS NULL))
				OR (dcc.EffectiveDate <= @EndDate AND dcc.EndDate >= @EndDate AND (dcc.IsCurrentPlan = 0 OR dcc.IsCurrentPlan IS NULL))
			)
			AND
			(
				sp.WithdrawalDate IS NULL 
				OR DATEADD(mm, cast(sp.WithdrawalNextMonth as int), sp.WithdrawalDate) > @endDate	
			) 
			AND sp.IsDeleted != 1
        ) AS R
        LEFT JOIN
        (
            SELECT @CentreId AS CentreId, (ISNULL(COUNT(DISTINCT dcc.ClientId), 0) + @AssignedCountForTotalAccumulated) AS Total
            FROM @TempDayCareServicePlan dcc
            INNER JOIN dbo.Client c ON dcc.ClientId = c.ID AND c.IsDeleted = 0
            INNER JOIN dbo.DayCarePlan dc ON dcc.DayCarePlanId = dc.ID 
            --AND dc.IsDeleted = 0
            INNER JOIN dbo.Client_ServicePlan sp ON sp.ClientId = dcc.ClientId AND sp.IsDeleted = 0
            INNER JOIN dbo.ServiceGroup sg ON sg.ID = sp.ServiceGroupId AND sg.Name = 'DayCare'
            INNER JOIN (SELECT ID FROM dbo.Lookup_Data WHERE Lookup_Data.Category in ('DayCarePlanType')
					AND dbo.Lookup_Data.Name IN ('Regular','Respite')
					) lk ON lk.ID = dc.PlanType              
            WHERE dcc.CentreId = @CentreId
            --AND IsCurrentPlan = 1
            AND 
            (
				(dcc.IsCurrentPlan = 1 AND dcc.EffectiveDate <= @endDate) 
				OR (dcc.EffectiveDate <= dcc.EndDate AND dcc.EndDate >= @stDate AND dcc.EndDate <= @endDate AND (dcc.IsCurrentPlan = 0 OR dcc.IsCurrentPlan IS NULL))
				OR (dcc.EffectiveDate <= @EndDate AND (dcc.IsCurrentPlan = 0 OR dcc.IsCurrentPlan IS NULL))
			)
			AND dcc.ClientId NOT IN ---- to exclude customers with only trial plan
			(
				SELECT DISTINCT dcc.ClientId FROM dbo.Client_DayCareServicePlan dcc
				INNER JOIN dbo.Client c ON dcc.ClientId = c.ID AND c.IsDeleted = 0
				INNER JOIN dbo.DayCarePlan dc ON dcc.DayCarePlanId = dc.ID AND dc.IsDeleted = 0
				INNER JOIN dbo.Client_ServicePlan sp ON dcc.ClientId = sp.ClientId
				INNER JOIN dbo.ServiceGroup sg ON sp.ServiceGroupId = sg.ID AND sg.Name = 'DayCare'
				WHERE dcc.CentreId = @CentreId 
				AND dcc.ClientId NOT IN
				(
					SELECT DISTINCT dcc.ClientId FROM dbo.Client_DayCareServicePlan dcc
					INNER JOIN dbo.Client c ON dcc.ClientId = c.ID AND c.IsDeleted = 0
					INNER JOIN dbo.DayCarePlan dc ON dcc.DayCarePlanId = dc.ID AND dc.IsDeleted = 0
					INNER JOIN dbo.Client_ServicePlan sp ON dcc.ClientId = sp.ClientId
					INNER JOIN dbo.ServiceGroup sg ON sp.ServiceGroupId = sg.ID AND sg.Name = 'DayCare'
					INNER JOIN (SELECT ID FROM dbo.Lookup_Data WHERE Lookup_Data.Category in ('DayCarePlanType')
					AND dbo.Lookup_Data.Name IN ('Regular','Respite')
					) lk ON lk.ID = dc.PlanType
					INNER JOIN @TempDayCareServicePlan T on dcc.ID = T.ID -- to exclude plan with same effective date
					WHERE dcc.CentreId = @CentreId 
					AND T.EffectiveDate <= T.EndDate -- to exclude plan with same effective date
					AND sp.IsDeleted != 1
				)
				AND dcc.EffectiveDate <= @EndDate	
			)
        ) AS A ON R.CentreId = A.CentreId
       
        FETCH NEXT FROM Curr_Centre INTO @CentreId, @name

    END
   
    CLOSE Curr_Centre
    DEALLOCATE Curr_Centre
   
    SELECT centrename, TotalRegisteredClients, AccumulatedTotalRegisteredClients FROM #Report order by centrename
END
