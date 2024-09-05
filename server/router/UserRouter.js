// Importa o módulo express, que é utilizado para criar um roteador de rotas
import express from 'express';

// Importa o controlador que contém a lógica para buscar todos os usuários
// Presume-se que o controlador esteja definido em '../controller/UserController.js'
import { buscarAllUserCont } from '../controller/UserController.js';

// Cria uma instância do roteador Express
// O roteador é utilizado para definir e agrupar as rotas da API
export const router = express.Router();

// Define uma rota GET para o caminho '/buscarAll'
// Quando uma requisição GET é feita para '/api/buscarAll', o controlador buscarAllUserCont é chamado
// O controlador é responsável por processar a requisição e gerar a resposta
router.get('/buscarAll', buscarAllUserCont);
