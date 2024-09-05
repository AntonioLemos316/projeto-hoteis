// Importa o módulo express, que é uma biblioteca para construir aplicações web e APIs em Node.js
import express from 'express';

// Importa o router definido em './router/UserRouter.js', que contém as rotas da API
import { router } from './router/UserRouter.js';

// Cria uma instância da aplicação Express
const app = express();

// Define a porta em que o servidor vai escutar requisições
const PORT = 3000;

// Middleware para parsear o corpo das requisições em formato JSON
// Isso é necessário para que a aplicação possa ler e manipular os dados JSON enviados nas requisições
app.use(express.json());

// Define o prefixo '/api' para todas as rotas gerenciadas pelo router importado
// As rotas definidas em './router/UserRouter.js' estarão disponíveis sob o prefixo '/api'
// Exemplo: se o router define uma rota '/users', ela estará disponível em '/api/users'
app.use('/api', router);

// Inicia o servidor e faz com que ele comece a escutar na porta definida (3000)
// Após iniciar, o servidor exibe uma mensagem no console indicando que está rodando
app.listen(PORT, () => console.log(`Server rodando em http://localhost:${PORT}`));
