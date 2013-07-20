#!/bin/sh
# Postrm for kioskmode

set -e

if [ "$1" = "purge" ]; then
	deluser --quiet --system kiosk > /dev/null || true
	rm -fr /home/kiosk
fi

exit 0
