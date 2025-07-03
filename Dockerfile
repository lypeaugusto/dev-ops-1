# 1. Imagem Base
# Usamos uma imagem oficial do Python. A versão 'slim' é mais leve,
# o que resulta em uma imagem Docker final menor.
FROM python:3.10-slim

# 2. Diretório de Trabalho
# Define o diretório de trabalho dentro do container. Todos os comandos
# subsequentes serão executados a partir deste diretório.
WORKDIR /app

# 3. Copiar e Instalar Dependências
# Copiamos o arquivo de dependências primeiro. O Docker armazena em cache
# esta camada. Se o requirements.txt não mudar, o Docker reutilizará o cache,
# acelerando o build em futuras alterações no código.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 4. Copiar o Código da Aplicação
COPY . .

EXPOSE 8000
# 5. Comando para Executar a Aplicação
# Executa a aplicação usando uvicorn. O host 0.0.0.0 torna a aplicação
# acessível de fora do container. O --reload não é usado aqui, pois é
# mais adequado para um ambiente de produção.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]

