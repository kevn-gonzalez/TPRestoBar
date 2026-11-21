
CREATE DATABASE RestoBar_P3_DB;
GO

USE RestoBar_P3_DB;
GO

CREATE TABLE Insumos (
    Id INT IDENTITY(1,1) NOT NULL,
    Nombre NVARCHAR(100) NOT NULL,
    Tipo NVARCHAR(100) NOT NULL,
    StockActual INT NOT NULL DEFAULT 0,
    PrecioVenta DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    Activo BIT NOT NULL DEFAULT 1,
    
    CONSTRAINT PK_Insumos PRIMARY KEY (Id)
);
GO



CREATE TABLE Mesa (
    Id INT IDENTITY(1,1) NOT NULL,
    NumeroMesa INT NOT NULL,
    Capacidad INT NOT NULL DEFAULT 2,
    Estado NVARCHAR(50) NOT NULL DEFAULT 'Libre', -- Ej: "Libre", "Ocupada", "Reservada"
    
    CONSTRAINT PK_Mesas PRIMARY KEY (Id),
    CONSTRAINT UQ_NumeroMesa UNIQUE (NumeroMesa) -- Evita que existan dos mesas con el mismo número
);
GO


CREATE TABLE Usuarios (
    Id INT IDENTITY(1,1) NOT NULL,
    Username NVARCHAR(50) NOT NULL,
    Password NVARCHAR(255) NOT NULL, -- Mayor longitud para contraseñas encriptadas/hasheadas
    Nombre NVARCHAR(100) NOT NULL,
    TipoPerfil NVARCHAR(50) NOT NULL, -- Ej: "Admin", "Mesero", "Cajero"
    
    CONSTRAINT PK_Usuarios PRIMARY KEY (Id),
    CONSTRAINT UQ_Username UNIQUE (Username) -- Evita que dos usuarios tengan el mismo nombre de usuario
);
GO

CREATE TABLE Pedidos (
    Id INT IDENTITY(1,1) NOT NULL,
    MesaId INT NOT NULL,
    MeseroId INT NOT NULL,
    FechaApertura DATETIME NOT NULL DEFAULT GETDATE(),
    FechaCierre DATETIME NULL, -- Permite nulos mediante el tipo DateTime? de C#
    Estado NVARCHAR(50) NOT NULL DEFAULT 'Abierto', -- Ej: "Abierto", "Pagado", "Cancelado"
    
    CONSTRAINT PK_Pedidos PRIMARY KEY (Id),
    CONSTRAINT FK_Pedidos_Mesas FOREIGN KEY (MesaId) REFERENCES Mesa (Id),
    -- Asumo que la tabla de usuarios se llamará 'Usuarios' y su clave primaria es 'ID'
    CONSTRAINT FK_Pedidos_Usuarios FOREIGN KEY (MeseroId) REFERENCES Usuarios (Id)
);
GO

CREATE TABLE Consumiciones (
    Id INT IDENTITY(1,1) NOT NULL,
    InsumoId INT NOT NULL,
    PedidoId INT NOT NULL,
    Nombre NVARCHAR(100) NOT NULL,
    Tipo NVARCHAR(50) NOT NULL, -- Almacena "comida" o "bebida"
    Precio DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    Cantidad INT NOT NULL DEFAULT 0,
    
    CONSTRAINT PK_Consumiciones PRIMARY KEY (Id),
    CONSTRAINT FK_Insumos FOREIGN KEY (InsumoId) REFERENCES Insumos (Id),
    CONSTRAINT FK_Consumiciones FOREIGN KEY (PedidoId) REFERENCES Pedidos (Id) 
);
