# Hashicorp Vault HA + Consul + HAProxy

Implementação em docker das ferramentas Hashicorp Vault em HA (vault_s1, vault_s2, vault_s3) utilizando storage backend Consul (consul_s1, consult_s2, etc).

Consult agent dos vaults foram montado em containers separados, porém a idéia na implementação final é que fiquem no mesmo servidor.

# Cenário

![enter image description here](https://i.imgur.com/d6ELesR.png)

## Utilização inicial

Depois de clonar o repositório, inicie os containers através do comando *docker-compose up --build.*

O cluster de servers Consul pode ser consultado através dos comandos abaixo:

    vault_ha$ sudo docker exec vault_ha_consul_s1_1 consul members
    Node       Address           Status  Type    Build   Protocol  DC   Partition  Segment
    consul_s1  10.1.42.101:8301  alive   server  1.13.1  2         dc1  default    <all>
    consul_s2  10.1.42.102:8301  alive   server  1.13.1  2         dc1  default    <all>
    consul_s3  10.1.42.103:8301  alive   server  1.13.1  2         dc1  default    <all>
    consul_s4  10.1.42.104:8301  alive   server  1.13.1  2         dc1  default    <all>
    consul_s5  10.1.42.105:8301  alive   server  1.13.1  2         dc1  default    <all>
    consul_c1  10.1.42.10:8301   alive   client  1.13.1  2         dc1  default    <default>
    consul_c2  10.1.42.11:8301   alive   client  1.13.1  2         dc1  default    <default>
    consul_c3  10.1.42.12:8301   alive   client  1.13.1  2         dc1  default    <default>

    vault_ha$ sudo docker exec vault_ha_consul_s1_1 consul operator raft list-peers
    Node       ID                                    Address           State     Voter  RaftProtocol
    consul_s1  bb072ba0-1f4b-15da-e062-3d68555b604d  10.1.42.101:8300  leader    true   3
    consul_s2  9f489bdf-4486-1474-a2b5-3a40823b9206  10.1.42.102:8300  follower  true   3
    consul_s3  cd84fb6a-723c-fbaf-9d74-807558a101d0  10.1.42.103:8300  follower  true   3
    consul_s4  e34c269f-188b-145d-f971-bfc1f0d82734  10.1.42.104:8300  follower  true   3
    consul_s5  6636b66b-1bf6-6460-44d6-bf7e70770fae  10.1.42.105:8300  follower  true   3

O HAProxy está redirecionando a porta 8080 para 8200 dos Vault Servers, sendo que eles precisam estar iniciados e unsealed para que funcione.

## Material de referência

https://learn.hashicorp.com/tutorials/vault/ha-with-consul
https://learn.hashicorp.com/tutorials/vault/reference-architecture
https://www.vaultproject.io/docs/concepts/ha
https://www.vaultproject.io/docs/configuration/storage/consul
