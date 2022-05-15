wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip > /dev/null 2>&1
unzip ngrok-stable-linux-amd64.zip > /dev/null 2>&1
read -p "Paste authtoken here https://dashboard.ngrok.com/get-started/your-authtoken (Copy and Ctrl+V to paste then press Enter): " CRP
./ngrok authtoken $CRP
echo region us, eu, au, ap, sa, jp, in.
read -p "region: " region
nohup ./ngrok tcp -region $region 5900 &>/dev/null &
mkdir win11
cd win11
echo update
sudo apt update -y > /dev/null 2>&1
sudo apt-get install unrar
echo install qemu
sudo apt install qemu-system-x86 curl -y > /dev/null 2>&1
echo install mint iso
wget https://cdn-125.anonfiles.com/X4a0Ifg0yc/187ca35d-1652629517/Tiny11%20by%20Harbour%20of%20Tech.iso
echo making disk
qemu-img create win11.vdi 100G
echo Your VNC IP Address:
curl --silent --show-error http://127.0.0.1:4040/api/tunnels | sed -nE 's/.*public_url":"tcp:..([^"]*).*/\1/p'
sudo qemu-system-x86_64 -cdrom Tiny11 by Harbour of Tech.iso -vnc :0 -hda win11.vdi -smp cores=5 -m 10000M -machine usb=on -device usb-tablet > /dev/null 2>&1
