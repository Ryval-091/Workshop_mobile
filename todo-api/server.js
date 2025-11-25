import express from 'express';
import Todo from './database.js';
import cors from 'cors';

const app   = express();
const port  = 3000;


app.use(cors());
// middleware untuk parsing js
app.use(express.json());

// endpoint
app.get('/', (req, res) => {
    res.send('API is running');
});

// api untuk ambil daftar todo 
app.get('/todos', async (req,res) => {
    try{
        const todos = await Todo.findAll();
        res.json(todos);
    }
    catch(error) {
        res.status(500).json({ error: 'Terjadi Kesalahan'})
    }
});

// api untuk insert todos 
app.post('/todos', async (req,res) => {
    try{
        const newTodo = await Todo.create(req.body);
        res.status(201).json(newTodo);
    }
    catch(error) {
        res.status(400).json({ error: "Gagal menyimpan todo"});

    }
});

app.patch('/todos/:id/toggle', async (req, res) => {
    try{
        const todo = await Todo.findByPk(req.params.id);
        if(todo){
            await todo.update({ completed: todo.completed});
            res.json(todo);
        }
        else{
            res.status(404).json({message: 'Item not found'});
        }
    }
    catch(error){
        res.status(400).json({error: 'Failed to Toggle Item'});
    }
});

// menjalankan server 
app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
})

