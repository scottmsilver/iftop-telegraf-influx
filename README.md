# iftop-telegraf-influx
Collect iftop metrics and send them via telegraf influx format (and then import them how you like - I use Influx/Grafana)

# To install

 - Clone this repository
 - Install telegraf if you haven't already.
 - Install iftop in the usal way via your favorite package manager.
 - Look at iftop_telegraf.sh and update the interface name - typically your LAN interface -- and the path to iftop. Mine is igb1.
 - Test this by running iftop_telegraf.sh

```
$ ./iftop_telegraf.sh

hosts,sender=236.24.186.35.bc.googleusercontent.com,receiver=nest-driveway-at-street.localdomain sendRate=15200.0,receiveRate=1070000.0
 ```

 - Set up your telegraf.conf with the following (If you're using pfSense you can add this to your "Additional configuration" for Telegraf section.)
  
```
[[inputs.exec]]
        commands = ["/PATH/TO/iftop_telegraf.sh"]
        timeout = "5s"
        data_format = "influx"
```

 - Now if you're using influx db and grafana you'll see under the "telegraf" database (or however you've configured it a new measurement called "hosts", the rates are bits per second
 

# Notes

I have tested this on MacOS and FreeBSD (for my pfSense setup)
