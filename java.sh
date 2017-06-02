#!/bin/bash
echo "default Install? (No will install all sdk's from jdk.apt.list)"
apt-get install default-jre
select yn in "Yes" "No"; do
	case $yn in
		Yes ) apt-get install default-jdk; break;;
		No ) 	add-apt-repository ppa:webupd8team/java
			while IFS='' read -r line || [[ -n "$line" ]]; do    
	 		apt-get install $line
			done < "jdk.apt.list"
			update-alternatives --config java
	esac
done

apt-get install maven
