#!/bin/sh

BASEDIR=$(dirname $0)
cd $BASEDIR

mkdir -p scans/`hostname -s` && cd $_
OUTPUT_FILE=`hostname -s`-`date +"%s"`.txt
printf '' > $OUTPUT_FILE

printf "Enter Site Name: "
read SITENAME
printf "Site Name: %s\n" "$SITENAME" >> $OUTPUT_FILE

printf "Enter Description: "
read DESCRIPTION
printf "Description: %s\n" "$DESCRIPTION" >> $OUTPUT_FILE

#==============#
# Date of Scan #
#==============#
echo "Date:" $(date +"%D @ %r") | tee -a $OUTPUT_FILE

#===============#
# Computer Name #
#===============#
echo "Hostname:" $(hostname) | tee -a $OUTPUT_FILE

#============#
# OS Version #
#============#
echo "OS Version:" $(sw_vers -productVersion) | tee -a $OUTPUT_FILE

#================#
# Unique user ID #
#================#
echo "Username:" $(whoami) | tee -a $OUTPUT_FILE
echo "Full Name:" $(finger `whoami` | awk -F: '{ print $3 }' | head -n1 | sed 's/^ //') | tee -a $OUTPUT_FILE

#===================#
# Autologon Enabled #
#===================#
AUTOLOGON_USER=`defaults read /Library/Preferences/com.apple.loginwindow autoLoginUser 2>&1`
	if [ $? -eq 0 ]; then
		printf "Autologon: Enabled (with user '%s')\n" $AUTOLOGON_USER | tee -a $OUTPUT_FILE
	else
		echo "AutoLogon: Disbaled" | tee -a $OUTPUT_FILE
	fi

#======================#
# Screen Saver Enabled #
#======================#
# echo "Screen Saver:" $(if [ $(defaults -currentHost read com.apple.screensaver idleTime -int) -eq 0 ]; then echo "Disabled"; else echo "Enabled"; fi) | tee -a $OUTPUT_FILE
if [ $(defaults -currentHost read com.apple.screensaver idleTime -int) -eq 0 ]; then
	echo "Screen Saver: Disabled" | tee -a $OUTPUT_FILE
else
	echo "Screen Saver: Enabled" | tee -a $OUTPUT_FILE
fi

#======================#
# Screen Saver Timeout #
#======================#
echo "Screen Saver Timeout: $(defaults -currentHost read com.apple.screensaver idleTime -int) Seconds" | tee -a $OUTPUT_FILE

#=================================#
# Screen Saver Password Protected #
#=================================#
echo "Ask For Password:" $(defaults read com.apple.screensaver askForPassword -int) | tee -a $OUTPUT_FILE
echo "Ask For Password Delay:" $(defaults read com.apple.screensaver askForPasswordDelay -int) | tee -a $OUTPUT_FILE

#======================#
# Force Network Logoff #
#======================#


#=========================#
# Minimum Password Length #
#=========================#
echo "Minimum Password Length:" $(pwpolicy get-effective-policy -u $USER | grep -o 'minChars=\d' | cut -d '=' -f2) | tee -a $OUTPUT_FILE

#======================#
# Maximum Password Age #
#======================#
echo "Maximum Password Age:" $(pwpolicy get-effective-policy -u $USER | grep -o 'maxMinutesUntilChangePassword=\d' | cut -d '=' -f2) | tee -a $OUTPUT_FILE

#=================================#
# Historical Passwords Remembered #
#=================================#
echo "Historical Passwords Remembered:" $(pwpolicy get-effective-policy -u $USER | grep -o 'usingHistory=\d' | cut -d '=' -f2) | tee -a $OUTPUT_FILE

#===================#
# Lockout threshold #
#===================#
echo "Lockout threshold:" $(pwpolicy get-effective-policy -u $USER | grep -o 'maxFailedLoginAttempts=\d' | cut -d '=' -f2) | tee -a $OUTPUT_FILE

#=======================#
# Hard Drive Encryption #
#=======================#
echo "HDD Encryption:" $(fdesetup status) | tee -a $OUTPUT_FILE

#================#
# USB Encryption #
#================#


#============================#
# Symantec Antivirus Program #
#============================#


#============================#
# Most Recent AV Definitions #
#============================#


#======================#
# Days Since AV Update #
#======================#


#===================================================#
# Windows Critical Security Patches last applied on #
#===================================================#
system_profiler SPInstallHistoryDataType -xml > ${OUTPUT_FILE%%.*}-installed_software.spx
system_profiler SPInstallHistoryDataType > ${OUTPUT_FILE%%.*}-installed_software.txt

#==================#
# Days since Patch #
#==================#

#=====================#
# External IP Address #
#=====================#
echo "External IP Address:" $(curl -s icanhazip.com) | tee -a $OUTPUT_FILE

#===============#
# Get Interface #
#===============#
INTERFACE=`route get 8.8.8.8 | grep interface | cut -d ':' -f2 | tr -d ' '`
echo "Network Interface:" $INTERFACE | tee -a $OUTPUT_FILE

#=====================#
# Internal IP Address #
#=====================#
echo "Internal IP Address: $(ipconfig getpacket $INTERFACE | grep yiaddr  | cut -d '=' -f2 | tr -d ' ')" | tee -a $OUTPUT_FILE

#=============#
# DHCP Server #
#=============#
echo "DHCP Server: $(ipconfig getpacket $INTERFACE | grep "server_identifier (ip)" | cut -d ':' -f2 | tr -d ' ')" | tee -a $OUTPUT_FILE

#=============#
# MAC Address #
#=============#
echo "MAC Address: $(ipconfig getpacket $INTERFACE | grep chaddr  | cut -d '=' -f2 | tr -d ' ')" | tee -a $OUTPUT_FILE

#================#
# Firewall State #
#================#
echo "Firewall:" $(/usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate) | tee -a $OUTPUT_FILE

#=================#
# System Profiler #
#=================#
read -p "Run System Profiler? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
	system_profiler -detailLevel basic -xml > ${OUTPUT_FILE%%.*}.spx
fi

printf "\e[32;1mSaved file to: \e[35;1m%s\e[0m\n" "$OUTPUT_FILE"
printf "Press [ENTER] to exit."
read