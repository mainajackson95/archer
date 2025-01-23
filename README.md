**Archer** 🏹  
*Precision Targeting for Web Reconnaissance*  

---

**Archer** is a modular Bash-based reconnaissance tool designed to streamline the discovery of exposed assets, sensitive files, and hidden attack surfaces using **Wayback Machine** archives. Built for penetration testers, red teams, and security researchers, Archer automates tedious data collection and analysis, turning raw web archives into actionable intelligence.  

---

### **Key Features**  
- 🎯 **Wayback Machine Integration**: Fetch URLs, files, and directories archived over decades.  
- 🔍 **Sensitive Data Hunter**: Automatically scan PDFs for confidential keywords (e.g., *"internal use only"*, *SSNs*, *API keys*).  
- 📂 **Smart File Filtering**: Target high-risk files (PDFs, SQL dumps, configs, backups) using regex patterns.  
- 🗂️ **Organized Output**: Save results to timestamped files in a dedicated `results/` directory.  
- 🚀 **Lightweight & Fast**: Pure Bash—no bloated dependencies.  

---

### **Installation**  
```bash  
git clone https://github.com/mainajackson95/archer.git  
cd archer  
chmod +x archer.sh  
```  

**Dependencies**:  
- `curl`, `jq`, `pdftotext` (install via `sudo apt install curl jq poppler-utils`).  

---

### **Usage**  
```bash  
./archer.sh  

Enter target domain (e.g., example.com): example.com  
Choose your weapon:  
1. Fetch URLs from Wayback Machine  
2. Filter files by extensions (PDF, SQL, Configs, etc.)  
3. Hunt sensitive data in PDFs  
```  

**Example Output**:  
```plaintext  
[+] Results saved to: results/example.com_20231016_143022.txt  
[!] Sensitive data found in: https://example.com/confidential_contract.pdf  
```  

---

### **Why Archer?**  
- **Precision**: Focuses on high-value targets (configs, backups, credentials).  
- **Stealth**: Leverages public archives—no direct interaction with target systems.  
- **Portability**: Runs anywhere Bash is available (Linux/macOS/WSL).  

---

### **Contributing**  
PRs welcome! 🛠️ Ideas for improvements:  
- Add support for **Common Crawl** datasets.  
- Expand keyword lists for sensitive data.  
- Optimize PDF/text extraction.  

--- 

**Take Aim. Strike Smart.** 🏹  
*Find what’s hidden—before the attackers do.*  

---  

![Demo](https://via.placeholder.com/800x400?text=Archer+Terminal+Demo+Here)
