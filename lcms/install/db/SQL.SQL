
CREATE TABLE [dbo].[eWebEditor_Button]
(
	[B_Code] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[B_Title] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[B_Image] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[B_HTML] [ntext] COLLATE Chinese_PRC_CI_AS NULL,
	[B_Type] [int] NULL CONSTRAINT [DF_eWebEditor_Button_B_Type]  DEFAULT (0),
	[B_Event] [nvarchar](250) COLLATE Chinese_PRC_CI_AS NULL,
	[B_Class] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[B_Order] [int] NULL CONSTRAINT [DF_eWebEditor_Button_B_Order]  DEFAULT (0),
	[B_AllowSelect] [tinyint] NULL CONSTRAINT [DF_eWebEditor_Button_B_AllowSelect]  DEFAULT (1)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[eWebEditor_Style]
(
	[S_ID] [int] IDENTITY(1,1) NOT NULL,
	[S_Name] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[S_Dir] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[S_CSS] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[S_UploadDir] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL CONSTRAINT [DF_eWebEditor_Style_S_UploadDir]  DEFAULT (N'UploadFile/'),
	[S_Width] [int] NULL,
	[S_Height] [int] NULL,
	[S_Memo] [ntext] COLLATE Chinese_PRC_CI_AS NULL,
	[S_IsSys] [tinyint] NULL,
	[S_FileExt] [nvarchar](250) COLLATE Chinese_PRC_CI_AS NULL,
	[S_FlashExt] [nvarchar](250) COLLATE Chinese_PRC_CI_AS NULL,
	[S_ImageExt] [nvarchar](250) COLLATE Chinese_PRC_CI_AS NULL,
	[S_MediaExt] [nvarchar](250) COLLATE Chinese_PRC_CI_AS NULL,
	[S_RemoteExt] [nvarchar](250) COLLATE Chinese_PRC_CI_AS NULL,
	[S_FileSize] [int] NULL CONSTRAINT [DF_eWebEditor_Style_S_FileSize]  DEFAULT (0),
	[S_FlashSize] [int] NULL CONSTRAINT [DF_eWebEditor_Style_S_FlashSize]  DEFAULT (0),
	[S_ImageSize] [int] NULL CONSTRAINT [DF_eWebEditor_Style_S_ImageSize]  DEFAULT (0),
	[S_MediaSize] [int] NULL CONSTRAINT [DF_eWebEditor_Style_S_MediaSize]  DEFAULT (0),
	[S_RemoteSize] [int] NULL CONSTRAINT [DF_eWebEditor_Style_S_RemoteSize]  DEFAULT (0),
	[S_StateFlag] [tinyint] NULL CONSTRAINT [DF_eWebEditor_Style_S_StateFlag]  DEFAULT (1),
	[S_DetectFromWord] [nvarchar](10) COLLATE Chinese_PRC_CI_AS NULL CONSTRAINT [DF_eWebEditor_Style_S_DetectFromWord]  DEFAULT (N'true'),
	[S_InitMode] [nvarchar](10) COLLATE Chinese_PRC_CI_AS NULL,
	[S_BaseUrl] [nvarchar](10) COLLATE Chinese_PRC_CI_AS NULL CONSTRAINT [DF_eWebEditor_Style_S_BaseUrl]  DEFAULT (N'1'),
	[S_UploadObject] [tinyint] NULL,
	[S_AutoDir] [tinyint] NULL,
	[S_BaseHref] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[S_ContentPath] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[S_AutoRemote] [tinyint] NULL CONSTRAINT [DF_eWebEditor_Style_S_AutoRemote]  DEFAULT (1),
	[S_ShowBorder] [tinyint] NULL CONSTRAINT [DF_eWebEditor_Style_S_ShowBorder]  DEFAULT (0)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[eWebEditor_ToolBar]
(
	[T_ID] [int] IDENTITY(1,1) NOT NULL,
	[S_ID] [int] NULL,
	[T_Name] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[T_Order] [int] NULL CONSTRAINT [DF_eWebEditor_ToolBar_T_Order]  DEFAULT (0),
	[T_Button] [ntext] COLLATE Chinese_PRC_CI_AS NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[LCMS_Administrator]
(
	[Admin_ID] [int] IDENTITY(1,1) NOT NULL,
	[Admin_Name] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[Admin_UserName] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[Admin_Password] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[Admin_Usableness] [char](1) COLLATE Chinese_PRC_CI_AS NULL,
	[Admin_Note] [varchar](1000) COLLATE Chinese_PRC_CI_AS NULL,
	[Admin_AddDate] [datetime] NULL,
	[Admin_LastDate] [datetime] NULL,
	[Admin_IP] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[Admin_Options] [varchar](1000) COLLATE Chinese_PRC_CI_AS NULL CONSTRAINT [DF_LCMS_Administrator_Admin_Options]  DEFAULT (N'0,')
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[LCMS_Content]
(
	[Content_Id] [int] IDENTITY(1,1) NOT NULL,
	[Content_Menu_Id] [int] NOT NULL,
	[Content_Title] [varchar](250) COLLATE Chinese_PRC_CI_AS NULL,
	[Content_Title_Color] [varchar](16) COLLATE Chinese_PRC_CI_AS NULL,
	[Content_User_Id] [int] NULL CONSTRAINT [DF_LCMS_Content_Content_User_Id]  DEFAULT ((0)),
	[Content_Keyword] [varchar](100) COLLATE Chinese_PRC_CI_AS NULL,
	[Content_Description] [text] COLLATE Chinese_PRC_CI_AS NULL,
	[Content_Author] [varchar](150) COLLATE Chinese_PRC_CI_AS NULL,
	[Content_Editor] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[Content_Copy_From] [varchar](150) COLLATE Chinese_PRC_CI_AS NULL,
	[Content_Content] [text] COLLATE Chinese_PRC_CI_AS NULL,
	[Content_Market_Price] [money] NULL,
	[Content_Price] [money] NULL,
	[Content_VIP_Price] [money] NULL,
	[Content_Sale_Price] [money] NULL,
	[Content_Has_Image] [int] NULL CONSTRAINT [DF_LCMS_Content_Content_Has_Image]  DEFAULT ((0)),
	[Content_Image_URL] [varchar](150) COLLATE Chinese_PRC_CI_AS NULL,
	[Content_sImage_URL] [varchar](150) COLLATE Chinese_PRC_CI_AS NULL,
	[Content_On_Top] [int] NULL CONSTRAINT [DF_LCMS_Content_Content_On_Top]  DEFAULT ((0)),
	[Content_Is_Best] [int] NULL,
	[Content_Locked] [int] NULL CONSTRAINT [DF_LCMS_Content_Content_Locked]  DEFAULT ((0)),
	[Content_Clicks] [int] NULL CONSTRAINT [DF_LCMS_Content_Content_Clicks]  DEFAULT ((0)),
	[Content_Add_Time] [datetime] NULL CONSTRAINT [DF_LCMS_Content_Content_Add_Time]  DEFAULT (getdate()),
	[Content_URL] [varchar](250) COLLATE Chinese_PRC_CI_AS NULL,
	[Content_Publish_Time] [datetime] NULL,
	[Content_Deleted] [int] NULL CONSTRAINT [DF_LCMS_Content_Content_Deleted]  DEFAULT ((0)),
	[Content_Orders] [int] NULL,
	[Content_SubId] [int] NULL CONSTRAINT [DF_LCMS_Content_Content_SubId]  DEFAULT ((0)),
	[Content_Version] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[Content_Language] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[Content_License] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[Content_RunOS] [varchar](250) COLLATE Chinese_PRC_CI_AS NULL,
	[Content_Size] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[Content_DemoURL] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[Content_RegURL] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[Content_DownURLs] [text] COLLATE Chinese_PRC_CI_AS NULL,
	[Content_DownCount] [int] NULL CONSTRAINT [DF_LCMS_Content_Content_DownCount]  DEFAULT ((0))
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[LCMS_Link]
(
	[Link_Id] [int] IDENTITY(1,1) NOT NULL,
	[Link_MenuId] [int] NULL,
	[Link_Name] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[Link_Template] [varchar](150) COLLATE Chinese_PRC_CI_AS NULL,
	[Link_URL] [varchar](150) COLLATE Chinese_PRC_CI_AS NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[LCMS_Log]
(
	[Log_Id] [int] IDENTITY(1,1) NOT NULL,
	[Log_Date] [datetime] NULL,
	[Log_IP] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[Log_Content] [varchar](200) COLLATE Chinese_PRC_CI_AS NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[LCMS_Menu]
(
	[Menu_Id] [int] IDENTITY(1,1) NOT NULL,
	[Menu_Name] [varchar](100) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[Menu_English_Name] [varchar](150) COLLATE Chinese_PRC_CI_AS NULL,
	[Menu_Parent_Id] [int] NOT NULL CONSTRAINT [DF_LCMS_Menu_Menu_Parent_Id]  DEFAULT (0),
	[Menu_Child_Count] [int] NULL CONSTRAINT [DF_LCMS_Menu_Menu_Child_Count]  DEFAULT (0),
	[Menu_Type] [int] NOT NULL,
	[Menu_Allow_Pub] [bit] NULL CONSTRAINT [DF_LCMS_Menu_Menu_Allow_Pub]  DEFAULT (1),
	[Menu_Icon] [varchar](100) COLLATE Chinese_PRC_CI_AS NULL,
	[Menu_List_Template] [varchar](150) COLLATE Chinese_PRC_CI_AS NULL,
	[Menu_Content_Template] [varchar](150) COLLATE Chinese_PRC_CI_AS NULL,
	[Menu_List_URL] [varchar](150) COLLATE Chinese_PRC_CI_AS NULL,
	[Menu_Content_URL] [varchar](150) COLLATE Chinese_PRC_CI_AS NULL,
	[Menu_Infomation] [varchar](1500) COLLATE Chinese_PRC_CI_AS NULL,
	[Menu_Orders] [int] NULL,
	[Menu_Data_Table] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[Menu_List_Count] [int] NULL CONSTRAINT [DF_LCMS_Menu_Menu_List_Count]  DEFAULT (20),
	[Menu_Master_Pub] [bit] NULL CONSTRAINT [DF_LCMS_Menu_Menu_Master_Pub]  DEFAULT (1),
	[Menu_Company_Pub] [bit] NULL CONSTRAINT [DF_LCMS_Menu_Menu_Company_Pub]  DEFAULT (0),
	[Menu_Member_Pub] [bit] NULL CONSTRAINT [DF_LCMS_Menu_Menu_Member_Pub]  DEFAULT (0)
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[LCMS_Sub]
(
	[Sub_Id] [int] IDENTITY(1,1) NOT NULL,
	[Sub_Menu_Type] [int] NULL,
	[Sub_Name] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[Sub_User_Id] [int] NULL,
	[Sub_Image] [varchar](150) COLLATE Chinese_PRC_CI_AS NULL,
	[Sub_Info] [text] COLLATE Chinese_PRC_CI_AS NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[Upload_Files]
(
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FileName] [varchar](150) COLLATE Chinese_PRC_CI_AS NULL,
	[FileSize] [int] NULL CONSTRAINT [DF_Upload_Files_FileSize]  DEFAULT (0),
	[URL] [varchar](250) COLLATE Chinese_PRC_CI_AS NULL,
	[UploadTime] [datetime] NULL CONSTRAINT [DF_Upload_Files_UploadTime]  DEFAULT (getdate()),
	[UploadUser] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[IP] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL
) ON [PRIMARY]

