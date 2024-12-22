# Arbeidskrav2: Terraform-prosjekt for webserver tilkoblet til database i Azure

Terraform-prosjekt som oppretter en VM med webtjeneste og 2 VM med database i lastbalansering

## Struktur

- **`main.tf`**: Hovedkonfigurasjonsfilen
- **`variables.tf`**: Definerer variabler
- **`variables.tfvars`**: Variabler ment til å endres av bruker
- **`modules/db-install/scripts/`**: Scripts brukt i prosjektet
- **`install_mariadb.sh`**: Installasjon og konfigurering av MariaDB for DB-serverne
- **`playbook.yml`**: Ansible-playbook for konfigurasjon av webserver

## Instruksjoner for oppsett

### Forutsetninger

- Installert [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli).
- Azure-konto med nødvendige rettigheter.
- Installert [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-windows?tabs=azure-cli) og autentisert med `az login`.

### Nedlastning og oppsett

1. **NEDLASTNING**:
- Last ned prosjektet som zip og pakk ut.
2. **HVIS DU VIL GJØRE ENDRINGER**
- Gjør nødvendige endringer i **`variables.tfvars`**
- Endringer som MÅ gjøres manuelt dersom man endrer **`variables.tfvars`**:
  - Linje 6 og 7 i **`modules/db-install/scripts/install_mariadb.sh`** må ha lik verdi som `admin_username` og `admin_password` i **`terraform.tfvars`**
  - Linje 64 og 65 i **`modules/db-install/scripts/playbook.yml`** må ha lik verdi som `admin_username` og `admin_password` i **`terraform.tfvars`**
3. **KJØRE TERRAFORM VIA POWERSHELL**
- Det kan hende at man ikke klarer å logge inn med `az login`, men da følger man instruksjonene som dukker opp i Powershell.
- 1. Åpne powershell
  2. az login
  3. cd <"stien til Terraform-mappen"> 
  4. terraform init -upgrade
  5. terraform plan -out main.tfplan
  6. terraform apply main.tfplan
- Det kan hende at man får en feilmelding relatert til MariaDB installasjon, men da kan man slette ressursene i Azure og prøve å kjøre Terraform på nytt.
- Det kan være at man får beskjed at storage accounten finnes allerede selv om det ligger 0 storage accounts på kontoen. Da må du inn i terraform.tfvars og endre på "install_script_url".
4. **BENYTTE PROSJEKTET**
- Skriv den offentlige IP-adressen som står i `web_vm_public_ip = "<IP-adresse>"` som dukker opp i outputs i en nettleser for å få vise nettsiden som har kontakt med databasen.
  - Det kan hende at det tar litt tid før nettsiden som henter data fra databasen er ferdig satt opp.
- Skriv `terraform output admin_password` for å vise passordet til adminbrukeren.
- For å koble til webserveren via SSH:
  ```powershell
  ssh <admin_username>@<offentlige IP-adressen>
  <admin_username>@<offentlige IP-adressen> password: <admin_password>
  ```
- For å koble til DB-serverne via SSH fra webserver:
  ```powershell
  ssh <admin_username>@<IP-adressen til VM>
  <admin_username>@<IP-adressen til VM> password: <admin_password>
  ```
5. **ELIMINERE RESSURSER ETTER OPPSETT**
- Plan og apply destroy for prosjektet:
  ```powershell
  terraform plan -destroy -out main.destroy.tfplan
  terraform apply main.destroy.tfplan
  ```
