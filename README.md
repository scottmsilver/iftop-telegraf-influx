# iftop-telegraf
Collect iftop metrics and send them via telegraf format (and then import them how you like

# To install

 - Clone this repository
 - Look at iftop_telegraf.sh and update the interface name.
 - Test this by running iftop_telegraf.sh
 - Should look like this

```
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
 