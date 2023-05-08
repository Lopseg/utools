#!/bin/bash

# Verifique se o arquivo de entrada foi fornecido
if [ "$#" -ne 1 ]; then
    echo "Uso: $0 arquivo_de_entrada"
    exit 1
fi

arquivo_de_entrada="$1"

# Lista de extensões de arquivo
extensoes=("php" "html" "js" "css" "xml" "json" "sql" "asp" "aspx" "jsp" "cgi" "py" "pl" "rb" "log" "ini" "conf" "sh" "bat" "ps1" "exe" "dll" "jar" "war" "swf" "zip" "tar" "gz" "bz2" "7z" "rar" "pdf" "doc" "docx" "xls" "xlsx" "ppt" "pptx" "rtf" "txt" "csv" "mdb" "accdb" "sqlite" "db" "db3" "yml" "yaml" "htaccess" "htpasswd" "pem" "crt" "key" "bak" "old" "swp" "tmp" "sln" "cs" "csproj" "vb" "vbproj" "java" "class" "config" "properties" "env" "dmp" "idb" "pdb" "psd" "ai")

for extensao in "${extensoes[@]}"; do
    cat "$arquivo_de_entrada" | grep -E "\.${extensao}([?#]|$)" > "urls_${extensao}.txt"
done


diretorio="."

# Encontre arquivos vazios no diretório e os delete
find "$diretorio" -type f -empty -exec rm -f {} \;
