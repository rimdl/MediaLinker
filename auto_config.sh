CONFIG_EMBY_NETWORK="${EMBY_NETWORK:-172.17.0.1}"
CONFIG_EMBY_PORT="${EMBY_PORT:-8096}"
CONFIG_EMBY_APIKEY="${EMBY_APIKEY:-None}"
CONFIG_OPENLIST_NETWRK="${OPENLIST_NETWRK:-172.17.0.1}"
CONFIG_OPENLIST_PORT="${OPENLIST_PORT:-5244}"
CONFIG_OPENLIST_APIKEY="${OPENLIST_SPIKEY:-None}"
CONFIG_OPENLIST_PUB_URL="${OPENLIST_PUB_URL:-}"
CONFIG_MOUNT_PATH="${MOUNT_PATH:-['/mnt']}"
CONFIG_OPENLIST_SIGN_ENABLE="${OPENLIST_SIGN_ENABLE:-false}"
CONFIG_OPENLIST_EXPIRE_TIME="${OPENLIST_EXPIRE_TIME:-0}"

emby_ip_address=$(ping -c 1 $EMBY_NETWORK | sed -n 's/^PING[^(]*(\([^)]*\)).*/\1/p')
openlist_ip_address=$(ping -c 1 $OPENLIST_NETWRK | sed -n 's/^PING[^(]*(\([^)]*\)).*/\1/p')

cat << EOF | cat - /opt/constant.js > temp.txt && mv temp.txt /opt/constant.js
const embyHost = "http://$emby_ip_address:$CONFIG_EMBY_PORT";
const embyApiKey = "$CONFIG_EMBY_APIKEY";
const mediaMountPath = $CONFIG_MOUNT_PATH;
const alistAddr = "http://$openlist_ip_address:$CONFIG_OPENLIST_PORT";
const alistToken = "$CONFIG_OPENLIST_APIKEY";
const alistSignEnable = $CONFIG_OPENLIST_SIGN_ENABLE;
const alistSignExpireTime = $CONFIG_OPENLIST_EXPIRE_TIME;
const alistPublicAddr = "$CONFIG_OPENLIST_PUB_URL";
EOF