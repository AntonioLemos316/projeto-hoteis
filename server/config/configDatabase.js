// Importa o módulo mysql2/promise, que é uma versão da biblioteca mysql2 com suporte para Promises
import mysql from 'mysql2/promise';

// Cria uma conexão com o banco de dados usando as credenciais e configurações fornecidas
// O uso de `await` aqui garante que a conexão seja estabelecida antes que o módulo seja exportado
export const connection = await mysql.createConnection({
  host: 'localhost', // Endereço do servidor de banco de dados. 'localhost' indica que o banco está na mesma máquina
  user: 'root',      // Nome de usuário para autenticação no banco de dados
  password: 'root',  // Senha para autenticação no banco de dados. Se não houver senha, este campo deve ser removido ou deixado como uma string vazia
  database: 'hoteis',// Nome do banco de dados ao qual você deseja se conectar
});
