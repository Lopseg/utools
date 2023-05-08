#!/bin/bash

# Verificar se os arquivos de entrada foram fornecidos
if [ "$#" -ne 3 ]; then
    echo "Uso: $0 <arquivo_output_gau> <arquivo_parametros> <arquivo_urls_filtradas>"
    exit 1
fi

gau_output_file="$1"
params_file="$2"
filtered_urls_file="$3"

# Limpar o arquivo de URLs filtradas antes de começar
> "$filtered_urls_file"

# Iterar pelos parâmetros e filtrar as URLs
while read -r param; do
    grep -E "[?&]$param=" "$gau_output_file" >> "$filtered_urls_file"
done < "$params_file"

# Remover URLs duplicadas
sort -u -o "$filtered_urls_file" "$filtered_urls_file"

echo "URLs filtradas foram salvas em $filtered_urls_file"
