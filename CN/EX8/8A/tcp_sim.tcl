# EX8_TCP_NS2_XGRAPH.tcl
# TCP performance simulation for NS2
# Produces tcpout.dat directly readable by xgraph

set ns [new Simulator]

# Nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]

# Links (bandwidth, delay)
$ns duplex-link $n0 $n2 5Mb 2ms DropTail
$ns duplex-link $n1 $n2 5Mb 2ms DropTail
$ns duplex-link $n2 $n3 1.5Mb 10ms DropTail

# Agents
set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]

$ns attach-agent $n0 $tcp
$ns attach-agent $n3 $sink
$ns connect $tcp $sink

# FTP application
set ftp [new Application/FTP]
$ftp attach-agent $tcp

# Open output file for xgraph (time, throughput)
set f [open tcpout.dat w]

# Packet counting variable
set bytes_total 0

# Procedure to record throughput every 0.1s
proc record_throughput {ns sink f bytes_total} {
    set now [$ns now]
    set received [$sink set bytes_]
    set delta [expr {$received - $bytes_total}]
    set throughput [expr {$delta*8/0.1}] ;# bits/sec
    puts $f "$now $throughput"
    set bytes_total $received
    $ns at [expr {$now + 0.1}] "record_throughput $ns $sink $f $bytes_total"
}

# Initialize packet counting at time 0
$ns at 0.0 "record_throughput $ns $sink $f 0"

# Start and stop simulation
$ns at 0.2 "$ftp start"
$ns at 2.0 "$ftp stop"
$ns at 2.1 "finish"

proc finish {} {
    global ns f
    $ns flush-trace
    close $f
    puts "Simulation finished. Plot tcpout.dat with xgraph."
    exec xgraph tcpout.dat -geometry 600x400 &
    exit 0
}

# Run simulation
$ns run

