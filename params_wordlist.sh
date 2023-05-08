#!/bin/bash

input_file="gau_output.txt"
output_file="params_wordlist.txt"

# Extraindo parâmetros das URLs e salvando em um arquivo temporário
grep -oE '[\?&][^=]*=' "$input_file" | sed 's/^[\?&]//; s/=$//' > temp_params.txt

# Removendo duplicatas e salvando no arquivo de saída
sort -u temp_params.txt > "$output_file"

# Removendo o arquivo temporário
rm temp_params.txt

echo "Parâmetros salvos em $output_file"
