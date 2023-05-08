#!/bin/bash

# 1. Ler o arquivo com as URLs (output do gau)
input_file="gau_output.txt"

# 2. Filtrar URLs duplicadas com protocolos diferentes e manter apenas as com protocolo HTTPS
awk -F "://" '{print $2}' "$input_file" | sort -u | awk '{print "https://" $0}' > "https_only.txt"

# 3. Filtrar pelas extensões discutidas acima e armazenar em um arquivo separado
grep -Ei "\.js$|\.php$|\.asp$|\.aspx$|\.jspx$|\.html$|\.htm$|\.svg$" "https_only.txt" > "filtered_extensions.txt"

# 4. Filtrar pelos top 10000 parâmetros mais vulneráveis de bug bounty
grep -Ei "(\?|&)(id|username|password|email|key|api|token|auth|user|account|session|credential|config|setting|redirect|path|file|input|data|upload|command|request|report|query|search|item|product|order|cart|view|mode|action|process|event|filter|id)[^&]*=" "filtered_extensions.txt" > "filtered_parameters.txt"

# 5. Executar o httpx neste arquivo de URLs filtradas sem a opção -follow-redirects e armazenar o output em um arquivo separado
httpx -l "filtered_parameters.txt" -status-code -content-length -title -tech-detect -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3" > "httpx_output.txt"

# 6. Ler este arquivo separado (output do httpx) e separar as URLs por código de status HTTP em um diretório chamado URLS-OUTPUT
mkdir -p "URLS-OUTPUT"
awk '/\[20[0-9]{1}\]/{ print $2 >> "URLS-OUTPUT/2xx.txt" } /[30[1-8]{1}\]/{ print $2 >> "URLS-OUTPUT/3xx.txt" } /[4[0-9]{2}\]/{ print $2 >> "URLS-OUTPUT/4xx.txt" } /[5[0-9]{2}\]/{ print $2 >> "URLS-OUTPUT/5xx.txt" }' "httpx_output.txt"

# Limpar arquivos temporários
rm https_only.txt filtered_extensions.txt filtered_parameters.txt
