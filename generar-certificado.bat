@echo off
set /p razon="Razon Social (sin_espacios):"
set /p cuit="Cuit (sin-guiones):"
set /p crtNum="Certificado Numero:"
openssl genrsa -out ClavePrivada_de_%razon%_%crtNum% 2048
cls
type ClavePrivada_de_%razon%_%crtNum%
pause
cls
openssl req -new -key ClavePrivada_de_%razon%_%crtNum% -config openssl.cnf -subj "/C=AR/O=%razon%/CN=fewlines%crtNum%/serialNumber=CUIT %cuit%" -out PedidoCSR_de_%razon%_%crtNum%
type ClavePrivada_de_%razon%_%crtNum%
pause
cls
type PedidoCSR_de_%razon%_%crtNum% | clip
@echo Se copio el certificado al Portapapeles
@echo activalo en la pagina de la afip
@echo luego copia la respuesta de la afip, vuelve a esta ventana y
pause
cls
powershell -command "Get-Clipboard" > Certificado_de_%razon%_%crtNum%.crt
type Certificado_de_%razon%_%crtNum%.crt
pause
cls
openssl pkcs12 -export -out pkcs12_%razon%_%crtNum%.pfx -inkey ClavePrivada_de_%razon%_%crtNum% -in Certificado_de_%razon%_%crtNum%.crt
type pkcs12_%razon%_%crtNum%.pfx
pause
cls
md %razon%
move ClavePrivada_de_%razon%_%crtNum% %razon%\ClavePrivada_de_%razon%_%crtNum%
move PedidoCSR_de_%razon%_%crtNum% %razon%\PedidoCSR_de_%razon%_%crtNum%
move Certificado_de_%razon%_%crtNum%.crt %razon%\Certificado_de_%razon%_%crtNum%.crt
move pkcs12_%razon%_%crtNum%.pfx %razon%\pkcs12_%razon%_%crtNum%.pfx
@echo Su certificado esta en la carpeta /%razon%/*
pause