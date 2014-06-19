CourseProject
=============

Assignment for "Getting and Cleaning data"

Well, English isn't my mother language so I'm gonna give my best so you can understand me.
My script doesn't need the Samsung data in the working directory, but it needs an Internet connection so it can download it.
My script 

* Lines [3-4] It downloads the data file.

* Lines [6-13] It extracts the data files, then it reads them.
* Line 14: It unlinks the temporal file
* Lines [16-18] Merges the training and test sets (First step)
* Lines [21-28] Deletes data.frames that we don't need anymore
* Lines [31-34] Removes all not-mean-nor-std columns. First it extracts the name of all columns from the features.txt file. Then it uses "grep" to identify the target columns. Saves the dataset using the first two columns (id, activity) and the target columns
* Lines [38-43]
