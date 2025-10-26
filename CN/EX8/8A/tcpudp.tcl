# TCP/UDP Performance Simulation using NS2
set ns [new Simulator]

# Define colors for NAM trace
$ns color 0 Blue
$ns color 1 Red
$ns color 2 Yellow

# Create nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]

# Open trace files
set f [open tcpout.tr w]
$ns trace-all $f
set nf [open tcpout.nam w]
$ns namtrace-all $nf

# Create duplex links
$ns duplex-link $n0 $n2 5Mb 2ms DropTail
$ns duplex-link $n1 $n2 5Mb 2ms DropTail
$ns duplex-link $n2 $n3 1.5Mb 10ms DropTail

# Set link orientation (for NAM visualization)
$ns duplex-link-op $n0 $n2 orient right-up
$ns duplex-link-op $n1 $n2 orient right-down
$ns duplex-link-op $n2 $n3 orient right
$ns duplex-link-op $n2 $n3 queuePos 0.5

# TCP Agent and Sink
set tcp [new Agent/TCP]
$tcp set class_ 1
set sink [new Agent/TCPSink]

# Attach TCP agent to node n1, sink to n3
$ns attach-agent $n1 $tcp
$ns attach-agent $n3 $sink

# Connect TCP and sink
$ns connect $tcp $sink

# FTP Application
set ftp [new Application/FTP]
$ftp attach-agent $tcp

# Schedule events
$ns at 1.2 "$ftp start"
$ns at 1.35 "$ns detach-agent $n1 $tcp ; $ns detach-agent $n3 $sink"
$ns at 3.0 "finish"

# Finish procedure
proc finish {} {
    global ns f nf
    $ns flush-trace
    close $f
    close $nf
    puts "Running nam.."
    exec nam tcpout.nam &
    exit 0
}

# Set finish event
$ns at 3.0 "finish"
$ns run

