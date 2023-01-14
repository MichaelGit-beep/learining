# Benchmark with FIO
- Random Read/Write Operation Test
When running the test, an 8 GB file will be created. Then fio will read/write a 4KB block (a standard block size) with the 75/25% by the number of reads and writes operations and measure the performance. The command is as follows:
```
apt-get install fio
fio --randrepeat=1 --ioengine=libaio --direct=1 --gtod_reduce=1 --name=fiotest --filename=testfio --bs=4k --iodepth=64 --size=8G --readwrite=randrw --rwmixread=75
```

- Latency test with ioping
```
apt install ioping
ioping -c 20 /tmp
```
The average value is 298.7 us (microseconds), so the average latency in our case is 0.3 ms, that is excellent.
`The latency value can be specified in us (microseconds) or ms (milliseconds). To get a ms value from an us one, divide it by 1,000.`


# Sar
```
sar -u CPU
sar -r MEM
sar -d DISK
sar -h HUMAN
```
- Simmulate write OPS on disk with DD
```
dd if=/dev/zero of=/tmp/test1.img bs=1G count=1 oflag=dsync
Check latency
dd if=/dev/zero of=/tmp/test2.img bs=512 count=1000 oflag=dsync
```


- Check all CPU cores utilization within 1 sec interval
```
sar [option] [interval] [count]
sar -u 1 
```

- get history info
```

```

- Check disk latency(sar - await, iostat - w_await)
```
sar -d [INTERCAL] [COUNT] 
iostat -dx
```
- Check First CPU core utilization within 1 sec interval
```
sar [option] [interval] [count]
sar -P 0 1 
```

# IOstat
- Check disk load by volumes latency etc and see overall CPU utilization,
```
iostat [interval] [count]
iostat 1 10
```

# IOtop
- iotop 
```
navigations with arrows 
```

