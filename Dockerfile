FROM node:21-slim

# Atualiza o npm
RUN npm install -g npm@latest --loglevel=error

# Define diretório de trabalho
WORKDIR /usr/src/app

# Copia os arquivos do backend
COPY package*.json ./
COPY server.js ./

# Instala dependências do backend
RUN npm install --loglevel=error

# Copia o frontend
COPY client ./client

# Instala dependências do frontend e builda o React
RUN cd client && npm install --loglevel=error && npm run build

# Move o build do React para uma pasta acessível
RUN mv client/build ./frontend-build

# Exponha a porta do backend (ajuste se for diferente)
EXPOSE 8080

# Inicia o backend
CMD ["npm", "start"]
