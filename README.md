app.js


// const express = require('express');
// const bodyParser = require('body-parser');
// //const router = require('./route/routing');
// //const myErrorLogger = require('./utilities/errorlogger');
// //const myRequestLogger = require('./utilities/requestlogger');
// const setupdb = require("./model/dbsetup")
// const cors = require('cors');
// const app = express();

// app.use(cors());
// app.use(bodyParser.json());
// //app.use(myRequestLogger);
// // app.use('/', router);
// //app.use(myErrorLogger);


// app.get('/setupdb', async (req, res, next) => {
//     try {
//         let data = await setupdb();
//         res.send(data);
//     } catch (err) {
//         next(err);
//     }
// })

// app.listen(2040);
// console.log("Server listening in port 2040");

// module.exports = app;


const express = require('express');
const bodyParser = require('body-parser');
const userRouter = require('./router/routing')
const cors = require("cors")
const create = require('./model/dbsetup')

const app = express();
const errorLogger= require('./utilities/ErrorLogger')
const requestLogger= require('./utilities/RequestLogger')

app.use(cors())
app.use(bodyParser.json());
// to setup the Database
app.get('/setupDb', (req, res, next) => {
    create.setupDb().then((data) => {
        res.send(data)
    }).catch((err) => {
        next(err)
    })
})
app.use(requestLogger)
//app.use('/user', userRouter)

app.use(errorLogger)
console.log("Server listening in port 500");
app.listen(500);


module.exports = app;



connection.js


// const { Schema } = require("mongoose");
// const mongoose = require("mongoose")

// const customerSchema = Schema({
//     customerId: { type: Number, required: true },
//     name: String,
//     purchaseDate: { type: Date, default: new Date() },
//     installationDate: { type: Date, default: new Date() },
//     location: String
// })

// const allocationSchema = Schema({
//     solarHeaterId: { type: Number, required: true, unique: true },
//     distributorName: String,
//     customer: { type: [customerSchema], default: [] }
// }, { collection: "Allocation" })

// let collection = {};

// const EliteSolarDBURL = "mongodb://localhost:27017/Pro";

// let connectionOptions = {
//     useNewUrlParser: true,
//     useUnifiedTopology: true,
//     useCreateIndex: true
// }

// collection.getAllocationData = async () => {
//     try {
//         let database = await mongoose.connect(EliteSolarDBURL, connectionOptions);
//         let allocationModel = await database.model('Allocation', allocationSchema);
//         return allocationModel
//     } catch (error) {
//         let err = new Error("Could not connect to database");
//         err.status = 500;
//         throw err;
//     }
// }

// module.exports = collection; 


const { Schema } = require("mongoose");
const Mongoose = require("mongoose")
Mongoose.Promise = global.Promise;
Mongoose.set('useCreateIndex', true)
const url = "mongodb://localhost:27017/TestMension";
let collection = {}

//user schema 
const userSchema = Schema({
    userId: {
        type: String,
        required: [true, 'Required field'],
        unique: [true, 'Id must be unique']
    },
    name: {
        type: String,
        required: [true, 'Required field'],
        match: [/^[a-zA-Z]+( )*[a-zA-Z]*( )*[a-zA-Z]+$/, 'Please enter a valid name(name should not contain space at end)']
    },
    emailId: {
        type: String,
        minLength: [8, "password should have atleast 8 characters "],
        maxLength: [20, "dont write password overlimit"],
        required: [true, 'Required field'],
        unique: [true, 'Id must be unique'],
        match: [/^[a-z]+[0-9]*@[a-z]+\.([a-z]{2,3})(\.){0,1}([a-z]{0,2})$/, 'Please enter a valid email Id(hint:your@gmail.com)']
    },
    contactNo: {
        type: Number,

        required: [true, 'Required field'],

        match: [/^[6-9][0-9]{9}$/, 'Please enter a valid 10 digit phone number']
    },
    city: {
        type: String
    },
    area: String,
    pincode: {

        type: Number
       
    },
    password:{
        type: String,

        required: [true, 'Required field']

      
    },
     wishlist: []},
     { collection: "User" });


     

collection.getUserCollection = () => {
    return Mongoose.connect(url, { useNewUrlParser: true }).then((database) => {
        return database.model('User', userSchema)
    }).catch(() => {
        let err = new Error("Could not connect to Database");
        err.status = 500;
        throw err;
    })
}



module.exports = collection;



ErrorLogger.js

const fs = require( 'fs' );

let errorLogger = ( err, req, res, next ) => {
    fs.appendFile( './ErrorLogger.txt', err.stack + "\n", ( error ) => {
        if( error ) console.log( "logging error failed" );
    } );
    if( err.status ) res.status( err.status );
    else res.status( 500 );
    res.json( { "message": err.message } )
    next();
}

module.exports = errorLogger;


RequestLogger.js

const fs = require( 'fs' );

let requestLogger = ( req, res, next ) => {
    let logMessage = "" + new Date() + " " + req.method + " " + req.url + "\n";
    fs.appendFile( './RequestLogger.txt', logMessage, ( err ) => {
        if( err ) return next( err );
    } );
    next();

}

module.exports = requestLogger;



