#!/bin/bash

OUTPUT_FILE=out.txt

printf > $OUTPUT_FILE

# echo "" $() | tee -a $OUTPUT_FILE

#==============#
# Date of Scan #
#==============#
echo "Date:" $(date) | tee -a $OUTPUT_FILE

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
		printf "Autologon: Enabled with user '%s'\n" $AUTOLOGON_USER | tee -a $OUTPUT_FILE
	else
		echo "AutoLogon: Disbaled" | tee -a $OUTPUT_FILE
	fi

#======================#
# Screen Saver Enabled #
#======================#
echo "Screen Saver:" $(if [ $(defaults -currentHost read com.apple.screensaver idleTime -int) -eq 0 ]; then echo "Disabled"; else echo "Enabled"; fi) | tee -a $OUTPUT_FILE

#======================#
# Screen Saver Timeout #
#======================#
echo "Screen Saver Timeout:" $(defaults -currentHost read com.apple.screensaver idleTime -int) | tee -a $OUTPUT_FILE

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
# grep for minChars
#	pwpolicy getglobalpolicy # Get global policies.
#	pwpolicy getpolicy # Get policies for a user
#	pwpolicy get-effective-policy # Gets the combination of global and user policies that apply to the user.
#	pwpolicy getglobalhashtypes #Returns a list of password hashes stored on disk by default.
#	pwpolicy gethashtypes # Returns a list of password hashes stored on disk for a user account.

#======================#
# Maximum Password Age #
#======================#
# grep for maxMinutesUntilChangePassword
#	pwpolicy getglobalpolicy # Get global policies.
#	pwpolicy getpolicy # Get policies for a user
#	pwpolicy get-effective-policy # Gets the combination of global and user policies that apply to the user.
#	pwpolicy getglobalhashtypes #Returns a list of password hashes stored on disk by default.
#	pwpolicy gethashtypes # Returns a list of password hashes stored on disk for a user account.

#=================================#
# Historical Passwords Remembered #
#=================================#
# grep for usingHistory
#	pwpolicy getglobalpolicy # Get global policies.
#	pwpolicy getpolicy # Get policies for a user
#	pwpolicy get-effective-policy # Gets the combination of global and user policies that apply to the user.
#	pwpolicy getglobalhashtypes #Returns a list of password hashes stored on disk by default.
#	pwpolicy gethashtypes # Returns a list of password hashes stored on disk for a user account.

#===================#
# Lockout threshold #
#===================#
# grep for maxFailedLoginAttempts
#	pwpolicy getglobalpolicy # Get global policies.
#	pwpolicy getpolicy # Get policies for a user
#	pwpolicy get-effective-policy # Gets the combination of global and user policies that apply to the user.
#	pwpolicy getglobalhashtypes #Returns a list of password hashes stored on disk by default.
#	pwpolicy gethashtypes # Returns a list of password hashes stored on disk for a user account.

#======================#
# Hard Drive Encrypted #
#======================#
echo "HDD Encryption:" $(fdesetup status) | tee -a $OUTPUT_FILE

#===============#
# USB Encrypted #
#===============#


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


#==================#
# Days since Patch #
#==================#

