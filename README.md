# Networking Project

## Spring 2017

### Project README Documentation

#### Author: Justin Goulet

--------------------------------------------------------------------------------

## Introduction

The Networking project was more difficult than I thought it to be. After spending numerous hours on the project, I was able to complete it rather successfully. Please read the information about my project below.

## Instructions

The project comes with a compressed folder, specifically, a .zip. This folder is named Goulet.ZIP, since I was the only person in my group. Within the folder, you will see a hierarchy of files:

> Folder9:

> - .AWK files
> - .XLS files

> Folder10

> - .AWK files
> - .XLS files

> Folder13

> - .AWK files
> - .XLS files

> Folder16

> - .AWK files
> - .XLS files

> Backup Charts (Reason Below)

> - Folder9/*.xls
> - Folder10/*.xls
> - Folder13/*.xls
> - Folder16/*.xls

Within each folder, the documents are pretty straight forward, as they comply with the limits of this assignment.

You will notice, however, that within the parent directory, their are a few more files. Their brief descriptions are below:

> MainTopography.TCL

> - Main TCL file for this project. Creates and manages connections in this network simulation.

> output.tr

> - The output from running the command 'ns MainTopography.TCL' in the command line

> run_me.sh

> - A Shell Script I created that allowed me to build all of the excel files at once. This enabled multiple tests to be run without needing to run the gawk command for each file, each time. Instructions in own section below.

> This file

> - You are reading it.

### Script Instructions

If you wish to use the script, please note what it does. The script "run_me.sh" is a script that runs each awk file within each child directory in my project. If you wish to use it, or read it, here are some things you might need to do:

#### Change the Permissions

Due to the nature of it being a script, you may need to modify the permissions to make it executable. To do this, navigate to the directory it's in (this project's parent) and run 'chmod a+x run_me.sh'

#### Read / Run

To read the script, before you run it, simply enter 'cat run_me.sh'. This will allow the script to be displayed within your command window.

To run the script, enter './run_me.sh'. This will run the script and display the output on the console window.

The new Excel Files have been created. Any existing files - with charts have been replaced.

#### Backup Charts

If you just ran the script, you will notice that their aren't any charts in the excel documents. There used to be, prior to running the above script. In order to play it safe, I added another folder that just contained the excel spreadsheets - with graphs. I maintained the same file configuration as the main project's, but kept an additional copy of these documents.

### En Toto

That is all for now!

Created By    | Last Modified
------------- | --------------
Justin Goulet | April 21, 2017
