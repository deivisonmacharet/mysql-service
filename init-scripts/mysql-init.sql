CREATE DATABASE IF NOT EXISTS init_db
CREATE SCHEMA IF NOT EXISTS init_db;
USE init_db;


CREATE TABLE user_position (
	id_position INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,	-- Nome do cargo
    enabled BOOLEAN DEFAULT 1,			-- ativo/inativo
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE users (
	id_user INT AUTO_INCREMENT PRIMARY KEY,
	id_position INT NOT NULL,						-- Id do cargo
	name VARCHAR(100) NOT NULL,                     -- Nome
	cpf VARCHAR(11) UNIQUE NOT NULL,				-- cpf
	cel VARCHAR(20) DEFAULT NULL,					-- celular
    date_birth DATE NOT NULL,						-- data de nascimento
	password VARCHAR(255) NOT NULL,					-- senha
	email VARCHAR(255) UNIQUE NOT NULL,				-- email
	enabled BOOLEAN DEFAULT 1,						-- ativo/inativo
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,	-- data cadastro

	FOREIGN KEY (id_position) REFERENCES user_position(id_position) ON DELETE RESTRICT ON UPDATE CASCADE
);
CREATE INDEX idx_user_email ON users(email);
CREATE INDEX idx_user_cpf ON users(cpf);

CREATE TABLE user_address (
    id_user_address INT AUTO_INCREMENT PRIMARY KEY,
    id_user INT NOT NULL,
    cep VARCHAR(10) NOT NULL,             -- 00000-000
    street VARCHAR(150) NOT NULL,         -- Rua / Avenida
    number VARCHAR(20) NOT NULL,          -- Número (aceita "S/N")
    complement VARCHAR(100),              -- Apto, bloco, casa, etc
    neighborhood VARCHAR(100) NOT NULL,   -- Bairro
    city VARCHAR(100) NOT NULL,            -- Cidade
    state CHAR(2) NOT NULL,                -- UF (SP, PR, etc)
    country VARCHAR(50) DEFAULT 'Brasil',  -- Pais
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_user_address_user FOREIGN KEY (id_user) REFERENCES users(id_user) ON DELETE CASCADE
);
CREATE INDEX idx_user_address_user ON user_address(id_user);

