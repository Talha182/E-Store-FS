const express = require('express');
const MongoClient = require('mongodb').MongoClient;
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();
const port = 3000;

// Middleware
app.use(bodyParser.json());
app.use(cors());

// MongoDB connection URL
const mongoUri = 'mongodb://localhost:27017';

// Connect to MongoDB
MongoClient.connect(mongoUri, { useNewUrlParser: true, useUnifiedTopology: true })
    .then(client => {
        const db = client.db('StoreAppDB');
        const dressesCollection = db.collection('Dresses');
        const jacketsCollection = db.collection('jackets');
        const jeansCollection = db.collection('jeans');
        const shoesCollection = db.collection('shoes');

        // Route to get dresses
        app.get('/dresses', (req, res) => {
            dressesCollection.find().toArray()
                .then(results => {
                    res.status(200).json(results);
                })
                .catch(error => {
                    console.error(error);
                    res.status(500).send(error);
                });
        });

        // Route to get jackets
        app.get('/jackets', (req, res) => {
            jacketsCollection.find().toArray()
                .then(results => {
                    res.status(200).json(results);
                })
                .catch(error => {
                    console.error(error);
                    res.status(500).send(error);
                });
        });

        // Route to get jeans
        app.get('/jeans', (req, res) => {
            jeansCollection.find().toArray()
                .then(results => {
                    res.status(200).json(results);
                })
                .catch(error => {
                    console.error(error);
                    res.status(500).send(error);
                });
        });


        // Route to get shoes
        app.get('/shoes', (req, res) => {
            shoesCollection.find().toArray()
                .then(results => {
                    res.status(200).json(results);
                })
                .catch(error => {
                    console.error(error);
                    res.status(500).send(error);
                });
        });

        // Start server
        app.listen(port, () => {
            console.log(`Server running on port ${port}`);
        });
    })
    .catch(error => console.error(error));
