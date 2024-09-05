import express from 'express'
import { buscarAllUserCont } from '../controller/UserController.js'

export const router = express.Router()

router.get('/buscarAll', buscarAllUserCont)