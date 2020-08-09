OPTION=$1

case $OPTION in

    list) 
        iptables -L -n -t nat 
    ;;

    add) 
        IP_ORIGIN=$2
        PORT_ORIGIN=$3
        IP_DESTINATION=$4
        PORT_DESTINATION=$5

        COMMAND="iptables -t nat -A PREROUTING -d $IP_ORIGIN -p tcp --dport $PORT_ORIGIN -j DNAT --to $IP_DESTINATION:$PORT_DESTINATION"
        echo $COMMAND
        $COMMAND

        COMMAND="iptables -t nat -A POSTROUTING -d $IP_DESTINATION -p tcp --dport $PORT_DESTINATION -j SNAT --to $IP_ORIGIN"
        echo $COMMAND
        $COMMAND
    ;;

    rm) 
        IP_ORIGIN=$2
        PORT_ORIGIN=$3
        IP_DESTINATION=$4
        PORT_DESTINATION=$5

        COMMAND="iptables -t nat -D PREROUTING -d $IP_ORIGIN -p tcp --dport $PORT_ORIGIN -j DNAT --to $IP_DESTINATION:$PORT_DESTINATION"
        echo $COMMAND
        $COMMAND

        COMMAND="iptables -t nat -D POSTROUTING -d $IP_DESTINATION -p tcp --dport $PORT_DESTINATION -j SNAT --to $IP_ORIGIN"
        echo $COMMAND
        $COMMAND
    ;;

esac
