sudo adduser krish
su - krish
sudo apt install mailutils -y
mail --version
sudo su
cd
vim main.cf
postmap sasl_passwd
chmod 600 sasl_passwd*
echo "test mail" | mail -s "test subject" email@email.com
