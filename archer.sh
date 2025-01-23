#!/bin/bash

echo "Enter a domain (example domain.com):"
read Domain

if [ -z "$Domain" ]; then
    echo "No Domain Provided. Exiting!"
    exit 1
fi

# Generate unique filename with domain and timestamp
FILENAME="${Domain}_$(date +%Y%m%d_%H%M%S).txt"
RESULTS_DIR="results"
mkdir -p "$RESULTS_DIR"  # Create directory if it doesn't exist

echo "Choose your weapon:"
echo "1. Fetch URLs from Wayback Machine"
echo "2. Filter Files by Extensions"
echo "3. Search PDFs for Sensitive Data"
read -p "Enter choice (1/2/3): " choice

case $choice in
    1)
        echo "[+] Fetching URLs to ${RESULTS_DIR}/${FILENAME}..."
        curl -Gs "https://web.archive.org/cdx/search/cdx" \
            --data-urlencode "url=*.$Domain/*" \
            --data-urlencode "collapse=urlkey" \
            --data-urlencode "output=text" \
            --data-urlencode "fl=original" > "${RESULTS_DIR}/${FILENAME}"
        ;;
    2)
        echo "[+] Filtering files to ${RESULTS_DIR}/${FILENAME}..."
        curl -Gs "https://web.archive.org/cdx/search/cdx?url=*.$Domain/*" \
            --data-urlencode "collapse=urlkey" \
            --data-urlencode "output=text" \
            --data-urlencode "fl=original" \
            --data-urlencode "filter=original:.*\.\(xls\|xml\|xlsx\|json\|pdf\|sql\|doc\|docx\|pptx\|txt\|git\|zip\|tar\.gz\|tgz\|bak\|7z\|rar\|log\|cache\|secret\|db\|backup\|yml\|gz\|config\|csv\|yaml\|md\|md5\|exe\|dll\|bin\|ini\|bat\|sh\|tar\|deb\|rpm\|iso\|img\|env\|apk\|msi\|dmg\|tmp\|crt\|pem\|key\|pub\|asc\)$" | tee "${RESULTS_DIR}/${FILENAME}"
        ;;
    3)
        read -p "Enter input file path (from Option 1/2): " input_file
        if [ ! -f "$input_file" ]; then
            echo "Error: File $input_file not found!"
            exit 1
        fi
        echo "[+] Searching PDFs in $input_file..."
        grep -Ea '\.pdf' "$input_file" | while read -r url; do
            curl -s "$url" | pdftotext - - | grep -Esi \
            '(internal use only|confidential|strictly private|personal & confidential|private|restricted|internal|not for distribution|do not share|proprietary|trade secret|classified|sensitive|bank statement|invoice|salary|contract|agreement|non disclosure|passport|social security|ssn|date of birth|credit card|identity|id number|company confidential|staff only|management only|internal only)' \
            && echo "Sensitive data found in: $url";
        done | tee "${RESULTS_DIR}/${Domain}_pdf_analysis_$(date +%H%M%S).txt"
        ;;
    *)
        echo "Invalid choice! Exiting."
        exit 1
        ;;
esac

echo -e "\n[!] Results saved to: ${RESULTS_DIR}/${FILENAME}"
