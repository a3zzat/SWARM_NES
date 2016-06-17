function set_rosip
{
  RED="$(tput setb 4)"
  GREEN="$(tput setaf 0)$(tput setb 2)"
  BOLD=$(tput bold)
  NOCOLOR=$(tput sgr0)

  {
  ifconfig $1
  } &> /dev/null


  if [ $? -ne 0 ]; then
    echo -e "${RED}Interface ${BOLD}$1${NOCOLOR}${RED} not found! ${BOLD}ROS_IP not set!${NOCOLOR}"
    return 1
  fi

  ip_addr=`ifconfig $1 | grep 'inet addr:' | cut -d: -f2 | awk '{print $1}'`

  if [ -z "$ip_addr" ]; then
    if [ "$3" == "1" ]; then
      echo -e "${RED}Interface ${BOLD}$1${NOCOLOR}${RED} not connected, ${BOLD}ROS_IP not set!${NOCOLOR}"
    fi
    return 1
  fi

  if [ "$2" == "1" ]; then
    echo ${GREEN}ROS_IP set to $1 with IP $ip_addr${NOCOLOR}
  fi


  export ROS_IP=$ip_addr
}
#Tries to get setup ROS_IP in the specified order and stops on the first success ... 
set_rosip wlan0 1 0 || set_rosip eth0 1 1 \
# ||  set_rosip ${anotherinterface} ${printonsuccess} ${printonfail}
