# Brutus Brute-Force Mini Lab

A self-contained lab environment for demonstrating brute-force credential testing using [Brutus](https://github.com/praetorian-inc/brutus), a modern Hydra alternative written in Go.

Built as part of KYBS2001 – Introductory Penetration Testing course extra activities assignment.

---

## What This Lab Does

The lab sets up 3 services running inside Docker containers with weak passwords. Brutus is then used to crack those passwords automatically. A secured version of the same lab is also included where strong passwords are used, showing that Brutus finds nothing.

This demonstrates clearly why password strength matters against brute-force attacks.

---

## Protocols Tested

| Protocol | Port | Vulnerable Password | Secured Password |
|---|---|---|---|
| SSH | 2222 | password123 | X7!kP#9mQzL2@vR5 |
| FTP | 21 | ftp123 | Yh3$nW8@qK5!mJ2x |
| MySQL | 3307 | root123 | Zp6#tR9@wN4!kM7y |

---

## Requirements

- [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- [Git](https://git-scm.com/)
- Windows, macOS, or Linux

---

## Quick Start

### Step 1 – Clone the repository

```
git clone https://github.com/samiwazni/brutus-lab.git
cd brutus-lab
```

### Step 2 – Download Brutus binary

**Linux / macOS:**

```
chmod +x setup.sh
./setup.sh
```

**Windows (PowerShell):**

Download `brutus-windows-amd64.exe` from the link below and rename it to `brutus.exe`, then place it in the project folder.

```
https://github.com/praetorian-inc/brutus/releases/latest
```

---

## Running the Vulnerable Lab

### Step 1 – Start the vulnerable targets

**Linux / macOS:**

```
./run_vuln.sh
```

**Windows:**

```
docker compose up -d
```

Wait about 15 seconds for all containers to start.

### Step 2 – Run the brute force attack

**Linux / macOS:**

```
./exploit_test.sh
```

**Windows:**

```
.\brutus.exe --target localhost:2222 --protocol ssh -U wordlists\usernames.txt -P wordlists\passwords.txt
```

```
.\brutus.exe --target localhost:21 --protocol ftp -U wordlists\usernames.txt -P wordlists\passwords.txt
```

```
.\brutus.exe --target localhost:3307 --protocol mysql -U wordlists\usernames.txt -P wordlists\passwords.txt
```

### Expected Output

```
[+] VALID: ssh   admin:password123  @ localhost:2222
[+] VALID: ftp   ftpuser:ftp123     @ localhost:21
[+] VALID: mysql root:root123       @ localhost:3307
```

All 3 weak passwords are cracked successfully.

---

## Running the Secured Lab

### Step 1 – Switch to secured targets

**Linux / macOS:**

```
./run_secured.sh
```

**Windows:**

```
docker compose down
docker compose -f docker-compose.secured.yml up -d
```

### Step 2 – Run the same attacks again

```
.\brutus.exe --target localhost:2222 --protocol ssh -U wordlists\usernames.txt -P wordlists\passwords.txt
```

```
.\brutus.exe --target localhost:21 --protocol ftp -U wordlists\usernames.txt -P wordlists\passwords.txt
```

```
.\brutus.exe --target localhost:3307 --protocol mysql -U wordlists\usernames.txt -P wordlists\passwords.txt
```

### Expected Output

```
Results Summary
  Valid:     0
  Invalid:   135
  Total:     135
```

Brutus finds nothing because the strong passwords are not in any wordlist.

---

## Results Summary

| Protocol | Vulnerable Version | Secured Version |
|---|---|---|
| SSH | Cracked in 88ms | Not found |
| FTP | Cracked in 84ms | Not found |
| MySQL | Cracked in 20ms | Not found |

---

## Stopping the Lab

```
docker compose down
```

---

## File Structure

```
brutus-lab/
├── readme.md                    <- This file
├── REPORT.md                    <- Full lab report
├── setup.sh                     <- Downloads Brutus (Linux/macOS)
├── run_vuln.sh                  <- Starts vulnerable targets
├── exploit_test.sh              <- Runs Brutus attack
├── run_secured.sh               <- Starts secured targets
├── docker-compose.yml           <- Vulnerable environment
├── docker-compose.secured.yml   <- Secured environment
├── brutus.exe                   <- Brutus binary (Windows)
├── targets/
│   ├── ssh/
│   ├── ftp/
│   └── mysql/
└── wordlists/
    ├── usernames.txt            <- 9 common usernames
    └── passwords.txt            <- 15 common passwords
```

---

## Troubleshooting

**Docker Desktop will not start**
Run `wsl --update` in PowerShell then restart Docker Desktop.

**MySQL port conflict**
If port 3306 is already in use on your machine, the lab uses port 3307 instead. This is already configured in the docker-compose files.

**Brutus download fails in PowerShell**
Use `Invoke-WebRequest` instead of `curl`, or download manually from the browser.

**SSH attack shows connection errors**
This is normal for the secured version. Errors mean the wrong password was rejected. `Valid: 0` is the important result.

---

## How It Relates to the Course

During the course brute-force assignment, Hydra was used to crack credentials in DVWA. This lab extends that concept using Brutus across 3 real network protocols instead of a web form. The core idea is the same, automated credential testing using wordlists, but applied to SSH, FTP, and MySQL which are common services in real networks.

---

## Sources

- Brutus: https://github.com/praetorian-inc/brutus
- Docker images used: linuxserver/openssh-server, garethflowers/ftp-server, mysql:5.7
- Course: KYBS2001 – Introductory Penetration Testing
- Inspiration: Course brute-force assignment using Hydra and DVWA
