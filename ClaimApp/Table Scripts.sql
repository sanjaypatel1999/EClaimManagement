USE [emsdb]
GO
/****** Object:  Table [dbo].[Claim_Master]    Script Date: 11/4/2023 8:36:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Claim_Master](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Claim_Title] [varchar](100) NULL,
	[Claim_Reason] [varchar](100) NULL,
	[Amount] [decimal](18, 0) NULL,
	[ClaimDt] [datetime] NULL,
	[Evidence] [varchar](500) NULL,
	[Claim_Description] [varchar](500) NULL,
	[CurrentStatus] [varchar](50) NULL,
	[Status] [tinyint] NULL,
	[UserId] [int] NULL,
	[ExpenseDt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee_Claim_Action]    Script Date: 11/4/2023 8:36:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee_Claim_Action](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ClaimId] [int] NULL,
	[Action] [varchar](100) NULL,
	[ActionBy] [int] NULL,
	[ActionDt] [datetime] NULL,
	[Remarks] [varchar](100) NULL,
	[Status] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee_Claim_Master_Mapping]    Script Date: 11/4/2023 8:36:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee_Claim_Master_Mapping](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CurrentAction] [varchar](100) NULL,
	[NextAction] [varchar](100) NULL,
	[Status] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee_Claim_Role_Master]    Script Date: 11/4/2023 8:36:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee_Claim_Role_Master](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Role] [varchar](100) NULL,
	[Action] [varchar](100) NULL,
	[Status] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee_Claim_Transaction]    Script Date: 11/4/2023 8:36:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee_Claim_Transaction](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Transaction_No] [varchar](100) NULL,
	[Employee_Id] [int] NULL,
	[Amount] [decimal](18, 0) NULL,
	[TransactionDt] [datetime] NULL,
	[ClaimId] [int] NULL,
	[Status] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Program_Master]    Script Date: 11/4/2023 8:36:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Program_Master](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[P_title] [varchar](100) NULL,
	[Path] [varchar](500) NULL,
	[Descr] [varchar](500) NULL,
	[Display_Sequence] [int] NULL,
	[Status] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role_Employee_Mapping]    Script Date: 11/4/2023 8:36:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role_Employee_Mapping](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [int] NULL,
	[EmpId] [int] NULL,
	[Status] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role_master]    Script Date: 11/4/2023 8:36:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role_master](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Role] [varchar](100) NULL,
	[Status] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_Rights]    Script Date: 11/4/2023 8:36:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Rights](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Programe_id] [int] NULL,
	[UserId] [int] NULL,
	[RoleId] [int] NULL,
	[Status] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User_Master]    Script Date: 11/4/2023 8:36:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User_Master](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nm] [varchar](100) NULL,
	[Email] [varchar](100) NULL,
	[Mobile] [varchar](100) NULL,
	[Password] [varchar](500) NULL,
	[Manager_Id] [int] NULL,
	[Status] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Claim_Master] ON 
GO
INSERT [dbo].[Claim_Master] ([Id], [Claim_Title], [Claim_Reason], [Amount], [ClaimDt], [Evidence], [Claim_Description], [CurrentStatus], [Status], [UserId], [ExpenseDt]) VALUES (1, N'Food expense', N'Food', CAST(4500 AS Decimal(18, 0)), CAST(N'2023-11-02T21:35:01.273' AS DateTime), N'EvidenceFiles/Evidence_cb789437-a570-4f5b-9e3f-5ac46f29bcb0.jpg', N'test', N'Completed', 1, 2, CAST(N'2023-11-03T00:00:00.000' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Claim_Master] OFF
GO
SET IDENTITY_INSERT [dbo].[Employee_Claim_Action] ON 
GO
INSERT [dbo].[Employee_Claim_Action] ([Id], [ClaimId], [Action], [ActionBy], [ActionDt], [Remarks], [Status]) VALUES (1, 1, N'Initiated', 2, CAST(N'2023-11-02T21:35:01.273' AS DateTime), N'test', 1)
GO
INSERT [dbo].[Employee_Claim_Action] ([Id], [ClaimId], [Action], [ActionBy], [ActionDt], [Remarks], [Status]) VALUES (2, 1, N'Pending at HR', 1, CAST(N'2023-11-04T20:09:58.943' AS DateTime), N'ok for approval', 1)
GO
INSERT [dbo].[Employee_Claim_Action] ([Id], [ClaimId], [Action], [ActionBy], [ActionDt], [Remarks], [Status]) VALUES (3, 1, N'Pending at Account', 4, CAST(N'2023-11-04T20:17:05.383' AS DateTime), N'Ok for payment', 1)
GO
INSERT [dbo].[Employee_Claim_Action] ([Id], [ClaimId], [Action], [ActionBy], [ActionDt], [Remarks], [Status]) VALUES (4, 1, NULL, 5, CAST(N'2023-11-04T20:20:40.593' AS DateTime), N'not ok', 1)
GO
INSERT [dbo].[Employee_Claim_Action] ([Id], [ClaimId], [Action], [ActionBy], [ActionDt], [Remarks], [Status]) VALUES (5, 1, N'Completed', 5, CAST(N'2023-11-04T20:25:12.550' AS DateTime), N'ok for money', 1)
GO
INSERT [dbo].[Employee_Claim_Action] ([Id], [ClaimId], [Action], [ActionBy], [ActionDt], [Remarks], [Status]) VALUES (6, 1, N'Completed', 5, CAST(N'2023-11-04T20:26:15.207' AS DateTime), N'ok', 1)
GO
INSERT [dbo].[Employee_Claim_Action] ([Id], [ClaimId], [Action], [ActionBy], [ActionDt], [Remarks], [Status]) VALUES (7, 1, N'Completed', 5, CAST(N'2023-11-04T20:27:26.540' AS DateTime), N'okk', 1)
GO
INSERT [dbo].[Employee_Claim_Action] ([Id], [ClaimId], [Action], [ActionBy], [ActionDt], [Remarks], [Status]) VALUES (8, 1, N'Completed', 5, CAST(N'2023-11-04T20:28:22.993' AS DateTime), N'okkk', 1)
GO
SET IDENTITY_INSERT [dbo].[Employee_Claim_Action] OFF
GO
SET IDENTITY_INSERT [dbo].[Employee_Claim_Master_Mapping] ON 
GO
INSERT [dbo].[Employee_Claim_Master_Mapping] ([Id], [CurrentAction], [NextAction], [Status]) VALUES (1, N'Initiated', N'Pending at Manager', 1)
GO
INSERT [dbo].[Employee_Claim_Master_Mapping] ([Id], [CurrentAction], [NextAction], [Status]) VALUES (2, N'Pending at Manager', N'Pending at HR', 1)
GO
INSERT [dbo].[Employee_Claim_Master_Mapping] ([Id], [CurrentAction], [NextAction], [Status]) VALUES (3, N'Pending at Manager', N'Rejected By Manager', 0)
GO
INSERT [dbo].[Employee_Claim_Master_Mapping] ([Id], [CurrentAction], [NextAction], [Status]) VALUES (4, N'Pending at HR', N'Pending at Account', 1)
GO
INSERT [dbo].[Employee_Claim_Master_Mapping] ([Id], [CurrentAction], [NextAction], [Status]) VALUES (5, N'Pending at HR', N'Rejected By HR', 0)
GO
INSERT [dbo].[Employee_Claim_Master_Mapping] ([Id], [CurrentAction], [NextAction], [Status]) VALUES (6, N'Pending at Account', N'Completed', 1)
GO
SET IDENTITY_INSERT [dbo].[Employee_Claim_Master_Mapping] OFF
GO
SET IDENTITY_INSERT [dbo].[Employee_Claim_Role_Master] ON 
GO
INSERT [dbo].[Employee_Claim_Role_Master] ([Id], [Role], [Action], [Status]) VALUES (1, N'Employee', N'Initiated', 1)
GO
INSERT [dbo].[Employee_Claim_Role_Master] ([Id], [Role], [Action], [Status]) VALUES (2, N'Manager', N'Pending at Manager', 1)
GO
INSERT [dbo].[Employee_Claim_Role_Master] ([Id], [Role], [Action], [Status]) VALUES (3, N'HR', N'Pending at HR', 1)
GO
INSERT [dbo].[Employee_Claim_Role_Master] ([Id], [Role], [Action], [Status]) VALUES (4, N'Account', N'Pending at Account', 1)
GO
SET IDENTITY_INSERT [dbo].[Employee_Claim_Role_Master] OFF
GO
SET IDENTITY_INSERT [dbo].[Program_Master] ON 
GO
INSERT [dbo].[Program_Master] ([Id], [P_title], [Path], [Descr], [Display_Sequence], [Status]) VALUES (1, N'Add Claim', N'Claim/AddClaim', N'Add new claim', 0, 1)
GO
INSERT [dbo].[Program_Master] ([Id], [P_title], [Path], [Descr], [Display_Sequence], [Status]) VALUES (2, N'Employee Claims', N'Claim/ShowClaim', N'show claim request', 1, 1)
GO
INSERT [dbo].[Program_Master] ([Id], [P_title], [Path], [Descr], [Display_Sequence], [Status]) VALUES (3, N'Dashboard', N'Home/Dashboard', N'dashboard', 2, 1)
GO
INSERT [dbo].[Program_Master] ([Id], [P_title], [Path], [Descr], [Display_Sequence], [Status]) VALUES (4, N'Show Claim Status', N'Claim/ClaimStatus', N'show claim', 3, 1)
GO
SET IDENTITY_INSERT [dbo].[Program_Master] OFF
GO
SET IDENTITY_INSERT [dbo].[Role_Employee_Mapping] ON 
GO
INSERT [dbo].[Role_Employee_Mapping] ([Id], [RoleId], [EmpId], [Status]) VALUES (1, 1, 2, 1)
GO
INSERT [dbo].[Role_Employee_Mapping] ([Id], [RoleId], [EmpId], [Status]) VALUES (2, 1, 3, 1)
GO
INSERT [dbo].[Role_Employee_Mapping] ([Id], [RoleId], [EmpId], [Status]) VALUES (3, 2, 1, 1)
GO
INSERT [dbo].[Role_Employee_Mapping] ([Id], [RoleId], [EmpId], [Status]) VALUES (4, 3, 4, 1)
GO
INSERT [dbo].[Role_Employee_Mapping] ([Id], [RoleId], [EmpId], [Status]) VALUES (5, 4, 5, 1)
GO
SET IDENTITY_INSERT [dbo].[Role_Employee_Mapping] OFF
GO
SET IDENTITY_INSERT [dbo].[Role_master] ON 
GO
INSERT [dbo].[Role_master] ([Id], [Role], [Status]) VALUES (1, N'Employee', 1)
GO
INSERT [dbo].[Role_master] ([Id], [Role], [Status]) VALUES (2, N'Manager', 1)
GO
INSERT [dbo].[Role_master] ([Id], [Role], [Status]) VALUES (3, N'HR', 1)
GO
INSERT [dbo].[Role_master] ([Id], [Role], [Status]) VALUES (4, N'Account', 1)
GO
SET IDENTITY_INSERT [dbo].[Role_master] OFF
GO
SET IDENTITY_INSERT [dbo].[Tbl_Rights] ON 
GO
INSERT [dbo].[Tbl_Rights] ([Id], [Programe_id], [UserId], [RoleId], [Status]) VALUES (1, 1, 1, NULL, 1)
GO
INSERT [dbo].[Tbl_Rights] ([Id], [Programe_id], [UserId], [RoleId], [Status]) VALUES (2, 2, 1, NULL, 1)
GO
INSERT [dbo].[Tbl_Rights] ([Id], [Programe_id], [UserId], [RoleId], [Status]) VALUES (3, 3, 1, NULL, 1)
GO
INSERT [dbo].[Tbl_Rights] ([Id], [Programe_id], [UserId], [RoleId], [Status]) VALUES (4, 4, 1, NULL, 1)
GO
INSERT [dbo].[Tbl_Rights] ([Id], [Programe_id], [UserId], [RoleId], [Status]) VALUES (5, 1, 2, NULL, 1)
GO
INSERT [dbo].[Tbl_Rights] ([Id], [Programe_id], [UserId], [RoleId], [Status]) VALUES (6, 4, 2, NULL, 1)
GO
INSERT [dbo].[Tbl_Rights] ([Id], [Programe_id], [UserId], [RoleId], [Status]) VALUES (7, 1, 3, NULL, 1)
GO
INSERT [dbo].[Tbl_Rights] ([Id], [Programe_id], [UserId], [RoleId], [Status]) VALUES (8, 4, 3, NULL, 1)
GO
INSERT [dbo].[Tbl_Rights] ([Id], [Programe_id], [UserId], [RoleId], [Status]) VALUES (9, 1, 4, NULL, 1)
GO
INSERT [dbo].[Tbl_Rights] ([Id], [Programe_id], [UserId], [RoleId], [Status]) VALUES (10, 2, 4, NULL, 1)
GO
INSERT [dbo].[Tbl_Rights] ([Id], [Programe_id], [UserId], [RoleId], [Status]) VALUES (11, 3, 4, NULL, 1)
GO
INSERT [dbo].[Tbl_Rights] ([Id], [Programe_id], [UserId], [RoleId], [Status]) VALUES (12, 4, 4, NULL, 1)
GO
INSERT [dbo].[Tbl_Rights] ([Id], [Programe_id], [UserId], [RoleId], [Status]) VALUES (13, 1, 5, NULL, 1)
GO
INSERT [dbo].[Tbl_Rights] ([Id], [Programe_id], [UserId], [RoleId], [Status]) VALUES (14, 2, 5, NULL, 1)
GO
INSERT [dbo].[Tbl_Rights] ([Id], [Programe_id], [UserId], [RoleId], [Status]) VALUES (15, 3, 5, NULL, 1)
GO
INSERT [dbo].[Tbl_Rights] ([Id], [Programe_id], [UserId], [RoleId], [Status]) VALUES (16, 4, 5, NULL, 1)
GO
INSERT [dbo].[Tbl_Rights] ([Id], [Programe_id], [UserId], [RoleId], [Status]) VALUES (17, 2, 3, NULL, 1)
GO
INSERT [dbo].[Tbl_Rights] ([Id], [Programe_id], [UserId], [RoleId], [Status]) VALUES (18, 3, 3, NULL, 1)
GO
SET IDENTITY_INSERT [dbo].[Tbl_Rights] OFF
GO
SET IDENTITY_INSERT [dbo].[User_Master] ON 
GO
INSERT [dbo].[User_Master] ([Id], [Nm], [Email], [Mobile], [Password], [Manager_Id], [Status]) VALUES (1, N'Akash Kumar', N'akash123@gmail.com', N'93483943', N'5BD4D4E7AB3495A126035CC0FCF08557192B0B027CC54F4FEDE03449833A13B8', NULL, 1)
GO
INSERT [dbo].[User_Master] ([Id], [Nm], [Email], [Mobile], [Password], [Manager_Id], [Status]) VALUES (2, N'Rahul Kumar', N'rahul213@gmail.com', N'73483943', N'6110E881C3B1912B7C4D0E63D645AC95F529FBEAE7BD80DA7DCC56438F757CD8', 1, 1)
GO
INSERT [dbo].[User_Master] ([Id], [Nm], [Email], [Mobile], [Password], [Manager_Id], [Status]) VALUES (3, N'Mayank Kumar', N'mayank0023@gmail.com', N'88483943', N'535B3311338EAE13AEB2CB13263F6B5948158A7DEA55090D8313A57552D9D4D1', 1, 1)
GO
INSERT [dbo].[User_Master] ([Id], [Nm], [Email], [Mobile], [Password], [Manager_Id], [Status]) VALUES (4, N'Sumit Kumar', N'smt03@gmail.com', N'78483943', N'F0769D93661E28CDD2625A6AAC07AFEF373A81D2CDC5292794D058AB71BA7C2C', 3, 1)
GO
INSERT [dbo].[User_Master] ([Id], [Nm], [Email], [Mobile], [Password], [Manager_Id], [Status]) VALUES (5, N'Pawan Kumar', N'pawan123@gmail.com', N'87483943', N'476D0D465F370CBAB7C04A8B03BBFAAB92DA7F5DA2413AD6C05D4E3326885395', 3, 1)
GO
SET IDENTITY_INSERT [dbo].[User_Master] OFF
GO
