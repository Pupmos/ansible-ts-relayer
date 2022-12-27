DD_API_KEY?=''
TARGET_OPTS?=

ifdef TARGET
	TARGET_OPTS = '-l $(TARGET)'
endif

setup:
	@ansible-playbook -i inventory/hosts -e 'target=relayer dd_api_key=$(DD_API_KEY) provider=$(PROVIDER)' $(TARGET_OPTS) setup.yml

launch:
	@ansible-playbook -i inventory/hosts -e 'target=relayer container_name=$(CHAIN_ID) registry_url=$(REGISTRY_URL) src=$(SRC) dest=$(DEST) src_connection=$(SRC_CONNECTION) dest_connection=$(DEST_CONNECTION) mnemonic="$(MNEMONIC)"' $(TARGET_OPTS) launch.yml
