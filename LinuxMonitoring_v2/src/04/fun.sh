. conf.sh

function get_ip() {
    local ip=""
    ip+="$((1+$RANDOM % 255))"
    ip+=".$(($RANDOM % 255))"
    ip+=".$(($RANDOM % 255))"
    ip+=".$(($RANDOM % 255))"
    echo $ip
}

function get_cod() {
    echo "${response_codes[$(($RANDOM % ${#response_codes[@]}))]}"
}

function get_method() {
    echo "${methods[$(($RANDOM % ${#methods[@]}))]}"
}

function get_URL() {
    echo "${URL[$(($RANDOM % ${#URL[@]}))]}"
}

function get_agent() {
    echo "${agents[$(($RANDOM % ${#agents[@]}))]}"
}
