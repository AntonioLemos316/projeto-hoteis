// Importa a função buscarAllUserRepo do repositório de usuários
// Presume-se que essa função é responsável por buscar todos os usuários no banco de dados
import { buscarAllUserRepo } from "../model/UserRepository.js";

// Define a função buscarAllUserCont, que será utilizada como controlador para processar a requisição
// A função é assíncrona porque realiza uma operação de I/O (acesso ao banco de dados)
export const buscarAllUserCont = async (req, res) => {
    try {
        // Chama a função buscarAllUserRepo para obter a lista de usuários do banco de dados
        const result = await buscarAllUserRepo();

        // Verifica se o resultado é vazio ou não existe
        // Se não houver usuários, retorna uma resposta com status 404 e uma mensagem de erro
        if (!result || result.length === 0) {
            return res.status(404).json({ message: 'Erro nada encontrado' });
        }

        // Se a busca for bem-sucedida e houver usuários, retorna uma resposta com status 200 e os dados dos usuários
        res.status(200).json(result);
    } catch (error) {
        // Em caso de erro, lança uma exceção com uma mensagem de erro
        // Aqui você pode querer enviar uma resposta de erro para o cliente em vez de lançar uma exceção
        res.status(500).json({ message: 'Erro ao buscar usuários' });
    }
};
