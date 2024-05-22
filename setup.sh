#!/usr/bin/env bash

set -e

show_usage() {
  echo "Usage: $(basename $0) takes exactly 1 argument (install | uninstall)"
}

if [ $# -ne 1 ]
then
  show_usage
  exit 1
fi

check_env() {
  if [[ -z "${RALPM_TMP_DIR}" ]]; then
    echo "RALPM_TMP_DIR is not set"
    exit 1
  
  elif [[ -z "${RALPM_PKG_INSTALL_DIR}" ]]; then
    echo "RALPM_PKG_INSTALL_DIR is not set"
    exit 1
  
  elif [[ -z "${RALPM_PKG_BIN_DIR}" ]]; then
    echo "RALPM_PKG_BIN_DIR is not set"
    exit 1
  fi
}

install() {
  sudo snap install bluez

  echo "This package provides the following commands:
  - bluez.bluetoothctl: Interactive bluetooth control tool
  - bluez.btmgmt: A command-line interface of BlueZ for management
  - bluez.hciattach: Attach serial devices via UART HCI to BlueZ stack
  - bluez.hcidump: hcidump utility allows the monitoring of Bluetooth activity
  - bluez.meshctl: Bluetooth mesh control tool
  - bluez.sdptool: Control and interrogate SDP servers
  - bluez.btattach: Attach serial devices to BlueZ stack
  - bluez.btmon: Bluetooth monitor
  - bluez.hciconfig: Configure Bluetooth devices
  - bluez.hcitool: Configure Bluetooth connections
  - bluez.obexctl: A command-line interface of BlueZ for OBEX (file transfer)"
}

uninstall() {
  sudo snap remove bluez
}

run() {
  if [[ "$1" == "install" ]]; then 
    install
  elif [[ "$1" == "uninstall" ]]; then 
    uninstall
  else
    show_usage
  fi
}

check_env
run $1