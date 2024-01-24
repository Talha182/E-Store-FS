const express = require('express');
const MongoClient = require('mongodb').MongoClient;
const bodyParser = require('body-parser');
const cors = require('cors');
const bcrypt = require('bcrypt');
const saltRounds = 10;
const { ObjectId } = require('mongodb');
const mongoose = require('mongoose');


const app = express();
app.use(express.json());
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


       // MongoDB User Schema
       const userSchema = new mongoose.Schema({
         username: { type: String, required: true, unique: true },
         email: { type: String, required: true, unique: true },
         password: { type: String, required: true }
       });

       const User = mongoose.model('User', userSchema);

       // MongoDB Connection
       mongoose.connect('mongodb://localhost:27017/StoreAppDB', {
         useNewUrlParser: true,
         useUnifiedTopology: true,
       }).then(() => console.log('MongoDB Connected'))
         .catch(err => console.log(err));


             app.post('/login', async (req, res) => {
                    try {
                        const { email, password } = req.body;
                        const user = await User.findOne({ email });
                        if (!user) {
                              return res.status(404).json({ error: 'User not found' });
                        }
                        const isMatch = await bcrypt.compare(password, user.password);
                        if (!isMatch) {
                           return res.status(401).json({ error: 'Invalid password' });
                         }
                         res.status(200).json({ message: 'Login successful' });
                         } catch (error) {
                         console.error(error);
                         res.status(500).send('Server error');
                         }
                           });



       // User Registration Route
       app.post('/register', async (req, res) => {
         try {
           const { username, email, password } = req.body;

           // Check if all fields are provided
           if (!username || !email || !password) {
             return res.status(400).json({ error: 'All fields are required' });
           }

           // Check if user already exists
           const existingUser = await User.findOne({ $or: [{ username }, { email }] });
           if (existingUser) {
             return res.status(409).json({ error: 'Username or Email already exists' });
           }

           // Hash the password
           const hashedPassword = await bcrypt.hash(password, saltRounds);

           // Create a new user
           const newUser = new User({
             username,
             email,
             password: hashedPassword
           });

           // Save the user in the database
           await newUser.save();

           // Respond with success
           res.status(201).json({ message: 'User registered successfully' });
         } catch (error) {
           console.error(error);
           res.status(500).send('Server error');
         }
       });




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

               // Route to delete a wishlist item
                          app.delete('/wishlist/:id', (req, res) => {
                              const { id } = req.params;
                              const wishlistItemId = new ObjectId(id);

                              wishlistCollection.deleteOne({ _id: wishlistItemId })
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








                      app.listen(port, () => {
                          console.log(`Server running on port ${port}`);
                      });
                  })
                  .catch(error => console.error(error));