USE [CalendarSchedule]
GO
/****** Object:  Table [dbo].[AppSettings]    Script Date: 12-09-2021 23:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppSettings](
	[AppSesstingId] [int] IDENTITY(1,1) NOT NULL,
	[Email] [varchar](100) NULL,
	[EmailPassword] [varchar](100) NULL,
	[EmailPort] [varchar](10) NULL,
	[EmailHost] [varchar](100) NULL,
	[EmailSSL] [bit] NULL,
 CONSTRAINT [PK_AppSettings] PRIMARY KEY CLUSTERED 
(
	[AppSesstingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Course]    Script Date: 12-09-2021 23:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Course](
	[CourseId] [int] IDENTITY(1,1) NOT NULL,
	[CourseName] [varchar](100) NULL,
 CONSTRAINT [PK_Course] PRIMARY KEY CLUSTERED 
(
	[CourseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmailTemplate]    Script Date: 12-09-2021 23:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmailTemplate](
	[EmailTemplateId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](200) NULL,
	[Subject] [varchar](500) NULL,
	[Body] [varchar](max) NULL,
 CONSTRAINT [PK_EmailTemplate] PRIMARY KEY CLUSTERED 
(
	[EmailTemplateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FacultyDetails]    Script Date: 12-09-2021 23:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FacultyDetails](
	[facultyId] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [varchar](100) NULL,
	[Email] [varchar](200) NULL,
	[Password] [varchar](max) NULL,
	[AvaiblityFrom] [varchar](20) NULL,
	[AvaiblityTo] [varchar](20) NULL,
	[Interval] [int] NULL,
 CONSTRAINT [PK_FacultyDetails] PRIMARY KEY CLUSTERED 
(
	[facultyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MeetingSchedule]    Script Date: 12-09-2021 23:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MeetingSchedule](
	[ScheduleId] [int] IDENTITY(1,1) NOT NULL,
	[facultyId] [int] NULL,
	[FirstName] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
	[Email] [varchar](200) NULL,
	[AppointmentDate] [date] NULL,
	[Time] [varchar](20) NULL,
	[CourseId] [int] NULL,
	[Purpose] [varchar](200) NULL,
	[Comments] [varchar](100) NULL,
	[IsActive] [bit] NULL,
	[Accepted] [int] NULL,
 CONSTRAINT [PK_MeetingSchedule] PRIMARY KEY CLUSTERED 
(
	[ScheduleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Purpose]    Script Date: 12-09-2021 23:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Purpose](
	[PurposeId] [int] IDENTITY(1,1) NOT NULL,
	[Purpose] [varchar](200) NULL,
 CONSTRAINT [PK_Purpose] PRIMARY KEY CLUSTERED 
(
	[PurposeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Course] ON 
GO
INSERT [dbo].[Course] ([CourseId], [CourseName]) VALUES (1, N'Engineering Course-Dr. Julian Davis
')
GO
INSERT [dbo].[Course] ([CourseId], [CourseName]) VALUES (2, N'Business course')
GO
INSERT [dbo].[Course] ([CourseId], [CourseName]) VALUES (3, N'Management course')
GO
INSERT [dbo].[Course] ([CourseId], [CourseName]) VALUES (4, N'Accounting course')
GO
INSERT [dbo].[Course] ([CourseId], [CourseName]) VALUES (5, N'Project Management course')
GO
INSERT [dbo].[Course] ([CourseId], [CourseName]) VALUES (6, N'Finance course')
GO
SET IDENTITY_INSERT [dbo].[Course] OFF
GO
SET IDENTITY_INSERT [dbo].[EmailTemplate] ON 
GO
INSERT [dbo].[EmailTemplate] ([EmailTemplateId], [Name], [Subject], [Body]) VALUES (1, N'AcceptOrRejectEmail', N'Meeting for ##Purpose## ##Time## (##ToEmailAddress##)', N'<!doctype html>
<html>
<head>
    <meta name="viewport" content="width=device-width">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Simple Transactional Email</title>
    <style>

        @media only screen and (max-width: 620px) {
            table[class=body] h1 {
                font-size: 28px !important;
                margin-bottom: 10px !important;
            }

            table[class=body] p,
            table[class=body] ul,
            table[class=body] ol,
            table[class=body] td,
            table[class=body] span,
            table[class=body] a {
                font-size: 16px !important;
            }

            table[class=body] .wrapper,
            table[class=body] .article {
                padding: 10px !important;
            }

            table[class=body] .content {
                padding: 0 !important;
            }

            table[class=body] .container {
                padding: 0 !important;
                width: 100% !important;
            }

            table[class=body] .main {
                border-left-width: 0 !important;
                border-radius: 0 !important;
                border-right-width: 0 !important;
            }

            table[class=body] .btn table {
                width: 100% !important;
            }

            table[class=body] .btn a {
                width: 100% !important;
            }

            table[class=body] .img-responsive {
                height: auto !important;
                max-width: 100% !important;
                width: auto !important;
            }
        }


        @media all {
            .ExternalClass {
                width: 100%;
            }

                .ExternalClass,
                .ExternalClass p,
                .ExternalClass span,
                .ExternalClass font,
                .ExternalClass td,
                .ExternalClass div {
                    line-height: 100%;
                }

            .apple-link a {
                color: inherit !important;
                font-family: inherit !important;
                font-size: inherit !important;
                font-weight: inherit !important;
                line-height: inherit !important;
                text-decoration: none !important;
            }

            #MessageViewBody a {
                color: inherit;
                text-decoration: none;
                font-size: inherit;
                font-family: inherit;
                font-weight: inherit;
                line-height: inherit;
            }

            .btn-primary table td:hover {
                background-color: #34495e !important;
            }

            .btn-primary a:hover {
                background-color: #34495e !important;
                border-color: #34495e !important;
            }
        }
    </style>
</head>
<body class="" style="background-color: #f6f6f6; font-family: sans-serif; -webkit-font-smoothing: antialiased; font-size: 14px; line-height: 1.4; margin: 0; padding: 0; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%;">
    <span class="preheader" style="color: transparent; display: none; height: 0; max-height: 0; max-width: 0; opacity: 0; overflow: hidden; mso-hide: all; visibility: hidden; width: 0;">This is preheader text. Some clients will show this text as a preview.</span>
    <table role="presentation" border="0" cellpadding="0" cellspacing="0" class="body" style="border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%; background-color: #f6f6f6;">
        <tr>
            <td style="font-family: sans-serif; font-size: 14px; vertical-align: top;">&nbsp;</td>
            <td class="container" style="font-family: sans-serif; font-size: 14px; vertical-align: top; display: block; Margin: 0 auto; max-width: 580px; padding: 10px; width: 580px;">
                <div class="content" style="box-sizing: border-box; display: block; Margin: 0 auto; max-width: 580px; padding: 10px;">


                    <table role="presentation" class="main" style="border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%; background: #ffffff; border-radius: 3px;">


                        <tr>
                            <td class="wrapper" style="font-family: sans-serif; font-size: 14px; vertical-align: top; box-sizing: border-box; padding: 20px;">
                                <table role="presentation" border="0" cellpadding="0" cellspacing="0" style="border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%;">
                                    <tr>
                                        <td style="font-family: sans-serif; font-size: 14px; vertical-align: top;">
                                            <p style="font-family: sans-serif; font-size: 14px; font-weight: normal; margin: 0; Margin-bottom: 15px;">Hi there,</p>
                                            <p style="font-family: sans-serif; font-size: 14px; font-weight: normal; margin: 0; Margin-bottom: 15px;">Meeting for ##Purpose##</p>
                                            <p style="font-family: sans-serif; font-size: 14px; font-weight: normal; margin: 0; Margin-bottom: 15px;">Course:- ##Course##</p>
                                            <p style="font-family: sans-serif; font-size: 14px; font-weight: normal; margin: 0; Margin-bottom: 15px;">When ##Time##</p>
                                            <p style="font-family: sans-serif; font-size: 14px; font-weight: normal; margin: 0; Margin-bottom: 15px;">Who ##EmailAddress##</p>
                                            <p style="font-family: sans-serif; font-size: 14px; font-weight: normal; margin: 0; Margin-bottom: 15px;">Comments:- ##Comments##</p>
                                            <table role="presentation" border="0" cellpadding="0" cellspacing="0" class="btn btn-primary" style="border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%; box-sizing: border-box;">
                                                <tbody>
                                                    <tr>
                                                        <td align="left" style="font-family: sans-serif; font-size: 14px; vertical-align: top; padding-bottom: 15px;">
                                                            <table role="presentation" border="0" cellpadding="0" cellspacing="0" style="border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: auto;">
                                                                <tbody>
                                                                    <tr>
                                                                        <td style="font-family: sans-serif; font-size: 14px; vertical-align: top; background-color: #3498db; border-radius: 5px; text-align: center;">
                                                                            <a href="##Accept##" target="_blank" style="display: inline-block; color: #ffffff; background-color: #3498db; border: solid 1px #3498db; border-radius: 5px; box-sizing: border-box; cursor: pointer; text-decoration: none; font-size: 14px; font-weight: bold; margin: 0; padding: 12px 25px; text-transform: capitalize; border-color: #3498db;">Accept</a>
                                                                        </td>
                                                                        <td>
                                                                            &nbsp;&nbsp;
                                                                        </td>
                                                                        <td style="font-family: sans-serif; font-size: 14px; vertical-align: top; background-color: #3498db; border-radius: 5px; text-align: center;">
                                                                            <a href="##Reject##" target="_blank" style="display: inline-block; color: #ffffff; background-color: #3498db; border: solid 1px #3498db; border-radius: 5px; box-sizing: border-box; cursor: pointer; text-decoration: none; font-size: 14px; font-weight: bold; margin: 0; padding: 12px 25px; text-transform: capitalize; border-color: #3498db;">Reject</a>
                                                                        </td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>

                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>


                    </table>

                </div>
            </td>
            <td style="font-family: sans-serif; font-size: 14px; vertical-align: top;">&nbsp;</td>
        </tr>
    </table>
</body>
</html>')
GO
INSERT [dbo].[EmailTemplate] ([EmailTemplateId], [Name], [Subject], [Body]) VALUES (3, N'AcceptedEmail', N'Accepted: Meeting for  ##Purpose## ##Time## (##ToEmailAddress##)', N'<!doctype html>
<html>
<head>
    <meta name="viewport" content="width=device-width">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Simple Transactional Email</title>
    <style>

        @media only screen and (max-width: 620px) {
            table[class=body] h1 {
                font-size: 28px !important;
                margin-bottom: 10px !important;
            }

            table[class=body] p,
            table[class=body] ul,
            table[class=body] ol,
            table[class=body] td,
            table[class=body] span,
            table[class=body] a {
                font-size: 16px !important;
            }

            table[class=body] .wrapper,
            table[class=body] .article {
                padding: 10px !important;
            }

            table[class=body] .content {
                padding: 0 !important;
            }

            table[class=body] .container {
                padding: 0 !important;
                width: 100% !important;
            }

            table[class=body] .main {
                border-left-width: 0 !important;
                border-radius: 0 !important;
                border-right-width: 0 !important;
            }

            table[class=body] .btn table {
                width: 100% !important;
            }

            table[class=body] .btn a {
                width: 100% !important;
            }

            table[class=body] .img-responsive {
                height: auto !important;
                max-width: 100% !important;
                width: auto !important;
            }
        }


        @media all {
            .ExternalClass {
                width: 100%;
            }

                .ExternalClass,
                .ExternalClass p,
                .ExternalClass span,
                .ExternalClass font,
                .ExternalClass td,
                .ExternalClass div {
                    line-height: 100%;
                }

            .apple-link a {
                color: inherit !important;
                font-family: inherit !important;
                font-size: inherit !important;
                font-weight: inherit !important;
                line-height: inherit !important;
                text-decoration: none !important;
            }

            #MessageViewBody a {
                color: inherit;
                text-decoration: none;
                font-size: inherit;
                font-family: inherit;
                font-weight: inherit;
                line-height: inherit;
            }

            .btn-primary table td:hover {
                background-color: #34495e !important;
            }

            .btn-primary a:hover {
                background-color: #34495e !important;
                border-color: #34495e !important;
            }
        }
    </style>
</head>
<body class="" style="background-color: #f6f6f6; font-family: sans-serif; -webkit-font-smoothing: antialiased; font-size: 14px; line-height: 1.4; margin: 0; padding: 0; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%;">
    <span class="preheader" style="color: transparent; display: none; height: 0; max-height: 0; max-width: 0; opacity: 0; overflow: hidden; mso-hide: all; visibility: hidden; width: 0;">This is preheader text. Some clients will show this text as a preview.</span>
    <table role="presentation" border="0" cellpadding="0" cellspacing="0" class="body" style="border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%; background-color: #f6f6f6;">
        <tr>
            <td style="font-family: sans-serif; font-size: 14px; vertical-align: top;">&nbsp;</td>
            <td class="container" style="font-family: sans-serif; font-size: 14px; vertical-align: top; display: block; Margin: 0 auto; max-width: 580px; padding: 10px; width: 580px;">
                <div class="content" style="box-sizing: border-box; display: block; Margin: 0 auto; max-width: 580px; padding: 10px;">


                    <table role="presentation" class="main" style="border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%; background: #ffffff; border-radius: 3px;">


                        <tr>
                            <td class="wrapper" style="font-family: sans-serif; font-size: 14px; vertical-align: top; box-sizing: border-box; padding: 20px;">
                                <table role="presentation" border="0" cellpadding="0" cellspacing="0" style="border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%;">
                                    <tr>
                                        <td style="font-family: sans-serif; font-size: 14px; vertical-align: top;">
                                            <p style="font-family: sans-serif; font-size: 14px; font-weight: normal; margin: 0; Margin-bottom: 15px;">Hi there,</p>
                                            <p style="font-family: sans-serif; font-size: 14px; font-weight: normal; margin: 0; Margin-bottom: 15px;">Meeting for ##Purpose##</p>
                                            <p style="font-family: sans-serif; font-size: 14px; font-weight: normal; margin: 0; Margin-bottom: 15px;">Course:- ##Course##</p>
                                            <p style="font-family: sans-serif; font-size: 14px; font-weight: normal; margin: 0; Margin-bottom: 15px;">When ##Time##</p>
                                            <p style="font-family: sans-serif; font-size: 14px; font-weight: normal; margin: 0; Margin-bottom: 15px;">Who ##EmailAddress##</p>
                                            <p style="font-family: sans-serif; font-size: 14px; font-weight: normal; margin: 0; Margin-bottom: 15px;">Comments:- ##Comments##</p>
                                            

                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>


                    </table>

                </div>
            </td>
            <td style="font-family: sans-serif; font-size: 14px; vertical-align: top;">&nbsp;</td>
        </tr>
    </table>
</body>
</html>')
GO
INSERT [dbo].[EmailTemplate] ([EmailTemplateId], [Name], [Subject], [Body]) VALUES (4, N'RejectedEmail', N'Rejected: Meeting for  ##Purpose## ##Time## (##ToEmailAddress##)', N'<!doctype html>
<html>
<head>
    <meta name="viewport" content="width=device-width">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Simple Transactional Email</title>
    <style>

        @media only screen and (max-width: 620px) {
            table[class=body] h1 {
                font-size: 28px !important;
                margin-bottom: 10px !important;
            }

            table[class=body] p,
            table[class=body] ul,
            table[class=body] ol,
            table[class=body] td,
            table[class=body] span,
            table[class=body] a {
                font-size: 16px !important;
            }

            table[class=body] .wrapper,
            table[class=body] .article {
                padding: 10px !important;
            }

            table[class=body] .content {
                padding: 0 !important;
            }

            table[class=body] .container {
                padding: 0 !important;
                width: 100% !important;
            }

            table[class=body] .main {
                border-left-width: 0 !important;
                border-radius: 0 !important;
                border-right-width: 0 !important;
            }

            table[class=body] .btn table {
                width: 100% !important;
            }

            table[class=body] .btn a {
                width: 100% !important;
            }

            table[class=body] .img-responsive {
                height: auto !important;
                max-width: 100% !important;
                width: auto !important;
            }
        }


        @media all {
            .ExternalClass {
                width: 100%;
            }

                .ExternalClass,
                .ExternalClass p,
                .ExternalClass span,
                .ExternalClass font,
                .ExternalClass td,
                .ExternalClass div {
                    line-height: 100%;
                }

            .apple-link a {
                color: inherit !important;
                font-family: inherit !important;
                font-size: inherit !important;
                font-weight: inherit !important;
                line-height: inherit !important;
                text-decoration: none !important;
            }

            #MessageViewBody a {
                color: inherit;
                text-decoration: none;
                font-size: inherit;
                font-family: inherit;
                font-weight: inherit;
                line-height: inherit;
            }

            .btn-primary table td:hover {
                background-color: #34495e !important;
            }

            .btn-primary a:hover {
                background-color: #34495e !important;
                border-color: #34495e !important;
            }
        }
    </style>
</head>
<body class="" style="background-color: #f6f6f6; font-family: sans-serif; -webkit-font-smoothing: antialiased; font-size: 14px; line-height: 1.4; margin: 0; padding: 0; -ms-text-size-adjust: 100%; -webkit-text-size-adjust: 100%;">
    <span class="preheader" style="color: transparent; display: none; height: 0; max-height: 0; max-width: 0; opacity: 0; overflow: hidden; mso-hide: all; visibility: hidden; width: 0;">This is preheader text. Some clients will show this text as a preview.</span>
    <table role="presentation" border="0" cellpadding="0" cellspacing="0" class="body" style="border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%; background-color: #f6f6f6;">
        <tr>
            <td style="font-family: sans-serif; font-size: 14px; vertical-align: top;">&nbsp;</td>
            <td class="container" style="font-family: sans-serif; font-size: 14px; vertical-align: top; display: block; Margin: 0 auto; max-width: 580px; padding: 10px; width: 580px;">
                <div class="content" style="box-sizing: border-box; display: block; Margin: 0 auto; max-width: 580px; padding: 10px;">


                    <table role="presentation" class="main" style="border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%; background: #ffffff; border-radius: 3px;">


                        <tr>
                            <td class="wrapper" style="font-family: sans-serif; font-size: 14px; vertical-align: top; box-sizing: border-box; padding: 20px;">
                                <table role="presentation" border="0" cellpadding="0" cellspacing="0" style="border-collapse: separate; mso-table-lspace: 0pt; mso-table-rspace: 0pt; width: 100%;">
                                    <tr>
                                        <td style="font-family: sans-serif; font-size: 14px; vertical-align: top;">
                                            <p style="font-family: sans-serif; font-size: 14px; font-weight: normal; margin: 0; Margin-bottom: 15px;">Hi there,</p>
                                            <p style="font-family: sans-serif; font-size: 14px; font-weight: normal; margin: 0; Margin-bottom: 15px;">Meeting for ##Purpose##</p>
                                            <p style="font-family: sans-serif; font-size: 14px; font-weight: normal; margin: 0; Margin-bottom: 15px;">Course:- ##Course##</p>
                                            <p style="font-family: sans-serif; font-size: 14px; font-weight: normal; margin: 0; Margin-bottom: 15px;">When ##Time##</p>
                                            <p style="font-family: sans-serif; font-size: 14px; font-weight: normal; margin: 0; Margin-bottom: 15px;">Who ##EmailAddress##</p>
                                            <p style="font-family: sans-serif; font-size: 14px; font-weight: normal; margin: 0; Margin-bottom: 15px;">Comments:- ##Comments##</p>
                                            

                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>


                    </table>

                </div>
            </td>
            <td style="font-family: sans-serif; font-size: 14px; vertical-align: top;">&nbsp;</td>
        </tr>
    </table>
</body>
</html>')
GO
SET IDENTITY_INSERT [dbo].[EmailTemplate] OFF
GO
ALTER TABLE [dbo].[MeetingSchedule] ADD  CONSTRAINT [DF_MeetingSchedule_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[MeetingSchedule] ADD  CONSTRAINT [DF_MeetingSchedule_Accepted]  DEFAULT ((0)) FOR [Accepted]
GO
/****** Object:  StoredProcedure [dbo].[GetAppointmentFullDetails]    Script Date: 12-09-2021 23:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create    PROCEDURE [dbo].[GetAppointmentFullDetails]
( 
 @ScheduleId int
 )
AS
BEGIN
SET NOCOUNT ON
select FacultyDetails.Email as FEmail,FullName as FFullName, isnull(FirstName,'') +' '+ isnull(LastName,'') as SName,
MeetingSchedule.Email AS SEmail,
FORMAT (CAST(AppointmentDate as DATETIME) + CAST(Time AS DATETIME), 'dddd,MMM dd,yyyy,hh:mm:ss tt')  as AppointmentTime,
Course.CourseName, Purpose,Comments from MeetingSchedule
left outer join FacultyDetails on MeetingSchedule.facultyId=FacultyDetails.facultyId
left outer join Course on MeetingSchedule.CourseId=Course.CourseId
where MeetingSchedule.ScheduleId=@ScheduleId

ENd
GO
/****** Object:  StoredProcedure [dbo].[GetAppSettings]    Script Date: 12-09-2021 23:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create   PROCEDURE [dbo].[GetAppSettings]

AS
BEGIN
SET NOCOUNT ON
select * from AppSettings 
END
GO
/****** Object:  StoredProcedure [dbo].[GetCourse]    Script Date: 12-09-2021 23:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[GetCourse]
AS
BEGIN
SET NOCOUNT ON
select * from Course
END
GO
/****** Object:  StoredProcedure [dbo].[GetEmailTemplate]    Script Date: 12-09-2021 23:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create   PROCEDURE [dbo].[GetEmailTemplate]
( 
 @Name varchar(200)
 )
AS
BEGIN
SET NOCOUNT ON
select * from EmailTemplate where Name=@Name
END
GO
/****** Object:  StoredProcedure [dbo].[GetFaculty]    Script Date: 12-09-2021 23:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create   PROCEDURE [dbo].[GetFaculty]
( 
 @facultyId int
 )
AS
BEGIN
SET NOCOUNT ON
select * from FacultyDetails where facultyId=@facultyId
END
GO
/****** Object:  StoredProcedure [dbo].[GetFacultyDetails]    Script Date: 12-09-2021 23:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create   PROCEDURE [dbo].[GetFacultyDetails]
( 
 @Email varchar(200),
 @Password varchar(max)
 )
AS
BEGIN
SET NOCOUNT ON
select * from FacultyDetails where Email=@Email and Password=@Password
END
GO
/****** Object:  StoredProcedure [dbo].[GetFacultyDetailsById]    Script Date: 12-09-2021 23:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[GetFacultyDetailsById]
( 
 @Id int
 )
AS
BEGIN
SET NOCOUNT ON
select * from FacultyDetails where facultyId=@Id 
END
GO
/****** Object:  StoredProcedure [dbo].[GetMeetingSchedule]    Script Date: 12-09-2021 23:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[GetMeetingSchedule]
( 
 @facultyId int
 )
AS
BEGIN
SET NOCOUNT ON
select 
ScheduleId,
facultyId,
FirstName,
LastName,
Email,
CONVERT(DATETIME, CONVERT(CHAR(8), AppointmentDate, 112) + ' ' + CONVERT(CHAR(8), [Time], 108)) as AppointmentDate,
Time,
CourseId,
Purpose,
Comments,
IsActive,
case
when Accepted = 0 then 'Pending-Meeting'
when Accepted = 1 then 'Accepted-Meeting'
when Accepted = 2 then 'Cancel-Meeting'
else 'Pending-Meeting' End as EventStatus
from MeetingSchedule where
facultyId=@facultyId and IsActive = 1
--and 1 = CASE
--WHEN @ScheduleId = 0  THEN 1 
--WHEN @ScheduleId != 0 and ScheduleId = @ScheduleId  THEN 1 
--ELSE 0


END
GO
/****** Object:  StoredProcedure [dbo].[InsertUpdateFacultyDetails]    Script Date: 12-09-2021 23:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE     PROCEDURE [dbo].[InsertUpdateFacultyDetails]    
( @FullName varchar(100),  
@Email varchar(200),  
@Password  varchar(max),  
@AvaiblityFrom varchar(20),  
@AvaiblityTo varchar(20),  
@Interval int,
@Id int    OUTPUT  

)    
AS    
BEGIN    
SET NOCOUNT ON    
    
Declare @facultyId int

  if exists(select * from FacultyDetails where Email=@Email)  
  begin  
  
  update FacultyDetails set FullName=@FullName,Password=@Password,AvaiblityFrom=@AvaiblityFrom,AvaiblityTo=@AvaiblityTo,Interval=@Interval  
  where Email=@Email  
  

  select @facultyId=facultyId from FacultyDetails where Email=@Email  
  set @Id=@facultyId

  end  
  else  
  begin  
  
   insert into FacultyDetails (FullName,Email,Password,AvaiblityFrom,AvaiblityTo,Interval)    
 values(@FullName,@Email,@Password,@AvaiblityFrom,@AvaiblityTo,@Interval)   
   set @Id=@@IDENTITY
  end  
  
   
  
END
GO
/****** Object:  StoredProcedure [dbo].[InsertUpdateMeetingSchedule]    Script Date: 12-09-2021 23:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE      PROCEDURE [dbo].[InsertUpdateMeetingSchedule]      
(     
@ScheduleId int=NULL,    
@facultyId int,      
@FirstName varchar(50),      
@LastName varchar(50),      
@Email varchar(200),      
@AppointmentDate date,       
@Time varchar(20),      
@CourseId int,      
@Purpose varchar(200),      
@Comments varchar(100),      
@IsActive bit=1,
@Id int    OUTPUT  
 )      
AS      
BEGIN      
SET NOCOUNT ON        
   
  
 if not exists (select * from MeetingSchedule where ScheduleId=@ScheduleId)  
 begin
 insert into MeetingSchedule (facultyId,FirstName,LastName,Email,AppointmentDate,Time,CourseId,Purpose,Comments,IsActive)      
 values(@facultyId,@FirstName,@LastName,@Email,@AppointmentDate,@Time,@CourseId,@Purpose,@Comments,@IsActive)      

 set @Id=@@IDENTITY
 end
  else    
  begin
  update MeetingSchedule set     
  facultyId = @facultyId,    
  FirstName = @FirstName,    
  LastName = @LastName,    
  Email = @Email,    
  AppointmentDate =@AppointmentDate,    
  [Time] = @Time,    
  CourseId = @CourseId,    
  Purpose = @Purpose,    
  Comments = @Comments,    
  IsActive = @IsActive    
  where ScheduleId = @ScheduleId
  
 set @Id=@ScheduleId
  end   
END
GO
/****** Object:  StoredProcedure [dbo].[MeetingScheduleAccepted]    Script Date: 12-09-2021 23:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create   PROCEDURE [dbo].[MeetingScheduleAccepted]
( 
 @ScheduleId int=NULL,
 @Accepted int
 )
AS
BEGIN
SET NOCOUNT ON
update  MeetingSchedule set Accepted=@Accepted where ScheduleId=@ScheduleId
END
GO
