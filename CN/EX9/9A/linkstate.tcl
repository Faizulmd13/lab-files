# Link State Routing Performance - NS2 Simulation (Graph-Only Output)
set ns [new Simulator]
$ns rtproto LS

# Open trace file
set f [open linkstate.tr w]
$ns trace-all $f

# Create 7 nodes
for {set i 0} {$i < 7} {incr i} {
    set n($i) [$ns node]
}

# Connect nodes in a ring topology
for {set i 0} {$i < 7} {incr i} {
    $ns duplex-link $n($i) $n([expr ($i+1)%7]) 1Mb 10ms DropTail
}

# Create UDP agent and CBR traffic
set udp0 [new Agent/UDP]
$ns attach-agent $n(0) $udp0

set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 500
$cbr0 set interval_ 0.005
$cbr0 attach-agent $udp0

set null0 [new Agent/Null]
$ns attach-agent $n(3) $null0
$ns connect $udp0 $null0

# Schedule events (traffic and link up/down)
$ns at 0.5 "$cbr0 start"
$ns rtmodel-at 1.0 down $n(1) $n(2)
$ns rtmodel-at 2.0 up $n(1) $n(2)
$ns at 4.5 "$cbr0 stop"

# Finish procedure for graph plotting
proc finish {} {
    global ns f
    $ns flush-trace
    close $f
    puts "Simulation Completed."
    puts "To plot traffic received at node 3 over time, run these commands:"
    puts {  awk '$1=="r" && $4=="3" {print $2, $6}' linkstate.tr > linkstate.dat }
    puts {  xgraph linkstate.dat -geometry 600x400 & }
    exit 0
}

$ns at 5.0 "finish"
$ns run

