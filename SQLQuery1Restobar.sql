

CREATE DATABASE RestoBar_P3_DB;
GO

USE RestoBar_P3_DB;
GO

CREATE TABLE Insumos (
    IdInsumo INT IDENTITY(1,1) NOT NULL,
    Nombre NVARCHAR(100) NOT NULL,
    StockActual INT NOT NULL DEFAULT 0,
    PrecioVenta DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    Activo BIT NOT NULL DEFAULT 1,
    
    CONSTRAINT PK_Insumos PRIMARY KEY (IdInsumo)
);
GO


CREATE TABLE Consumiciones (
    ID INT IDENTITY(1,1) NOT NULL,
    Nombre NVARCHAR(100) NOT NULL,
    Tipo NVARCHAR(50) NOT NULL, -- Almacena "comida" o "bebida"
    Precio DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    StockActual INT NOT NULL DEFAULT 0,
    
    CONSTRAINT PK_Consumiciones PRIMARY KEY (ID)
);
GO


CREATE TABLE Mesa (
    ID INT IDENTITY(1,1) NOT NULL,
    NumeroMesa INT NOT NULL,
    Capacidad INT NOT NULL DEFAULT 2,
    Estado NVARCHAR(50) NOT NULL DEFAULT 'Libre', -- Ej: "Libre", "Ocupada", "Reservada"
    
    CONSTRAINT PK_Mesas PRIMARY KEY (ID),
    CONSTRAINT UQ_NumeroMesa UNIQUE (NumeroMesa) -- Evita que existan dos mesas con el mismo número
);
GO


CREATE TABLE Usuarios (
    ID INT IDENTITY(1,1) NOT NULL,
    Username NVARCHAR(50) NOT NULL,
    Password NVARCHAR(255) NOT NULL, -- Mayor longitud para contraseñas encriptadas/hasheadas
    Nombre NVARCHAR(100) NOT NULL,
    TipoPerfil NVARCHAR(50) NOT NULL, -- Ej: "Admin", "Mesero", "Cajero"
    
    CONSTRAINT PK_Usuarios PRIMARY KEY (ID),
    CONSTRAINT UQ_Username UNIQUE (Username) -- Evita que dos usuarios tengan el mismo nombre de usuario
);
GO

CREATE TABLE Pedidos (
    ID INT IDENTITY(1,1) NOT NULL,
    ID_Mesa INT NOT NULL,
    ID_Mesero INT NOT NULL,
    FechaApertura DATETIME NOT NULL DEFAULT GETDATE(),
    FechaCierre DATETIME NULL, -- Permite nulos mediante el tipo DateTime? de C#
    Estado NVARCHAR(50) NOT NULL DEFAULT 'Abierto', -- Ej: "Abierto", "Pagado", "Cancelado"
    
    CONSTRAINT PK_Pedidos PRIMARY KEY (ID),
    CONSTRAINT FK_Pedidos_Mesas FOREIGN KEY (ID_Mesa) REFERENCES Mesa (ID),
    -- Asumo que la tabla de usuarios se llamará 'Usuarios' y su clave primaria es 'ID'
    CONSTRAINT FK_Pedidos_Usuarios FOREIGN KEY (ID_Mesero) REFERENCES Usuarios (ID)
);