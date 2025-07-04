FROM python:3.10.18-alpine3.22

# Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copia o arquivo de dependências primeiro para aproveitar o cache do Docker.
# Se o requirements.txt não mudar, o Docker reutilizará a camada de cache
# da instalação das dependências, acelerando o build.
COPY requirements.txt ./

# Instala as dependências da aplicação
RUN pip install --no-cache-dir -r requirements.txt

# Copia o restante do código da aplicação para o diretório de trabalho
COPY . .

# Expõe a porta 8000, que é a porta padrão do Uvicorn
EXPOSE 8000

# Comando para executar a aplicação quando o contêiner iniciar.
# O host 0.0.0.0 é usado para que a aplicação seja acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]

