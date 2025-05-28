## 🔍 CyberSecurity Scripting Project Overviews
![No License](https://img.shields.io/badge/license-unlicensed-lightgrey)

### 📂 `dataanalysis-and-sshsecurity`


#### Part 1: Data Analytics with Bash
- Analyzed a CSV file (`cyber.csv`) containing cybersecurity indexes.
- Extracted insights such as:
  - Number of records
  - Countries with best/worst CEI and NCSI values
  - Canada's performance
  - Region-wise index averages using `awk` and loops
- Modularized with separate `.inc` files and executed via `part1.sh`.

#### Part 2: Passwordless SSH & Server Monitoring
- Set up passwordless SSH between Kali and Ubuntu VMs.
- Monitored services, memory usage, and system load.
- Extracted:
  - Number of users and groups
  - Home directory assignments
  - Live system stats using `uptime`, `free`, `systemctl`
- Errors from unreachable servers (e.g., `badserver`) were handled gracefully.

---

### 📂 `webscraping-and-networkscan`

#### Part 1: Python Web Scraper (Douglas College)
- Scraped the Douglas College final exam schedule and course details.
- Generated:
  - A JSON file with cleaned data.
  - An HTML summary using a template.
- Techniques:
  - Used `BeautifulSoup` for scraping and HTML parsing.
  - Managed `rowspan` inconsistencies and performed course lookups via a secondary site.

#### Part 2: Nmap Network Scanning
- Scanned multiple machines (Kali, Ubuntu, Host) for active services.
- Used `nmap` via Python and saved results to CSV.
- Covered SSH, NGINX, MySQL, and more.
- Results were parsed and returned as dictionaries for reuse and logging.

---

### 📂 `powershell-automation`

#### Part 1: System Info with CIM + Module Manifest
- Developed a PowerShell module to:
  - Load disk, memory, OS, and CPU info using CIM.
  - Scan specified TCP ports using `Test-Connection -TcpPort`.
  - Read from both `.json` and `.csv` config files.
- Script features:
  - Auto-load and unload modules.
  - Manifest file with metadata.
  - Output formatted to JSON for easy parsing.

#### Part 2: Caesar Cipher Tool
- Implemented Caesar cipher using PowerShell functions.
- Allowed user input for:
  - Message
  - Rotation (validated to 1–25)
- Displayed encrypted output via custom script logic using character manipulation.

---

## 🛠️ Technologies Used

- **Linux** (Kali, Ubuntu)
- **Bash** scripting
- **Python** (BeautifulSoup, Nmap, CSV, JSON)
- **PowerShell** (Modules, Manifest, CIM, TCP Port Checks)
- **GitLab** for version control
- **Nmap** for network security scanning
- **SSH** for secure remote server access

---

## 🔐 Note

Sensitive details have been anonymized. Replace any placeholder values like `tpa940` or hostnames with your own when replicating these projects in your environment.

---

## 🔒 Disclaimer & License

This repository is intended for **personal portfolio and demonstration purposes only**. It contains solutions to academic assignments that showcase my hands-on skills in scripting, automation, and cybersecurity.

Please note:
- This project is **not open for public contribution or reuse**.
- All code and documentation are based on coursework and should **not be copied or submitted** for academic use.
- Sensitive or identifying details have been anonymized.

If you're a student working on a similar assignment, I strongly encourage you to complete the work independently for your own learning and integrity.
