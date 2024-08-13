const { Client } = require('whatsapp-web.js');
const express = require('express');
const qrcode = require('qrcode-terminal');

const app = express();
app.use(express.json());

const client = new Client();

client.on('qr', (qr) => {
    qrcode.generate(qr, { small: true });
    console.log('Escanea este código QR con tu WhatsApp');
});

client.on('ready', () => {
    console.log('Cliente está listo');
});

client.initialize();

app.post('/webhook', (req, res) => {
    const { number, message } = req.body;

    client.sendMessage(`${number}@c.us`, message).then(response => {
        res.status(200).json({
            status: 'success',
            data: response
        });
    }).catch(err => {
        res.status(500).json({
            status: 'error',
            message: err.message
        });
    });
});

module.exports = app;
