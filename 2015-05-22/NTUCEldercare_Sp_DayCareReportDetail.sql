USE [NTUCEldercare_17042015_NEW]
GO
/****** Object:  StoredProcedure [dbo].[NTUCEldercare_Sp_DayCareReportDetail]    Script Date: 05/22/2015 15:20:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 2015-05-22 Zhou Kai starts to study this procedure
--NTUCEldercare_Sp_DayCareReportDetail '2010-01-01','2015-05-10'  
ALTER proc [dbo].[NTUCEldercare_Sp_DayCareReportDetail_test] (@stDate datetime, @endDate datetime)  
as  
begin  
  
 create table #Report   
  ( clientid bigint null,  
   centreid bigint,   
   centrename nvarchar(150),   
   nric nvarchar(150) null,  
   clientname nvarchar(150) null,  
   gender nvarchar(10) null,  
   age int null,  
   race nvarchar(150) null,  
   address nvarchar(500) null,  
   constituency nvarchar(500) null,  
   emergencycontactperson nvarchar(500) null,  
   emergencycontactno nvarchar(50) null,  
   emergencycontactpersonrelationship nvarchar(150) null,  
   ntucunionmember nvarchar(500) null,  
   ntucunionmemberrelationship nvarchar(500) null,  
   ntucunionmembernric nvarchar(500) null,  
   admissiondate datetime null,  
   withdrawaldate datetime null,  
   reasonforwithdrawal nvarchar(max) null,  
   sourceofreferral nvarchar(max) null,  
   referraldate datetime null,  
   serviceschedule nvarchar(max) null,  
   category nvarchar(max) null,  
   transport float null,  
   companionmeal float null  
  )  
    
 -- create service columns  
 select distinct name as servicename into #service from service  
  where servicegroupid=1 and IsDeleted != 1  
   
 declare service_curr cursor for  
 select * from #service  
  
 declare @servicename nvarchar(500)  
 set @servicename = ''  
   
 Open service_curr  
 fetch next from service_curr into @servicename  
 while @@fetch_status = 0  
 begin  
     
  exec ('alter table #report add [' + @servicename + '] nvarchar(150) null ')  
  fetch next from service_curr into @servicename  
 end  
    
 close service_curr  
 deallocate service_curr  
  
 -- create subsidy columns  
 declare subsidy_curr cursor for  
 select name as subsidyname from subsidy  
  where servicegroupid=1 and IsDeleted != 1  
  
 declare @subsidyname nvarchar(500)  
 set @subsidyname = ''  
  
 Open subsidy_curr  
 fetch next from subsidy_curr into @subsidyname  
 while @@fetch_status = 0  
 begin  
  exec ('alter table #report add [' + @subsidyname + '] nvarchar(150) null ')  
  fetch next from subsidy_curr into @subsidyname  
 end  
    
 close subsidy_curr  
 deallocate subsidy_curr  
  
  
 -- create corporate discount columns  
 declare corpdiscount_curr cursor for  
 select name as name from CorporateDiscount  
  where servicegroupid=1 and IsDeleted != 1  
  
 declare @corpdiscname nvarchar(500)  
 set @corpdiscname = ''  
  
 Open corpdiscount_curr  
 fetch next from corpdiscount_curr into @corpdiscname  
 while @@fetch_status = 0  
 begin  
  IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS  
  WHERE TABLE_NAME = 'tempdb.#report' AND COLUMN_NAME like '[' + @corpdiscname + ']')  
  BEGIN  
     exec ('alter table #report add [' + @corpdiscname + '] nvarchar(150) null ')  
  END  
  --exec ('alter table #report add [' + @corpdiscname + '] nvarchar(150) null ')  
  fetch next from corpdiscount_curr into @corpdiscname  
 end  
    
 close corpdiscount_curr  
 deallocate corpdiscount_curr  
  
  
 
 
  
 --/// Means Test
 declare TestTier_curr cursor for  
 SELECT distinct a.tierdescription
 FROM MeansTesttier a
 where deleted =0
 
  
 declare @TestTierName nvarchar(500)  
 set @TestTierName = ''  
  
 Open TestTier_curr  
 fetch next from TestTier_curr into @TestTierName  
 while @@fetch_status = 0  
 begin  
  exec ('alter table #report add [' + 'Tier ' + @TestTierName + '] nvarchar(150) null ')  
  fetch next from TestTier_curr into @TestTierName  
 end 
 
 close TestTier_curr  
 deallocate TestTier_curr  
 --/// 
  
 alter table #report add FullPayment char(1)  
 alter table #report add PaymentDue char(1)  
  
   
  
 Declare @plantype as int  
 set @plantype = 0  
 select @plantype = Id from lookup_data where category='DayCarePlanType' and name='Regular'  
   
 -- client curr  
 select distinct clientid into #clientdaycare from Client_DayCareServicePlan  as cdp  
 inner join daycareplan dp on dp.ID = cdp.daycareplanid and dp.plantype=@plantype   
 inner join client c on c.id = cdp.clientid and c.isdeleted = 0   
 where cdp.EffectiveDate <= @endDate  
  
 declare client_cursor cursor for   
 select clientid  
 from #clientdaycare  
  
 open client_cursor    
 declare @clientid int  
 fetch next from client_cursor into @clientid   
 while @@fetch_status = 0    
 begin    
    
  -- reset values for every client  
  declare @id bigint  
  set @id= 0  
  declare @centreid bigint  
  set @centreid  = 0  
  declare @daycareplanid bigint  
  set @daycareplanid  = 0  
  declare @transportfee float  
  set @transportfee = 0  
  declare @companionmeal float  
  set @companionmeal = 0  
  declare @FrequencyDelimit nvarchar(max)  
  set @FrequencyDelimit  = ''  
  declare @ServicePlanIdDelimit nvarchar(max)  
  set @ServicePlanIdDelimit = ''  
   
  
  set @centreid = 0  
  set @id = 0  
  set @daycareplanid = 0  
  set @transportfee = 0  
  set @companionmeal = 0   
  
  select top 1 @id = id, @daycareplanid = daycareplanid, @transportfee=transportfee, @companionmeal=companionmeal, @centreid = centreId,   
   @FrequencyDelimit=FrequencyDelimit, @ServicePlanIdDelimit = ServicePlanIdDelimit  
  from Client_DayCareServicePlan where clientid = @clientid and effectivedate<=@endDate order by effectivedate desc  
  
  
  -- insert centre client details  
  insert into #report (  
  clientid,  
  centreid,   
  centrename,   
  nric,  
  clientname,  
  gender,  
  age,  
  race,  
  address,  
  constituency,  
  emergencycontactperson,  
  emergencycontactno,  
  emergencycontactpersonrelationship,  
  ntucunionmember,  
  ntucunionmemberrelationship,  
  ntucunionmembernric,  
  sourceofreferral,  
  referraldate  
  )  
  select @clientid,  
  @centreid,  
  centre.name,  
  isnull(client.nric,''),  
  isnull(client.name,''),  
  isnull(gender.name,''),  
  case  
   when DATEPART(day, client.dob) > DATEPART(day, getdate()) then DATEDIFF(month, client.dob, getdate()) - 1  
   else DATEDIFF(month, client.dob, getdate())  
   end / 12   
  as Age,  
  isnull(race.name,''),  
  isnull(client.address,'') + ' ' + isnull(client.postcode,''),  
  Constituency.name, -- constituency  
  isnull(client_emergency.name,'') as contactpersonname,  
  isnull(client_emergency.mobile,'') as contactpersoncontactno,  
  isnull(contact.name,'') as relationship,  
  cb.unioncardnumber,  
  unionrelationship.name,  
  cb.unionnric,  
  isnull(InformationSource.name,''),  
  client_informationsource.ReferalDate  
  from Client_DayCareServicePlan as cdb  
   inner join client on client.id = @clientid  
   left join lookup_data as gender on gender.id = client.genderid  
   left join lookup_data as race on race.id = client.raceid  
   left join client_emergency on client_emergency.clientid = client.id and  
     client_emergency.id in (select max(id) from client_emergency where isdeleted=0 and clientid = @clientid)  
   left join lookup_data as contact on contact.id = client_emergency.relationship  
   left join client_informationsource on client_informationsource.clientid=@clientid  
    and client_informationsource.id in (select max(id) from client_informationsource where clientid = @clientid and ServiceGroupid=1)  
   left join InformationCategory as InformationCategory on InformationCategory.id=client_informationsource.InforCategoryId  
   left join InformationSource as InformationSource on InformationSource.id=client_informationsource.InformationSourceId   
   left join client_background as cb on cb.clientid = @clientid  
   left join lookup_data as unionrelationship on unionrelationship.id = cb.unionrelationship  
   left join centre on centre.id = cdb.centreid  
   left join Constituency on client.ConstituencyId = Constituency.id  
   where @id = cdb.id  
  
  
  -- get admission date  
  declare @serviceplanid bigint  
  set @serviceplanid = 0  
  declare @admissiondate datetime  
  set @admissiondate = null  
  declare @withdrawdate datetime  
  set @withdrawdate = null  
  declare @withdrawreason nvarchar(500)  
  set @withdrawreason = null  
  
  select top 1 @serviceplanid = client_serviceplan.id,   
   @admissiondate=admissiondate,   
   @withdrawdate=WithdrawalDate,  
   @withdrawreason=lookup_data.name   
     from client_serviceplan   
    left join lookup_data on lookup_data.id=client_serviceplan.WithdrawalReason  
    where clientid=@clientid and createddate<=@enddate order by createddate desc  
  
  update #report   
  set  admissiondate = @admissiondate,  
    withdrawaldate = @withdrawdate,  
    reasonforwithdrawal = @withdrawreason  
  where clientid = @clientid  
   
     
  -- services schedule  
  update #report set serviceschedule = converT(nvarchar(10),isnull(dbo.Fn_GetServiceFrequencyCount(@FrequencyDelimit),0)) + ' days per week'  
  where clientid = @clientid  
  
    
  declare @category as nvarchar(max)  
  select  @category = case   
    when catagory='Cat1' then 'Cat 1'   
    when catagory='Cat2' then 'Cat 2'  
    when catagory='Cat3' then 'Cat 3'  
    when catagory='Cat4' then 'Cat 4' end   
  from Client where id= @clientid  
  
  update #report set Category=@category where clientid=@clientid  
  update #report set transport = @transportfee where clientid=@clientid  
  update #report set companionmeal =  isnull(@companionmeal,0) where clientid=@clientid  
  
  
  -- services    
  declare service_curr1 cursor for  
  select id, name from service where servicegroupid=1 and IsDeleted != 1  
  
  declare @serviceidcheck nvarchar(500)  
  declare @servicenamecheck nvarchar(500)  
    
  Open service_curr1  
  fetch next from service_curr1 into @serviceidcheck,@servicenamecheck  
  while @@fetch_status = 0  
  begin  
   declare @servicecount int  
   set @servicecount = 0     
     
   select @servicecount = COUNT(*) from dbo.Split(@ServicePlanIdDelimit, ',') where Data in (@serviceidcheck)  
   if (@servicecount > 0)  
    exec ('update #report set [' + @servicenamecheck + '] = ''Y'' where clientid='+@Clientid)  
   else  
    exec ('update #report set [' + @servicenamecheck + '] = ''N'' where clientid='+@Clientid)  
  
   fetch next from service_curr1 into @serviceidcheck, @servicenamecheck  
  end  
     
  close service_curr1  
  deallocate service_curr1   
  
  
  declare @clientsubsidy as nvarchar(max)  
  set @clientsubsidy = ''  
  declare @clientcorpdic as nvarchar(max)  
  set @clientcorpdic = ''  
  select top 1 @clientsubsidy = SubsidyIdDelimit, @clientcorpdic = CorporateDiscountIdDelimit from Client_Subsidy where clientid=@clientid  
    and servicegroupid=1 and effectivedate<=@enddate order by effectivedate  
  
  declare subsidy_curr1 cursor for  
  select id, name as subsidyname from subsidy  
   where servicegroupid=1 and IsDeleted != 1  
  
  declare @subsidyid1 as nvarchar(500)  
  declare @subsidyname1 nvarchar(500)  
  
    
  -- by default full payment is Y  
  update #report set FullPayment='Y' where clientid=@clientid  
    
  Open subsidy_curr1  
  fetch next from subsidy_curr1 into @subsidyid1, @subsidyname1  
  while @@fetch_status = 0  
  begin  
   if charindex(@subsidyid1, @clientsubsidy)>0  
    begin  
     exec ('update #report set [' + @subsidyname1 + '] = ''Y'' where clientid='+@Clientid)  
     update #report set FullPayment='N' where clientid=@clientid  
    end  
   else  
    exec ('update #report set [' + @subsidyname1 + '] = ''N'' where clientid='+@Clientid)  
  
   fetch next from subsidy_curr1 into @subsidyid1, @subsidyname1  
  end  
     
  close subsidy_curr1  
  deallocate subsidy_curr1  
  
  
  -- create corporate discount columns  
  declare corpdiscount_curr1 cursor for  
  select id, name from CorporateDiscount  
   where servicegroupid=1 and IsDeleted != 1  
  
  declare @corpdiscid1 as nvarchar(500)  
  declare @corpdiscname1 nvarchar(500)  
  
  Open corpdiscount_curr1  
  fetch next from corpdiscount_curr1 into @corpdiscid1, @corpdiscname1  
  while @@fetch_status = 0  
  begin  
   if charindex(@corpdiscid1, @clientcorpdic)>0  
    exec ('update #report set [' + @corpdiscname1 + '] = ''Y'' where clientid='+@Clientid)  
   else  
    exec ('update #report set [' + @corpdiscname1 + '] = ''N'' where clientid='+@Clientid)  
   fetch next from corpdiscount_curr1 into @corpdiscid1, @corpdiscname1  
  end  
  
  close corpdiscount_curr1  
  deallocate corpdiscount_curr1  
  
  -- check previous payment due  
  declare @previousinvoiceno as nvarchar(500)  
  declare @balance as float  
  set @balance = 0  
  select top 1 id,  isnull(TotalPayable,0) - isnull(ClientPaymentAmount,0) as balance   
  into #clientinvoice  
  from Invoice   
  where IsVoid=0 and IsClosed=1 and ServiceGroupId=1 and clientid=@ClientId  
  order by InvoiceDate desc  
  select @previousinvoiceno = id, @balance = balance from #clientinvoice  
    
  if isnull(@balance,0)>0  
   update #report set PaymentDue = 'Y' where Clientid = @Clientid  
  else  
   update #report set PaymentDue = 'N' where Clientid = @Clientid  
  
  drop table #clientinvoice  
  fetch next from client_cursor into @clientid   
   
 end  
  
  close client_cursor  
  deallocate client_cursor  
    
   --/// Means Test  
 declare TestTier_currUpdate cursor for  
 SELECT distinct a.tierdescription
 FROM MeansTesttier a
 where deleted =0
 
  
 declare @TestTierNameUpdate nvarchar(500)  
 set @TestTierNameUpdate = ''  
  
 Open TestTier_currUpdate  
 fetch next from TestTier_currUpdate into @TestTierNameUpdate  
 while @@fetch_status = 0  
 begin  
   exec ('update #report set ['  + 'Tier ' + @TestTierNameUpdate + '] = ''N''')     
  fetch next from TestTier_currUpdate into @TestTierNameUpdate  
 end 
 
 close TestTier_currUpdate  
 deallocate TestTier_currUpdate  
 --/// 
   
   
   
 declare TestTier_curr2 cursor for  
 SELECT tierdescription, ClientID
 FROM
 (
	 SELECT dense_rank() OVER (PARTITION BY b.clientid, b.testtier ORDER BY b.createddate DESC) as RnkNum , a.tierdescription, b.ClientID
	 FROM MeansTesttier a
	 INNER JOIN Client_Subsidy b
	 on a.tierId = b.testtier 
	 where deleted =0
 ) tbl
 where tbl.RnkNum =1 
 
  
 declare @TestTierName2 nvarchar(500)  
 declare @Clientid2 bigint 
  
 set @TestTierName2 = ''  
 set @Clientid2 = 0  
  
 Open TestTier_curr2 
 fetch next from TestTier_curr2 into @TestTierName2, @Clientid2  
 while @@fetch_status = 0  
 begin      
  exec ('update #report set ['  + 'Tier ' +  @TestTierName2 + '] = ''Y'' where clientid='+@Clientid2)     
  fetch next from TestTier_curr2 into @TestTierName2,@Clientid2
 end 
 
 close TestTier_curr2  
 deallocate TestTier_curr2  
 --///   
    
  alter table #report drop column centreid  
  alter table #report drop column clientid  
  
  select * from #report order by centrename, clientname  
  
  
end  
  
  