import mysql from 'mysql2/promise';

// Criando a conexão com o banco de dados
export const connection = await mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: 'root', // Se não tiver senha só tirar esse campo aqui
  database: 'hoteis', // Nome da sua base de dados / banco de dados
});

