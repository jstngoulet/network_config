# Calculates the delay for connection 9->27

BEGIN {
	highest_packet_id = 0;
}

{
# Note that each $ var signifies a column in the TR file
	action = $1;
	time = $2;
	from = $3;
	to = $4;
	type = $5;
	pktsize = $6;
	flow_id = $8;
	src = $9;
	dst = $10;
	seq_no = $11;
	packet_id = $12;

  # If the source is 9 and the destination is 27,

	if (int(src) == 9 && int(dst) == 27) {

		if (packet_id > highest_packet_id) {
			highest_packet_id = packet_id;
		}

		if (start_time[packet_id] == 0) {
			start_time[packet_id] = time;
		}

		if (action != "d") {
			if (action == "r")
			{
				end_time[packet_id] = time;
			}
			else
			{
				end_time[packet_id] = -1;
			}
		}
	}

}

END {

	for (packet_id = 0; packet_id <= highest_packet_id; packet_id++) {

		start = start_time[packet_id];
		end = end_time[packet_id];
		packet_duration = end - start;

		if (start < end) {
			printf("%f \t %f\n", start, packet_duration) > "9delay.xls";
		}

	}

}
