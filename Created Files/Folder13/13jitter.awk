#This program is used for calculating the jitter

BEGIN{
  #Initialize
  highest_packet_id = 0;
}
{

action = $1;

time = $2;

from = $3;

to = $4;

type = $5;

pktsize = $6;

source = $9;

destination = $10;

seq_no = $11;

packet_id = $12;

#check source and destination

  if ( packet_id > highest_packet_id ) {

  highest_packet_id = packet_id;

  }


  #Record the transmission time

  if ( start_time[packet_id] == 0 ) {

  # Record the sequence number

  pkt_seqno[packet_id] = seq_no;

  start_time[packet_id] = time;

  }

  #Record the receiving time for CBR (flow_id=2)
if(int(source) == 13 && int(destination) == 21){
  if ( action != "d" ) {

  if ( action == "r" ) {

  end_time[packet_id] = time;

  }

} else {
  end_time[packet_id] = -1;
}
}
}

END {
  last_seqno = 0;
  last_delay = 0;
  seqno_diff = 0;
  for( packet_id = 0; packet_id <= highest_packet_id; packet_id++ ){
    start = start_time[packet_id];
    end = end_time[packet_id];
    packet_duration = end - start;

    if(start < end){
      seqno_diff = pkt_seqno[packet_id] - last_seqno;
      delay_diff = packet_duration - last_delay;
      if(seqno_diff == 0){
        jitter = 0;

      }
      else{
        jitter = delay_diff/seqno_diff
      }
      printf("%f \t %f\n", start, jitter) > "13jitter.xls";
      last_seqno = pkt_seqno[packet_id];

      last_delay = packet_duration;
    }

  }

}
