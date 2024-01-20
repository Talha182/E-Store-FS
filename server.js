const express = require('express');
const MongoClient = require('mongodb').MongoClient;
const bodyParser = require('body-parser');
const cors = require('cors');
const bcrypt = require('bcrypt');
const saltRounds = 10;
const { ObjectId } = require('mongodb');

const app = express();
const port = 3000;

app.use(bodyParser.json());
app.use(cors());

const mongoUri = 'mongodb://localhost:27017';

MongoClient.connect(mongoUri, { useNewUrlParser: true, useUnifiedTopology: true })
    .then(client => {
        const db = client.db('StoreAppDB');
        const dressesCollection = db.collection('Dresses');
        const jacketsCollection = db.collection('jackets');
        const jeansCollection = db.collection('jeans');
        const shoesCollection = db.collection('shoes');
        const cartCollection = db.collection('cart');
        const usersCollection = db.collection('users');
        const wishlistCollection = db.collection('wishlist');


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

            // Route to add an item to the cart
                app.post('/cart', (req, res) => {
                    cartCollection.insertOne(req.body)
                        .then(result => {
                            res.status(201).send(result);
                        })
                        .catch(error => {
                            console.error(error);
                            res.status(500).send(error);
                        });
                });

                // Route to get cart items
                app.get('/cart', (req, res) => {
                    cartCollection.find().toArray()
                        .then(results => {
                            res.status(200).json(results);
                        })
                        .catch(error => {
                            console.error(error);
                            res.status(500).send(error);
                        });
                });

              // Route to delete a cart item
              app.delete('/cart/:id', (req, res) => {
                const { id } = req.params;
                // Use ObjectId to create an ObjectId instance from the provided id
                const cartItemId = new ObjectId(id);

                cartCollection.deleteOne({ _id: cartItemId })
                  .then(result => {
                    if (result.deletedCount === 0) {
                      return res.status(404).send('Item not found');
                    }
                    res.status(200).send('Item deleted');
                  })
                  .catch(error => {
                    console.error(error);
                    res.status(500).send(error);
                  });
              });


              // Route to add an item to the wishlist
              app.post('/wishlist', (req, res) => {
                wishlistCollection.insertOne(req.body)
                  .then(result => {
                    res.status(201).send(result);
                  })
                  .catch(error => {
                    console.error(error);
                    res.status(500).send(error);
                  });
              });

              // Route to get wishlist items
              app.get('/wishlist', (req, res) => {
                wishlistCollection.find().toArray()
                  .then(results => {
                    res.status(200).json(results);
                  })
                  .catch(error => {
                    console.error(error);
                    res.status(500).send(error);
                  });
              });





                app.post('/register', (req, res) => {
                          const newUser = req.body;
                          usersCollection.findOne({ $or: [{ username: newUser.username }, { email: newUser.email }] })
                              .then(user => {
                                  if (user) {
                                      if (user.username === newUser.username) {
                                          res.status(409).json({ error: 'Username already exists' });
                                      } else if (user.email === newUser.email) {
                                          res.status(409).json({ error: 'Email already exists' });
                                      }
                                  } else {
                                      bcrypt.hash(newUser.password, saltRounds, function(err, hash) {
                                          if (err) {
                                              console.error('Error hashing password: ', err);
                                              res.status(500).send('Error hashing password');
                                          } else {
                                              newUser.password = hash;
                                              usersCollection.insertOne(newUser)
                                                  .then(result => {
                                                      res.status(201).json(result);
                                                  })
                                                  .catch(error => {
                                                      console.error(error);
                                                      res.status(500).send(error);
                                                  });
                                          }
                                      });
                                  }
                              })
                              .catch(error => {
                                  console.error(error);
                                  res.status(500).send(error);
                              });
                      });

                      app.post('/login', (req, res) => {
                          const { email, password } = req.body;

                          usersCollection.findOne({ email: email })
                              .then(user => {
                                  if (user) {
                                      bcrypt.compare(password, user.password, function(err, result) {
                                          if (result) {
                                              res.status(200).json({ message: 'Login successful' });
                                          } else {
                                              res.status(401).json({ error: 'Invalid password' });
                                          }
                                      });
                                  } else {
                                      res.status(404).json({ error: 'User not found' });
                                  }
                              })
                              .catch(error => {
                                  console.error(error);
                                  res.status(500).send(error);
                              });
                      });

                      app.listen(port, () => {
                          console.log(`Server running on port ${port}`);
                      });
                  })
                  .catch(error => console.error(error));