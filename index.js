const express = require('express')
const mysql = require('promise-mysql')
const expressjwt = require("express-jwt");
const jwt = require("jsonwebtoken");
const cors = require('cors')

const app = express()
const port = 8000
app.use(express.json())
app.use(cors())

const errorCheck = function (err, req, res, next) {
    if (err.name === 'UnauthorizedError') {
        res.json({success: false, status: 401, message: 'invalid token'})
    }
};

const jwtCheck = expressjwt({
    secret: "mysupersecretkey",
    algorithms: ['HS256']
});

app.get('/profile/:id', async (req,res) => {
    const connection = await mysql.createConnection({
        user: 'root',
        password: 'password',
        database: 'bird-blog'
    })

    // const userInfo = await connection.query("SELECT `id`, `username`, `bio` FROM `users` WHERE `id` = '" + req.params.id + "'")
    const posts = await connection.query(" SELECT `posts`.`content` FROM `users` LEFT JOIN `posts` ON `users`.`id` = `posts`.`user-id` WHERE `users`.`id` = '" + req.params.id + "'")
    res.json({posts: posts, userInfo: userInfo})
})

// foreach over all the following ID's, then put them into profile root to get name.
app.get('/following/:id', async (req,res) => {
    const connection = await mysql.createConnection({
        user: 'root',
        password: 'password',
        database: 'bird-blog'
    })
    const following = await connection.query("SELECT `user-following`.`following-id` FROM `users` LEFT JOIN `user-following` ON `users`.`id` = `user-following`.`user-id` WHERE `users`.`id` = '" + req.params.id + "'")
    res.json({following: following})
})

app.post('/signUp', async (req,res) => {
    let {username, bio, email, password} = req.body

    const connection = await mysql.createConnection({
        user: 'root',
        password: 'password',
        database: 'bird-blog'
    })

    let users = await connection.query("SELECT `username`, `bio`, `email`, `password`, `id` FROM `users`")

    users = JSON.parse(JSON.stringify(users))

    const user = users.find((u) => {
        return u.email === email
    })

    if (user) {
        res.json({success: false, message: 'email already in use'})
        return;
    }

    const result = await connection.query("INSERT INTO users (username, bio, email, password) VALUES (?,?,?,?)", [username, bio, email, password])

    if (!result){
        res.json({success: false, message: "something went wrong"})
        return
    }

    const token = jwt.sign({
        sub: result.insertId,
        username: username,
        email: email
    }, "mysupersecretkey", {expiresIn: "3 hours"});

    res.json({success: true, message: 'successfully logged in', data: {username, email, bio, access_token: token}})

})

app.post('/login', async (req,res) => {
    //check to see that the credentials are being sent in the body of the req
    //create the connection to the db
    //grab all the users from the db
    //search through the users for someone that matches the provided credentials
    //if no one matches send a fail response
    //if someone matches then create a new token and send a success response

    if (!req.body.email || !req.body.password) {
        res.json({success: false, message: 'please send all credentials needed'})
        return;
    }

    let {email, password} = req.body

    const connection = await mysql.createConnection({
        user: 'root',
        password: 'password',
        database: 'bird-blog'
    })

    let users = await connection.query("SELECT `username`, `bio`, `email`, `password`, `id` FROM `users`")

    users = JSON.parse(JSON.stringify(users))

    const user = users.find((u) => {
        return u.email === email && u.password === password;
    });

    if (!user) {
        res.json({success: false, message: 'could not find anyone that matches your credentials'})
        return;
    }

    const token = jwt.sign({
        sub: user.id,
        username: user.username,
        email: user.email
    }, "mysupersecretkey", {expiresIn: "3 hours"});

    res.json({success: true, message: 'successfully logged in', data: {...user, access_token: token}})

})

app.post('/userProfileWritePost', async (req,res) => {
    let {userId,common, binomial, date, where} = req.body
    console.log('requestBody: ' + req.body)

    const connection = await mysql.createConnection({
        user: 'root',
        password: 'password',
        database: 'bird-blog'
    })

    let dateTime = '2022-01-15 17:38:34'
    // const userInfo = await connection.query("SELECT `id`, `username`, `bio` FROM `users` WHERE `id` = '" + req.params.id + "'")
    const result = await connection.query("INSERT INTO `posts` (`user-id`,`common`, `binomial`, `date`, `where`) VALUES (?,?,?,?,?)", [userId, common, binomial, date, where])

    // res.json({posts: posts, userInfo: userInfo})

    if (!result){
        res.json({success: false, message: "something went wrong"})
        return
    }

    res.json({success: true, message: 'new post created', data: {userId, common, binomial, date, where}})

})

app.get('/myProfile', jwtCheck, errorCheck, async (req, res) => {
    let id = req.user.sub
    console.log(id)
    const connection = await mysql.createConnection({
        user: 'root',
        password: 'password',
        database: 'bird-blog'
    })

    // const userInfo = await connection.query("SELECT `username`, `bio`,`id` FROM `users` WHERE `id` = '" + id + "'")
    const posts = await connection.query(" SELECT `common`, `binomial`, `date`, `where` FROM `posts` WHERE `user-id` = '" + id + "'")
    console.log(posts)
    res.json({posts: posts})

})

app.get('/test', (req, res) => {
    res.json({"name": 'Bird Blog'})
})

// The app.listen() function is used to bind and listen the
// connections on the specified host and port.
app.listen(port)