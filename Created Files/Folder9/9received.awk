BEGIN{
timet1 = 0.0;
time2 = 0.0;
num_packets = 0;
}

{
  action = $1
  time2 = $2
  destination = $10;
  source = $9;
#check source and destination
  if (int(source) == 9 && int(destination) == 27){

    if(time2 - time1 > .5){
      printf("%f \t %f\n", time2, num_packets) > "9received.xls";
      time1 = time2;
      num_packets = 0
    }
    if(action == "r"&& $4 == destination){
      #if packet arrived at destination increment num of packets
      num_packets++;

    }
  }
}
