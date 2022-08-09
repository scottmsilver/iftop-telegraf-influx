# iftop-telegraf-influx

Collect iftop metrics and send them via telegraf influx format (and then import them how you like - I use Influx/Grafana)

# To install

 - Clone this repository
 - Install and set-up telegraf if you haven't already.
 - Setup telegraf to output to influx if that is your desired path.
 - Install iftop in the usual way via your favorite package manager.
 - Look at iftop_telegraf.sh and update the interface name - typically your LAN interface -- and the path to iftop. Mine is igb1.
 - Test this by running iftop_telegraf.sh

```
$ ./iftop_telegraf.sh

hosts,sender=236.24.186.35.bc.googleusercontent.com,receiver=nest-driveway-at-street.localdomain sendRate=15200.0,receiveRate=1070000.0
 ```

 - Set up your telegraf.conf with the following (If you're using pfSense you can add this to your "Additional configuration" for Telegraf section.). Update the commands path to the path to your script.
  
```
[[inputs.exec]]
        commands = ["/PATH/TO/iftop_telegraf.sh"]
        timeout = "5s"
        data_format = "influx"
```

 - Now if you're using influx db and grafana you'll see under the "telegraf" database (or however you've configured it a new measurement called "hosts", the rates are bits per second

# To use in Grafana/Influx

- First create a datasource for Telegraf. Telegraf will put the data in a database called "telegraf" which
- Now look for the measurement called "hosts." You can see below for an example query
- The data are in bits per second.
- example InfluxQL query used in Grafana

```
from(bucket: "telegraf")
  |> range(start: v.timeRangeStart, stop: v.timeRangeStop)
  |> filter(fn: (r) => r["_measurement"] == "hosts")
  |> filter(fn: (r) => r["_field"] == "receiveRate")
  |> group(columns: ["receiver"])
  |> aggregateWindow(every: v.windowPeriod, fn: mean, createEmpty: false)
  |> yield(name: "mean")
```

# Example Graph

![Example Dashboard Showing Query](https://raw.githubusercontent.com/scottmsilver/iftop-telegraf-influx/main/Screenshot%202020-10-03%20at%201.17.41%20PM.png)

# Notes

I have tested this on MacOS and FreeBSD (for my pfSense setup)
