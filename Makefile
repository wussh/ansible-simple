list:
	ansible all -i inventory/hosts --list-hosts

ping:
	ansible all -i inventory/hosts -m ping

user:
	ansible-playbook -i inventory/hosts playbookuser.yaml

start:
	ansible-playbook -i inventory/hosts playbook.yaml