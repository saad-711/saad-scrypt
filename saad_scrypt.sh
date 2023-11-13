#!/bin/bash

# Define colors
purple='\e[0;35m'
nc='\e[0m' # No Color

# Function to display banner
display_banner() {
    echo -e "${purple}"
    figlet "Saad Scrypt"
    echo -e "${nc}"
}

# Function to display public IP
display_public_ip() {
    public_ip=$(curl -s ifconfig.me)
    echo -e "Your Public IP Address: ${public_ip}"
}

# Function to display MAC address
display_mac_address() {
    mac_address=$(ip link show | grep ether | awk '{print $2}')
    echo -e "Your MAC Address: ${mac_address}"
}

# Function to display system information
display_system_information() {
    echo "System Information:"
    uname -a
    echo ""
    echo "CPU Information:"
    lscpu
    echo ""
    echo "Memory Information:"
    free -h
    echo ""
    echo "Disk Space:"
    df -h
}

# Function to list running processes
list_running_processes() {
    echo "Running Processes:"
    ps aux
}

# Function to show disk space
show_disk_space() {
    echo "Disk Space:"
    df -h
}

# Function to check system logs
check_system_logs() {
    echo "System Logs:"
    tail /var/log/syslog
}

# Main menu
while true; do
    display_banner
    
    echo "1. Update system"
    echo "2. Install software"
    echo "3. Enable SSH"
    echo "4. Install Apache"
    echo "5. Enable Network Manager"
    echo "6. Enable Monitor Mode"
    echo "7. Display Public IP"
    echo "8. Display MAC Address"
    echo "9. Display System Information"
    echo "10. List Running Processes"
    echo "11. Show Disk Space"
    echo "12. Check System Logs"
    echo "13. Exit"

    read -p "Enter your choice: " choice

    case $choice in
        1)
            sudo apt update && sudo apt upgrade -y
            ;;
        2)
            read -p "Enter the name of the software to install: " software
            sudo apt install "$software" -y
            ;;
        3)
            sudo systemctl enable ssh
            sudo systemctl start ssh
            echo "SSH enabled and started."
            ;;
        4)
            sudo apt install apache2 -y
            echo "Apache installed."
            ;;
        5)
            sudo systemctl enable NetworkManager
            sudo systemctl start NetworkManager
            echo "Network Manager enabled and started."
            ;;
        6)
            # Assuming wlan0 is your wireless interface, you can modify this based on your system
            sudo airmon-ng start wlan0
            echo "Monitor mode enabled."
            ;;
        7)
            display_public_ip
            ;;
        8)
            display_mac_address
            ;;
        9)
            display_system_information
            ;;
        10)
            list_running_processes
            ;;
        11)
            show_disk_space
            ;;
        12)
            check_system_logs
            ;;
        13)
            echo "Exiting..."
            break
            ;;
        *)
            echo "Invalid choice, please try again."
            ;;
    esac
done
