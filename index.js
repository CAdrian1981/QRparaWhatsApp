const { Client, LocalAuth } = require('whatsapp-web.js');
const qrcode = require('qrcode-terminal');
const express = require('express');

const app = express();
app.use(express.json());

const client = new Client({
    authStrategy: new LocalAuth()
});

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

// No se especifica el puerto directamente, Vercel lo maneja
module.exports = app;
