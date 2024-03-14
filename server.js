const { Client } = require('pg');
const http = require('http');
require('dotenv').config(); 


const client = new Client({
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    port: process.env.DB_PORT,
    host: process.env.DB_HOST,
    ssl: {
        rejectUnauthorized: false 
    }
});


client.connect()
    .then(() => {
        console.log('Connected to PostgreSQL database');
    })
    .catch(err => {
        console.error('Error connecting to PostgreSQL:', err.message);
    });


const requestListener = async function (req, res) {
    if (req.url !== '/favicon.ico') {
        try {
            
            const result = await client.query('UPDATE public.counter_table SET count = count + 1 RETURNING count');

           
            if (result.rows.length > 0 && 'count' in result.rows[0]) {
                const count = result.rows[0].count;
                res.writeHead(200);
                res.end(`Welcome to Tessolve Semiconductor\nPage view count: ${count}`);
            } else {
                console.error('Error: Unable to retrieve count value from database');
                res.writeHead(500);
                res.end('Internal Server Error');
            }
        } catch (err) {
            console.error('Error executing SQL:', err.message);
            res.writeHead(500);
            res.end('Internal Server Error');
        }
    }
};


const server = http.createServer(requestListener);


server.listen(8080, () => {
    console.log('Server is running on port 8080');
});
