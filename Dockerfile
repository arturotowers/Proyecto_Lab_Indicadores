# Imagen base de Python (Linux)
FROM python:3.12-slim

# Evitar archivos .pyc y hacer logs sin buffer
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Carpeta de trabajo dentro del contenedor
WORKDIR /app

# Copiamos solo requirements primero (para aprovechar la cache de Docker)
COPY requirements.txt .

# Instalamos las dependencias
RUN pip install --no-cache-dir -r requirements.txt

# Copiamos el resto del proyecto (incluida la carpeta Notebook/)
COPY . .

# Exponemos el puerto donde correrá Jupyter Lab
EXPOSE 8888

# Comando por defecto: lanzar Jupyter Lab accesible desde el host
# OJO: esto es para uso local; no lo uses así en un servidor público sin seguridad
CMD ["jupyter","lab","--ip=0.0.0.0","--port=8888","--no-browser","--NotebookApp.token=","--NotebookApp.password=","--allow-root"]
