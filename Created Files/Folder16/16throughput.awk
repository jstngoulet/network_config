# Calculates the average throughput per 0.5 seconds for connection 16->18

BEGIN {
	node = 18;
	time1 = 0.0;
	time2 = 0.0;
	num_packets = 0;
}

{
	action = $1;
	time2 = $2;
	from = $3;
	to = $4;
	type = $5;
	pktsize = $6;
	flow_id = $8;
	src = $9;
	dst = $10;
	seq_no = $11;
	packet_id = $12;

	if (int(src) == 16 && int(dst) == 18) {
		if (time2 - time1 > 0.5) {
			throughput = bytes_counter / (time2 - time1);
			printf("%f \t %f\n", time2, throughput) > "16throughput.xls";
			time1 = $2;
			bytes_counter = 0;
		}

		# If packet was received at destination increment count of packets.
		if (action == "r" && to == node) {
			bytes_counter += pktsize;
			num_packets++;
		}

	}

}
