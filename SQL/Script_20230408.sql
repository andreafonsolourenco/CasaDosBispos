IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[APPLICATION_CONFIG]') AND type in (N'U'))
	DROP TABLE [dbo].[APPLICATION_CONFIG]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[APPLICATION_CONFIG](
	[APPLICATION_CONFIGID] [int] IDENTITY(1,1) NOT NULL,
	[email] [varchar](500) NULL default 'no-reply@casadosbispos.pt',
	[email_password] [varchar](250) NULL default 'casadosbispos2023',
	[email_smtp] [varchar](150) NULL default 'mail.casadosbispos.pt',
	[email_smtpport] [varchar](20) NULL default '465',
	[emails_alerta] [varchar](max) NOT NULL default 'geral@casadosbispos.pt;gabrielalmeidawill@gmail.com;afonsopereira6@gmail.com',
	[sessaomaxmin] [int] NOT NULL default 600,
	[ctrldata] [datetime] NOT NULL default getdate(),
	[ctrlcodop] [varchar](500) NOT NULL default 'AL',
	[ctrldataupdt] [datetime] NULL,
	[ctrlcodopupdt] [varchar](500) NULL,
	[URL] [varchar](max) NOT NULL default 'https://www.casadosbispos.pt/',
 CONSTRAINT [PK_APPLICATION_CONFIG] PRIMARY KEY CLUSTERED 
(
	[APPLICATION_CONFIGID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[USERTYPE]') AND type in (N'U'))
	DROP TABLE [dbo].[USERTYPE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[USERTYPE](
	[USERTYPEID] [int] IDENTITY(1,1) NOT NULL,
	[nome] [varchar](500) NOT NULL default '',
	[notas] [varchar](500) NOT NULL default '',
	[administrador] [bit] NOT NULL default 1,
	[ctrldata] [datetime] NOT NULL default getdate(),
	[ctrlcodop] [varchar](500) NOT NULL default 'AL',
	[ctrldataupdt] [datetime] NULL,
	[ctrlcodopupdt] [varchar](500) NULL,
 CONSTRAINT [PK_USERTYPE] PRIMARY KEY CLUSTERED 
(
	[USERTYPEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
CONSTRAINT [IX_USERTYPE_NOME] UNIQUE NONCLUSTERED 
(
	[nome] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[USERS]') AND type in (N'U'))
	DROP TABLE [dbo].[USERS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[USERS](
	[USERSID] [int] IDENTITY(1,1) NOT NULL,
	[nome] [varchar](max) NOT NULL default '',
	[codigo] [varchar](500) NOT NULL default '',
	[email] [varchar](max) NULL default '',
	[telemovel] [varchar](50) NULL default '',
	[ativo] [bit] NOT NULL default 1,
	[password] [varchar](250) NULL default '*',
	[notas] [varchar](max) NULL default '',
	[lastlogin] [datetime] NULL,
	[id_tipo_utilizador] [int] NOT NULL REFERENCES USERTYPE (usertypeid),
	[ctrldata] [datetime] NOT NULL default getdate(),
	[ctrlcodop] [varchar](500) NOT NULL default 'AL',
	[ctrldataupdt] [datetime] NULL,
	[ctrlcodopupdt] [varchar](500) NULL,
 CONSTRAINT [PK_USERS] PRIMARY KEY CLUSTERED 
(
	[USERSID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
CONSTRAINT [IX_USERS_CODIGO] UNIQUE NONCLUSTERED 
(
	[codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ACESSOS]') AND type in (N'U'))
	DROP TABLE [dbo].[ACESSOS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ACESSOS](
	[ACESSOSID] [int] IDENTITY(1,1) NOT NULL,
	[id_utilizador] [int] NOT NULL REFERENCES USERS (USERSID),
	[datahora] [datetime] NOT NULL default getdate(),
	[tipo] [varchar](50) NOT NULL default 'LOGIN',
	[ctrldata] [datetime] NOT NULL default getdate(),
	[ctrlcodop] [varchar](500) NOT NULL default 'AL',
	[ctrldataupdt] [datetime] NULL,
	[ctrlcodopupdt] [varchar](500) NULL,
 CONSTRAINT [PK_ACESSOS] PRIMARY KEY CLUSTERED 
(
	[ACESSOSID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [IX_ACESSOS_USER_DATE_TYPE] UNIQUE NONCLUSTERED 
(
	[id_utilizador] ASC,
	[datahora] ASC,
	[tipo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IMAGES_TYPE]') AND type in (N'U'))
	DROP TABLE [dbo].[IMAGES_TYPE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[IMAGES_TYPE](
	[IMAGES_TYPEID] [int] IDENTITY(1,1) NOT NULL,
	[NOME] [varchar](500) NOT NULL default '',
	[NOME_EN] [varchar](500) NOT NULL default '',
	[NOME_FR] [varchar](500) NOT NULL default '',
	[NOME_ES] [varchar](500) NOT NULL default '',
	[ORDEM] [int] NOT NULL default 0,
	[ctrldata] [datetime] NOT NULL default getdate(),
	[ctrlcodop] [varchar](500) NOT NULL default 'AL',
	[ctrldataupdt] [datetime] NULL,
	[ctrlcodopupdt] [varchar](500) NULL,
 CONSTRAINT [PK_IMAGES_TYPE] PRIMARY KEY CLUSTERED 
(
	[IMAGES_TYPEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
CONSTRAINT [IX_IMAGES_TYPE_NOME] UNIQUE NONCLUSTERED 
(
	[NOME] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

--alter table images_type
--drop constraint FK__IMAGES_TY__id_im__17C286CF

--alter table images_type
--drop column id_imagem_capa


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IMAGE]') AND type in (N'U'))
	DROP TABLE [dbo].[IMAGE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[IMAGE](
	[IMAGEID] [int] IDENTITY(1,1) NOT NULL,
	[NOME] [varchar](max) NOT NULL default '',
	[NOME_EN] [varchar](max) NOT NULL default '',
	[NOME_FR] [varchar](max) NOT NULL default '',
	[NOME_ES] [varchar](max) NOT NULL default '',
	[ID_TIPO] [int] NOT NULL REFERENCES IMAGES_TYPE (IMAGES_TYPEID),
	[ORDEM] [int] NOT NULL default 0,
	[SLIDER_INICIAL] [bit] NOT NULL default 0,
	[EXTENSAO] [varchar](10) NOT NULL default '.jpg',
	[ctrldata] [datetime] NOT NULL default getdate(),
	[ctrlcodop] [varchar](500) NOT NULL default 'AL',
	[ctrldataupdt] [datetime] NULL,
	[ctrlcodopupdt] [varchar](500) NULL,
 CONSTRAINT [PK_IMAGE] PRIMARY KEY CLUSTERED 
(
	[IMAGEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

--alter table image
--drop constraint FK__IMAGE__ID_TIPO__1209AD79

--alter table image
--drop column id_tipo



IF COL_LENGTH('IMAGES_TYPE','id_imagem_capa') IS NULL
BEGIN
	ALTER TABLE IMAGES_TYPE
	ADD id_imagem_capa int null --references [IMAGE] (imageid);
END



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CONTACTOS]') AND type in (N'U'))
	DROP TABLE [dbo].[CONTACTOS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CONTACTOS](
	[CONTACTOSID] [int] IDENTITY(1,1) NOT NULL,
	[NOME] [varchar](500) NOT NULL default '',
	[MORADA1] [varchar](500) NOT NULL default '',
	[MORADA2] [varchar](500) NOT NULL default '',
	[COD_POSTAL] [varchar](500) NOT NULL default '',
	[LOCALIDADE] [varchar](500) NOT NULL default '',
	[ctrldata] [datetime] NOT NULL default getdate(),
	[ctrlcodop] [varchar](500) NOT NULL default 'AL',
	[ctrldataupdt] [datetime] NULL,
	[ctrlcodopupdt] [varchar](500) NULL,
	[telefone] [varchar](20) NOT NULL default '',
	[email] [varchar](500) NOT NULL default '',
 CONSTRAINT [PK_CONTACTOS] PRIMARY KEY CLUSTERED 
(
	[CONTACTOSID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LOG]') AND type in (N'U'))
	DROP TABLE [dbo].[LOG]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[LOG](
	[LOGID] [int] IDENTITY(1,1) NOT NULL,
	[id_user] [int] NOT NULL REFERENCES USERS (USERSID),
	[id_relacionado] [int] NULL,
	[tipo] [varchar](200) NOT NULL default '',
	[notas] [varchar](max) NOT NULL default 'AL',
	[ctrldata] [datetime] NOT NULL default getdate(),
	[ctrlcodop] [varchar](500) NOT NULL default 'AL',
	[ctrldataupdt] [datetime] NULL,
	[ctrlcodopupdt] [varchar](500) NULL,
 CONSTRAINT [PK_LOG] PRIMARY KEY CLUSTERED 
(
	[LOGID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
CONSTRAINT [IX_LOG_TIPO_IDRELACIONADO_DATA] UNIQUE NONCLUSTERED 
(
	[id_user] ASC,
	[tipo] ASC,
	[id_relacionado] ASC,
	[ctrldata] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SITE_CONTACTS]') AND type in (N'U'))
	DROP TABLE [dbo].[SITE_CONTACTS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SITE_CONTACTS](
	[SITE_CONTACTSID] [int] IDENTITY(1,1) NOT NULL,
	[NOME] [varchar](500) NOT NULL default '',
	[EMAIL] [varchar](500) NOT NULL default '',
	[ASSUNTO] [varchar](500) NOT NULL default '',
	[TEXTO] [varchar](max) NOT NULL default '',
	[SUCESSO] [bit] NOT NULL default 1,
	[ctrldata] [datetime] NOT NULL default getdate(),
	[ctrlcodop] [varchar](500) NOT NULL default 'AL',
	[ctrldataupdt] [datetime] NULL,
	[ctrlcodopupdt] [varchar](500) NULL,
 CONSTRAINT [PK_SITE_CONTACTS] PRIMARY KEY CLUSTERED 
(
	[SITE_CONTACTSID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
CONSTRAINT [IX_EMAIL_ASSUNTO_DATA] UNIQUE NONCLUSTERED 
(
	[EMAIL] ASC,
	[ASSUNTO] ASC,
	[ctrldata] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TEXTOS]') AND type in (N'U'))
	DROP TABLE [dbo].[TEXTOS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TEXTOS](
	[TEXTOSID] [int] IDENTITY(1,1) NOT NULL,
	[CODIGO] [varchar](100) NOT NULL default '*',
	[NOME] [varchar](500) NOT NULL default '',
	[NOME_EN] [varchar](500) NOT NULL default '',
	[NOME_FR] [varchar](500) NOT NULL default '',
	[NOME_ES] [varchar](500) NOT NULL default '',
	[TEXTO] [varchar](max) NOT NULL default '',
	[TEXTO_EN] [varchar](max) NOT NULL default '',
	[TEXTO_FR] [varchar](max) NOT NULL default '',
	[TEXTO_ES] [varchar](max) NOT NULL default '',
	[ordem] [int] NOT NULL default 0,
	[ctrldata] [datetime] NOT NULL default getdate(),
	[ctrlcodop] [varchar](500) NOT NULL default 'AL',
	[ctrldataupdt] [datetime] NULL,
	[ctrlcodopupdt] [varchar](500) NULL,
	[id_imagem] [int] NULL REFERENCES IMAGE (IMAGEID),
 CONSTRAINT [PK_TEXTOS] PRIMARY KEY CLUSTERED 
(
	[TEXTOSID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
CONSTRAINT [IX_TEXTOS_CODIGO] UNIQUE NONCLUSTERED 
(
	[CODIGO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


SET IDENTITY_INSERT [dbo].[CONTACTOS] ON 
GO
INSERT [dbo].[CONTACTOS] ([CONTACTOSID], [NOME], [MORADA1], [MORADA2], [COD_POSTAL], [LOCALIDADE], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt], [telefone], [email]) VALUES (2, N'CASA DOS BISPOS', N'Largo da Praça', N'', N'6430-011', N'Aveloso', CAST(N'2023-04-03T23:56:34.813' AS DateTime), N'AL', CAST(N'2023-04-04T00:08:57.637' AS DateTime), N'AL', N'(+351) 934 901 395', N'geral@casadosbispos.pt')
GO
SET IDENTITY_INSERT [dbo].[CONTACTOS] OFF
GO

SET IDENTITY_INSERT [dbo].[IMAGES_TYPE] ON 
GO
INSERT [dbo].[IMAGES_TYPE] ([IMAGES_TYPEID], [NOME], [NOME_EN], [NOME_FR], [NOME_ES], [ORDEM], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (2, N'TESTE', N'TESTE', N'TESTE', N'TESTE', 1, CAST(N'2023-03-19T02:31:07.503' AS DateTime), N'AL', CAST(N'2023-04-02T23:17:35.753' AS DateTime), N'AL')
GO
SET IDENTITY_INSERT [dbo].[IMAGES_TYPE] OFF
GO


SET IDENTITY_INSERT [dbo].[IMAGE] ON 
GO
INSERT [dbo].[IMAGE] ([IMAGEID], [NOME], [NOME_EN], [NOME_FR], [NOME_ES], [ID_TIPO], [ORDEM], [SLIDER_INICIAL], [EXTENSAO], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (1, N'TESTE1', N'TESTE1', N'TESTE1', N'TESTE1', 2, 1, 1, N'.jpeg', CAST(N'2023-03-19T13:39:53.960' AS DateTime), N'AL', CAST(N'2023-04-02T23:17:35.757' AS DateTime), N'AL')
GO
SET IDENTITY_INSERT [dbo].[IMAGE] OFF
GO

update images_type
set id_imagem_capa = 1
where IMAGES_TYPEID = 2
go



SET IDENTITY_INSERT [dbo].[TEXTOS] ON 
GO
INSERT [dbo].[TEXTOS] ([TEXTOSID], [CODIGO], [NOME], [NOME_EN], [NOME_FR], [NOME_ES], [TEXTO], [TEXTO_EN], [TEXTO_FR], [TEXTO_ES], [ordem], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt], [id_imagem]) VALUES (4, N'CASADOSBISPOS', N'Casa dos Bispos', N'Bishops'' House', N'Maison des Évêques', N'Casa de los Obispos', N'A Casa dos Bispos data inicialmente de cerca de 1220 e foi a residência de Verão dos Bispos de Lamego. Sofreu várias remodelações desde então, sendo a mais recente a de 2022.<br />No seu interior encontram-se marcas na pedra com datas e inscrições judaicas e outros detalhes que só se podem encontrar numa casa com tanta história.', N'The Bishop''s House originally dates from around 1220 and was the summer residence of the Bishops of Lamego. It has undergone several renovations since then, the most recent being in 2022.<br />In its interior there are marks in the stone with Jewish dates and inscriptions and other details that can only be found in a house with so much history.', N'La Maison des Évêques date d''environ 1220 et était la résidence d''été des évêques de Lamego. Elle a subi plusieurs remaniements depuis lors, le plus récent datant de 2022.<br />À l''intérieur, la pierre porte des dates, des inscriptions juives et d''autres détails que l''on ne peut trouver que dans une maison chargée d''histoire.', N'La Casa de los Obispos data originalmente de alrededor de 1220 y era la residencia de verano de los obispos de Lamego. Desde entonces ha sufrido varias remodelaciones, la última en 2022.<br />En su interior hay marcas en la piedra con fechas e inscripciones judías y otros detalles que sólo se pueden encontrar en una casa con tanta historia.', 1, CAST(N'2023-02-26T03:43:10.487' AS DateTime), N'AL', CAST(N'2023-04-05T11:24:57.237' AS DateTime), N'AL', 1)
GO
INSERT [dbo].[TEXTOS] ([TEXTOSID], [CODIGO], [NOME], [NOME_EN], [NOME_FR], [NOME_ES], [TEXTO], [TEXTO_EN], [TEXTO_FR], [TEXTO_ES], [ordem], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt], [id_imagem]) VALUES (5, N'ENVOLVENTE', N'Envolvente', N'Involving', N'Mise Sous Pli', N'Envolvente', N'Apesar de se localizar na Praça Central da aldeia do Aveloso, a casa é também rodeada por uma quinta de 10 hectares, permitindo a imersão no sossego da vida rural. Incluindo outros terrenos na zona exterior da aldeia, há um total de 90 hectares de área agrícola e florestal a explorar. <br />Há, assim, a possibilidade de participar no tratamento e colheita de uva, maçã, castanha, batata, amêndoa, avelã, azeitona e cereais, bem como no tratamento de animais como vacas, ovelhas, cabras, coelhos e animais de capoeira. ', N'Although located in the central square of the village of Aveloso, the house is also surrounded by a 10-hectare farm, allowing you to immerse yourself in the tranquility of rural life. Including other land outside the village, there is a total of 90 hectares of agricultural and forestry area to explore.<br />There is thus the possibility of participating in the handling and harvesting of grapes, apples, chestnuts, potatoes, almonds, hazelnuts, olives and cereals, as well as in the handling of animals such as cows, sheep, goats, rabbits and poultry. ', N'Bien que située sur la place centrale du village d''Aveloso, la maison est également entourée d''une ferme de 10 hectares, ce qui vous permet de vous immerger dans la tranquillité de la vie rurale. Avec d''autres terres situées à l''extérieur du village, ce sont au total 90 hectares de zones agricoles et forestières qui sont à découvrir.<br />Il est donc possible de participer au traitement et à la récolte du raisin, des pommes, des châtaignes, des pommes de terre, des amandes, des noisettes, des olives et des céréales, ainsi qu''au traitement des animaux tels que les vaches, les moutons, les chèvres, les lapins et la volaille.', N'Aunque se encuentra en la plaza central del pueblo de Aveloso, la casa también está rodeada por una finca de 10 hectáreas, lo que le permite sumergirse en la tranquilidad de la vida rural. Incluyendo otros terrenos fuera del pueblo, hay un total de 90 hectáreas de superficie agrícola y forestal para explorar.<br />Existe, por tanto, la posibilidad de participar en el tratamiento y la cosecha de uvas, manzanas, castañas, patatas, almendras, avellanas, aceitunas y cereales, así como en el tratamiento de animales como vacas, ovejas, cabras, conejos y aves de corral. ', 2, CAST(N'2023-02-26T03:43:10.503' AS DateTime), N'AL', CAST(N'2023-04-05T11:26:31.063' AS DateTime), N'AL', 1)
GO
INSERT [dbo].[TEXTOS] ([TEXTOSID], [CODIGO], [NOME], [NOME_EN], [NOME_FR], [NOME_ES], [TEXTO], [TEXTO_EN], [TEXTO_FR], [TEXTO_ES], [ordem], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt], [id_imagem]) VALUES (6, N'ALDEIA', N'A Aldeia', N'About the Village', N'Le Village', N'El Pueblo', N'No Aveloso, pode-se caminhar ao longo da ribeira Teja e observar marcos de outros tempos, como a Ponte Romana, o Pelourinho e inscrições judaicas (também no interior da Casa dos Bispos). E ainda, percorrer os mesmos caminhos que o Homem-Macaco calcorreou. <br />No entanto, não se fique por aqui e conheça as outras pequenas aldeias vizinhas, com castelos, barragens e miradouros.', N'In Aveloso, you can walk along the Ribeira Teja and observe landmarks from other times, such as the Roman Bridge, the Pillory and Jewish inscriptions (also inside the Bishops'' House). And also, walk the same paths that the Man-Ape walked.<br />However, don''t stop there and visit the other small neighboring villages, with castles, dams and viewpoints.', N'À Aveloso, vous pouvez vous promener le long de la Ribeira Teja et observer des monuments d''autres époques, comme le pont romain, le pilori et les inscriptions juives (également à l''intérieur de la Maison des Évêques). Vous pourrez également emprunter les mêmes chemins que l''homme-singe. <br />Mais ne vous arrêtez pas là et découvrez les autres petits villages voisins, avec leurs châteaux, leurs barrages et leurs points de vue.', N'En Aveloso, puede pasear por la Ribeira Teja y ver hitos de otros tiempos, como el Puente Romano, la Pillory e inscripciones judías (también dentro de la Casa de los Obispos). Y también, caminar por los mismos senderos que recorrió el Hombre-Mono. <br />Pero no se quede ahí y descubra las otras pequeñas aldeas vecinas, con castillos, presas y miradores.', 3, CAST(N'2023-02-26T03:43:10.513' AS DateTime), N'AL', CAST(N'2023-04-05T11:32:47.280' AS DateTime), N'AL', 1)
GO
INSERT [dbo].[TEXTOS] ([TEXTOSID], [CODIGO], [NOME], [NOME_EN], [NOME_FR], [NOME_ES], [TEXTO], [TEXTO_EN], [TEXTO_FR], [TEXTO_ES], [ordem], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt], [id_imagem]) VALUES (7, N'OUTROSPONTOS', N'Outros pontos a visitar', N'Other places to visit', N'Autres sites à visiter', N'Otros lugares para visitar', N'A casa dista 15 km da aldeia histórica de Marialva, 25km de Vila Nova de Foz Côa, 17km da aldeia de Longroiva, 15km de Penedono e 24km de Trancoso.<br />Mais distante mas não menos interessante, poderá também visitar Pinhel (45km), Almeida (72km) ou a aldeia histórica de Linhares da Beira (61km).', N'The house is 15 km from the historical village of Marialva, 25km from Vila Nova de Foz Côa, 17km from the village of Longroiva, 15km from Penedono and 24km from Trancoso.<br />Further away but no less interesting, you can also visit Pinhel (45km), Almeida (72km) or the historical village of Linhares da Beira (61km).', N'La maison se trouve à 15 km du village historique de Marialva, à 25 km de Vila Nova de Foz Coa, à 17 km du village de Longroiva, à 15 km de Penedono et à 24 km de Trancoso.<br />Plus loin, mais non moins intéressant, vous pouvez également visiter Pinhel (45 km), Almeida (72 km) ou le village historique de Linhares da Beira (61 km).', N'La casa está a 15 km del pueblo histórico de Marialva, a 25km de Vila Nova de Foz Coa, a 17km del pueblo de Longroiva, a 15km de Penedono y a 24km de Trancoso.<br />Más lejos, pero no menos interesante, también se puede visitar Pinhel (45km), Almeida (72km) o el pueblo histórico de Linhares da Beira (61km).', 4, CAST(N'2023-04-05T12:01:16.510' AS DateTime), N'AL', CAST(N'2023-04-05T12:01:16.510' AS DateTime), N'AL', 1)
GO
INSERT [dbo].[TEXTOS] ([TEXTOSID], [CODIGO], [NOME], [NOME_EN], [NOME_FR], [NOME_ES], [TEXTO], [TEXTO_EN], [TEXTO_FR], [TEXTO_ES], [ordem], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt], [id_imagem]) VALUES (8, N'ALOJAMENTO', N'Alojamento', N'Housing', N'Hébergement', N'Alojamiento', N'Os dois principais alojamentos são a Casa do Montês e o Estábulo. Ambos contam com casa de banho privativa, quarto, zona de lazer com televisão e pequena área de cozinha com máquina de café, micro-ondas, torradeira, entre outros. Adicionalmente, a Casa do Montês oferece uma kitchenette para a confeção de refeições.<br />Há ainda a possibilidade de pernoitar no interior do edifício principal, em quartos com casa de banho partilhada. Todos incluem televisão.', N'The two main accommodations are the Casa do Montês and the Estábulo. Both have private bathroom, bedroom, leisure area with TV and small kitchen area with coffee machine, microwave, toaster, among others. Additionally, Casa do Montês offers a kitchenette for cooking meals.<br />There is also the possibility of staying overnight inside the main building, in rooms with shared bathroom. All rooms include a TV.', N'Les deux principaux logements sont la Casa do Montês et l''Estábulo. Tous deux disposent d''une salle de bain privée, d''une chambre à coucher, d''un espace de détente avec télévision et d''une petite cuisine avec machine à café, micro-ondes, grille-pain, entre autres. En outre, la Casa do Montês dispose d''une kitchenette pour la préparation des repas.<br />Il est également possible de passer la nuit à l''intérieur du bâtiment principal, dans des chambres avec salle de bains commune. Toutes les chambres comprennent une télévision.', N'Los dos alojamientos principales son la Casa do Montês y el Estábulo. Ambos disponen de baño privado, dormitorio, zona de ocio con TV y pequeña zona de cocina con cafetera, microondas, tostadora, entre otros. Además, la Casa do Montês ofrece una cocina americana para la preparación de comidas.<br />También existe la posibilidad de pernoctar dentro del edificio principal, en habitaciones con baño compartido. Todas las habitaciones incluyen TV.', 99, CAST(N'2023-04-06T01:01:01.800' AS DateTime), N'AL', CAST(N'2023-04-06T01:01:20.417' AS DateTime), N'AL', NULL)
GO
SET IDENTITY_INSERT [dbo].[TEXTOS] OFF
GO


SET IDENTITY_INSERT [dbo].[USERTYPE] ON 
GO
INSERT [dbo].[USERTYPE] ([USERTYPEID], [nome], [notas], [administrador], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (1, N'Administrador', N'', 1, CAST(N'2023-02-25T02:18:43.367' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[USERTYPE] ([USERTYPEID], [nome], [notas], [administrador], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (2, N'Default User', N'', 0, CAST(N'2023-02-25T02:18:43.383' AS DateTime), N'AL', NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[USERTYPE] OFF
GO



SET IDENTITY_INSERT [dbo].[USERS] ON 
GO
INSERT [dbo].[USERS] ([USERSID], [nome], [codigo], [email], [telemovel], [ativo], [password], [notas], [lastlogin], [id_tipo_utilizador], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (1, N'André Lourenço', N'AL', N'afonsopereira6@gmail.com', N'912803666', 1, N'liedson31', N'', CAST(N'2023-04-06T00:55:13.053' AS DateTime), 1, CAST(N'2023-02-25T02:18:43.390' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[USERS] ([USERSID], [nome], [codigo], [email], [telemovel], [ativo], [password], [notas], [lastlogin], [id_tipo_utilizador], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (2, N'Gabriela Will', N'GABRIELAWILL', N'jogaboliveira@gmail.com', N'934901395', 1, N'will', N'', NULL, 1, CAST(N'2023-02-25T02:18:43.400' AS DateTime), N'AL', NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[USERS] OFF
GO



SET IDENTITY_INSERT [dbo].[ACESSOS] ON 
GO
INSERT [dbo].[ACESSOS] ([ACESSOSID], [id_utilizador], [datahora], [tipo], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (1, 1, CAST(N'2023-02-25T02:41:51.160' AS DateTime), N'LOGIN', CAST(N'2023-02-25T02:41:51.160' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[ACESSOS] ([ACESSOSID], [id_utilizador], [datahora], [tipo], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (2, 1, CAST(N'2023-02-26T03:58:00.020' AS DateTime), N'LOGIN', CAST(N'2023-02-26T03:58:00.020' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[ACESSOS] ([ACESSOSID], [id_utilizador], [datahora], [tipo], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (3, 1, CAST(N'2023-03-02T22:42:30.893' AS DateTime), N'LOGIN', CAST(N'2023-03-02T22:42:30.893' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[ACESSOS] ([ACESSOSID], [id_utilizador], [datahora], [tipo], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (4, 1, CAST(N'2023-03-10T01:05:47.013' AS DateTime), N'LOGIN', CAST(N'2023-03-10T01:05:47.017' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[ACESSOS] ([ACESSOSID], [id_utilizador], [datahora], [tipo], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (5, 1, CAST(N'2023-03-12T01:31:36.847' AS DateTime), N'LOGIN', CAST(N'2023-03-12T01:31:36.847' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[ACESSOS] ([ACESSOSID], [id_utilizador], [datahora], [tipo], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (6, 1, CAST(N'2023-03-12T02:02:14.697' AS DateTime), N'LOGIN', CAST(N'2023-03-12T02:02:14.697' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[ACESSOS] ([ACESSOSID], [id_utilizador], [datahora], [tipo], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (7, 1, CAST(N'2023-03-12T02:07:06.800' AS DateTime), N'LOGIN', CAST(N'2023-03-12T02:07:06.800' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[ACESSOS] ([ACESSOSID], [id_utilizador], [datahora], [tipo], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (8, 1, CAST(N'2023-03-12T02:54:11.830' AS DateTime), N'LOGIN', CAST(N'2023-03-12T02:54:11.833' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[ACESSOS] ([ACESSOSID], [id_utilizador], [datahora], [tipo], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (9, 1, CAST(N'2023-03-12T19:24:31.667' AS DateTime), N'LOGIN', CAST(N'2023-03-12T19:24:31.667' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[ACESSOS] ([ACESSOSID], [id_utilizador], [datahora], [tipo], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (10, 1, CAST(N'2023-03-13T01:06:57.430' AS DateTime), N'LOGIN', CAST(N'2023-03-13T01:06:57.563' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[ACESSOS] ([ACESSOSID], [id_utilizador], [datahora], [tipo], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (11, 1, CAST(N'2023-03-18T13:29:39.510' AS DateTime), N'LOGIN', CAST(N'2023-03-18T13:29:39.510' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[ACESSOS] ([ACESSOSID], [id_utilizador], [datahora], [tipo], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (12, 1, CAST(N'2023-03-18T20:27:16.910' AS DateTime), N'LOGIN', CAST(N'2023-03-18T20:27:16.910' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[ACESSOS] ([ACESSOSID], [id_utilizador], [datahora], [tipo], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (13, 1, CAST(N'2023-03-19T02:16:30.680' AS DateTime), N'LOGIN', CAST(N'2023-03-19T02:16:30.687' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[ACESSOS] ([ACESSOSID], [id_utilizador], [datahora], [tipo], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (14, 1, CAST(N'2023-03-22T14:24:37.277' AS DateTime), N'LOGIN', CAST(N'2023-03-22T14:24:37.277' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[ACESSOS] ([ACESSOSID], [id_utilizador], [datahora], [tipo], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (15, 1, CAST(N'2023-03-26T16:15:04.060' AS DateTime), N'LOGIN', CAST(N'2023-03-26T16:15:04.060' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[ACESSOS] ([ACESSOSID], [id_utilizador], [datahora], [tipo], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (16, 1, CAST(N'2023-03-26T22:56:28.610' AS DateTime), N'LOGIN', CAST(N'2023-03-26T22:56:28.610' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[ACESSOS] ([ACESSOSID], [id_utilizador], [datahora], [tipo], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (17, 1, CAST(N'2023-04-01T19:16:04.347' AS DateTime), N'LOGIN', CAST(N'2023-04-01T19:16:04.347' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[ACESSOS] ([ACESSOSID], [id_utilizador], [datahora], [tipo], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (18, 1, CAST(N'2023-04-02T01:12:19.090' AS DateTime), N'LOGIN', CAST(N'2023-04-02T01:12:19.093' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[ACESSOS] ([ACESSOSID], [id_utilizador], [datahora], [tipo], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (19, 1, CAST(N'2023-04-02T01:28:19.393' AS DateTime), N'LOGIN', CAST(N'2023-04-02T01:28:19.393' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[ACESSOS] ([ACESSOSID], [id_utilizador], [datahora], [tipo], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (20, 1, CAST(N'2023-04-02T20:38:29.573' AS DateTime), N'LOGIN', CAST(N'2023-04-02T20:38:29.573' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[ACESSOS] ([ACESSOSID], [id_utilizador], [datahora], [tipo], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (21, 1, CAST(N'2023-04-02T23:23:09.080' AS DateTime), N'LOGIN', CAST(N'2023-04-02T23:23:09.083' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[ACESSOS] ([ACESSOSID], [id_utilizador], [datahora], [tipo], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (22, 1, CAST(N'2023-04-02T23:26:06.947' AS DateTime), N'LOGIN', CAST(N'2023-04-02T23:26:06.947' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[ACESSOS] ([ACESSOSID], [id_utilizador], [datahora], [tipo], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (23, 1, CAST(N'2023-04-03T23:35:46.490' AS DateTime), N'LOGIN', CAST(N'2023-04-03T23:35:46.490' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[ACESSOS] ([ACESSOSID], [id_utilizador], [datahora], [tipo], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (24, 1, CAST(N'2023-04-05T11:15:45.000' AS DateTime), N'LOGIN', CAST(N'2023-04-05T11:15:45.000' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[ACESSOS] ([ACESSOSID], [id_utilizador], [datahora], [tipo], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (25, 1, CAST(N'2023-04-06T00:55:13.053' AS DateTime), N'LOGIN', CAST(N'2023-04-06T00:55:13.053' AS DateTime), N'AL', NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[ACESSOS] OFF
GO



SET IDENTITY_INSERT [dbo].[LOG] ON 
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (1, 1, 1, N'LOGIN', N'O utilizador AL efetuou login no sistema', CAST(N'2023-02-25T02:41:51.167' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (2, 1, 2, N'LOGIN', N'O utilizador AL efetuou login no sistema', CAST(N'2023-02-26T03:58:00.040' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (3, 1, 3, N'LOGIN', N'O utilizador AL efetuou login no sistema', CAST(N'2023-03-02T22:42:30.900' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (4, 1, 4, N'LOGIN', N'O utilizador AL efetuou login no sistema', CAST(N'2023-03-10T01:05:47.027' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (5, 1, 5, N'LOGIN', N'O utilizador AL efetuou login no sistema', CAST(N'2023-03-12T01:31:36.857' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (6, 1, 6, N'LOGIN', N'O utilizador AL efetuou login no sistema', CAST(N'2023-03-12T02:02:14.697' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (7, 1, 7, N'LOGIN', N'O utilizador AL efetuou login no sistema', CAST(N'2023-03-12T02:07:06.800' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (8, 1, 8, N'LOGIN', N'O utilizador AL efetuou login no sistema', CAST(N'2023-03-12T02:54:11.833' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (9, 1, 1, N'IMAGEM TIPO', N'O utilizador AL inseriu os dados do tipo de imagem Teste', CAST(N'2023-03-12T02:59:26.317' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (10, 1, 1, N'IMAGEM TIPO', N'O utilizador AL atualizou os dados do tipo de imagem Teste', CAST(N'2023-03-12T03:00:34.030' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (11, 1, 1, N'IMAGEM TIPO', N'O utilizador AL removeu o tipo de imagem Teste e todas as imagens associadas!', CAST(N'2023-03-12T03:00:39.647' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (12, 1, 9, N'LOGIN', N'O utilizador AL efetuou login no sistema', CAST(N'2023-03-12T19:24:31.670' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (13, 1, 10, N'LOGIN', N'O utilizador AL efetuou login no sistema', CAST(N'2023-03-13T01:06:57.927' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (14, 1, 11, N'LOGIN', N'O utilizador AL efetuou login no sistema', CAST(N'2023-03-18T13:29:39.513' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (15, 1, 12, N'LOGIN', N'O utilizador AL efetuou login no sistema', CAST(N'2023-03-18T20:27:16.910' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (16, 1, 13, N'LOGIN', N'O utilizador AL efetuou login no sistema', CAST(N'2023-03-19T02:16:30.690' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (17, 1, 2, N'IMAGEM TIPO', N'O utilizador AL inseriu os dados do tipo de imagem TESTE', CAST(N'2023-03-19T02:31:07.507' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (18, 1, 1, N'IMAGEM', N'O utilizador AL inseriu os dados da imagem TESTE', CAST(N'2023-03-19T02:31:07.510' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (19, 1, 2, N'IMAGEM TIPO', N'O utilizador AL atualizou os dados do tipo de imagem TESTE', CAST(N'2023-03-19T02:33:31.967' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (20, 1, 2, N'IMAGEM', N'O utilizador AL inseriu os dados da imagem TESTE', CAST(N'2023-03-19T02:33:31.970' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (21, 1, 2, N'IMAGEM TIPO', N'O utilizador AL atualizou os dados do tipo de imagem TESTE', CAST(N'2023-03-19T03:12:59.937' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (22, 1, 2, N'IMAGEM', N'O utilizador AL atualizou os dados da imagem TESTE', CAST(N'2023-03-19T03:12:59.940' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (23, 1, 2, N'IMAGEM TIPO', N'O utilizador AL atualizou os dados do tipo de imagem TESTE', CAST(N'2023-03-19T03:13:21.840' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (24, 1, 2, N'IMAGEM', N'O utilizador AL atualizou os dados da imagem TESTE', CAST(N'2023-03-19T03:13:21.840' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (25, 1, 2, N'IMAGEM TIPO', N'O utilizador AL atualizou os dados do tipo de imagem TESTE', CAST(N'2023-03-19T03:19:24.730' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (26, 1, 2, N'IMAGEM', N'O utilizador AL atualizou os dados da imagem TESTE', CAST(N'2023-03-19T03:19:24.730' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (27, 1, 2, N'IMAGEM TIPO', N'O utilizador AL atualizou os dados do tipo de imagem TESTE', CAST(N'2023-03-19T03:23:07.987' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (28, 1, 2, N'IMAGEM', N'O utilizador AL atualizou os dados da imagem TESTE', CAST(N'2023-03-19T03:23:07.987' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (29, 1, 2, N'IMAGEM TIPO', N'O utilizador AL atualizou os dados do tipo de imagem TESTE', CAST(N'2023-03-19T03:25:53.547' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (30, 1, 3, N'IMAGEM', N'O utilizador AL inseriu os dados da imagem TESTE2', CAST(N'2023-03-19T03:25:53.550' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (31, 1, 2, N'IMAGEM TIPO', N'O utilizador AL atualizou os dados do tipo de imagem TESTE', CAST(N'2023-03-19T03:32:25.333' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (32, 1, 2, N'IMAGEM', N'O utilizador AL atualizou os dados da imagem TESTE', CAST(N'2023-03-19T03:32:25.333' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (33, 1, 2, N'IMAGEM TIPO', N'O utilizador AL atualizou os dados do tipo de imagem TESTE', CAST(N'2023-03-19T03:35:50.497' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (34, 1, 4, N'IMAGEM', N'O utilizador AL inseriu os dados da imagem TESTE3', CAST(N'2023-03-19T03:35:50.500' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (35, 1, 2, N'IMAGEM TIPO', N'O utilizador AL atualizou os dados do tipo de imagem TESTE', CAST(N'2023-03-19T13:39:53.957' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (36, 1, 1, N'IMAGEM', N'O utilizador AL inseriu os dados da imagem TESTE1', CAST(N'2023-03-19T13:39:53.960' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (37, 1, 4, N'TEXTOS', N'O utilizador AL atualizou os dados do texto CASADOSBISPOS', CAST(N'2023-03-19T15:26:58.330' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (38, 1, 4, N'TEXTOS', N'O utilizador AL atualizou os dados do texto CASADOSBISPOS', CAST(N'2023-03-19T15:27:48.140' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (39, 1, 5, N'TEXTOS', N'O utilizador AL atualizou os dados do texto ALDEIADOAVELOSO', CAST(N'2023-03-19T15:29:33.737' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (40, 1, 6, N'TEXTOS', N'O utilizador AL atualizou os dados do texto HISTORIADOAVELOSO', CAST(N'2023-03-19T15:31:14.803' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (41, 1, 14, N'LOGIN', N'O utilizador AL efetuou login no sistema', CAST(N'2023-03-22T14:24:37.280' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (42, 1, 15, N'LOGIN', N'O utilizador AL efetuou login no sistema', CAST(N'2023-03-26T16:15:04.067' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (43, 1, 16, N'LOGIN', N'O utilizador AL efetuou login no sistema', CAST(N'2023-03-26T22:56:28.613' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (44, 1, 4, N'TEXTOS', N'O utilizador AL atualizou os dados do texto CASADOSBISPOS', CAST(N'2023-03-26T23:32:13.813' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (45, 1, 5, N'TEXTOS', N'O utilizador AL atualizou os dados do texto ALDEIADOAVELOSO', CAST(N'2023-03-27T00:30:30.230' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (46, 1, 6, N'TEXTOS', N'O utilizador AL atualizou os dados do texto HISTORIADOAVELOSO', CAST(N'2023-03-27T00:30:41.747' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (47, 1, 17, N'LOGIN', N'O utilizador AL efetuou login no sistema', CAST(N'2023-04-01T19:16:04.350' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (48, 1, 18, N'LOGIN', N'O utilizador AL efetuou login no sistema', CAST(N'2023-04-02T01:12:19.093' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (49, 1, 19, N'LOGIN', N'O utilizador AL efetuou login no sistema', CAST(N'2023-04-02T01:28:19.397' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (50, 1, 2, N'IMAGEM TIPO', N'O utilizador AL atualizou os dados do tipo de imagem TESTE', CAST(N'2023-04-02T03:05:24.527' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (51, 1, 2, N'IMAGEM TIPO', N'O utilizador AL atualizou os dados do tipo de imagem TESTE', CAST(N'2023-04-02T03:07:31.570' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (52, 1, 20, N'LOGIN', N'O utilizador AL efetuou login no sistema', CAST(N'2023-04-02T20:38:29.580' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (53, 1, 2, N'IMAGEM TIPO', N'O utilizador AL atualizou os dados do tipo de imagem TESTE', CAST(N'2023-04-02T23:15:05.613' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (54, 1, 1, N'IMAGEM', N'O utilizador AL atualizou os dados da imagem TESTE1', CAST(N'2023-04-02T23:15:05.613' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (55, 1, 2, N'IMAGEM TIPO', N'O utilizador AL atualizou os dados do tipo de imagem TESTE', CAST(N'2023-04-02T23:15:17.687' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (56, 1, 2, N'IMAGEM TIPO', N'O utilizador AL atualizou os dados do tipo de imagem TESTE', CAST(N'2023-04-02T23:15:45.560' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (57, 1, 2, N'IMAGEM TIPO', N'O utilizador AL atualizou os dados do tipo de imagem TESTE', CAST(N'2023-04-02T23:16:24.560' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (58, 1, 2, N'IMAGEM TIPO', N'O utilizador AL atualizou os dados do tipo de imagem TESTE', CAST(N'2023-04-02T23:17:35.753' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (59, 1, 1, N'IMAGEM', N'O utilizador AL atualizou os dados da imagem TESTE1', CAST(N'2023-04-02T23:17:35.757' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (60, 1, 21, N'LOGIN', N'O utilizador AL efetuou login no sistema', CAST(N'2023-04-02T23:23:09.083' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (61, 1, 22, N'LOGIN', N'O utilizador AL efetuou login no sistema', CAST(N'2023-04-02T23:26:06.950' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (62, 1, 23, N'LOGIN', N'O utilizador AL efetuou login no sistema', CAST(N'2023-04-03T23:35:46.497' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (63, 1, 2, N'CONTACTOS', N'O utilizador AL atualizou os dados de contacto', CAST(N'2023-04-04T00:06:31.440' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (64, 1, 2, N'CONTACTOS', N'O utilizador AL atualizou os dados de contacto', CAST(N'2023-04-04T00:08:48.733' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (65, 1, 2, N'CONTACTOS', N'O utilizador AL atualizou os dados de contacto', CAST(N'2023-04-04T00:08:57.640' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (66, 1, 24, N'LOGIN', N'O utilizador AL efetuou login no sistema', CAST(N'2023-04-05T11:15:45.003' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (67, 1, 5, N'TEXTOS', N'O utilizador AL atualizou os dados do texto ENVOLVENTE', CAST(N'2023-04-05T11:20:25.010' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (68, 1, 6, N'TEXTOS', N'O utilizador AL atualizou os dados do texto ALDEIA', CAST(N'2023-04-05T11:22:31.803' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (69, 1, 4, N'TEXTOS', N'O utilizador AL atualizou os dados do texto CASADOSBISPOS', CAST(N'2023-04-05T11:24:57.240' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (70, 1, 5, N'TEXTOS', N'O utilizador AL atualizou os dados do texto ENVOLVENTE', CAST(N'2023-04-05T11:26:31.067' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (71, 1, 6, N'TEXTOS', N'O utilizador AL atualizou os dados do texto ALDEIA', CAST(N'2023-04-05T11:32:01.040' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (72, 1, 6, N'TEXTOS', N'O utilizador AL atualizou os dados do texto ALDEIA', CAST(N'2023-04-05T11:32:47.283' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (73, 1, 7, N'TEXTOS', N'O utilizador AL inseriu os dados do texto OUTROSPONTOS', CAST(N'2023-04-05T12:01:16.513' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (74, 1, 25, N'LOGIN', N'O utilizador AL efetuou login no sistema', CAST(N'2023-04-06T00:55:13.060' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (75, 1, 8, N'TEXTOS', N'O utilizador AL inseriu os dados do texto ALOJAMENTO', CAST(N'2023-04-06T01:01:01.810' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (76, 1, 8, N'TEXTOS', N'O utilizador AL atualizou os dados do texto ALOJAMENTO', CAST(N'2023-04-06T01:01:15.757' AS DateTime), N'AL', NULL, NULL)
GO
INSERT [dbo].[LOG] ([LOGID], [id_user], [id_relacionado], [tipo], [notas], [ctrldata], [ctrlcodop], [ctrldataupdt], [ctrlcodopupdt]) VALUES (77, 1, 8, N'TEXTOS', N'O utilizador AL atualizou os dados do texto ALOJAMENTO', CAST(N'2023-04-06T01:01:20.417' AS DateTime), N'AL', NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[LOG] OFF
GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[REPORT_CONFIGS]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
	DROP FUNCTION [REPORT_CONFIGS]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[REPORT_CONFIGS]()
returns table as return
(
	select
		email, 
		email_password, 
		email_smtp, 
		email_smtpport, 
		emails_alerta, 
		sessaomaxmin,
		[url]
	from APPLICATION_CONFIG
)
GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[REPORT_CONTACTOS]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
	DROP FUNCTION [REPORT_CONTACTOS]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[REPORT_CONTACTOS]()
returns table as return
(
	select
		CONTACTOSID as id,
		NOME,
		MORADA1,
		MORADA2,
		COD_POSTAL,
		LOCALIDADE,
		email,
		telefone
	from CONTACTOS
)
GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[REPORT_IMAGEM_TIPO]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
	DROP FUNCTION [REPORT_IMAGEM_TIPO]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[REPORT_IMAGEM_TIPO](@id int, @nome varchar(500))
returns table as return
(
	select
		it.IMAGES_TYPEID as id,
		it.nome,
		it.nome_en,
		it.nome_fr,
		it.nome_es,
		it.ordem,
		ISNULL(it.id_imagem_capa, 0) as id_imagem_capa,
		CONCAT(ISNULL(LTRIM(RTRIM(STR(img.IMAGEID))), ''), ISNULL(img.extensao, '')) as img_capa
	from IMAGES_TYPE it
	left join [IMAGE] img on img.IMAGEID = it.id_imagem_capa
	where (@id is null or @id = IMAGES_TYPEID)
	and (@nome is null or @nome = it.nome)
)
GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[REPORT_IMAGEM]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
	DROP FUNCTION [REPORT_IMAGEM]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[REPORT_IMAGEM](@id int, @nome varchar(500), @id_tipo int)
returns table as return
(
	select
		img.IMAGEID as id,
		img.nome_en,
		img.nome_es,
		img.nome_fr,
		img.nome,
		img.ordem,
		img.slider_inicial,
		img.extensao,
		img_tp.id as id_tipo,
		img_tp.nome as nome_tipo,
		img_tp.nome_en as nome_en_tipo,
		img_tp.nome_fr as nome_fr_tipo,
		img_tp.nome_es as nome_es_tipo,
		img_tp.ordem as ordem_tipo,
		img_tp.id_imagem_capa as id_imagem_capa_tipo,
		img_tp.img_capa as img_capa_tipo
	from [IMAGE] img
	inner join [REPORT_IMAGEM_TIPO](@id_tipo, null) img_tp on img_tp.id = img.id_tipo
	where (@id_tipo is null or @id_tipo = img_tp.id)
	and (@id is null or @id = img.IMAGEID)
	and (@nome is null or @nome = img.nome)
)
GO



IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[REPORT_SITE_CONTACTS]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
	DROP FUNCTION [REPORT_SITE_CONTACTS]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[REPORT_SITE_CONTACTS](@id int, @nome varchar(500), @email varchar(500), @sucesso bit, @data_inicial date, @data_final date)
returns table as return
(
	select
		SITE_CONTACTSID as id,
		NOME,
		EMAIL,
		ASSUNTO,
		TEXTO,
		SUCESSO,
		CONCAT(CONVERT(varchar, ctrldata, 103), ' ', CONVERT(varchar, ctrldata, 108)) as data_envio,
		ctrldata
	from site_contacts
	where (@id is null or @id = SITE_CONTACTSID)
	and (@nome is null or @nome = nome)
	and (@email is null or @email = email)
	and (@sucesso is null or @sucesso = sucesso)
	and (@data_inicial is null or @data_inicial >= cast(ctrldata as date))
	and (@data_final is null or @data_final <= cast(ctrldata as date))
)
GO



IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[REPORT_TEXTOS]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
	DROP FUNCTION [REPORT_TEXTOS]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[REPORT_TEXTOS](@id int, @codigo varchar(100))
returns table as return
(
	select
		t.textosid as id,
		t.CODIGO,
		t.NOME,
		t.NOME_EN,
		t.NOME_FR,
		t.NOME_ES,
		t.TEXTO,
		t.TEXTO_EN,
		t.TEXTO_FR,
		t.TEXTO_ES,
		t.ordem,
		ISNULL(img.id, 0) as id_imagem,
		ISNULL(img.nome_en, '') as nome_en_imagem,
		ISNULL(img.nome_es, '') as nome_es_imagem,
		ISNULL(img.nome_fr, '') as nome_fr_imagem,
		ISNULL(img.nome, '') as nome_imagem,
		ISNULL(img.ordem, 0) as ordem_imagem,
		ISNULL(img.slider_inicial, 0) as slider_inicial_imagem,
		ISNULL(img.extensao, '') as extensao_imagem,
		ISNULL(img.id_tipo, 0) as id_tipo_imagem,
		ISNULL(img.nome_tipo, '') as nome_tipo_imagem,
		ISNULL(img.nome_en, '') as nome_en_tipo_imagem,
		ISNULL(img.nome_fr, '') as nome_fr_tipo_imagem,
		ISNULL(img.nome_es, '') as nome_es_tipo_imagem,
		ISNULL(img.ordem_tipo, '') as ordem_tipo_imagem
	from textos t
	left join REPORT_IMAGEM(null, null, null) img on img.id = t.id_imagem
	where (@id is null or @id = textosid)
	and (@codigo is null or @codigo = codigo)
)
GO



IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[REPORT_USERTYPE]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
	DROP FUNCTION [REPORT_USERTYPE]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[REPORT_USERTYPE](@id_tipo int)
returns table as return
(
    SELECT
		USERTYPEID as id,
		nome,
		notas,
		administrador,
		ctrldata,
		ctrlcodop,
		ctrldataupdt,
		ctrlcodopupdt
    FROM USERTYPE
    WHERE (@id_tipo is null or @id_tipo = USERTYPEID)
)
GO



IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[REPORT_USERS]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
	DROP FUNCTION [REPORT_USERS]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[REPORT_USERS](@id_user int, @username varchar(500), @password varchar(250), @ativo bit, @id_tipo int)
returns table as return
(
	select
		u.usersid as id,
		u.nome,
		u.codigo,
		u.email,
		u.telemovel,
		u.ativo,
		u.password,
		u.notas,
		u.lastlogin,
		ut.id as id_tipo,
		ut.nome as tipo,
		ut.administrador,
		u.ctrldata,
		u.ctrlcodop,
		u.ctrldataupdt,
		u.ctrlcodopupdt
	from users u
	inner join REPORT_USERTYPE(@id_tipo) as ut on ut.id = id_tipo_utilizador
	where (@id_user is null or @id_user = USERSID)
	and (@username is null or @username = u.codigo)
	and (@password is null or @password = u.password)
	and (@ativo is null or @ativo = u.ativo)
	and (@id_tipo is null or @id_tipo = u.id_tipo_utilizador)
)
GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[SITE_REPORT_IMAGEM_TIPO]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
	DROP FUNCTION [SITE_REPORT_IMAGEM_TIPO]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[SITE_REPORT_IMAGEM_TIPO](@id_tipo int, @lingua varchar(10))
returns table as return
(
	select
		it.IMAGES_TYPEID as id,
		case when @lingua = 'EN' then it.nome_en else
		case when @lingua = 'ES' then it.nome_es else
		case when @lingua = 'FR' then it.nome_fr else
		it.nome end end end as nome,
		it.ordem,
		ISNULL(it.id_imagem_capa, 0) as id_imagem_capa,
		CONCAT(ISNULL(LTRIM(RTRIM(STR(img.IMAGEID))), ''), ISNULL(img.extensao, '')) as img_capa
	from IMAGES_TYPE it
	left join [IMAGE] img on img.IMAGEID = it.id_imagem_capa
	where (@id_tipo is null or @id_tipo = IMAGES_TYPEID)
)
GO



IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[SITE_REPORT_IMAGEM]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
	DROP FUNCTION [SITE_REPORT_IMAGEM]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[SITE_REPORT_IMAGEM](@id int, @id_tipo int, @lingua varchar(10))
returns table as return
(
	select
		img.IMAGEID as id,
		case when @lingua = 'EN' then img.nome_en else
		case when @lingua = 'ES' then img.nome_es else
		case when @lingua = 'FR' then img.nome_fr else
		img.nome end end end as nome,
		img.ordem,
		img.slider_inicial,
		img.extensao,
		img_tp.id as id_tipo,
		img_tp.nome as nome_tipo,
		img_tp.ordem as ordem_tipo,
		img_tp.id_imagem_capa as id_imagem_capa_tipo,
		img_tp.img_capa as img_capa_tipo
	from [IMAGE] img
	inner join [SITE_REPORT_IMAGEM_TIPO](@id_tipo, @lingua) img_tp on img_tp.id = img.id_tipo
	where (@id_tipo is null or @id_tipo = img_tp.id)
	and (@id is null or @id = img.IMAGEID)
)
GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[SITE_REPORT_MAIN_IMAGES]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
	DROP FUNCTION [SITE_REPORT_MAIN_IMAGES]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[SITE_REPORT_MAIN_IMAGES](@img varchar(500))
returns table as return
(		
	with img as
	(
		select
			CONCAT(LTRIM(RTRIM(STR(id))), extensao) as imagem,
			ordem
		from [REPORT_IMAGEM](null, null, null)
		where slider_inicial = 1
	)

	select distinct
		imagem, ordem
	from img
	where (@img is null or @img = imagem)
)
GO



IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[SITE_REPORT_TEXTOS]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
	DROP FUNCTION [SITE_REPORT_TEXTOS]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[SITE_REPORT_TEXTOS](@codigo varchar(100), @id_texto int, @lingua varchar(10))
returns table as return
(
	select
		t.TEXTOSID as id_texto,
		t.CODIGO,
		case when @lingua = 'EN' then t.nome_en else
		case when @lingua = 'ES' then t.nome_es else
		case when @lingua = 'FR' then t.nome_fr else
		t.nome end end end as nome,
		case when @lingua = 'EN' then t.texto_en else
		case when @lingua = 'ES' then t.texto_es else
		case when @lingua = 'FR' then t.texto_fr else
		t.texto end end end as texto,
		t.ordem,
		ISNULL(img.id, 0) as id_imagem,
		ISNULL(img.nome, '') as nome_imagem,
		ISNULL(img.ordem, 0) as ordem_imagem,
		ISNULL(img.slider_inicial, 0) as slider_inicial_imagem,
		ISNULL(img.extensao, '') as extensao_imagem,
		ISNULL(img.id_tipo, 0) as id_tipo,
		ISNULL(img.nome_tipo, '') as nome_tipo_imagem,
		ISNULL(img.ordem_tipo, 0) as ordem_tipo_imagem
	from textos t
	left join SITE_REPORT_IMAGEM (null, null, @lingua) img on img.id = t.id_imagem
	where (@codigo is null or @codigo = CODIGO)
	and (@id_texto is null or @id_texto = textosid)
)
GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[REPORT_DASHBOARD_DATA]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
	DROP FUNCTION [REPORT_DASHBOARD_DATA]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[REPORT_DASHBOARD_DATA]()
returns table as return
(
	with users as (
		select
			count(id) as total1,
			'Utilizadores' as label1,
			'Total de Utilizadores no Sistema' as rodape1
		from REPORT_USERS(null, null, null, null, 1)
	),
	img as (
		select
			count(id) as total2,
			'Imagens' as label2,
			'Total de Imagens no Site' as rodape2
		from [REPORT_IMAGEM](null, null, null)
	),
	contacts as (
		select
			count(id) as total3,--count(id) as total2,
			'Contactos pelo site' as label3,
			'Total de contactos pelo Site' as rodape3
		from REPORT_SITE_CONTACTS(null, null, null, null, null, null)
	)

	SELECT 
		label1,
		total1,
		rodape1,

		label2,
		total2,
		rodape2,

		label3,
		total3,
		rodape3
	from users
	inner join img on 1=1
	inner join contacts on 1=1
)
GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[REPORT_DASHBOARD_TABLE_DATA]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
	DROP FUNCTION [REPORT_DASHBOARD_TABLE_DATA]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[REPORT_DASHBOARD_TABLE_DATA]()
returns table as return
(
	with suc as (
		select
			count(id) as nr,
			YEAR(ctrldata) as ano,
			MONTH(ctrldata) as mes,
			sucesso,
			DATENAME(MONTH, MONTH(ctrldata)) as mes_nome
		from REPORT_SITE_CONTACTS(null, null, null, null, null, null)
		where sucesso = 1
		group by year(ctrldata), MONTH(ctrldata), sucesso
	),
	not_suc as (
		select
			count(id) as nr,
			YEAR(ctrldata) as ano,
			MONTH(ctrldata) as mes,
			sucesso,
			DATENAME(MONTH, MONTH(ctrldata)) as mes_nome
		from REPORT_SITE_CONTACTS(null, null, null, null, null, null)
		where sucesso = 0
		group by year(ctrldata), MONTH(ctrldata), sucesso
	),
	t1 as (
		select
			s.ano,
			s.mes,
			s.nr as success,
			isnull(ns.nr, 0) as not_success,
			s.mes_nome
		from suc s
		left join not_suc ns on ns.ano = s.ano and ns.mes = s.mes
	),
	t2 as (
		select
			ns.ano,
			ns.mes,
			ns.nr as not_success,
			isnull(s.nr, 0) as success,
			ns.mes_nome
		from not_suc ns
		left join suc s on s.ano = ns.ano and s.mes = ns.mes
	)

	select
		ano, mes, success, not_success, mes_nome
	from t1
	union
	select
		ano, mes, success, not_success, mes_nome
	from t2
)
GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[REPORT_GRAPHIC_DATA]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
	DROP FUNCTION [REPORT_GRAPHIC_DATA]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[REPORT_GRAPHIC_DATA]()
returns table as return
(
	select
		count(id) as nr,
		YEAR(ctrldata) as ano,
		MONTH(ctrldata) as mes,
		sucesso,
		DATENAME(MONTH, MONTH(ctrldata)) as mes_nome
	from REPORT_SITE_CONTACTS(null, null, null, null, null, null)
	group by year(ctrldata), MONTH(ctrldata), sucesso
)
GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[REPORT_LOGS]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
	DROP FUNCTION [REPORT_LOGS]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[REPORT_LOGS](@id int, @tipo varchar(200), @id_relacionado int, @initialDate date, @finalDate date, @idUser int)
returns table as return
(
	with lgn as (
		select
			lg.LOGID as id,
			users.id as id_user,
			users.nome as name_user,
			users.codigo as code_user,
			lg.tipo as tipo,
			lg.notas as notas,
			lg.id_relacionado as id_relacionado,
			lg.ctrldata as data_log,
			CONCAT(convert(varchar, lg.ctrldata, 105), ' ', convert(varchar, lg.ctrldata, 108)) as data_log_it, --dd-mm-yyyy
			CONCAT(convert(varchar, lg.ctrldata, 103), ' ', convert(varchar, lg.ctrldata, 108)) as data_log_uk, --dd/mm/yyyy
			CONCAT(convert(varchar, lg.ctrldata, 111), ' ', convert(varchar, lg.ctrldata, 108)) as data_log_jp, --yyyy/mm/dd
			convert(varchar, lg.ctrldata, 120) as data_log_odbc --yyyy-mm-dd
		from [LOG] lg
		inner join REPORT_USERS(null, null, null, null, null) users on users.id = lg.id_user
		left join ACESSOS ac on ac.ACESSOSID = lg.id_relacionado
		where lg.tipo = 'LOGIN'
	),
	sess as (
		select
			lg.LOGID as id,
			users.id as id_user,
			users.nome as name_user,
			users.codigo as code_user,
			lg.tipo as tipo,
			lg.notas as notas,
			lg.id_relacionado as id_relacionado,
			lg.ctrldata as data_log,
			CONCAT(convert(varchar, lg.ctrldata, 105), ' ', convert(varchar, lg.ctrldata, 108)) as data_log_it, --dd-mm-yyyy
			CONCAT(convert(varchar, lg.ctrldata, 103), ' ', convert(varchar, lg.ctrldata, 108)) as data_log_uk, --dd/mm/yyyy
			CONCAT(convert(varchar, lg.ctrldata, 111), ' ', convert(varchar, lg.ctrldata, 108)) as data_log_jp, --yyyy/mm/dd
			convert(varchar, lg.ctrldata, 120) as data_log_odbc --yyyy-mm-dd
		from [LOG] lg
		inner join REPORT_USERS(null, null, null, null, null) users on users.id = lg.id_user
		where lg.tipo = 'SESSÃO'
	),
	users as (
		select
			lg.LOGID as id,
			users.id as id_user,
			users.nome as name_user,
			users.codigo as code_user,
			lg.tipo as tipo,
			lg.notas as notas,
			lg.id_relacionado as id_relacionado,
			lg.ctrldata as data_log,
			CONCAT(convert(varchar, lg.ctrldata, 105), ' ', convert(varchar, lg.ctrldata, 108)) as data_log_it, --dd-mm-yyyy
			CONCAT(convert(varchar, lg.ctrldata, 103), ' ', convert(varchar, lg.ctrldata, 108)) as data_log_uk, --dd/mm/yyyy
			CONCAT(convert(varchar, lg.ctrldata, 111), ' ', convert(varchar, lg.ctrldata, 108)) as data_log_jp, --yyyy/mm/dd
			convert(varchar, lg.ctrldata, 120) as data_log_odbc --yyyy-mm-dd
		from [LOG] lg
		inner join REPORT_USERS(null, null, null, null, null) users on users.id = lg.id_user
		left join REPORT_USERS(null, null, null, null, null) u on u.id = lg.id_relacionado
		where lg.tipo = 'UTILIZADORES'
	),
	contactos as (
		select
			lg.LOGID as id,
			users.id as id_user,
			users.nome as name_user,
			users.codigo as code_user,
			lg.tipo as tipo,
			lg.notas as notas,
			lg.id_relacionado as id_relacionado,
			lg.ctrldata as data_log,
			CONCAT(convert(varchar, lg.ctrldata, 105), ' ', convert(varchar, lg.ctrldata, 108)) as data_log_it, --dd-mm-yyyy
			CONCAT(convert(varchar, lg.ctrldata, 103), ' ', convert(varchar, lg.ctrldata, 108)) as data_log_uk, --dd/mm/yyyy
			CONCAT(convert(varchar, lg.ctrldata, 111), ' ', convert(varchar, lg.ctrldata, 108)) as data_log_jp, --yyyy/mm/dd
			convert(varchar, lg.ctrldata, 120) as data_log_odbc --yyyy-mm-dd
		from [LOG] lg
		inner join REPORT_USERS(null, null, null, null, null) users on users.id = lg.id_user
		left join REPORT_CONTACTOS() cont on cont.id = lg.id_relacionado
		where lg.tipo = 'CONTACTOS'
	),
	textos as (
		select
			lg.LOGID as id,
			users.id as id_user,
			users.nome as name_user,
			users.codigo as code_user,
			lg.tipo as tipo,
			lg.notas as notas,
			lg.id_relacionado as id_relacionado,
			lg.ctrldata as data_log,
			CONCAT(convert(varchar, lg.ctrldata, 105), ' ', convert(varchar, lg.ctrldata, 108)) as data_log_it, --dd-mm-yyyy
			CONCAT(convert(varchar, lg.ctrldata, 103), ' ', convert(varchar, lg.ctrldata, 108)) as data_log_uk, --dd/mm/yyyy
			CONCAT(convert(varchar, lg.ctrldata, 111), ' ', convert(varchar, lg.ctrldata, 108)) as data_log_jp, --yyyy/mm/dd
			convert(varchar, lg.ctrldata, 120) as data_log_odbc --yyyy-mm-dd
		from [LOG] lg
		inner join REPORT_USERS(null, null, null, null, null) users on users.id = lg.id_user
		left join REPORT_TEXTOS(null, null) txt on txt.id = lg.id_relacionado
		where lg.tipo = 'TEXTOS'
	),
	others as (
		select
			lg.LOGID as id,
			users.id as id_user,
			users.nome as name_user,
			users.codigo as code_user,
			lg.tipo as tipo,
			lg.notas as notas,
			lg.id_relacionado as id_relacionado,
			lg.ctrldata as data_log,
			CONCAT(convert(varchar, lg.ctrldata, 105), ' ', convert(varchar, lg.ctrldata, 108)) as data_log_it, --dd-mm-yyyy
			CONCAT(convert(varchar, lg.ctrldata, 103), ' ', convert(varchar, lg.ctrldata, 108)) as data_log_uk, --dd/mm/yyyy
			CONCAT(convert(varchar, lg.ctrldata, 111), ' ', convert(varchar, lg.ctrldata, 108)) as data_log_jp, --yyyy/mm/dd
			convert(varchar, lg.ctrldata, 120) as data_log_odbc --yyyy-mm-dd
		from [LOG] lg
		inner join REPORT_USERS(null, null, null, null, null) users on users.id = lg.id_user
		where lg.tipo not in ('TEXTOS', 'CONTACTOS', 'UTILIZADORES', 'SESSÃO', 'LOGIN')
	),
	
	all_logs as (
		select
			id,
			id_user,
			name_user,
			code_user,
			tipo,
			notas,
			id_relacionado,
			data_log,
			data_log_it, --dd-mm-yyyy
			data_log_uk, --dd/mm/yyyy
			data_log_jp, --yyyy/mm/dd
			data_log_odbc --yyyy-mm-dd
		from lgn
		union
		select
			id,
			id_user,
			name_user,
			code_user,
			tipo,
			notas,
			id_relacionado,
			data_log,
			data_log_it, --dd-mm-yyyy
			data_log_uk, --dd/mm/yyyy
			data_log_jp, --yyyy/mm/dd
			data_log_odbc --yyyy-mm-dd
		from sess
		union
		select
			id,
			id_user,
			name_user,
			code_user,
			tipo,
			notas,
			id_relacionado,
			data_log,
			data_log_it, --dd-mm-yyyy
			data_log_uk, --dd/mm/yyyy
			data_log_jp, --yyyy/mm/dd
			data_log_odbc --yyyy-mm-dd
		from users
		union
		select
			id,
			id_user,
			name_user,
			code_user,
			tipo,
			notas,
			id_relacionado,
			data_log,
			data_log_it, --dd-mm-yyyy
			data_log_uk, --dd/mm/yyyy
			data_log_jp, --yyyy/mm/dd
			data_log_odbc --yyyy-mm-dd
		from contactos
		union
		select
			id,
			id_user,
			name_user,
			code_user,
			tipo,
			notas,
			id_relacionado,
			data_log,
			data_log_it, --dd-mm-yyyy
			data_log_uk, --dd/mm/yyyy
			data_log_jp, --yyyy/mm/dd
			data_log_odbc --yyyy-mm-dd
		from textos
		union
		select
			id,
			id_user,
			name_user,
			code_user,
			tipo,
			notas,
			id_relacionado,
			data_log,
			data_log_it, --dd-mm-yyyy
			data_log_uk, --dd/mm/yyyy
			data_log_jp, --yyyy/mm/dd
			data_log_odbc --yyyy-mm-dd
		from others
	)

	select
		id,
		id_user,
		name_user,
		code_user,
		tipo,
		notas,
		id_relacionado,
		data_log,
		data_log_it, --dd-mm-yyyy
		data_log_uk, --dd/mm/yyyy
		data_log_jp, --yyyy/mm/dd
		data_log_odbc --yyyy-mm-dd
	from all_logs
	where (@id is null or @id = id)
	and (@tipo is null or @tipo = tipo)
	and (@id_relacionado is null or @id_relacionado = id_relacionado)
	and (@initialDate is null or @initialDate <= cast(data_log as date))
	and (@finalDate is null or @finalDate >= cast(data_log as date))
	and (@idUser is null or @idUser = id_user)
)
GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[REGISTA_LOG]') AND type IN (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[REGISTA_LOG]
END

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[REGISTA_LOG](
	@idUser int,
	@id INT,
	@tipo varchar(200),
	@texto varchar(max),
	@ret int OUTPUT,
    @retMsg VARCHAR(max) OUTPUT
)
AS BEGIN
	DECLARE @codOp varchar(500);

	select @codOp = codigo from REPORT_USERS(@idUser, null, null, 1, null)

	INSERT INTO [LOG](id_user, id_relacionado, tipo, notas, ctrlcodop)
	VALUES(@idUser, @id, @tipo, @texto, @codOp)

	set @ret = SCOPE_IDENTITY();
	set @retMsg = 'Log registado com sucesso!';

	return;
END
GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CRIA_EDITA_CONTACTOS]') AND type IN (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[CRIA_EDITA_CONTACTOS]
END

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CRIA_EDITA_CONTACTOS](
	@idUser int,
	@id INT,
	@nome varchar(500),
	@morada1 varchar(500),
	@morada2 varchar(500),
	@codpostal varchar(500),
	@localidade varchar(500),
	@telefone varchar(20),
	@email varchar(500),
	@ret int OUTPUT,
    @retMsg VARCHAR(max) OUTPUT
)
AS BEGIN
	DECLARE @codOp varchar(500);
	DECLARE @admin bit;
	DECLARE @tipoLog varchar(200) = 'CONTACTOS';
	DECLARE @log varchar(max);
	DECLARE @retLog int;
	DECLARE @retMsgLog varchar(max);

	select @codOp = codigo, @admin = administrador from REPORT_USERS(@idUser, null, null, 1, null)

	if(isnull(@admin, 0) = 0)
	begin
		set @ret = -1;
		set @retMsg = 'Utilizador não tem permissões suficientes para efetuar a operação!';
		return
	end
	else
	begin
		if(isnull(@id, 0) <= 0)
		begin
			insert into contactos(nome, morada1, morada2, cod_postal, localidade, email, telefone, ctrldata, ctrlcodop)
			values(@nome, @morada1, @morada2, @codpostal, @localidade, @email, @telefone, getdate(), @codOp)

			set @ret = SCOPE_IDENTITY();
			set @retMsg = 'Contactos inseridos com sucesso!';

			set @log = CONCAT('O utilizador ', @codOp, ' inseriu os dados de contacto')
		end
		else
		begin
			update contactos
				set nome = @nome,
				morada1 = @morada1,
				morada2 = @morada2,
				cod_postal = @codpostal,
				localidade = @localidade,
				email = @email,
				telefone = @telefone,
				ctrldataupdt = getdate(),
				ctrlcodopupdt = @codOp
			where contactosid = @id

			set @ret = @id;
			set @retMsg = 'Contactos atualizados atualizado com sucesso!';

			set @log = CONCAT('O utilizador ', @codOp, ' atualizou os dados de contacto')
		end
	end

	EXEC REGISTA_LOG @idUser, @ret, @tipoLog, @log, @retLog output, @retMsgLog output;

	return;
END
GO




IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CRIA_EDITA_TEXTOS]') AND type IN (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[CRIA_EDITA_TEXTOS]
END

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CRIA_EDITA_TEXTOS](
	@idUser int,
	@id INT,
	@codigo varchar(100),
	@nome varchar(500),
	@nome_en varchar(500),
	@nome_fr varchar(500),
	@nome_es varchar(500),
	@texto varchar(max),
	@texto_en varchar(max),
	@texto_fr varchar(max),
	@texto_es varchar(max),
	@ordem int,
	@id_imagem int,
	@ret int OUTPUT,
    @retMsg VARCHAR(max) OUTPUT
)
AS BEGIN
	DECLARE @codOp varchar(500);
	DECLARE @admin bit;
	DECLARE @tipoLog varchar(200) = 'TEXTOS';
	DECLARE @log varchar(max);
	DECLARE @retLog int;
	DECLARE @retMsgLog varchar(max);

	select @codOp = codigo, @admin = administrador from REPORT_USERS(@idUser, null, null, 1, null)

	if(isnull(@admin, 0) = 0)
	begin
		set @ret = -1;
		set @retMsg = 'Utilizador não tem permissões suficientes para efetuar a operação!';
		return
	end
	else
	begin
		select top 1 @id = id from [REPORT_TEXTOS](@id, @codigo)

		if(isnull(@id_imagem, 0) <= 0)
		begin
			set @id_imagem = null;
		end
		else
		begin
			if(select count(id) from REPORT_IMAGEM(@id_imagem, null, null)) <= 0
			begin
				set @ret = -2;
				set @retMsg = 'Imagem não encontrada!';
				return;
			end
			else
			begin
				set @id_imagem = @id_imagem
			end
		end

		if(isnull(@id, 0) <= 0)
		begin
			insert into TEXTOS(codigo, nome, nome_en, nome_fr, nome_es, texto, texto_en, texto_fr, texto_es, ordem, id_imagem, ctrldataupdt, ctrlcodopupdt)
			values(@codigo, @nome, @nome_en, @nome_fr, @nome_es, @texto, @texto_en, @texto_fr, @texto_es, @ordem, @id_imagem, getdate(), @codOp)

			set @ret = SCOPE_IDENTITY();
			set @retMsg = CONCAT('Texto ', @codigo, ' inserido com sucesso!');

			set @log = CONCAT('O utilizador ', @codOp, ' inseriu os dados do texto ', @codigo)

			EXEC REGISTA_LOG @idUser, @ret, @tipoLog, @log, @retLog output, @retMsgLog output;
			return;
		end
		else
		begin
			update TEXTOS
				set codigo = @codigo,
				nome = @nome,
				nome_en = @nome_en,
				nome_fr = @nome_fr,
				nome_es = @nome_es,
				texto = @texto,
				texto_en = @texto_en,
				texto_fr = @texto_fr,
				texto_es = @texto_es,
				ordem = @ordem,
				id_imagem = @id_imagem,
				ctrldataupdt = getdate(),
				ctrlcodopupdt = @codOp
			where TEXTOSID = @id

			set @ret = @id;
			set @retMsg = CONCAT('Texto ', @codigo, ' atualizado com sucesso!');

			set @log = CONCAT('O utilizador ', @codOp, ' atualizou os dados do texto ', @codigo)

			EXEC REGISTA_LOG @idUser, @ret, @tipoLog, @log, @retLog output, @retMsgLog output;
			return;
		end
	end

	
	set @ret = -3;
	set @retMsg = 'Texto não encontrado!';
	return;
END
GO




IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CRIA_EDITA_UTILIZADOR]') AND type IN (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[CRIA_EDITA_UTILIZADOR]
END

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CRIA_EDITA_UTILIZADOR](
	@idUser int,
	@id INT,
	@nome varchar(max),
	@codigo varchar(500),
	@email varchar(max),
	@telemovel varchar(50),
	@ativo bit,
	@password varchar(250),
	@notas varchar(max),
	@id_tipo int,
	@ret int OUTPUT,
    @retMsg VARCHAR(max) OUTPUT
)
AS BEGIN
	DECLARE @codOp varchar(500);
	DECLARE @admin bit;
	DECLARE @tipoLog varchar(200) = 'UTILIZADORES';
	DECLARE @log varchar(max);
	DECLARE @retLog int;
	DECLARE @retMsgLog varchar(max);
	DECLARE @matricula varchar(20);

	select @codOp = codigo, @admin = administrador from REPORT_USERS(@idUser, null, null, 1, null)

	if(isnull(@admin, 0) = 0 and isnull(@idUser, 0) <> isnull(@id, 0))
	begin
		set @ret = -1;
		set @retMsg = 'Utilizador não tem permissões suficientes para efetuar a operação!';
		return
	end
	else
	begin
		if(isnull(@id, 0) <= 0)
		begin
			insert into users(nome, codigo, email, telemovel, ativo, [password], notas, id_tipo_utilizador, ctrldata, ctrlcodop)
			values(@nome, @codigo, @email, @telemovel, @ativo, @password, @notas, @id_tipo, getdate(), @codOp)

			set @ret = SCOPE_IDENTITY();
			set @retMsg = 'Utilizador ' + @codigo + ' inserido com sucesso!';

			set @log = CONCAT('O utilizador ', @codOp, ' inseriu os dados do utilizador ', @codigo)
		end
		else
		begin
			update users
				set nome = @nome,
				codigo = @codigo,
				email = @email,
				telemovel = @telemovel,
				ativo = @ativo,
				[password] = @password,
				notas = @notas,
				id_tipo_utilizador = @id_tipo,
				ctrldataupdt = getdate(),
				ctrlcodopupdt = @codOp
			where usersid = @id

			set @ret = @id;
			set @retMsg = 'Utilizador ' + @codigo + ' atualizado com sucesso!';

			set @log = CONCAT('O utilizador ', @codOp, ' atualizou os dados do utilizador ', @codigo)
		end
	end

	EXEC REGISTA_LOG @idUser, @ret, @tipoLog, @log, @retLog output, @retMsgLog output;

	return;
END
GO




IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DELETE_TEXTO]') AND type IN (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[DELETE_TEXTO]
END

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DELETE_TEXTO](
	@idUser int,
	@id int,
	@ret int OUTPUT,
	@retMsg varchar(max) output
)
AS BEGIN
	DECLARE @tipoLog varchar(200) = 'TEXTOS';
	DECLARE @log varchar(max);
	DECLARE @codOp varchar(500);
	DECLARE @retLog int;
	DECLARE @retMsgLog varchar(max);
	DECLARE @admin bit;
	DECLARE @codigo varchar(100);
	
	select @admin = administrador, @codOp = codigo from REPORT_USERS(@idUser, null, null, 1, null)

	IF(ISNULL(@admin, 0) = 0)
	begin
		set @ret = -1;
		set @retMsg = 'O utilizador não tem permissões para apagar textos!';
		return
	end

	select @codigo = codigo from report_textos(@id, @codigo)

	delete from TEXTOS where TEXTOSID = @id;

	set @ret = @id;
	set @retMsg = 'Texto eliminado com sucesso!';

	set @log = CONCAT('O utilizador ', @codOp, ' removeu o texto ', @codigo)

	EXEC REGISTA_LOG @idUser, @id, @tipoLog, @log, @retLog output, @retMsgLog output;
END;
GO



IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DELETE_USER]') AND type IN (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[DELETE_USER]
END

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DELETE_USER](
	@idUser int,
	@id int,
	@ret int OUTPUT,
	@retMsg varchar(max) output
)
AS BEGIN
	DECLARE @tipoLog varchar(200) = 'UTILIZADORES';
	DECLARE @log varchar(max);
	DECLARE @codOp varchar(500);
	DECLARE @retLog int;
	DECLARE @retMsgLog varchar(max);
	DECLARE @admin bit;
	DECLARE @codUser varchar(max);
	
	select @admin = administrador, @codOp = codigo from REPORT_USERS(@idUser, null, null, 1, null)

	IF(ISNULL(@admin, 0) = 0)
	begin
		set @ret = -1;
		set @retMsg = 'O utilizador não tem permissões para apagar utilizadores!';
		return
	end

	IF(@id = @idUser)
	begin
		set @ret = -2;
		set @retMsg = 'O utilizador não se pode eliminar a ele próprio visto estar a usar o sistema! Por favor, contacte outro administrador!';
		return
	end

	select @codUser = codigo from REPORT_USERS(@id, null, null, null, null)

	delete from acessos where id_utilizador = @id;
	delete from USERS where USERSID = @id;

	set @ret = @id;
	set @retMsg = 'Utilizador eliminado com sucesso!';

	set @log = CONCAT('O utilizador ', @codOp, ' removeu o utilizador ', @codUser, ' e consequentemente todos os seus acessos')

	EXEC REGISTA_LOG @idUser, @id, @tipoLog, @log, @retLog output, @retMsgLog output;
END;
GO




IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[login]') AND type IN (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[login]
END

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[login](
	@user varchar(150),
	@pass varchar(60),
    @ret int OUTPUT,
    @retMsg VARCHAR(max) OUTPUT
)
AS BEGIN
	declare @id int;
	declare @ativo bit;
	declare @id_tipo int;
	declare @dataatual datetime;
	DECLARE @tipoLog varchar(200) = 'LOGIN';
	DECLARE @log varchar(max);
	DECLARE @codOp varchar(500);
	DECLARE @retLog int;
	DECLARE @retMsgLog varchar(max);
	DECLARE @idAcesso int;

	select top 1
		@id = id,
		@ativo = ativo,
		@codOp = codigo
	from REPORT_USERS(@id, @user, @pass, @ativo, @id_tipo)

	IF (@id is not null)
		BEGIN
			IF (@ativo = 1)
				begin
					set @dataatual = getdate()
					set @ret = @id;
					set @retMsg = 'Login efetuado com sucesso!'

					UPDATE USERS SET lastlogin = @dataatual WHERE USERSID = @id;
					INSERT INTO ACESSOS (id_utilizador, datahora) SELECT @id, @dataatual;

					set @idAcesso = SCOPE_IDENTITY();

					set @log = CONCAT('O utilizador ', @codOp, ' efetuou login no sistema')

					EXEC REGISTA_LOG @id, @idAcesso, @tipoLog, @log, @retLog output, @retMsgLog output;
				end
			ELSE
				begin
					set @ret = -1;
					set @retMsg = 'Utilizador Inativo!' + CHAR(13) + CHAR(10) + 'Para mais informações, por favor contacte o administrador do sistema!';
				end
		END
	ELSE 
		BEGIN
			set @ret = -2;
			set @retMsg = 'Dados de autenticação inválidos!';
		END

	RETURN;
END;
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[VALIDATE_USER_SESSION]') AND type IN (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[VALIDATE_USER_SESSION]
END

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[VALIDATE_USER_SESSION](
	@id INT,
    @ret bit OUTPUT,
	@admin bit OUTPUT,
	@name varchar(max) OUTPUT
)
AS BEGIN
	DECLARE @u varchar(150);
    DECLARE @p varchar(60);
    DECLARE @ativo bit = 1;
    DECLARE @id_tipo int;
    DECLARE @sessaomax int = (select sessaomaxmin from report_configs());
	DECLARE @tipoLog varchar(200) = 'SESSÃO';
	DECLARE @log varchar(max);
	DECLARE @codOp varchar(500);
	DECLARE @retLog int;
	DECLARE @retMsgLog varchar(max);

    SELECT 
	    @ret = CASE WHEN DATEDIFF(mi, ut.lastlogin, getdate()) > @sessaomax then 0 else 1 end,
		@admin = administrador,
		@name = nome,
		@codOp = codigo
    FROM report_users(@id, @u, @p, @ativo, @id_tipo) ut 

	if(@sessaomax = 0)
	begin
		set @log = CONCAT('O utilizador ', @codOp, ' perdeu a sessão')

		EXEC REGISTA_LOG @id, null, @tipoLog, @log, @retLog output, @retMsgLog output;
	end

	return;
END
GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[REGISTA_CONTACTO_SITE]') AND type IN (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[REGISTA_CONTACTO_SITE]
END

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[REGISTA_CONTACTO_SITE](
	@nome varchar(500),
	@email varchar(500),
	@assunto varchar(500),
	@texto varchar(max),
	@sucesso bit,
	@ret int OUTPUT,
    @retMsg VARCHAR(max) OUTPUT
)
AS BEGIN

	INSERT INTO site_contacts(nome, email, assunto, texto, sucesso)
	VALUES(@nome, @email, @assunto, @texto, @sucesso)

	set @ret = SCOPE_IDENTITY();
	set @retMsg = 'Contacto efetuado com sucesso! Responderemos com a maior brevidade possível!';

	return;
END
GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CRIA_EDITA_IMAGEM_TIPO]') AND type IN (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[CRIA_EDITA_IMAGEM_TIPO]
END

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CRIA_EDITA_IMAGEM_TIPO](
	@idUser int,
	@id INT,
	@nome varchar(500),
	@nome_en varchar(500),
	@nome_fr varchar(500),
	@nome_es varchar(500),
	@ordem int,
	@id_img_capa int,
	@ret int OUTPUT,
    @retMsg VARCHAR(max) OUTPUT
)
AS BEGIN
	DECLARE @codOp varchar(500);
	DECLARE @admin bit;
	DECLARE @tipoLog varchar(200) = 'IMAGEM TIPO';
	DECLARE @log varchar(max);
	DECLARE @retLog int;
	DECLARE @retMsgLog varchar(max);

	select @codOp = codigo, @admin = administrador from REPORT_USERS(@idUser, null, null, 1, null)

	if(isnull(@admin, 0) = 0)
	begin
		set @ret = -1;
		set @retMsg = 'Utilizador não tem permissões suficientes para efetuar a operação!';
		return
	end
	else
	begin
		select top 1 @id = id from REPORT_IMAGEM_TIPO(@id, @nome)

		if(isnull(@id, 0) <= 0)
		begin
			insert into IMAGES_TYPE(nome, nome_en, nome_fr, nome_es, ordem, id_imagem_capa, ctrldataupdt, ctrlcodopupdt)
			values(@nome, @nome_en, @nome_fr, @nome_es, @ordem, @id_img_capa, getdate(), @codOp)

			set @ret = SCOPE_IDENTITY();
			set @retMsg = CONCAT('Tipo de Imagem ', @nome, ' inserido com sucesso!');

			set @log = CONCAT('O utilizador ', @codOp, ' inseriu os dados do tipo de imagem ', @nome)
			EXEC REGISTA_LOG @idUser, @ret, @tipoLog, @log, @retLog output, @retMsgLog output;
			return;
		end
		else
		begin
			update IMAGES_TYPE
				set nome = @nome,
				nome_en = @nome_en,
				nome_fr = @nome_fr,
				nome_es = @nome_es,
				ordem = @ordem,
				id_imagem_capa = @id_img_capa,
				ctrldataupdt = getdate(),
				ctrlcodopupdt = @codOp
			where IMAGES_TYPEID = @id

			set @ret = @id;
			set @retMsg = CONCAT('Tipo de Imagem ', @nome, ' atualizado com sucesso!');

			set @log = CONCAT('O utilizador ', @codOp, ' atualizou os dados do tipo de imagem ', @nome)
			EXEC REGISTA_LOG @idUser, @ret, @tipoLog, @log, @retLog output, @retMsgLog output;
			return;
		end
	end

	set @ret = -2;
	set @retMsg = 'Tipo de Imagem não encontrado!';
	return
END
GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DELETE_IMAGEM_TIPO]') AND type IN (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[DELETE_IMAGEM_TIPO]
END

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DELETE_IMAGEM_TIPO](
	@idUser int,
	@id int,
	@ret int OUTPUT,
	@retMsg varchar(max) output
)
AS BEGIN
	DECLARE @tipoLog varchar(200) = 'IMAGEM TIPO';
	DECLARE @log varchar(max);
	DECLARE @codOp varchar(500);
	DECLARE @retLog int;
	DECLARE @retMsgLog varchar(max);
	DECLARE @admin bit;
	DECLARE @tipo varchar(500);
	
	select @admin = administrador, @codOp = codigo from REPORT_USERS(@idUser, null, null, 1, null)

	IF(ISNULL(@admin, 0) = 0)
	begin
		set @ret = -1;
		set @retMsg = 'O utilizador não tem permissões para apagar tipos de imagem!';
		return
	end

	select @tipo = nome from REPORT_IMAGEM_TIPO(@id, null)

	delete from [IMAGE] where id_tipo = @id
	delete from IMAGES_TYPE where IMAGES_TYPEID = @id

	set @ret = @id;
	set @retMsg = 'Tipo de Imagem eliminado com sucesso!';

	set @log = CONCAT('O utilizador ', @codOp, ' removeu o tipo de imagem ', @tipo, ' e todas as imagens associadas!')

	EXEC REGISTA_LOG @idUser, @id, @tipoLog, @log, @retLog output, @retMsgLog output;
END;
GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DELETE_IMAGEM]') AND type IN (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[DELETE_IMAGEM]
END

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DELETE_IMAGEM](
	@idUser int,
	@id int,
	@ret int OUTPUT,
	@retMsg varchar(max) output
)
AS BEGIN
	DECLARE @tipoLog varchar(200) = 'IMAGEM';
	DECLARE @log varchar(max);
	DECLARE @codOp varchar(500);
	DECLARE @retLog int;
	DECLARE @retMsgLog varchar(max);
	DECLARE @admin bit;
	DECLARE @nome varchar(500);
	
	select @admin = administrador, @codOp = codigo from REPORT_USERS(@idUser, null, null, 1, null)

	IF(ISNULL(@admin, 0) = 0)
	begin
		set @ret = -1;
		set @retMsg = 'O utilizador não tem permissões para apagar imagens!';
		return
	end

	select @nome = nome from REPORT_IMAGEM(@id, null, null)

	delete from [IMAGE] where IMAGEID = @id

	set @ret = @id;
	set @retMsg = 'Imagem eliminada com sucesso!';

	set @log = CONCAT('O utilizador ', @codOp, ' removeu a imagem ', @nome, '!')

	EXEC REGISTA_LOG @idUser, @id, @tipoLog, @log, @retLog output, @retMsgLog output;
END;
GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CRIA_EDITA_IMAGEM]') AND type IN (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[CRIA_EDITA_IMAGEM]
END

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CRIA_EDITA_IMAGEM](
	@idUser int,
	@id INT,
	@nome varchar(500),
	@nome_en varchar(500),
	@nome_fr varchar(500),
	@nome_es varchar(500),
	@ordem int,
	@slider_inicial bit,
	@nome_tipo varchar(500),
	@nome_en_tipo varchar(500),
	@nome_fr_tipo varchar(500),
	@nome_es_tipo varchar(500),
	@ordem_tipo int,
	@extensao varchar(10),
	@imgCapa bit,
	@ret int OUTPUT,
    @retMsg VARCHAR(max) OUTPUT
)
AS BEGIN
	DECLARE @codOp varchar(500);
	DECLARE @admin bit;
	DECLARE @tipoLog varchar(200) = 'IMAGEM';
	DECLARE @log varchar(max);
	DECLARE @retLog int;
	DECLARE @retMsgLog varchar(max);
	DECLARE @id_tipo int = (select id from REPORT_IMAGEM_TIPO(null, @nome_tipo))
	DECLARE @id_img_capa int;

	select @codOp = codigo, @admin = administrador from REPORT_USERS(@idUser, null, null, 1, null)

	if(isnull(@admin, 0) = 0)
	begin
		set @ret = -1;
		set @retMsg = 'Utilizador não tem permissões suficientes para efetuar a operação!';
		return
	end
	else
	begin
		if(isnull(@id_tipo, 0) = 0)
		begin
			set @id_tipo = 0;
			EXEC CRIA_EDITA_IMAGEM_TIPO @idUser, @id_tipo, @nome_tipo, @nome_en_tipo, @nome_fr_tipo, @nome_es_tipo, @ordem_tipo, null, @ret OUTPUT, @retMsg OUTPUT;
		end
		else
		begin
			EXEC CRIA_EDITA_IMAGEM_TIPO @idUser, @id_tipo, @nome_tipo, @nome_en_tipo, @nome_fr_tipo, @nome_es_tipo, @ordem_tipo, null, @ret OUTPUT, @retMsg OUTPUT;
		end		

		if(@ret <= 0)
		begin
			return
		end
		else
		begin
			set @id_tipo = @ret;
			select top 1 @id = id from [REPORT_IMAGEM](@id, @nome, null)

			if(isnull(@id, 0) <= 0)
			begin
				insert into [IMAGE](nome, nome_en, nome_fr, nome_es, ordem, slider_inicial, id_tipo, EXTENSAO, ctrldataupdt, ctrlcodopupdt)
				values(@nome, @nome_en, @nome_fr, @nome_es, @ordem, @slider_inicial, @id_tipo, @extensao, getdate(), @codOp)

				set @ret = SCOPE_IDENTITY();
				set @retMsg = CONCAT('Imagem ', @nome, ' inserida com sucesso!');

				if(@imgCapa = 1)
				begin
					UPDATE IMAGES_TYPE
					set id_imagem_capa = @ret
					where IMAGES_TYPEID = @id_tipo
				end
				else
				begin
					select @id_img_capa = id_imagem_capa from REPORT_IMAGEM_TIPO(@id_tipo, null)

					if(@id_img_capa = @ret)
					begin
						UPDATE IMAGES_TYPE
						set id_imagem_capa = null
						where IMAGES_TYPEID = @id_tipo
					end
				end

				set @log = CONCAT('O utilizador ', @codOp, ' inseriu os dados da imagem ', @nome)
				EXEC REGISTA_LOG @idUser, @ret, @tipoLog, @log, @retLog output, @retMsgLog output;
				return;
			end
			else
			begin
				if(isnull(@extensao, '') = '')
				begin
					select @extensao = EXTENSAO from [image] where imageid = @id
				end
				else
				begin
					set @extensao = @extensao
				end

				update [IMAGE]
					set nome = @nome,
					nome_en = @nome_en,
					nome_fr = @nome_fr,
					nome_es = @nome_es,
					ordem = @ordem,
					slider_inicial = @slider_inicial,
					id_tipo = @id_tipo,
					EXTENSAO = @extensao,
					ctrldataupdt = getdate(),
					ctrlcodopupdt = @codOp
				where IMAGEID = @id

				set @ret = @id;
				set @retMsg = CONCAT('Imagem ', @nome, ' atualizada com sucesso!');

				if(@imgCapa = 1)
				begin
					UPDATE IMAGES_TYPE
					set id_imagem_capa = @ret
					where IMAGES_TYPEID = @id_tipo
				end
				else
				begin
					select @id_img_capa = id_imagem_capa from REPORT_IMAGEM_TIPO(@id_tipo, null)

					if(@id_img_capa = @ret)
					begin
						UPDATE IMAGES_TYPE
						set id_imagem_capa = null
						where IMAGES_TYPEID = @id_tipo
					end
				end

				set @log = CONCAT('O utilizador ', @codOp, ' atualizou os dados da imagem ', @nome)
				EXEC REGISTA_LOG @idUser, @ret, @tipoLog, @log, @retLog output, @retMsgLog output;
				return;
			end
		end
	end

	set @ret = -2;
	set @retMsg = 'Imagem não encontrada!';
	return
END
GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UPDATE_SLIDER_INICIAL]') AND type IN (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[UPDATE_SLIDER_INICIAL]
END

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UPDATE_SLIDER_INICIAL](
	@idUser int,
	@id INT,
	@slider_inicial bit,
	@ret int OUTPUT,
    @retMsg VARCHAR(max) OUTPUT
)
AS BEGIN
	DECLARE @codOp varchar(500);
	DECLARE @admin bit;
	DECLARE @tipoLog varchar(200) = 'IMAGEM';
	DECLARE @log varchar(max);
	DECLARE @retLog int;
	DECLARE @retMsgLog varchar(max);
	DECLARE @nome varchar(500);

	select @codOp = codigo, @admin = administrador from REPORT_USERS(@idUser, null, null, 1, null)

	if(isnull(@admin, 0) = 0)
	begin
		set @ret = -1;
		set @retMsg = 'Utilizador não tem permissões suficientes para efetuar a operação!';
		return
	end
	else
	begin
		select top 1 @nome = nome from REPORT_IMAGEM_TIPO(@id, null)

		if(isnull(@nome, '') = '')
		begin
			set @ret = -2;
			set @retMsg = 'Imagem não encontrada!';
			return
		end
		else
		begin
			update [IMAGE]
				set slider_inicial = @slider_inicial,
				ctrldataupdt = getdate(),
				ctrlcodopupdt = @codOp
			where IMAGEID = @id

			set @ret = @id;

			if(@slider_inicial = 1)
			begin
				set @retMsg = CONCAT('Imagem ', @nome, ' colocada no slider inicial!');
				set @log = CONCAT('O utilizador ', @codOp, ' colocou a imagem ', @nome, ' no slider inicial!')
			end
			else
			begin
				set @retMsg = CONCAT('Imagem ', @nome, ' retirada do slider inicial!');
				set @log = CONCAT('O utilizador ', @codOp, ' retirou a imagem ', @nome, ' do slider inicial!')
			end
			
			EXEC REGISTA_LOG @idUser, @ret, @tipoLog, @log, @retLog output, @retMsgLog output;
			return;
		end
	end
END
GO


insert into APPLICATION_CONFIG(email, email_password, email_smtp, email_smtpport, emails_alerta, sessaomaxmin, [url])
values('no-reply@casadosbispos.pt', 'casadosbispos2023', 'mail.casadosbispos.pt', '465', 'geral@casadosbispos.pt;gabrielalmeidawill@gmail.com;afonsopereira6@gmail.com', 600, 'https://www.casadosbispos.pt/')