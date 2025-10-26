set ns [new Simulator]
$ns rtproto LS

# Trace file for graph analysis
set f [open linkstate.tr w]
$ns trace-all $f

# Create 8 nodes as n(1) to n(8)
for {set i 1} {$i <= 8} {incr i} {
    set n($i) [$ns node]
}

# Octagon links using array indices
$ns duplex-link $n(1) $n(2) 1Mb 10ms DropTail
$ns duplex-link $n(2) $n(3) 1Mb 10ms DropTail
$ns duplex-link $n(3) $n(4) 1Mb 10ms DropTail
$ns duplex-link $n(4) $n(5) 1Mb 10ms DropTail
$ns duplex-link $n(5) $n(6) 1Mb 10ms DropTail
$ns duplex-link $n(6) $n(7) 1Mb 10ms DropTail
$ns duplex-link $n(7) $n(8) 1Mb 10ms DropTail
$ns duplex-link $n(8) $n(1) 1Mb 10ms DropTail

# UDP agent and CBR application from node 1 to node 4
set udp0 [new Agent/UDP]
$ns attach-agent $n(1) $udp0

set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 500
$cbr0 set interval_ 0.005
$cbr0 attach-agent $udp0

set null0 [new Agent/Null]
$ns attach-agent $n(4) $null0
$ns connect $udp0 $null0

# Event scheduling
$ns at 0.5 "$cbr0 start"
$ns rtmodel-at 1.0 down $n(3) $n(4)
$ns rtmodel-at 2.0 up $n(3) $n(4)
$ns at 4.5 "$cbr0 stop"

# Optional labels
$ns at 0.0 "$n(1) label Source"
$ns at 0.0 "$n(4) label Destination"

# Finish + graph analysis instructions
proc finish {} {
    global ns f
    $ns flush-trace
    close $f
    puts "Simulation Completed. To plot received traffic at node 4:"
    puts {  awk '$1=="r" && $4=="4" {print $2, $6}' linkstate.tr > n4.dat }
    puts {  xgraph n4.dat -geometry 600x400 & }
    exit 0
}

$ns at 5.0 "finish"
$ns run

