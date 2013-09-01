	########################################################################
	# Description: This script updates any software made in "django" from  #
	# version 1.4 to version 1.5                                           #
	#                                                                      #
	#                                                                      #
	#                                                                      #
	# Author : Harjot Kaur Mann, harjotmann1992@gmail.com		       #
	# License : GNU General Public License                                 #
	# Copyright: Copyright (c) 2013, Great Developers                      #
	#                                                                      #
	# created : 28-Aug-2013                                                #
	# last update : 31-Aug-2013                                            #
	# VERSION=0.1                                                          #
	#                                                                      #
	########################################################################


	read -p "Enter your system password:" password
	
	dist_path=/usr/local/lib/python2.7/dist-packages
	cp -R $dist_path/django/ Downloads
	cd Downloads
	chmod -R 777 django
	rm -R $dist_path/django
	echo ""
	echo "######################################################"
	echo "#                                                    #"
	echo "# --- CHECKING---Internet Connection ---             #"
	echo "#                                                    #"
	echo "######################################################"
	echo ""

	packet_loss=$(ping -c 5 -q 74.125.236.52 | \
	grep -oP '\d+(?=% packet loss)')

	if [ $packet_loss -le 50 ]
	then
		echo "::::::::::::INTERNET IS WORKING PROPERLY::::::::::::"
		wget https://www.djangoproject.com/m/releases/1.5/Django-1.5.2.tar.gz     
					tar xzvf Django-1.5.2.tar.gz                                            
					cd Django-1.5.2                                                           
					python setup.py install
		cd ..
		cp -R django/contrib/admin/media/ $dist_path/django/contrib/admin/
		cd ..
		cd Automation
		string1=django.views.generic.simple
		string2=django.views.generic
		string3=direct_to_template
		string4=TemplateView
		file=urls.py
		sed -i "s/$string1/$string2/g" $file
		sed -i "s/$string3/$string4/g" $file
		sed -i "s/$string1/$string2/g" report/$file
		sed -i "s/$string3/$string4/g" report/$file
		sed -i "s/$string1/$string2/g" report/$file
		sed -i "s/$string3/$string4/g" registration/backends/default/$file
		sed -i "s/$string1/$string2/g" registration/backends/default/$file
		cd templates
		base=base.html
		noClient=base_noclient.html
		login=registration/login.html
	
		sed -i "s/auth_logout/'auth_logout'/g" $base
		sed -i "s/auth_password_change/'auth_password_change'/g" \
		$base
		sed -i "s/auth_login/'auth_login'/g" $base
		sed -i "s/auth_logout/'auth_logout'/g" $noClient
		sed -i "s/auth_password_change/'auth_password_change'/g" \
		$noClient
		sed -i "s/auth_login/'auth_login'/g" $noClient
		sed -i "s/auth_password_reset/'auth_password_reset'/g" \
		$login
		sed -i "s/registration_register/'registration_register'/g" \
		$login
		sed -i "s/auth_login/'auth_login'/g" registration/activate.html
		sed -i "s/auth_login/'auth_login'/g" \
		registration/activation_complete.html
		sed -i "s/registration_activate/'registration_activate'/g" \
		registration/activation_email.txt
		cd ..
		cd ..
		cd Downloads
		rm -R django
		rm -R Django-1.5.2
		rm -R Django-1.5.2.tar.gz
		/etc/init.d/apache2 restart
		echo "################################################################"
		echo "#                                                              #"
		echo "# Congratulations!! Now you are enjoying django version 1.5.2. #"
		echo "#                                                              #"
		echo "################################################################"
	else
		echo "No internet connection detected."
	fi
