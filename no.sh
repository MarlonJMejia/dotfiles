#!/bin/bash

install_on_redhat() {
    sudo dnf install -y ansible
}

install_on_ubuntu() {
    sudo apt-get update
    sudo apt-get install -y ansible
}

OS="$(uname -s)"
case "${OS}" in
    Linux*)
        if command -v rpm; then
            install_on_redhat
        elif command -v apt; then
            install_on_ubuntu
        else
            echo "Unsupported Linux distribution"
            exit 1
        fi
        ;;
    Darwin*)
        install_on_mac
        ;;
    *)
        echo "Unsupported operating system: ${OS}"
        exit 1
        ;;
esac

ansible-playbook ~/.bootstrap/setup.yml --ask-become-pass

echo "Ansible installation complete."
