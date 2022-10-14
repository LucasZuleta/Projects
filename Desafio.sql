

create dataBase DB_LOGIN

create table USUARIO(
	IdUsuario int primary key identity (1,1),
	Nombre varchar (50),
	Apellido varchar (50),
	Correo_Electronico varchar (200),
	Fecha_Nacimiento date,
	Numero_Telefono int,
	Pais_Recidencia varchar (50),
	Desea_Info bit,
	Clave varchar (200)
	)

	create proc RegistrarUsuario(
		@Correo varchar (100),
		@Clave varchar (500),
		@Registrado bit output,
		@Mensaje varchar (100) output
		)

		as
		begin

			if(not exists(select * from USUARIO where Correo_Electronico = @Correo))
			begin
				insert into USUARIO(Correo_Electronico,Clave) values(@Correo,@Clave)
				set @Registrado = 1
				set @Mensaje = 'usuario registrado'
			end
			else
			begin
				set @Registrado = 0
				set @Mensaje = 'el correo ya existe'
			end

		end

	create proc sp_ValidarUsuario(
		@Correo varchar(100),
		@Clave varchar(500)
		)
		as
		begin
			if(exists(select * from USUARIO where Correo_Electronico = @Correo and Clave = @Clave))
				select IdUsuario from USUARIO where Correo_Electronico = @Correo and Clave = @Clave
			else
				select '0'
		end

		create table ACTIVIDAD(
			Id_actividad int primary key identity(1,1),
			Create_date date,
			IdUsuario int,
			Actividad varchar,
			Constraint fkIdUsuario foreign key (IdUsuario)
				references USUARIO

			)
