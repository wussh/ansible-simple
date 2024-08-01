list:
	ansible all -i inventory/hosts --list-hosts

ping:
	ansible all -i inventory/hosts -m ping

start:
	ansible-playbook -i inventory/hosts playbook.yaml