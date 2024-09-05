import { connection } from "../config/configDatabase.js";

export const buscarAllUserRepo = async () => {
    try {
        const [results] = await connection.query('SELECT * FROM users')
        return results
    } catch (error) {
        throw new Error("Erro ao buscar usuários");
    }
}