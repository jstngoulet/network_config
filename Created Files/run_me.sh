#!/bin/bash
#
# @Author:        Justin Goulet
# @Date-Created:  April 21, 2017
# @Purpose:       Create xls files using tr files within the project directory
#
# This program dows all the hard work for you.
# Just run once and you will see items appear as they occur.
#
#
# To make it simpler, I could have used a simpler, recursive command.
# I did it this way to ensure the folder structure was as requested

# Node 9
echo "Creating xls files in Folder9"
cd Folder9

gawk -f 9delay.awk ../output.tr
echo "•••••••••••••••••••••••••••••••• > DELAY"
gawk -f 9throughput.awk ../output.tr
echo "•••••••••••••••••••••••••••••••• > THROUGHPUT"
gawk -f 9jitter.awk ../output.tr
echo "•••••••••••••••••••••••••••••••• > JITTER"
gawk -f 9sent.awk ../output.tr
echo "•••••••••••••••••••••••••••••••• > SENT"
gawk -f 9received.awk ../output.tr
echo "•••••••••••••••••••••••••••••••• > RECIEVED"
gawk -f 9dropped.awk ../output.tr
echo "•••••••••••••••••••••••••••••••• > DROPPED"

echo "Completed."

echo ""

# Node 10
echo "Creating xls files in Folder10"
cd ..
cd Folder10
gawk -f 10throughput.awk ../output.tr
echo "•••••••••••••••••••••••••••••••• > THROUGHPUT"
echo "Completed."

echo ""

# Node 13
echo "Creating xls files in Folder13"
cd ..
cd Folder13

gawk -f 13delay.awk ../output.tr
echo "•••••••••••••••••••••••••••••••• > DELAY"
gawk -f 13throughput.awk ../output.tr
echo "•••••••••••••••••••••••••••••••• > THROUGHPUT"
gawk -f 13jitter.awk ../output.tr
echo "•••••••••••••••••••••••••••••••• > JITTER"
gawk -f 13sent.awk ../output.tr
echo "•••••••••••••••••••••••••••••••• > SENT"
gawk -f 13recieved.awk ../output.tr
echo "•••••••••••••••••••••••••••••••• > RECIEVED"
gawk -f 13dropped.awk ../output.tr
echo "•••••••••••••••••••••••••••••••• > DROPPED"
echo "Completed."

echo ""

# Node 16
echo "Creating xls files in Folder16"
cd ..
cd Folder16

gawk -f 16throughput.awk ../output.tr
echo "•••••••••••••••••••••••••••••••• > THROUGHPUT"
echo "Completed."

echo ""
