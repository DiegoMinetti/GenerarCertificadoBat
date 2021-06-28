@echo off
set /p razon="Razon Social (sin_espacios):"
set /p cuit="Cuit (sin-guiones):"
openssl genrsa -out %razon%.key 1024
openssl req -new -key %razon%.key -subj "/C=AR/O=%razon%/CN=certificado1/serialNumber=CUIT %cuit%" -out %razon%.csr
pause