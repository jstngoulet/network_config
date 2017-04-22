BEGIN{
time1 = 0.0;
time2 = 0.0
num_packets = 0;
}

{
  action = $1
  time2 = $2
  destination = $10;
  source = $9;
  pkt_id = $12;
#check source and destination
  if (int(source) == 13 && int(destination) == 21){

    if(time2 - time1 > .5){
      printf("%f \t %f\n", time2, num_packets) > "13sent.xls";
      time1 = time2;
      num_packets = 0
    }

    if(action == "r"&& packet_idAry[pkt_id] == ""){
      num_packets++;
      packet_idAry[pkt_id] = 1;

    }
  }
}
