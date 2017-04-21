#Create a simulator object
set ns [new Simulator]

#Tell the simulator to use dynamic routing
$ns rtproto DV

#Create a trace file
set tracefd [open output.tr w]
$ns trace-all $tracefd


#Define a 'finish' procedure
proc finish {} {
        global tracefd

        # Close the trace file
        close $tracefd

        exit 0
}

#Create 27 nodes
for {set i 0} {$i < 28} {incr i} {
        set ns$i [$ns node]
}
# -------------------------------------------------#

# Link the nodes
# |0|
$ns duplex-link $ns13 $ns0 1Mb 20ms DropTail
$ns duplex-link $ns14 $ns0 1Mb 20ms DropTail
$ns duplex-link $ns15 $ns0 1Mb 20ms DropTail
$ns duplex-link $ns16 $ns0 1Mb 20ms DropTail
# Queue Limits
$ns queue-limit $ns13 $ns0 10
$ns queue-limit $ns14 $ns0 10
$ns queue-limit $ns15 $ns0 10
$ns queue-limit $ns16 $ns0 10

# |1|
$ns duplex-link $ns7 $ns1 1Mb 20ms DropTail
$ns duplex-link $ns8 $ns1 1Mb 20ms DropTail
$ns duplex-link $ns9 $ns1 1Mb 20ms DropTail
$ns duplex-link $ns10 $ns1 1Mb 20ms DropTail
$ns duplex-link $ns11 $ns1 1Mb 20ms DropTail
$ns duplex-link $ns12 $ns1 1Mb 20ms DropTail
# Queue Limits
$ns queue-limit $ns7 $ns1 10
$ns queue-limit $ns8 $ns1 10
$ns queue-limit $ns9 $ns1 10
$ns queue-limit $ns10 $ns1 10
$ns queue-limit $ns11 $ns1 10
$ns queue-limit $ns12 $ns1 10

# |4|
$ns duplex-link $ns17 $ns4 1Mb 20ms DropTail
$ns duplex-link $ns18 $ns4 1Mb 20ms DropTail
$ns duplex-link $ns19 $ns4 1Mb 20ms DropTail
$ns duplex-link $ns20 $ns4 1Mb 20ms DropTail
# Queue Limits
$ns queue-limit $ns17 $ns4 10
$ns queue-limit $ns18 $ns4 10
$ns queue-limit $ns19 $ns4 10
$ns queue-limit $ns20 $ns4 10

# |5|
$ns duplex-link $ns21 $ns5 1Mb 20ms DropTail
$ns duplex-link $ns22 $ns5 1Mb 20ms DropTail
$ns duplex-link $ns23 $ns5 1Mb 20ms DropTail
$ns duplex-link $ns24 $ns5 1Mb 20ms DropTail
# Queue Limits
$ns queue-limit $ns21 $ns5 10
$ns queue-limit $ns22 $ns5 10
$ns queue-limit $ns23 $ns5 10
$ns queue-limit $ns24 $ns5 10

# |6|
$ns duplex-link $ns25 $ns6 1Mb 20ms DropTail
$ns duplex-link $ns26 $ns6 1Mb 20ms DropTail
$ns duplex-link $ns27 $ns6 1Mb 20ms DropTail
# Queue Limits
$ns queue-limit $ns25 $ns6 10
$ns queue-limit $ns26 $ns6 10
$ns queue-limit $ns27 $ns6 10

# Now that the outer nodes are all linked to the next tier, work on the second layer.
# |2|
$ns duplex-link $ns0 $ns2 2Mb 40ms DropTail
$ns duplex-link $ns4 $ns2 2Mb 40ms DropTail
# Queue Limits
$ns queue-limit $ns0 $ns2 15
$ns queue-limit $ns4 $ns2 15

# |3|
$ns duplex-link $ns5 $ns3 2Mb 40ms DropTail
$ns duplex-link $ns6 $ns3 2Mb 40ms DropTail
# Queue Limits
$ns queue-limit $ns5 $ns3 15
$ns queue-limit $ns6 $ns3 15

# Link up all of the middle nodes
# |1|
$ns duplex-link $ns2 $ns1 8Mb 50ms DropTail
$ns duplex-link $ns3 $ns1 8Mb 50ms DropTail
# Queue Limits
$ns queue-limit $ns2 $ns1 20
$ns queue-limit $ns3 $ns1 20

# -------------------------------------------------#
# -------------------------------------------------#
# ------------------- BLUE ------------------------#
# -------------------------------------------------#
# -------------------------------------------------#
# UDP Agents @ node 9 (Blue)
set udp912 [new Agent/UDP]
set udp914 [new Agent/UDP]
set udp915 [new Agent/UDP]
set udp920 [new Agent/UDP]
set udp923 [new Agent/UDP]
set udp927 [new Agent/UDP]

# Attach UDP Agents
$ns attach-agent $ns9 $udp912
$ns attach-agent $ns9 $udp914
$ns attach-agent $ns9 $udp915
$ns attach-agent $ns9 $udp920
$ns attach-agent $ns9 $udp923
$ns attach-agent $ns9 $udp927

# Set flow Ids
$udp912 set fid_ 1
$udp914 set fid_ 2
$udp915 set fid_ 3
$udp920 set fid_ 4
$udp923 set fid_ 5
$udp927 set fid_ 6

# CBR Agents @ node 9
set cbr912 [new Application/Traffic/CBR]
set cbr912 [new Application/Traffic/CBR]
set cbr914 [new Application/Traffic/CBR]
set cbr915 [new Application/Traffic/CBR]
set cbr920 [new Application/Traffic/CBR]
set cbr923 [new Application/Traffic/CBR]
set cbr927 [new Application/Traffic/CBR]

$cbr912 set packetSize_ 1500
$cbr912 set packetSize_ 1500
$cbr914 set packetSize_ 1500
$cbr915 set packetSize_ 1500
$cbr920 set packetSize_ 1500
$cbr923 set packetSize_ 1500
$cbr927 set packetSize_ 1500

$cbr912 set interval_ 0.005
$cbr912 set interval_ 0.005
$cbr914 set interval_ 0.005
$cbr915 set interval_ 0.005
$cbr920 set interval_ 0.005
$cbr923 set interval_ 0.005
$cbr927 set interval_ 0.005

$cbr912 set random_ 1
$cbr912 set random_ 1
$cbr914 set random_ 1
$cbr915 set random_ 1
$cbr920 set random_ 1
$cbr923 set random_ 1
$cbr927 set random_ 1

$cbr912 attach-agent $udp912
$cbr912 attach-agent $udp912
$cbr914 attach-agent $udp914
$cbr915 attach-agent $udp915
$cbr920 attach-agent $udp920
$cbr923 attach-agent $udp923
$cbr927 attach-agent $udp927

# Loss Monitors
set lossMon12 [new Agent/LossMonitor]
set lossMon14 [new Agent/LossMonitor]
set lossMon15 [new Agent/LossMonitor]
set lossMon20 [new Agent/LossMonitor]
set lossMon23 [new Agent/LossMonitor]
set lossMon27 [new Agent/LossMonitor]

$ns attach-agent $ns12 $lossMon12
$ns attach-agent $ns14 $lossMon14
$ns attach-agent $ns15 $lossMon15
$ns attach-agent $ns20 $lossMon20
$ns attach-agent $ns23 $lossMon23
$ns attach-agent $ns27 $lossMon27

# Connect traffic syncs for blue connections
$ns connect $udp912 $lossMon12
$ns connect $udp914 $lossMon14
$ns connect $udp915 $lossMon15
$ns connect $udp920 $lossMon20
$ns connect $udp923 $lossMon23
$ns connect $udp927 $lossMon27

# -------------------------------------------------#
# ------------------ End BLUE ---------------------#
# -------------------------------------------------#

# -------------------------------------------------#
# -------------------------------------------------#
# ------------------- RED -------------------------#
# -------------------------------------------------#
# -------------------------------------------------#
# UDP Agent
set udp1321 [new Agent/UDP]
$udp1321 set fid_ 7
$ns attach-agent $ns13 $udp1321

# EXP Traffic Generator
set exp1321 [new Application/Traffic/Exponential]

# Set provided vars
$exp1321 set packetSize_ 200
$exp1321 set burst_time_ 0.5s
$exp1321 set idle_time_ 0.5s
$exp1321 set rate_ 1000000

# Attach the udp agent and the exp generator
$exp1321 attach-agent $udp1321

# Loss Generator
set lossMon21 [new Agent/Null]
$ns attach-agent $ns21 $lossMon21

# Connect Traffic Syncs for red connections
$ns connect $udp1321 $lossMon21


# -------------------------------------------------#
# ------------------ End RED ----------------------#
# -------------------------------------------------#

# -------------------------------------------------#
# -------------------------------------------------#
# ------------------- GREEN -----------------------#
# -------------------------------------------------#
# -------------------------------------------------#
# Create a new TCP agent
set tcp1018 [new Agent/TCP]
set tcp1618 [new Agent/TCP]

# Set the TCP Agent to class 2
$tcp1018 set class_ 2
$tcp1618 set class_ 2

# Attach the agent
$ns attach-agent $ns10 $tcp1018
$ns attach-agent $ns16 $tcp1618

# Create a new TCP Sink Traffic for Green
set sink1 [new Agent/TCPSink]
set sink2 [new Agent/TCPSink]

# Attacth teh TCP Sink agents
$ns attach-agent $ns18 $sink1
$ns attach-agent $ns18 $sink2

# Connect the TCP agent tot eh sink agent
$ns connect $tcp1018 $sink1
$ns connect $tcp1618 $sink2

# Create CBR Traffic Generator
set cbr1018 [new Application/Traffic/CBR]
set cbr1618 [new Application/Traffic/CBR]

# Set the packsize to given
$cbr1018 set packetSize_ 1000
$cbr1618 set packetSize_ 1000

# Set the interval to given
$cbr1018 set interval_ 0.005
$cbr1618 set interval_ 0.005

# Set the Random to Given
$cbr1018 set random_ 1
$cbr1618 set random_ 1

# Attach the TCP Agent to the CBR Agent
$cbr1018 attach-agent $tcp1018
$cbr1618 attach-agent $tcp1618

#Connect traffic syncs for green connections
$ns connect $tcp1018 $sink1
$ns connect $tcp1618 $sink2

# Set the flow ID incrementally
$tcp1018 set fid_ 8
$tcp1618 set fid_ 9


# -------------------------------------------------#
# ------------------ End GREEN --------------------#
# -------------------------------------------------#

# Start all events
#Time 1
$ns at 1.0 "$cbr912 start"
$ns at 1.0 "$cbr914 start"
$ns at 1.0 "$cbr915 start"
$ns at 1.0 "$cbr920 start"
$ns at 1.0 "$cbr923 start"
$ns at 1.0 "$cbr927 start"

#Time 2
$ns at 2.0 "$exp1321 start"

#Time 3
$ns at 3.0 "$cbr1018 start"

#Time 4
$ns at 4.0 "$cbr1618 start"

#Time 6 - Link 1-3 Goes down
$ns rtmodel-at 6.0 down $ns1 $ns3

#Time 7 - Link 1-3 Goes back up
$ns rtmodel-at 7.0 up $ns1 $ns3

#Time 10
$ns at 10.0 "finish"

#Run the simulation
$ns run
