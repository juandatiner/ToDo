const express = require('express');
const cors = require('cors');
const mailgun = require('mailgun-js');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3000;

// Configurar Mailgun
const mg = mailgun({
  apiKey: process.env.MAILGUN_API_KEY,
  domain: process.env.MAILGUN_DOMAIN
});

// Middleware
app.use(cors());
app.use(express.json());

// Almacenamiento temporal de OTPs (en producción usar Redis o DB)
const otpStore = new Map();

// Generar OTP de 6 dígitos
function generateOTP() {
  return Math.floor(100000 + Math.random() * 900000).toString();
}

// Endpoint para enviar OTP
app.post('/send-otp', async (req, res) => {
  const { email } = req.body;

  if (!email) {
    return res.status(400).json({ error: 'Email es requerido' });
  }

  const otp = generateOTP();
  otpStore.set(email, { otp, timestamp: Date.now() });


  // Modo producción: enviar email real
  const data = {
    from: 'Tu App ToDo <noreply@tuapp.com>',
    to: email,
    subject: 'Código de verificación ToDo',
    text: `Tu código de verificación es: ${otp}. Este código expira en 10 minutos.`,
    html: `
      <div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;">
        <h2 style="color: #78BF32;">Código de verificación ToDo</h2>
        <p>Hola,</p>
        <p>Tu código de verificación es:</p>
        <div style="background-color: #f4f4f4; padding: 20px; text-align: center; font-size: 24px; font-weight: bold; margin: 20px 0;">
          ${otp}
        </div>
        <p>Este código expira en 10 minutos.</p>
        <p>Si no solicitaste este código, ignora este mensaje.</p>
      </div>
    `
  };

  try {
    await mg.messages().send(data);
    res.json({ message: 'OTP enviado exitosamente' });
  } catch (error) {
    console.error('Error enviando email:', error);
    res.status(500).json({ error: 'Error enviando OTP' });
  }
});

// Endpoint para verificar OTP
app.post('/verify-otp', (req, res) => {
  const { email, otp } = req.body;

  if (!email || !otp) {
    return res.status(400).json({ error: 'Email y OTP son requeridos' });
  }

  // Modo desarrollo: aceptar cualquier código
  if (process.env.DEV_MODE === 'true') {
    console.log(`🔥 MODO DESARROLLO - OTP aceptado automáticamente para ${email}`);
    return res.json({ message: 'OTP verificado exitosamente (modo desarrollo)' });
  }

  // Modo producción: verificación normal
  const storedData = otpStore.get(email);

  if (!storedData) {
    return res.status(400).json({ error: 'OTP no encontrado o expirado' });
  }

  // Verificar expiración (10 minutos)
  const now = Date.now();
  const diffMinutes = (now - storedData.timestamp) / (1000 * 60);

  if (diffMinutes > 10) {
    otpStore.delete(email);
    return res.status(400).json({ error: 'OTP expirado' });
  }

  if (storedData.otp === otp) {
    otpStore.delete(email);
    res.json({ message: 'OTP verificado exitosamente' });
  } else {
    res.status(400).json({ error: 'OTP inválido' });
  }
});

app.listen(PORT, '0.0.0.0', () => {
  console.log(`Servidor corriendo en puerto ${PORT} (accesible desde red)`);
});