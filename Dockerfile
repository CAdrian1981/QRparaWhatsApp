# Usar una imagen base oficial de Node.js
FROM node:20-slim

# Instalar las dependencias del sistema necesarias para Puppeteer
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    libnss3 \
    libatk-bridge2.0-0 \
    libxcomposite1 \
    libxrandr2 \
    libxdamage1 \
    libgbm1 \
    libasound2 \
    libxshmfence1 \
    libglu1-mesa \
    fonts-liberation \
    libappindicator3-1 \
    xdg-utils \
    libx11-xcb1 \
    libx11-6 \
    libcups2 \
    && rm -rf /var/lib/apt/lists/*

# Descargar e instalar Chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list' \
    && apt-get update \
    && apt-get install -y google-chrome-stable --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Establecer el directorio de trabajo en el contenedor
WORKDIR /app

# Copiar los archivos del proyecto al contenedor
COPY . .

# Instalar las dependencias del proyecto
RUN npm install

# Exponer el puerto en el que correrá la aplicación (3000 es un ejemplo)
EXPOSE 3000

# Establecer la variable de entorno para Puppeteer
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/google-chrome-stable

# Comando para ejecutar la aplicación
CMD ["node", "index.js"]
