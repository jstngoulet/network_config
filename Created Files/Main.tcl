# Create a network Simulator
set ns [new Simulator]

# Open the output files
set f912 [open Node9out12.tr w]
set f914 [open Node9out14.tr w]
set f915 [open Node9out15.tr w]
set f920 [open Node9out20.tr w]
set f923 [open Node9out23.tr w]
set f927 [open Node9out27.tr w]

set f1321 [open Node13out21.tr w]
set f1018 [open Node10out18.tr w]
set f1618 [open Node16out18.tr w]

# Create the nodes (up to 27)
for {set i 0} {$i < 28} {incr i} {
        set $ns$i [$ns node]
}

# Connect the nodes
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

# Create a UDP Connection for each blue
set udp912 [new Agent/UDP]
set udp914 [new Agent/UDP]
set udp915 [new Agent/UDP]
set udp920 [new Agent/UDP]
set udp923 [new Agent/UDP]
set udp927 [new Agent/UDP]
# Attach all the agents to node 9
$ns attach-agent $n9 $udp912
$ns attach-agent $n9 $udp914
$ns attach-agent $n9 $udp915
$ns attach-agent $n9 $udp920
$ns attach-agent $n9 $udp923
$ns attach-agent $n9 $udp927


# Create a TCP Connection for each Green
set tcp1018 [new Agent/TCPSink]
set tcp1618 [new Agent/TCPSink]
# Attach Agents to nodes 13, 16
$ns attach-agent $n18 $tcp1018
$ns attach-agent $n18 $tcp1618

# Now, add 1 CBR (node9) and 1 Loss Monitor(dest) per blue connection

# Add 1 EXP (node 13) and 1 Loss monitor(dest) per red connection

# Create TCP agents and 1 CBR traffic generator at 10 and 16
# And 2 TCPSink traffic Consumerrs at 18 for Green Connections




# Create a CBR traffic source for each of the starting values
$cbr9 set packetSize_ 1500
$cbr9 set interval_ 0.005
$cbr9 set random_ 1

$cbr1016 set packetSize_ 1000
$cbr1016 set interval_ 0.005
$cbr1016 set random_ 1



# Define a 'Finish' procedure
proc finish{}{
  global f912 f914 f915 f920 f923 f927 f1321 f1018 f1618

  # Close the output files
  close $f912
  close $f914
  close $f915
  close $f920
  close $f923
  close $f927

  close $f1321
  close $f1018
  close $f1618

  # Exit the procedure cleanly
  exit 0
}

# Define a procedure that attaches a UDP agent to a previously created node
# 'node' and attaches an Expoo traffic generator to the agent with the
# characteristic values:
#
#   • Size:   packet Size
#   • Burst:  burst time
#   • Idle:   Idle time
#   • Rate:   Burst Peak Rate
#
# The procedure connects the source with the previously defined traffic sink
# 'sink' and returns the source object

proc attach-expoo-traffic
  {node sink size burst idle rate}{
  # Get an instance of the Simulator
  set $ns [Simulator instance]

  # Create a UDP agent and attach it to the node
  set source [new Agent/UDP]
  $ns attach-agent $node $source

  # Create an Expoo traffic agent and set its configuration prarmeters
  set traffic [new Application/Traffic/Exponential]
  $traffic set packetSize_  $size
  $traffic set burst_time_  $burst
  $traffic set idle_time_   $idle
  $traffic set rate_        $rate

  # Attach traffic source tot he traffic generator
  $traffic attach-agent $source

  # Connect the source and the sink
  $ns connect $source $sink

  # Return the traffic
  return $traffic
}

# Define a procedure which peridodically records the bandwidth recieved by the
# three traffic sinks sink0/1/2 and writes it to the 3 files f0/f1/f2.
proc record{}{
  global sink0 sink1 sink2 f0 f1 f2

  #Get an instance of the Simulator
  set $ns [Simulator instance]

  #Set the time after which the procedure should be called upon
  set time 0.5

  # How many bytes have been recieevd by the traffic sinks?
  set bw0 [$sink0 set bytes_]
  set bw1 [$sink1 set bytes_]
  set bw2 [$sink2 set bytes_]

  # Get the current time
  set now [$ns now]

  # Calucluate the bandwidth (in Mb/s) and write it to the files
  puts $f0 "$now [expr $bw0/$time*8/1000000]"
  puts $f1 "$now [expr $bw1/$time*8/1000000]"
  puts $f2 "$now [expr $bw2/$time*8/1000000]"

  # Reset teh bytes_ values on the traffic sinks
  $sink0 set bytes_ 0
  $sink1 set bytes_ 0
  $sink2 set bytes_ 0

  # Re-Schedule the procedure
  $ns at [expr $now+$time] "record"

}

# Create a total of 9 sources
set sink0 [new Agent/LossMonitor]
set sink1 [new Agent/LossMonitor]
set sink2 [new Agent/LossMonitor]
set sink3 [new Agent/LossMonitor]
set sink4 [new Agent/LossMonitor]
set sink5 [new Agent/LossMonitor]
set sink6 [new Agent/LossMonitor]
set sink7 [new Agent/LossMonitor]
set sink8 [new Agent/LossMonitor]

set source0 [attach-expoo-traffic $n9 $sink12 200 2s 1s 100k]
set source1 [attach-expoo-traffic $n9 $sink14 200 2s 1s 100k]
set source2 [attach-expoo-traffic $n9 $sink15 200 2s 1s 100k]
set source3 [attach-expoo-traffic $n9 $sink20 200 2s 1s 100k]
set source4 [attach-expoo-traffic $n9 $sink23 200 2s 1s 100k]
set source5 [attach-expoo-traffic $n9 $sink27 200 2s 1s 100k]
set source6 [attach-expoo-traffic $n13 $sink21 200 2s 1s 100k]
set source7 [attach-expoo-traffic $n10 $sink18 200 2s 1s 100k]
set source8 [attach-expoo-traffic $n16 $sink18 200 2s 1s 100k]

# Start logging the recieevd bandwidth
$ns at 0.0 "record"

# Start the traffic sources
$ns at 10.0 "$source0 start"
$ns at 10.0 "$source1 start"
$ns at 10.0 "$source2 start"

# Start the traffic Sources
$ns at 50.0 "$source0 stop"
$ns at 50.0 "$source1 stop"
$ns at 50.0 "$source2 stop"

# Call the finish procedure after 10 seconds simulation time
$ns at 10.0 "finish"

# Run the simulation
$ns run
