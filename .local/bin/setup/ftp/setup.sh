sudo pacman -S vsftpd
sudo cp ./vsftpd.conf /etc/vsftpd.conf
sudo echo "ftpuser" >> /etc/vsftpd.user_list
cd
sudo useradd -m ftpuser
sudo passwd ftpuser
sudo chmod 770 /home/ftpuser/
sudo usermod -a -G ftpuser $(echo $USER)
ln -s ../ftpuser/ ftp
sudo systemctl enable --now vsftpd
echo "Please re-login to end setup of vsftpd server"
