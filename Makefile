# ----------------------------------------------------------------------
#
#  Copyright (C) 2013 Juan Ramon Castan Guillen <juanramoncastan@yahoo.es>
#    
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
# ----------------------------------------------------------------------

# ###########      mapping-touchscreen Makefile     ###########################

# Version: 0.0.1

# BUILD = "../package-name_version_architecture" given from "debianizador" script
# or make BUILD="" install to install directly into the system
BUILD = 

PREFIX = /usr
CONFIG_PATH = /etc
BIN_PATH = /bin

SYSTEMD_PATH = /systemd/system
SYSTEMD_SERVICE = mapping-touchscreen.service

UDEV_PATH = /udev/rules.d
UDEV_RULE = 99-mapping-touchscreen.rules

SHARE_PATH = /share

test:
    ifeq ($(BUILD),)
		@ echo "Make will install in the root system"
    else
		@ echo "Extractig in: $(BUILD)"
    endif
	
set-systemd:
	@ mkdir -p  $(BUILD)$(CONFIG_PATH)$(SYSTEMD_PATH)/
	@ sed -i  -e "s|\(ExecStart=\)\(.*\)|\1$(PREFIX)$(BIN_PATH)/mapping-touchscreen|" .$(SYSTEMD_PATH)/$(SYSTEMD_SERVICE)
	@ cp .$(SYSTEMD_PATH)/$(SYSTEMD_SERVICE) $(BUILD)$(CONFIG_PATH)$(SYSTEMD_PATH)
	@ echo "Systemd service \"$(SYSTEMD_SERVICE)\" instaled in \"$(BUILD)$(CONFIG_PATH)$(SYSTEMD_PATH)/\""
	
set-udev:
	@ mkdir -p  $(BUILD)$(CONFIG_PATH)$(UDEV_PATH)/
	@ cp .$(UDEV_PATH)/$(UDEV_RULE) $(BUILD)$(CONFIG_PATH)$(UDEV_PATH)
	@ echo "Udev rules \"$(UDEV_RULE)\" instaled in \"$(BUILD)$(CONFIG_PATH)$(UDEV_PATH)/\""
	
install: test set-systemd  set-udev
	@ mkdir -p  $(BUILD)$(PREFIX)$(BIN_PATH)
	@ cp .$(BIN_PATH)/mapping-touchscreen $(BUILD)$(PREFIX)$(BIN_PATH)
	@ cp .$(BIN_PATH)/get-edid.py $(BUILD)$(PREFIX)$(BIN_PATH)
	@ echo "Executables installed  in \"$(BUILD)$(PREFIX)$(BIN_PATH)/\""
	
uninstall:
	rm $(BUILD)$(PREFIX)$(BIN_PATH)/mapping-touchscreen
	rm $(BUILD)$(PREFIX)$(BIN_PATH)/get-edid.py
	rm $(BUILD)$(CONFIG_PATH)$(SYSTEMD_PATH)/$(SYSTEMD_SERVICE)
	rm $(BUILD)$(CONFIG_PATH)$(LIGHTDM_PATH)/$(LIGHTDM_CONF_FILE)
	rm $(BUILD)$(CONFIG_PATH)$(UDEV_PATH)$(UDEV_RULE)


