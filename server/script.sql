CREATE DATABASE IF NOT EXISTS hoteis;
    DEFAULT CHARACTER SET = 'utf8mb4';

USE hoteis;

CREATE TABLE IF NOT EXISTS users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS hoteis (
    hotel_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL,
    rating FLOAT CHECK (rating >= 0 AND rating <= 5),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS reservas (
    reserva_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    hotel_id INT,
    check_in DATE NOT NULL,
    check_out DATE NOT NULL,
    room_type VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (hotel_id) REFERENCES hoteis(hotel_id)
);

CREATE TABLE IF NOT EXISTS rooms (
    room_id INT AUTO_INCREMENT PRIMARY KEY,
    hotel_id INT,
    room_number VARCHAR(20),
    room_type VARCHAR(50),
    price DECIMAL(10, 2),
    availability BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (hotel_id) REFERENCES hoteis(hotel_id)
);

CREATE TABLE IF NOT EXISTS reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    hotel_id INT,
    rating INT CHECK (rating >= 1 AND rating <= 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (hotel_id) REFERENCES hoteis(hotel_id)
);

CREATE TABLE IF NOT EXISTS payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    reserva_id INT,
    amount DECIMAL(10, 2),
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method VARCHAR(50),
    FOREIGN KEY (reserva_id) REFERENCES reservas(reserva_id)
);

INSERT INTO users (username, email, password_hash, created_at, updated_at) VALUES
('johndoe', 'johndoe@example.com', 'hashedpassword1', NOW(), NOW()),
('janedoe', 'janedoe@example.com', 'hashedpassword2', NOW(), NOW());

INSERT INTO hoteis (name, address, city, country, rating, created_at, updated_at) VALUES
('Hotel Lux', '123 Luxury Ave', 'Paris', 'France', 4.5, NOW(), NOW()),
('Beachside Resort', '456 Ocean Rd', 'Miami', 'USA', 4.2, NOW(), NOW());

INSERT INTO reservas (user_id, hotel_id, check_in, check_out, room_type, created_at, updated_at) VALUES
(1, 1, '2024-09-10', '2024-09-15', 'Suite', NOW(), NOW()),
(2, 2, '2024-09-20', '2024-09-25', 'Double', NOW(), NOW());

INSERT INTO rooms (hotel_id, room_number, room_type, price, availability, created_at, updated_at) VALUES
(1, '101', 'Suite', 250.00, TRUE, NOW(), NOW()),
(1, '102', 'Double', 150.00, TRUE, NOW(), NOW()),
(2, '201', 'Double', 180.00, TRUE, NOW(), NOW()),
(2, '202', 'Single', 120.00, TRUE, NOW(), NOW());

INSERT INTO reviews (user_id, hotel_id, rating, comment, created_at, updated_at) VALUES
(1, 1, 5, 'Amazing stay! The suite was luxurious and the service was top-notch.', NOW(), NOW()),
(2, 2, 3, 'The location was great, but the room was a bit small and outdated.', NOW(), NOW());

INSERT INTO payments (reserva_id, amount, payment_date, payment_method) VALUES
(1, 1250.00, NOW(), 'Credit Card'),
(2, 900.00, NOW(), 'PayPal');
