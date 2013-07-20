#!/bin/sh
# postinst for koiskmode

set -e

if [ "$1" = "configure" ]; then
	if ! getent passwd kiosk >/dev/null; then
		adduser --disabled-password --quiet --system \
			--home /home/kiosk --no-create-home --group kiosk \
			--shell /bin/false

		mkdir /home/kiosk
		chown kiosk.kiosk /home/kiosk
	fi

	grep -q "[Seat:0]" "/etc/lightdm/lightdm.conf"
	if [ $? -eq 1 ]; then
		cat >> /etc/lightdm/lightdm.conf << EOT

[Seat:0]
xserver-command=X -nocursor -s 0 -dpms
allow-guest=false
autologin-user=kiosk
autologin-user-timeout=0
autologin-session=kiosk
user-session=kiosk
EOT
	fi
fi

exit 0
