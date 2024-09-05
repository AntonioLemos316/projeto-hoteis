import { buscarAllUserRepo } from "../repository/UserRepository.js"

export const buscarAllUserCont = async (req, res) => {
    try {
        const result = await buscarAllUserRepo()
        if(!result || result.length === 0){
            return res.status(404).json({message: 'Erro nada encontrado'})
        }

        res.status(200).json(result)
    } catch (error) {
        throw new Error("Erro ao buscar usuarios");
    }
}

