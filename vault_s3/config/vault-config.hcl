listener "tcp" {
    address          = "0.0.0.0:8200"
    cluster_address  = "10.1.42.203:8201"
    tls_disable      = "true"
}

storage "consul" {
    address = "10.1.42.12:8500"
    path    = "vault/"
}

api_addr =  "http://10.1.42.203:8200"
cluster_addr = "http://10.1.42.203:8201"
ui = "true"