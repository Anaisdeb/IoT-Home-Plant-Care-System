var express = require('express');
var router = express.Router();
var mongoClient = require("mongodb").MongoClient;

router.get('/', async function(request, response, next) {
    const client = await mongoClient.connect(process.env.mongodb);
    const db = client.db(`HPCSData`);
    const collection = db.collection('Temperature');
    result = await collection.find({}).toArray();
    response.send(JSON.stringify(result));
    await client.close();
});

router.post('/', async function(request, response, next) {
    const client = await mongoClient.connect(process.env.mongodb);
    const db = client.db(`HPCSData`);
    const collection = db.collection('Temperature');
    await collection.insertOne({date: request.body.date, value: request.body.value});
    response.status(201).send("201 - created");
    await client.close();
});

module.exports = router;
