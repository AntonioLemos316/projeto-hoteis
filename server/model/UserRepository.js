// Importa a conexão com o banco de dados definida em '../config/configDatabase.js'
// Presume-se que a conexão é uma instância do cliente do banco de dados, como o MySQL ou outro cliente SQL
import { connection } from "../config/configDatabase.js";

// Define a função buscarAllUserRepo, que é responsável por buscar todos os usuários do banco de dados
// A função é assíncrona porque realiza uma operação de I/O (consulta ao banco de dados)
export const buscarAllUserRepo = async () => {
    try {
        // Executa uma consulta SQL para selecionar todos os registros da tabela 'users'
        // `connection.query` é uma função assíncrona que retorna uma promessa
        // O resultado da consulta é desestruturado em `[results]`
        const [results] = await connection.query('SELECT * FROM users');

        // Retorna os resultados da consulta
        // `results` contém os dados dos usuários obtidos do banco de dados
        return results;
    } catch (error) {
        // Em caso de erro durante a consulta ao banco de dados, lança uma exceção com uma mensagem de erro
        // Lançar uma exceção faz com que o erro seja propagado para o controlador que chamou esta função
        throw new Error("Erro ao buscar usuários");
    }
};
