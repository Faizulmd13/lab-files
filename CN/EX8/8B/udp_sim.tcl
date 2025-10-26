# UDP Performance - NS2 Simulation (Graph-Only)
set ns [new Simulator]

# ---------------------------
# Open trace file
# ---------------------------
set f [open udpout.tr w]
$ns trace-all $f

# ---------------------------
# Create nodes
# ---------------------------
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]

# ---------------------------
# Create duplex links
# ---------------------------
$ns duplex-link $n0 $n2 5Mb 2ms DropTail
$ns duplex-link $n1 $n2 5Mb 2ms DropTail
$ns duplex-link $n2 $n3 1.5Mb 10ms DropTail

# ---------------------------
# Create UDP agents and CBR applications
# ---------------------------
set udp0 [new Agent/UDP]
$ns attach-agent $n0 $udp0
set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 1000
$cbr0 set interval_ 0.01
$cbr0 attach-agent $udp0

set null0 [new Agent/Null]
$ns attach-agent $n3 $null0
$ns connect $udp0 $null0

set udp1 [new Agent/UDP]
$ns attach-agent $n1 $udp1
set cbr1 [new Application/Traffic/CBR]
$cbr1 set packetSize_ 1000
$cbr1 set interval_ 0.01
$cbr1 attach-agent $udp1

set null1 [new Agent/Null]
$ns attach-agent $n3 $null1
$ns connect $udp1 $null1

# ---------------------------
# Start applications
# ---------------------------
$ns at 0.5 "$cbr0 start"
$ns at 0.6 "$cbr1 start"

# ---------------------------
# Finish procedure
# ---------------------------
proc finish {} {
    global ns f
    $ns flush-trace
    close $f
    puts "Simulation Completed."
    puts "You can now generate and view the graph using the following commands:"
    puts "  awk '\$1==\"+\" && \$3==\"0\" {print \$2, \$6}' udpout.tr > flow1.dat"
    puts "  awk '\$1==\"+\" && \$3==\"1\" {print \$2, \$6}' udpout.tr > flow2.dat"
    puts "  paste flow1.dat flow2.dat > udpout.dat"
    puts "  xgraph udpout.dat -geometry 600x400 &"
    exit 0
}

$ns at 10.0 "finish"

# ---------------------------
# Run the simulation
# ---------------------------
$ns run

