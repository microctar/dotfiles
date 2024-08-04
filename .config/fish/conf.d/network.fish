function create-certificate -d "create self-signed certificate"

    type -f openssl >/dev/null
    or return 255

    argparse -n create-certificate 'e/extfile=+' 'r/rootca=+' 'f/srvcert=+' 'c/config=+' 'd/days=+' -- $argv
    or return 1

    set -lq _flag_config
    and test -f $_flag_config
    or return 2

    set -lq _flag_extfile
    and test -f $_flag_extfile
    or return 3

    set -lq _flag_days
    or set -l _flag_days 180

    set -lq _flag_rootca
    or set -l _flag_rootca cacert

    set -lq _flag_srvcert
    or set -l _flag_srvcert srv

    set -l ca_key (printf "%s.key" $_flag_rootca)
    set -l ca_csr (printf "%s.csr" $_flag_rootca)
    set -l ca_crt (printf "%s.crt" $_flag_rootca)

    set -l srv_key (printf "%s.key" $_flag_srvcert)
    set -l srv_csr (printf "%s.csr" $_flag_srvcert)
    set -l srv_crt (printf "%s.crt" $_flag_srvcert)

    openssl genrsa -out $ca_key 4096
    openssl req -config $_flag_config -key $ca_key -new -out $ca_csr
    openssl req -x509 -new -key $ca_key -out $ca_crt -config $_flag_config -extensions v3_ca -days $_flag_days

    openssl genrsa -out $srv_key 4096
    openssl req -config $_flag_config -key $srv_key -new -out $srv_csr
    openssl x509 -req -CA $ca_crt -CAkey $ca_key -CAcreateserial -extfile $_flag_extfile -in $srv_csr -out $srv_crt -days $_flag_days

end
