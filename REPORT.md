\# Brutus Brute-Force Mini Lab – Lab Report



\*\*Student:\*\* Sami Wazni

\*\*Course:\*\* KYBS2001 – Introductory Penetration Testing

\*\*Date:\*\* April 17, 2026

\*\*GitHub:\*\* https://github.com/samiwazni/brutus-lab



\---



\## 1 What is This Lab



This mini-lab was built as part of the extra activities assignment for the course. The goal was to build a self-contained environment that demonstrates brute-force credential testing using a modern tool called Brutus.



Brutus is a free, open-source credential testing tool written in Go. It works similarly to Hydra, which was used during the course brute-force assignment, but it is a single binary with no dependencies and supports over 23 protocols. It was built by Praetorian Security and is available at:



https://github.com/praetorian-inc/brutus



The lab has two versions. A vulnerable version where targets run with weak passwords that Brutus can crack, and a secured version where targets run with strong complex passwords that Brutus cannot crack. This shows clearly why password strength matters.



\---



\## 2 What the Lab Contains



The lab tests brute-force attacks against 3 different protocols:



| Protocol | Port | Purpose |

|---|---|---|

| SSH | 2222 | Secure shell remote access |

| FTP | 21 | File transfer protocol |

| MySQL | 3307 | Database server |



All 3 targets run inside Docker containers so the lab is completely self-contained and does not require any existing software on the target machine except Docker.



\---



\## 3 How the Lab Was Built



\### 3.1 Tools and Technologies Used



| Tool | Version | Purpose |

|---|---|---|

| Docker Desktop | 29.3.1 | Running the target containers |

| Git | 2.41.0 | Version control and GitHub upload |

| Brutus | v1.0.2 | Brute-force credential testing |

| Windows PowerShell | – | Running commands |



\### 3.2 Docker Images Used



| Image | Purpose |

|---|---|

| linuxserver/openssh-server | SSH target container |

| garethflowers/ftp-server | FTP target container |

| mysql:5.7 | MySQL target container |



\### 3.3 File Structure



```

brutus-lab/

├── readme.md                    # Main documentation

├── REPORT.md                    # This file

├── setup.sh                     # Downloads Brutus binary

├── run\_vuln.sh                  # Starts vulnerable targets

├── exploit\_test.sh              # Runs Brutus attack

├── run\_secured.sh               # Starts secured targets

├── docker-compose.yml           # Vulnerable environment config

├── docker-compose.secured.yml   # Secured environment config

├── brutus.exe                   # Brutus binary (Windows)

├── targets/

│   ├── ssh/

│   ├── ftp/

│   └── mysql/

└── wordlists/

&#x20;   ├── usernames.txt            # 9 common usernames

&#x20;   └── passwords.txt            # 15 common passwords

```



\---



\## 4 Step by Step – How We Built It



\### Step 1 – Install Requirements



First Docker Desktop was installed from https://www.docker.com/products/docker-desktop/ and Git from https://git-scm.com/. WSL (Windows Subsystem for Linux) also needed to be updated using:



```

wsl --update

```



After updating WSL, Docker Desktop started correctly and showed the containers dashboard.



\### Step 2 – Create Project Structure



The project folder was created with all necessary subdirectories:



```

mkdir brutus-lab

cd brutus-lab

mkdir targets

mkdir targets\\ssh

mkdir targets\\ftp

mkdir targets\\mysql

mkdir wordlists

```



\### Step 3 – Create the Vulnerable Docker Environment



A `docker-compose.yml` file was created to define 3 services with weak passwords:



\- SSH container with username `admin` and password `password123`

\- FTP container with username `ftpuser` and password `ftp123`

\- MySQL container with root password `root123`



These passwords were chosen specifically because they appear in common wordlists, making them easy for Brutus to crack.



\### Step 4 – Create the Secured Docker Environment



A second file `docker-compose.secured.yml` was created with the same 3 services but using strong passwords like `X7!kP#9mQzL2@vR5`. These passwords are long, contain special characters, and are not in any common wordlist.



\### Step 5 – Create Wordlists



Two wordlist files were created manually:



`wordlists/usernames.txt` — 9 common usernames:

```

admin, root, user, ftpuser, dbuser, test, administrator, ubuntu, deploy

```



`wordlists/passwords.txt` — 15 common passwords:

```

123456, password, admin, root, password123, ftp123, dbpass123,

root123, test, letmein, welcome, monkey, dragon, master, qwerty

```



\### Step 6 – Download Brutus



Brutus binary for Windows was downloaded from the GitHub releases page:



https://github.com/praetorian-inc/brutus/releases/latest



The file `brutus-windows-amd64.exe` was downloaded and renamed to `brutus.exe` in the project folder.



\### Step 7 – Start the Vulnerable Targets



The vulnerable containers were started with:



```

docker compose up -d

```



One issue encountered was that MySQL port 3306 was already in use by a local MySQL installation. This was fixed by changing the external port to 3307 in docker-compose.yml.



All 3 containers started successfully as confirmed by Docker Desktop.



\### Step 8 – Run the Brute Force Attack



Brutus was run against each target separately.



\*\*SSH attack:\*\*

```

.\\brutus.exe --target localhost:2222 --protocol ssh -U wordlists\\usernames.txt -P wordlists\\passwords.txt

```



\*\*FTP attack:\*\*

```

.\\brutus.exe --target localhost:21 --protocol ftp -U wordlists\\usernames.txt -P wordlists\\passwords.txt

```



\*\*MySQL attack:\*\*

```

.\\brutus.exe --target localhost:3307 --protocol mysql -U wordlists\\usernames.txt -P wordlists\\passwords.txt

```



\### Step 9 – Start the Secured Targets



The vulnerable containers were stopped and the secured version was started:



```

docker compose down

docker compose -f docker-compose.secured.yml up -d

```



\### Step 10 – Run the Attack Again



The same 3 attacks were repeated against the secured containers.



\---



\## 5 Results



\### 5.1 Vulnerable Version Results



| Protocol | Target | Credentials Found | Time |

|---|---|---|---|

| SSH | localhost:2222 | admin:password123 | 88ms |

| FTP | localhost:21 | ftpuser:ftp123 | 84ms |

| MySQL | localhost:3307 | root:root123 | 20ms |



All 3 weak passwords were cracked successfully. The attacks were very fast because the passwords were near the top of the wordlist.



\### 5.2 Secured Version Results



| Protocol | Target | Credentials Found | Time |

|---|---|---|---|

| SSH | localhost:2222 | None | – |

| FTP | localhost:21 | None | – |

| MySQL | localhost:3307 | None | – |



All 3 attacks returned `Valid: 0`. Brutus tried all 135 combinations (9 usernames × 15 passwords) and found nothing because the strong passwords were not in the wordlist.



\---



\## 6 What the Results Show



The lab clearly demonstrates the difference between weak and strong passwords against a brute-force attack.



When weak common passwords are used, Brutus cracks them almost instantly. The SSH password was found in 88 milliseconds, the FTP password in 84 milliseconds, and the MySQL password in only 20 milliseconds. In a real attack this would mean an attacker gains access before anyone even notices something is wrong.



When strong passwords are used, Brutus tries every combination in the wordlist and finds nothing. This does not mean the service is completely safe — a longer wordlist or a more targeted attack could still work — but it shows that using passwords that do not appear in common lists dramatically reduces the risk.



\---



\## 7 How This Relates to the Course



During the course brute-force assignment, Hydra was used to crack credentials in the DVWA application. The process in this lab is very similar:



\- Both Hydra and Brutus use wordlists of usernames and passwords

\- Both require a valid session or connection to the target

\- Both stop when they find valid credentials



The main difference is that Brutus is a newer tool with zero dependencies, supports more protocols, and outputs results in JSON format which is useful for automation. Hydra is more established and widely used in existing course materials and tutorials.



The lesson from both exercises is the same — weak passwords are a critical vulnerability that can be exploited quickly with freely available tools.



\---



\## 8 Problems Encountered and How They Were Solved



| Problem | Cause | Solution |

|---|---|---|

| Docker Desktop would not start | WSL was outdated | Ran `wsl --update` then restarted Docker |

| MySQL container failed to start | Port 3306 already in use locally | Changed external port to 3307 |

| curl command failed in PowerShell | PowerShell uses different syntax | Used `Invoke-WebRequest` instead |

| Brutus download failed | Network connection dropped | Downloaded manually from browser |



\---



\## 9 Sources and Inspiration



\- Brutus tool and documentation: https://github.com/praetorian-inc/brutus

\- Course brute-force assignment using Hydra (DVWA module)

\- Docker image documentation:

&#x20; - https://hub.docker.com/r/linuxserver/openssh-server

&#x20; - https://hub.docker.com/r/garethflowers/ftp-server

&#x20; - https://hub.docker.com/\_/mysql

\- No code was copied from external sources. The Docker configuration and scripts were written based on the official Docker and Brutus documentation.

