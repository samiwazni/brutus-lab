\# Brutus Brute-Force Mini Lab



This mini-lab demonstrates brute-force credential testing using

\[Brutus](https://github.com/praetorian-inc/brutus), a modern

Hydra alternative written in Go.



\## What This Lab Does



The lab sets up 3 vulnerable services with weak passwords, then

uses Brutus to crack them. It also includes a secured version

where strong passwords are used to show that Brutus fails.



The 3 protocols tested are:

\- SSH (port 2222)

\- FTP (port 21)

\- MySQL (port 3306)



\## Requirements



\- Docker Desktop (https://www.docker.com/products/docker-desktop/)

\- Git (https://git-scm.com/)

\- Linux or WSL2 on Windows (for running the .sh scripts)



\## How to Run



\### Step 1 - Clone the repo

