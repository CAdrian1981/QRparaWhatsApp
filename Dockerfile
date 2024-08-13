# Usar una imagen base de Node.js con Puppeteer preconfigurado
FROM ghcr.io/puppeteer/puppeteer:latest

# Establecer el directorio de trabajo en el contenedor
WORKDIR /app

# Copiar los archivos del proyecto al directorio de trabajo del contenedor
COPY . .

# Instalar las dependencias del proyecto
RUN npm install

# Exponer el puerto en el que correrá la aplicación (3000 es un ejemplo)
EXPOSE 3000

# Comando para ejecutar la aplicación
CMD ["node", "index.js"]
