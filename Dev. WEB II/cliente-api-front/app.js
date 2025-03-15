const express = require('express');
const axios = require('axios');
const bodyParser = require('body-parser');
const app = express();

app.use(bodyParser.urlencoded({ extended:true}));
app.set('view engine', 'ejs');
app.use(express.static('public'));

const apiUrl = 'http://localhost:8080/api/clientes';

// app.get('/', (req,res) => {
//     res.send('Criando minha primeira rota!');
// });


app.get('/', async (req,res) => {
    try{
        const response = await axios.get(apiUrl);
        const clientes = response.data;
        res.render('index', {clientes});
    }catch(error){
        console.error(error);
        res.status(500).send('Erro ao buscar clientes');
    }
});

app.listen(3000, () => {
    console.log('Servidor rodando na porta 3000');
});