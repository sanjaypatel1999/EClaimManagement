USE [emsdb]
GO
/****** Object:  UserDefinedFunction [dbo].[HashPassword]    Script Date: 11/4/2023 8:36:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[HashPassword](@pass varchar(100))
returns nvarchar(500)
as
begin
declare @afterhash varbinary(500) = HASHBYTES('SHA2_256', @pass)
return convert(nvarchar(1000), @afterhash, 2) 
end
GO
/****** Object:  StoredProcedure [dbo].[raise_error]    Script Date: 11/4/2023 8:36:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[raise_error]
as
begin

   DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;

    SELECT 
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();
		
    RAISERROR (@ErrorMessage, -- Message text.
               @ErrorSeverity, -- Severity.
               @ErrorState -- State.
               );
	end
GO
/****** Object:  StoredProcedure [dbo].[usd_get_program_path]    Script Date: 11/4/2023 8:36:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- usd_get_program_path 4
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE proc [dbo].[usd_get_program_path]
@UserId INT
as
begin
select p.Id,
	p.P_title title,
  CASE WHEN p.Path='Claim/ShowClaim' THEN	p.path+'?Role='+(select Role from Role_master(nolock) 
			where Id=(select RoleId from Role_Employee_Mapping(nolock) where EmpId=@UserId)) 
			ELSE p.Path END
			path,
	p.Descr
	from Program_Master p 
	inner join Tbl_Rights tr on p.Id=tr.Programe_id 
		where tr.UserId = @UserId 
		AND ( p.Status =1 AND tr.Status =1 )
			order by p.Display_Sequence
end


GO
/****** Object:  StoredProcedure [dbo].[USP_GET_Pending_Request]    Script Date: 11/4/2023 8:36:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GET_Pending_Request]
@role varchar(20),
@userid int
as
begin

	select cm.Id,
			cm.Amount,
			cm.Claim_Title,
			cm.Claim_Reason,
			cm.Claim_Description,
			cm.ClaimDt,
			cm.Evidence,
			cm.ExpenseDt,
			cm.CurrentStatus,
			um.Nm
	from Claim_Master(nolock) cm
	JOIN
	User_Master(nolock)um on um.Id=cm.UserId
	WHERE cm.CurrentStatus=(
	select rm.Action from 
	Employee_Claim_Role_Master(nolock)rm where rm.Role=@role
	) AND ( um.Manager_Id= CASE WHEN @role = 'Manager' THEN 
			@userid ELSE um.Manager_Id
			END)


end
GO
/****** Object:  StoredProcedure [dbo].[usp_get_user_by_email]    Script Date: 11/4/2023 8:36:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[usp_get_user_by_email]
@email varchar(100)
as
begin

select Id,Nm,Email,Mobile,Manager_Id 
		from User_Master(nolock) 
				where Email=@email
end
GO
/****** Object:  StoredProcedure [dbo].[USP_LoginUser]    Script Date: 11/4/2023 8:36:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_LoginUser]
@email varchar(50),
@pass varchar(100)
as
begin
	if(EXISTS(SELECT 1 from User_Master(NOLOCK) where Email=@email and Status=1))
	begin
	if exists (select 1 from User_Master where Email = @email AND Password = dbo.HashPassword(@pass))
	begin
		select 1 as result
	end
	else
	begin
		select 2 as result
	end
	end
	else
	begin
	select 3 as result
	end
end
GO
/****** Object:  StoredProcedure [dbo].[USP_Raise_Claim_Request]    Script Date: 11/4/2023 8:36:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--exec USP_Raise_Claim_Request 'Refund pertrol charges','travel',2000,'2023-10-02','fake.jpg','test',2

--select* from Claim_Master


--truncate table Employee_Claim_Action


CREATE proc [dbo].[USP_Raise_Claim_Request]
@Claim_Title varchar(100),
@Claim_Reason varchar(50),
@Amount DECIMAL,
@ExpenseDt varchar(100),
@Evidence varchar(500)=null,
@Claim_Description varchar(500),
@UserId int
as 
begin

	Declare @current_status varchar(100)
	Declare @ClaimID INT
	select @current_status=NextAction 
			from Employee_Claim_Master_Mapping(nolock) 
				where CurrentAction='Initiated'
	
	
	if(EXISTS(SELECT 1 FROM Claim_Master(NOLOCK) where UserId=@UserId AND CurrentStatus LIKE '%Pending%'))
	BEGIN
	THROW 50000, 'Claim already in pending', 1
	--raiserror('Claim already in pending',1,16)
	return
	END
	begin try
	begin transaction trn_claim
	insert into Claim_Master 
				(Claim_Title,
				Claim_Reason,
				Amount,
				ClaimDt,
				Evidence,
				Claim_Description,
				CurrentStatus,
				Status,
				UserId,
				ExpenseDt)
			VALUES
				(
				@Claim_Title,
				@Claim_Reason,
				@Amount,
				GETDATE(),
				@Evidence,
				@Claim_Description,
				@current_status,
				1,
				@UserId,
				@ExpenseDt		
				)
	SET @ClaimID=SCOPE_IDENTITY();
	
	----------insert record in action table----------------
	insert into Employee_Claim_Action(
					ClaimId,
					Action,
					ActionBy,
					ActionDt,
					Remarks,
					Status
					)
					VALUES
					(
					@ClaimID,
					'Initiated',
					@UserId,
					GETDATE(),
					@Claim_Description,
					1
					)
	Commit transaction trn_claim
	-------------------
	end try
	begin catch
	rollback transaction trn_claim
	exec raise_error
	end catch
	end





GO
/****** Object:  StoredProcedure [dbo].[usp_update_claim]    Script Date: 11/4/2023 8:36:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE proc [dbo].[usp_update_claim]
@role varchar(20),
@action tinyint, --action will 1-approve 0-reject
@remark varchar(200),
@claimid int,
@userid int
as
begin

declare @current_status varchar(100)
declare @next_action varchar(100)

select @current_status=CurrentStatus 
		from Claim_Master(nolock)cm where cm.Id=@claimid

select @next_action=NextAction 
		from Employee_Claim_Master_Mapping(nolock)mp
			where mp.CurrentAction=@current_status and mp.Status=@action

begin tran trn_update_claim
	begin try
	update Claim_Master set CurrentStatus=@next_action where Id=@claimid

	insert into Employee_Claim_Action(
						ClaimId,
						Action,
						ActionBy,
						ActionDt,
						Remarks,
						Status
						)
				values
						(@claimid,
						@next_action,
						@userid,
						getdate(),
						@remark,
						1 
						)

	commit tran trn_update_claim
	end try
	begin catch
	rollback tran trn_update_claim
	end catch



end


GO
