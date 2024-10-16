const express = require('express');
const mongoose = require('mongoose');
const path = require('path');
const bcrypt = require('bcrypt');
const session = require('express-session'); // Import express-session
const User = require('./models/user');

const app = express();
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Configure session middleware
app.use(session({
    secret: 'your-secret-key', // Change this to your actual secret
    resave: false,
    saveUninitialized: true,
    cookie: { secure: false } // Set to true if using HTTPS
}));

// Serve static files
app.use('/Public', express.static(path.join(__dirname, 'Public')));
app.use('/login', express.static(path.join(__dirname, 'Login')));
app.use('/register', express.static(path.join(__dirname, 'Register')));

// Connect to MongoDB
mongoose.connect('mongodb+srv://NateNunthiphat:PrgUXzjFNK3tHs0U@cluster0.yhzls.mongodb.net/')
    .then(() => console.log('Database connected'))
    .catch(err => console.error('Database connection error:', err));

// Serve the home page
app.get('/', (req, res) => {
    if (req.session.username) {
        res.sendFile(path.join(__dirname, 'Homes', 'home2.html'));
    } else {
        res.sendFile(path.join(__dirname, 'Homes', 'home.html'));
    }
});

app.get('/logout', (req, res) => {
    res.sendFile(path.join(__dirname, 'Homes', 'home.html'));
});
app.get('/login', (req, res) => {
    res.sendFile(path.join(__dirname, 'Login', 'login.html'));
});
app.get('/register', (req, res) => {
    res.sendFile(path.join(__dirname, 'Register', 'register.html'));
});

app.post('/register', async (req, res) => {
    const { email, password, username } = req.body;

    const existingUser = await User.findOne({ email });
    if (existingUser) {
        return res.redirect('/Register/register.html?error=email_exists');
    }
    const existingUsername = await User.findOne({ username });
    if (existingUsername) {
        return res.redirect('/Register/register.html?error=username_exists');
    }

    const hashedPassword = await bcrypt.hash(password, 10);
    const newUser = new User({ email, username, password: hashedPassword });
    await newUser.save();

    res.redirect('/login'); // Redirect to the login page after registration
});

app.post('/login', async (req, res) => {
    const { email, username, password } = req.body; // Assuming both fields are provided
    const user = await User.findOne({ email, username });

    if (!user) {
        return res.redirect('/Login/login.html?error=invalid_credentials'); // Specific error message
    }

    const isMatch = await bcrypt.compare(password, user.password);
    if (isMatch) {
        req.session.username = user.username;
        console.log(req.session.username);
        return res.redirect('/');
    } else {
        return res.redirect('/Login/login.html?error=password_wrong');
    }
});

// Start the server
app.listen(3000, () => {
    console.log('Server running at http://localhost:3000/');
});
