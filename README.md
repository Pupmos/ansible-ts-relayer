# Pupmos/ansible-ts-relayer

An Ansible playbook for setting up [ts-relayer](https://github.com/confio/ts-relayer).

## Prerequisites

- [Python3](https://realpython.com/installing-python)
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

_Ideally ansible should be installed via [pip](https://pip.pypa.io/en/stable/), the package installer for python._

## Assumptions

This README assumes that you've already installed `debian` or `ubuntu` onto the target environment/s.

## Setup

1. Install the required git submodule dependencies:

```console
git submodule update --init
```

2. Install the ansible `community.general` collection:

```console
ansible-galaxy collection install community.general
```

3. Rename the `hosts.example` file in `inventory/` to `hosts`:

```console
cp inventory/hosts.example inventory/hosts
```

4. Edit the `inventory/hosts` and add the IP addresses of your relayer node/s.

## ts-relayer

### Setup

To setup a new relayer node:

```console
DD_API_KEY=<dd_api_key> \
PROVIDER=<provider> \
TARGET=<target> \
make setup
```

where:

| Param          | Description                                                                                            | Required |
|----------------|--------------------------------------------------------------------------------------------------------|----------|
| `<dd_api_key>` | The DataDog API key.                                                                                   | `false`  |
| `<provider>`   | The provider being used (`mevspace` or `ovhcloud`).                                                    | `true`   |
| `<target>`     | The IP address of the host to run the playbook against (all hosts will be configured if not provided). | `false`  |

e.g.:

```console
DD_API_KEY=0gD04PXCnLk0CYNHdamJ7lylKs5uMZkJ \
PROVIDER=ovhcloud \
TARGET=1.2.3.4 \
make setup
```

This will provision the host in question with all the necessary packages. To then launch a relayer, see the steps below.

### Launch

To launch a relayer to relay packets between two chains:

```console
REGISTRY_URL=<registry_url> \
SRC=<src_chain_id> \
DEST=<dest_chain_id> \
SRC_CONNECTION=<src_connection> \
DEST_CONNECTION=<dest_connection> \
MNEMONIC='<mnemonic>' \
TARGET=<target> \
make launch
```

where:

| Param               | Description                                                                                            | Required |
|---------------------|--------------------------------------------------------------------------------------------------------|----------|
| `<registry_url>`    | The URL of the `ts-relayer` registry config.                                                           | `true`   |
| `<src_chain_id>`    | The source chain Id (e.g.: `cosmoshub-4`).                                                             | `true`   |
| `<src_connection>`  | The source connection Id (e.g.: `connection-0`).                                                       | `true`   |
| `<dest_connection>` | The destination connection Id (e.g.: `connection-1`).                                                  | `true`   |
| `<mnemonic>`        | The mnemonic phrase of the wallet to use to fund the relaying.                                         | `true`   |
| `<target>`          | The IP address of the host to run the playbook against (all hosts will be configured if not provided). | `false`  |

e.g.:

```console
REGISTRY_URL=https://some.url/to/cosmoshub-4.yml \
SRC=cosmoshub-4 \
DEST=juno-1 \
SRC_CONNECTION=connection-0 \
DEST_CONNECTION=connection-1 \
MNEMONIC='some words that make up my mnemonic' \
TARGET=1.2.3.4 \
make launch
```

This assumes that an existing connection between chains has been established.
