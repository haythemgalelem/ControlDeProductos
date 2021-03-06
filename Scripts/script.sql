USE [ControlDeProductos]
GO
/****** Object:  StoredProcedure [dbo].[SP_ALTA_BAJA_MODIFICACION_PRODUCTOS]    Script Date: 05/06/2017 19:47:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[SP_ALTA_BAJA_MODIFICACION_PRODUCTOS]
@Codigo int,
@Nombre nchar(50)=null,
@Descripcion nchar(50)=null,
@IdProveedor int=null,
@IdRubro int=null,
@Marca nchar(50)=null,
@Precio nchar(50)=null,
@Activo bit =null,
@Consulta int 

AS

IF @Consulta = 1
begin

Insert into Productos (Nombre,Descripcion,IdProveedor,IdRubro,Marca,Precio)			
Values (@Nombre,@Descripcion,@IdProveedor,@IdRubro,@Marca,@Precio)
end

IF @Consulta = 2
begin

update Productos set Nombre = @Nombre ,Descripcion = @Descripcion
					,IdProveedor=@IdProveedor ,IdRubro = @IdRubro,
					Marca= @Marca, Precio= @Precio,Activo = @Activo
			where Codigo = @Codigo
end

IF @Consulta = 3
begin 
update Productos set Activo = 0 where Codigo = @Codigo
end 


GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAR_FAMILIAS]    Script Date: 05/06/2017 19:47:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[SP_LISTAR_FAMILIAS]
AS
SELECT IdFamilia,Nombre FROM Familias

GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAR_PRODUCTOS]    Script Date: 05/06/2017 19:47:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[SP_LISTAR_PRODUCTOS]

AS
SELECT p.Codigo,p.Descripcion,p.Marca,p.Nombre,p.Precio,p.IdProveedor,p.IdRubro,pr.Nombre Proveedor,r.Nombre Rubro FROM Productos p JOIN Proveedores pr ON p.IdProveedor=pr.IdProv JOIN Rubros r ON p.IdRubro=r.IdRubro




GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAR_PROVEEDORES]    Script Date: 05/06/2017 19:47:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[SP_LISTAR_PROVEEDORES]
AS

SELECT IdProv,Nombre FROM Proveedores


GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAR_RUBROS]    Script Date: 05/06/2017 19:47:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[SP_LISTAR_RUBROS]
@idFlia int
AS
SELECT IdRubro , Nombre FROM Rubros WHERE IdFlia = @idFlia

GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAR_RUBROS_SIN_FAMILIA]    Script Date: 05/06/2017 19:47:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create Procedure [dbo].[SP_LISTAR_RUBROS_SIN_FAMILIA]

AS
SELECT IdRubro , Nombre FROM Rubros

GO
/****** Object:  StoredProcedure [dbo].[SP_MOSTRAR_CODIGO_PRODUCTO]    Script Date: 05/06/2017 19:47:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[SP_MOSTRAR_CODIGO_PRODUCTO]

as 
begin
Select MAX(Codigo) FROM Productos
end


GO
/****** Object:  StoredProcedure [dbo].[SP_PRODUCTOS_CONSULTAR_TODOS]    Script Date: 05/06/2017 19:47:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[SP_PRODUCTOS_CONSULTAR_TODOS]
	@RUBRO int=null, 
	@PROVEEDOR int=null, 
	@FAMILIA int=null, 
	@FILTRO varchar(150) =null,
	@ACTIVO INT = NULL
AS
	SELECT P.Codigo,p.Nombre,p.Descripcion,p.Marca,p.Precio,pr.Nombre as Proveedor,r.Nombre as Rubro,f.Nombre as Familia,p.IdProveedor,p.IdRubro,f.IdFamilia,p.Activo

	FROM Productos P inner JOIN Rubros R ON (p.IdRubro=r.IdRubro)
	inner join Familias F on ( F.IdFamilia = R.IdFlia)
	inner join Proveedores PR on ( PR.IdProv = P.IdProveedor)

	WHERE R.IdRubro =ISNULL(@RUBRO, R.IdRubro) 
	and PR.IdProv = ISNULL(@PROVEEDOR,PR.IdProv)
	and f.IdFamilia = ISNULL (@FAMILIA,f.IdFamilia)
	and (( P.Codigo like  '%' + ISNULL(@FILTRO, P.Codigo) + '%')
			or ( P.Nombre like  '%' + ISNULL(@FILTRO, P.Nombre) + '%')
			or ( P.Descripcion like  '%' + ISNULL(@FILTRO, P.Descripcion) + '%')
			or ( P.Marca like  '%' + ISNULL(@FILTRO, P.Marca) + '%')
			or ( P.Precio like  '%' + ISNULL(@FILTRO, P.Precio) + '%')
			or ( F.Descripcion like  '%' + ISNULL(@FILTRO, F.Descripcion) + '%')	
			or ( R.Descripcion like  '%' + ISNULL(@FILTRO, R.Descripcion) + '%')	
			or ( PR.Nombre like  '%' + ISNULL(@FILTRO, PR.Nombre) + '%')		)
	and P.Activo = ISNULL(@ACTIVO,P.Activo)

GO
/****** Object:  StoredProcedure [dbo].[SP_VERIFICAR_USUARIO]    Script Date: 05/06/2017 19:47:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[SP_VERIFICAR_USUARIO]
@Usuario varchar(50) = null,
@Clave varchar(50) = null

AS  

   SELECT IdUsuario
   FROM Usuarios WHERE @Usuario = Usuario and @Clave = Clave


GO
/****** Object:  Table [dbo].[Familias]    Script Date: 05/06/2017 19:47:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Familias](
	[IdFamilia] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Descripcion] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Familias_1] PRIMARY KEY CLUSTERED 
(
	[IdFamilia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Productos]    Script Date: 05/06/2017 19:47:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Productos](
	[Codigo] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nchar](50) NOT NULL,
	[Descripcion] [nchar](50) NOT NULL,
	[IdProveedor] [int] NOT NULL,
	[IdRubro] [int] NOT NULL,
	[Marca] [nchar](50) NOT NULL,
	[Precio] [float] NOT NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [PK_Productos] PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Proveedores]    Script Date: 05/06/2017 19:47:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Proveedores](
	[IdProv] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Direccion] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Proveedores_1] PRIMARY KEY CLUSTERED 
(
	[IdProv] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Rubros]    Script Date: 05/06/2017 19:47:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Rubros](
	[IdRubro] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Descripcion] [varchar](50) NOT NULL,
	[IdFlia] [int] NOT NULL,
 CONSTRAINT [PK_Rubros] PRIMARY KEY CLUSTERED 
(
	[IdRubro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 05/06/2017 19:47:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Usuarios](
	[IdUsuario] [int] IDENTITY(1,1) NOT NULL,
	[Usuario] [varchar](50) NOT NULL,
	[Clave] [varchar](50) NOT NULL,
	[Tipo_Usuario] [varchar](50) NOT NULL,
 CONSTRAINT [Id__Usuarios] PRIMARY KEY CLUSTERED 
(
	[IdUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Familias] ON 

INSERT [dbo].[Familias] ([IdFamilia], [Nombre], [Descripcion]) VALUES (1, N'Tecnologia', N'Articulos 
		   Informaticos, Computadoras')
INSERT [dbo].[Familias] ([IdFamilia], [Nombre], [Descripcion]) VALUES (2, N'Electrodomesticos', N'Articulos 
		   para electronicos para el hogar')
INSERT [dbo].[Familias] ([IdFamilia], [Nombre], [Descripcion]) VALUES (3, N'Casa y Jardin', N'Articulos 
		   para interior y exterior')
INSERT [dbo].[Familias] ([IdFamilia], [Nombre], [Descripcion]) VALUES (4, N'Salud y Belleza', N'Articulos 
		   para cuidado personal')
INSERT [dbo].[Familias] ([IdFamilia], [Nombre], [Descripcion]) VALUES (5, N'Bebes y Niños', N'Articulos 
		   exclusivos para niños y bebes')
INSERT [dbo].[Familias] ([IdFamilia], [Nombre], [Descripcion]) VALUES (6, N'Otros                                             ', N'Sin categoria                                     ')
SET IDENTITY_INSERT [dbo].[Familias] OFF
SET IDENTITY_INSERT [dbo].[Productos] ON 

INSERT [dbo].[Productos] ([Codigo], [Nombre], [Descripcion], [IdProveedor], [IdRubro], [Marca], [Precio], [Activo]) VALUES (36, N'NoteBook                                          ', N'4gb RAM, display 15''''                             ', 3, 1, N'Lenovo                                            ', 5234, 1)
INSERT [dbo].[Productos] ([Codigo], [Nombre], [Descripcion], [IdProveedor], [IdRubro], [Marca], [Precio], [Activo]) VALUES (39, N'NoteBook                                          ', N'4gb RAM, display 15''''                             ', 4, 1, N'Lenovo                                            ', 1289.99, 1)
INSERT [dbo].[Productos] ([Codigo], [Nombre], [Descripcion], [IdProveedor], [IdRubro], [Marca], [Precio], [Activo]) VALUES (40, N'NoteBook                                          ', N'4gb RAM, display 15''''                             ', 2, 1, N'LG                                                ', 1234.789, 1)
INSERT [dbo].[Productos] ([Codigo], [Nombre], [Descripcion], [IdProveedor], [IdRubro], [Marca], [Precio], [Activo]) VALUES (41, N'Camara                                            ', N'20 Megapixel, Zoom 10x                            ', 1, 3, N'Nikon                                             ', 10000, 1)
INSERT [dbo].[Productos] ([Codigo], [Nombre], [Descripcion], [IdProveedor], [IdRubro], [Marca], [Precio], [Activo]) VALUES (42, N'Camara Lux                                        ', N'20 Megapixel, Zoom 10x                            ', 2, 3, N'Cannon                                            ', 11000, 1)
INSERT [dbo].[Productos] ([Codigo], [Nombre], [Descripcion], [IdProveedor], [IdRubro], [Marca], [Precio], [Activo]) VALUES (43, N'Camara                                            ', N'20 Megapixel, Zoom 10x                            ', 5, 3, N'Coolpix                                           ', 9000.7, 1)
INSERT [dbo].[Productos] ([Codigo], [Nombre], [Descripcion], [IdProveedor], [IdRubro], [Marca], [Precio], [Activo]) VALUES (44, N'Lavarropa Grim                                    ', N'Tapa Frontal, Automatico, 6KG                     ', 3, 7, N'Drean                                             ', 12000, 1)
INSERT [dbo].[Productos] ([Codigo], [Nombre], [Descripcion], [IdProveedor], [IdRubro], [Marca], [Precio], [Activo]) VALUES (45, N'Lavarropas Trim                                   ', N'Tapa Frontal, Automatico, 6KG                     ', 6, 7, N'LG                                                ', 100000, 1)
INSERT [dbo].[Productos] ([Codigo], [Nombre], [Descripcion], [IdProveedor], [IdRubro], [Marca], [Precio], [Activo]) VALUES (46, N'Peine Flower                                      ', N'Color Azul, 24 dientes                            ', 4, 16, N'Cool                                              ', 12.5, 1)
INSERT [dbo].[Productos] ([Codigo], [Nombre], [Descripcion], [IdProveedor], [IdRubro], [Marca], [Precio], [Activo]) VALUES (47, N'Batidora Mix                                      ', N'220v , 50 watts , Dos cuchillas, Tapa de acero    ', 5, 9, N'Liliana                                           ', 123.89, 1)
SET IDENTITY_INSERT [dbo].[Productos] OFF
SET IDENTITY_INSERT [dbo].[Proveedores] ON 

INSERT [dbo].[Proveedores] ([IdProv], [Nombre], [Direccion]) VALUES (1, N'Perez S.R.L.', N'Av Mayo 12')
INSERT [dbo].[Proveedores] ([IdProv], [Nombre], [Direccion]) VALUES (2, N'Gomez S.A.', N'Escobar 33')
INSERT [dbo].[Proveedores] ([IdProv], [Nombre], [Direccion]) VALUES (3, N'Ardiles e Hijos S.A.', N'Alem 2090')
INSERT [dbo].[Proveedores] ([IdProv], [Nombre], [Direccion]) VALUES (4, N'Medina y Hnos. S.R.L.', N'Cordoba 234')
INSERT [dbo].[Proveedores] ([IdProv], [Nombre], [Direccion]) VALUES (5, N'Cordova S.A.', N'Las Heras 678')
INSERT [dbo].[Proveedores] ([IdProv], [Nombre], [Direccion]) VALUES (6, N'Scortegagna e Hijos S.A.', N'Costa 546')
INSERT [dbo].[Proveedores] ([IdProv], [Nombre], [Direccion]) VALUES (7, N'Cruz S.R.L', N'Av. Brasil 123')
SET IDENTITY_INSERT [dbo].[Proveedores] OFF
SET IDENTITY_INSERT [dbo].[Rubros] ON 

INSERT [dbo].[Rubros] ([IdRubro], [Nombre], [Descripcion], [IdFlia]) VALUES (1, N'Infomatica computacion', N'Computadoras, Tablet, Pendrive', 1)
INSERT [dbo].[Rubros] ([IdRubro], [Nombre], [Descripcion], [IdFlia]) VALUES (2, N'Televisores', N'Smart TV, LEDs, Monitores', 1)
INSERT [dbo].[Rubros] ([IdRubro], [Nombre], [Descripcion], [IdFlia]) VALUES (3, N'Fotografia/Video', N'Camaras, Videograbadora, GoPro', 1)
INSERT [dbo].[Rubros] ([IdRubro], [Nombre], [Descripcion], [IdFlia]) VALUES (4, N'Accesorios', N'Lentes de camara, Auriculares', 1)
INSERT [dbo].[Rubros] ([IdRubro], [Nombre], [Descripcion], [IdFlia]) VALUES (5, N'Cuidado Personal', N'Afeitadora, Depiladora', 1)
INSERT [dbo].[Rubros] ([IdRubro], [Nombre], [Descripcion], [IdFlia]) VALUES (6, N'Ventilacion/Calefaccion', N'Aires acoondicionados, Ventiladores, Estufas', 2)
INSERT [dbo].[Rubros] ([IdRubro], [Nombre], [Descripcion], [IdFlia]) VALUES (7, N'Hogar/Limpieza', N'Aspiradoras, Enceradora', 2)
INSERT [dbo].[Rubros] ([IdRubro], [Nombre], [Descripcion], [IdFlia]) VALUES (8, N'Heladeras/Freezer', N'Heladera, Mini Bar, Freezer', 2)
INSERT [dbo].[Rubros] ([IdRubro], [Nombre], [Descripcion], [IdFlia]) VALUES (9, N'Pequeños Electrdomesticos', N'Tostadoras, Mixer, Licuadora', 2)
INSERT [dbo].[Rubros] ([IdRubro], [Nombre], [Descripcion], [IdFlia]) VALUES (10, N'Muebles', N'Armarios, Cajoneras', 3)
INSERT [dbo].[Rubros] ([IdRubro], [Nombre], [Descripcion], [IdFlia]) VALUES (11, N'Dormitorio', N'Camas, Sabana, Acolchados', 3)
INSERT [dbo].[Rubros] ([IdRubro], [Nombre], [Descripcion], [IdFlia]) VALUES (12, N'Cocina', N'Cocinas, Anafres, Microondas', 3)
INSERT [dbo].[Rubros] ([IdRubro], [Nombre], [Descripcion], [IdFlia]) VALUES (13, N'Living/Comedor', N'Mesas Ratona, Sillones', 3)
INSERT [dbo].[Rubros] ([IdRubro], [Nombre], [Descripcion], [IdFlia]) VALUES (14, N'Baño', N'Griferias, Lavatorios', 3)
INSERT [dbo].[Rubros] ([IdRubro], [Nombre], [Descripcion], [IdFlia]) VALUES (15, N'Herramientas', N'Taladro, Moladora', 3)
INSERT [dbo].[Rubros] ([IdRubro], [Nombre], [Descripcion], [IdFlia]) VALUES (16, N'Cuidado Capilar', N'Secador de pelo, Planchitas', 4)
INSERT [dbo].[Rubros] ([IdRubro], [Nombre], [Descripcion], [IdFlia]) VALUES (17, N'Moda', N'Ropa para damas, Ropa para Cabelleros', 4)
INSERT [dbo].[Rubros] ([IdRubro], [Nombre], [Descripcion], [IdFlia]) VALUES (18, N'Cuidado y Bienestar', N'Masajeador', 4)
INSERT [dbo].[Rubros] ([IdRubro], [Nombre], [Descripcion], [IdFlia]) VALUES (19, N'Cosmeticos', N'Maquillajes', 4)
INSERT [dbo].[Rubros] ([IdRubro], [Nombre], [Descripcion], [IdFlia]) VALUES (20, N'Juguetes', N'Juegos didacticos, Juegos de estrategia', 5)
INSERT [dbo].[Rubros] ([IdRubro], [Nombre], [Descripcion], [IdFlia]) VALUES (21, N'Butacas', N'Silla para autos', 5)
INSERT [dbo].[Rubros] ([IdRubro], [Nombre], [Descripcion], [IdFlia]) VALUES (22, N'Coches', N'Paraguitas, Coches de 3 ruedas,', 5)
SET IDENTITY_INSERT [dbo].[Rubros] OFF
SET IDENTITY_INSERT [dbo].[Usuarios] ON 

INSERT [dbo].[Usuarios] ([IdUsuario], [Usuario], [Clave], [Tipo_Usuario]) VALUES (1, N'tania', N'1234', N'1')
INSERT [dbo].[Usuarios] ([IdUsuario], [Usuario], [Clave], [Tipo_Usuario]) VALUES (2, N'matias', N'1234', N'1')
INSERT [dbo].[Usuarios] ([IdUsuario], [Usuario], [Clave], [Tipo_Usuario]) VALUES (3, N'gaby', N'12345', N'1')
INSERT [dbo].[Usuarios] ([IdUsuario], [Usuario], [Clave], [Tipo_Usuario]) VALUES (4, N'gabz', N'123', N'1')
INSERT [dbo].[Usuarios] ([IdUsuario], [Usuario], [Clave], [Tipo_Usuario]) VALUES (5, N'jona', N'1234', N'1')
INSERT [dbo].[Usuarios] ([IdUsuario], [Usuario], [Clave], [Tipo_Usuario]) VALUES (6, N'andres', N'1234', N'1')
INSERT [dbo].[Usuarios] ([IdUsuario], [Usuario], [Clave], [Tipo_Usuario]) VALUES (7, N'matiasq', N'1234', N'1')
SET IDENTITY_INSERT [dbo].[Usuarios] OFF
/****** Object:  Index [IX_Familias]    Script Date: 05/06/2017 19:47:29 ******/
ALTER TABLE [dbo].[Familias] ADD  CONSTRAINT [IX_Familias] UNIQUE NONCLUSTERED 
(
	[IdFamilia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Productos]    Script Date: 05/06/2017 19:47:29 ******/
ALTER TABLE [dbo].[Productos] ADD  CONSTRAINT [IX_Productos] UNIQUE NONCLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Rubros]    Script Date: 05/06/2017 19:47:29 ******/
ALTER TABLE [dbo].[Rubros] ADD  CONSTRAINT [IX_Rubros] UNIQUE NONCLUSTERED 
(
	[IdRubro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Usuarios]    Script Date: 05/06/2017 19:47:29 ******/
ALTER TABLE [dbo].[Usuarios] ADD  CONSTRAINT [IX_Usuarios] UNIQUE NONCLUSTERED 
(
	[IdUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Productos] ADD  CONSTRAINT [DF_Productos_Activo]  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[Productos]  WITH CHECK ADD  CONSTRAINT [FK_Productos_Proveedores] FOREIGN KEY([IdProveedor])
REFERENCES [dbo].[Proveedores] ([IdProv])
GO
ALTER TABLE [dbo].[Productos] CHECK CONSTRAINT [FK_Productos_Proveedores]
GO
ALTER TABLE [dbo].[Productos]  WITH CHECK ADD  CONSTRAINT [FK_Productos_Rubros] FOREIGN KEY([IdRubro])
REFERENCES [dbo].[Rubros] ([IdRubro])
GO
ALTER TABLE [dbo].[Productos] CHECK CONSTRAINT [FK_Productos_Rubros]
GO
ALTER TABLE [dbo].[Rubros]  WITH CHECK ADD  CONSTRAINT [FK_Rubros_Familias2] FOREIGN KEY([IdFlia])
REFERENCES [dbo].[Familias] ([IdFamilia])
GO
ALTER TABLE [dbo].[Rubros] CHECK CONSTRAINT [FK_Rubros_Familias2]
GO
