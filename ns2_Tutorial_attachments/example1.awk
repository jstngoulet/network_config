BEGIN {
   node = 1;
   time1 = 0.0;
   time2 = 0.0;
   num_packets = 0;
}

{
   time2 = $2;

   if (time2 - time1 > 0.05) {
      throughput = bytes_counter / (time2 - time1);
      printf("%f \t %f\n", time2, throughput) > "example1.xls";
      time1 = $2;
      bytes_counter = 0;
   }

   if ($1 == "r" && $4 == node && $5 == "cbr") {
      bytes_counter += $6;
      num_packets++;
   }
}

END {
   print("********");
   printf("Total number of packets received: \n%d\n", num_packets);
   print("********");
}

