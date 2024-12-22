location            = "Norway East" # Sett til en passenge lokasjon
resource_group_name = "minRessursgruppe1" # Sett et passende navn
admin_username      = "adminuser" # Sett til et passende brukernavn (må endres til lik verdi i playbook.yml og install_mariadb.sh, se README)
admin_password = "Passord123" # Sett til et passende passord (må endres til lik verdi i playbook.yml og install_mariadb.sh, se README)

# VM-størrelser
web_vm_size = "Standard_B1s"
db_vm_size  = "Standard_B1ms"
install_script_url = "mariadbinstall6"

# Nettverk
vnet_name = "vnet" # Navnet på det virtuelle nettverket
address_space = ["10.0.0.0/16"] # Bytt til det som skal brukes
db_subnet_prefix = "10.0.0.0/24" # Bytt til det som skal brukes
web_subnet_prefix = "10.0.1.0/24" # Bytt til det som skal brukes

# VM
web_vm_name = "web-server"
/*web_script_url = "https://mariadbinstall.blob.core.windows.net/play/playbook.yml"*/
vm_count = 2
db_vm_name = "db-server"
/*db_script_url = "https://mariadbinstall.blob.core.windows.net/install/install_mariadb.sh"*/