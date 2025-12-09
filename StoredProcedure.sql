
--Store Procedure para obtener una lista de productos
create procedure sp_ObtenerProducto
as
begin
select * from Productos
end

--Stored Procedure para obtener un solo producto por su id
create procedure sp_ObtenerProductoPorId
@IdProducto int
as
begin
select * from Productos where IdProducto = @IdProducto
end

--Stored Procedure para insertar producto
create procedure sp_InsertarProducto
@Descripcion varchar(100),
@Stock int,
@Precio decimal(18,2),
@IdCategoria int,
@NuevoId int OUTPUT
as
begin

SET NOCOUNT ON

insert into Productos(Descripcion, Stock, Precio, IdCategoria)
values(@Descripcion, @Stock, @Precio,@IdCategoria);

SET @NuevoId = SCOPE_IDENTITY();

end

--Stored Procedure para actualizar productos
create procedure sp_ActualizarProducto
@IdProducto int,
@Descripcion varchar(100),
@Stock int,
@Precio decimal(18,2),
@IdCategoria int
as
begin
update Productos
set Descripcion = @Descripcion,
	Stock = @Stock,
	Precio = @Precio,
	IdCategoria = @IdCategoria
where IdProducto = @IdProducto;
end

--Stored Procedure para eliminar producto
create procedure sp_EliminarProducto
@IdProducto int
as
begin
	set nocount on;
	
	if exists(select 1 from DetalleVenta where IdIdProducto = @IdProducto)
	begin
		select 1 as resultado, 'Este producto no puede ser eliminado, tiene ventas' as mensaje;
		return
	end

	delete from Productos where IdProducto = @IdProducto;

	IF @@ROWCOUNT = 0

	begin
		select 2 as resultado, 'El producto no existe' as mensaje
		return
	end
	select 0 as resultado, 'Producto eliminado' as mensaje
end