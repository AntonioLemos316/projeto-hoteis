-- Cria o banco de dados 'hoteis' se ele não existir e define o conjunto de caracteres padrão
CREATE DATABASE IF NOT EXISTS hoteis;
    DEFAULT CHARACTER SET = 'utf8mb4';

-- Define o banco de dados a ser usado para as seguintes operações
USE hoteis;

-- Cria a tabela 'users' se ela não existir, com campos para informações do usuário
CREATE TABLE IF NOT EXISTS users (
    user_id INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único do usuário
    username VARCHAR(50) NOT NULL UNIQUE, -- Nome de usuário único
    email VARCHAR(100) NOT NULL UNIQUE, -- Email único do usuário
    password_hash VARCHAR(255) NOT NULL, -- Hash da senha do usuário
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Data e hora da criação do registro
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP -- Data e hora da última atualização do registro
);

-- Cria a tabela 'hoteis' se ela não existir, com campos para informações do hotel
CREATE TABLE IF NOT EXISTS hoteis (
    hotel_id INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único do hotel
    name VARCHAR(100) NOT NULL, -- Nome do hotel
    address VARCHAR(255) NOT NULL, -- Endereço do hotel
    city VARCHAR(100) NOT NULL, -- Cidade onde o hotel está localizado
    country VARCHAR(100) NOT NULL, -- País onde o hotel está localizado
    rating FLOAT CHECK (rating >= 0 AND rating <= 5), -- Avaliação do hotel, entre 0 e 5
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Data e hora da criação do registro
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP -- Data e hora da última atualização do registro
);

-- Cria a tabela 'reservas' se ela não existir, com campos para informações de reservas
CREATE TABLE IF NOT EXISTS reservas (
    reserva_id INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único da reserva
    user_id INT, -- ID do usuário que fez a reserva
    hotel_id INT, -- ID do hotel reservado
    check_in DATE NOT NULL, -- Data de check-in
    check_out DATE NOT NULL, -- Data de check-out
    room_type VARCHAR(50), -- Tipo de quarto reservado
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Data e hora da criação da reserva
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- Data e hora da última atualização da reserva
    FOREIGN KEY (user_id) REFERENCES users(user_id), -- Chave estrangeira referenciando a tabela 'users'
    FOREIGN KEY (hotel_id) REFERENCES hoteis(hotel_id) -- Chave estrangeira referenciando a tabela 'hoteis'
);

-- Cria a tabela 'rooms' se ela não existir, com campos para informações de quartos
CREATE TABLE IF NOT EXISTS rooms (
    room_id INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único do quarto
    hotel_id INT, -- ID do hotel ao qual o quarto pertence
    room_number VARCHAR(20), -- Número do quarto
    room_type VARCHAR(50), -- Tipo do quarto
    price DECIMAL(10, 2), -- Preço do quarto
    availability BOOLEAN DEFAULT TRUE, -- Disponibilidade do quarto
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Data e hora da criação do registro
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- Data e hora da última atualização do registro
    FOREIGN KEY (hotel_id) REFERENCES hoteis(hotel_id) -- Chave estrangeira referenciando a tabela 'hoteis'
);

-- Cria a tabela 'reviews' se ela não existir, com campos para avaliações de hotéis
CREATE TABLE IF NOT EXISTS reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único da avaliação
    user_id INT, -- ID do usuário que fez a avaliação
    hotel_id INT, -- ID do hotel avaliado
    rating INT CHECK (rating >= 1 AND rating <= 5), -- Avaliação do hotel, entre 1 e 5
    comment TEXT, -- Comentário da avaliação
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Data e hora da criação da avaliação
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- Data e hora da última atualização da avaliação
    FOREIGN KEY (user_id) REFERENCES users(user_id), -- Chave estrangeira referenciando a tabela 'users'
    FOREIGN KEY (hotel_id) REFERENCES hoteis(hotel_id) -- Chave estrangeira referenciando a tabela 'hoteis'
);

-- Cria a tabela 'payments' se ela não existir, com campos para informações de pagamentos
CREATE TABLE IF NOT EXISTS payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único do pagamento
    reserva_id INT, -- ID da reserva associada ao pagamento
    amount DECIMAL(10, 2), -- Valor do pagamento
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Data e hora do pagamento
    payment_method VARCHAR(50), -- Método de pagamento
    FOREIGN KEY (reserva_id) REFERENCES reservas(reserva_id) -- Chave estrangeira referenciando a tabela 'reservas'
);

-- Insere alguns dados de exemplo na tabela 'users'
INSERT INTO users (username, email, password_hash, created_at, updated_at) VALUES
('johndoe', 'johndoe@example.com', 'hashedpassword1', NOW(), NOW()),
('janedoe', 'janedoe@example.com', 'hashedpassword2', NOW(), NOW());

-- Insere alguns dados de exemplo na tabela 'hoteis'
INSERT INTO hoteis (name, address, city, country, rating, created_at, updated_at) VALUES
('Hotel Lux', '123 Luxury Ave', 'Paris', 'France', 4.5, NOW(), NOW()),
('Beachside Resort', '456 Ocean Rd', 'Miami', 'USA', 4.2, NOW(), NOW());

-- Insere algumas reservas de exemplo na tabela 'reservas'
INSERT INTO reservas (user_id, hotel_id, check_in, check_out, room_type, created_at, updated_at) VALUES
(1, 1, '2024-09-10', '2024-09-15', 'Suite', NOW(), NOW()),
(2, 2, '2024-09-20', '2024-09-25', 'Double', NOW(), NOW());

-- Insere alguns dados de exemplo na tabela 'rooms'
INSERT INTO rooms (hotel_id, room_number, room_type, price, availability, created_at, updated_at) VALUES
(1, '101', 'Suite', 250.00, TRUE, NOW(), NOW()),
(1, '102', 'Double', 150.00, TRUE, NOW(), NOW()),
(2, '201', 'Double', 180.00, TRUE, NOW(), NOW()),
(2, '202', 'Single', 120.00, TRUE, NOW(), NOW());

-- Insere algumas avaliações de exemplo na tabela 'reviews'
INSERT INTO reviews (user_id, hotel_id, rating, comment, created_at, updated_at) VALUES
(1, 1, 5, 'Amazing stay! The suite was luxurious and the service was top-notch.', NOW(), NOW()),
(2, 2, 3, 'The location was great, but the room was a bit small and outdated.', NOW(), NOW());

-- Insere alguns dados de exemplo na tabela 'payments'
INSERT INTO payments (reserva_id, amount, payment_date, payment_method) VALUES
(1, 1250.00, NOW(), 'Credit Card'),
(2, 900.00, NOW(), 'PayPal');
