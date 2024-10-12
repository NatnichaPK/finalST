const express = require('express')
const mongoose = require('mongoose')
const path = require('path')
const port = 3000

const app = express();
app.use(express.static(__dirname))

mongoose.connect('mongodb+srv://NateNunthiphat:PrgUXzjFNK3tHs0U@cluster0.yhzls.mongodb.net/')
const db = mongoose.connection
db.once('open',()=>{
    console.log("Database connected")
})

app.get('/',(req,res)=>{
    res.sendFile(path.join(__dirname,'Homes/home.html'))
})

app.listen(port,()=>{
    console.log("Server started")
})
