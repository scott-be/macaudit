#!/bin/bash

OUTPUT_FILE=out.txt

printf '' > $OUTPUT_FILE

# echo "" $() | tee -a $OUTPUT_FILE

#==============#
# Date of Scan #
#==============#
printf "Date: %s\n" date | tee -a $OUTPUT_FILE

#===============#
# Computer Name #
#===============#
printf "Hostname: %s\n" hostname | tee -a $OUTPUT_FILE

#============#
# OS Version #
#============#
printf "OS Version: %s\n" sw_vers -productVersion | tee -a $OUTPUT_FILE

#================#
# Unique user ID #
#================#
printf "Username: %s\n" whoami | tee -a $OUTPUT_FILE
FULL_NAME=`finger \`whoami\` | awk -F: '{ print $3 }' | head -n1 | sed 's/^ //'`
printf "Full Name: %s\n" $FULL_NAME | tee -a $OUTPUT_FILE

#===================#
# Autologon Enabled #
#===================#
AUTOLOGON_USER=`defaults read /Library/Preferences/com.apple.loginwindow autoLoginUser 2>&1`
	if [ $? -eq 0 ]; then
		printf "Autologon: Enabled with user '%s'\n" $AUTOLOGON_USER | tee -a $OUTPUT_FILE
	else
		printf "AutoLogon: Disbaled\n" | tee -a $OUTPUT_FILE
	fi

#======================#
# Screen Saver Enabled #
#======================#
# echo "Screen Saver:" $(if [ $(defaults -currentHost read com.apple.screensaver idleTime -int) -eq 0 ]; then echo "Disabled"; else echo "Enabled"; fi) | tee -a $OUTPUT_FILE
if [ $(defaults -currentHost read com.apple.screensaver idleTime -int) -eq 0 ]; then
	printf "Screen Saver: Disabled\n" | tee -a $OUTPUT_FILE
else
	printf "Screen Saver: Enabled\n" | tee -a $OUTPUT_FILE
fi


#======================#
# Screen Saver Timeout #
#======================#
printf "Screen Saver Timeout: %s\n" "`defaults -currentHost read com.apple.screensaver idleTime -int`" | tee -a $OUTPUT_FILE

#=================================#
# Screen Saver Password Protected #
#=================================#
printf "Ask For Password: %s\n" "`defaults read com.apple.screensaver askForPassword -int`" | tee -a $OUTPUT_FILE
printf "Ask For Password Delay: %s\n" "`defaults read com.apple.screensaver askForPasswordDelay -int`" | tee -a $OUTPUT_FILE

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
printf "HDD Encryption: %s\n" "`fdesetup status`" | tee -a $OUTPUT_FILE

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

