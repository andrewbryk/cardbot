#Pokemon Card Poster
#========================================

	#Automatic scheduling:
	#https://stackoverflow.com/questions/2793389/scheduling-r-script

#Local
#========================================

	#Set metadata
	#====================

		#List of English sets
		setlist <- read.csv("/setlist.csv")

		#Format set names
		set_name <- as.character(setlist[, 1])
		ref_name <- set_name
		set_name <- tolower(set_name)
		set_name <- gsub(x = set_name, pattern = " ", replacement = "")

		#Format set numbers
		set_size <- as.numeric(setlist[, 2])

	#Stretch metadata for each card
	#====================

		#Repeat set name for each card
		fx_name <- function(i, target) { rep(target[i], set_size[i]) }
		cal_set <- unlist(lapply(1:length(set_name), fx_name, target = set_name))
		ref_set <- unlist(lapply(1:length(ref_name), fx_name, target = ref_name))
	
		#Increment set number for each card
		fx_number <- function(i) { 1:set_size[i] }
		cal_number <- unlist(lapply(1:length(set_name), fx_number))

	#Set the project clock
	#====================

		#Get today's date
		today <- as.Date(substr(Sys.time(), start = 1, stop = 10))

		#Get today's card number (across sets)
		project_start <- as.Date("2018-10-01")
		index <- today - project_start + 1

		#Relevant info, pass to `download.file`
		set <- cal_set[index]
		card_no <- cal_number[index]

	#Get today's card
	#====================

		#Make URL & target directory
		target <- paste("https://www.serebii.net/card/", set, "/", card_no, ".jpg", sep = "")
		image_loc <- "tmp.png"

		#Download
		#https://stackoverflow.com/questions/29110903/how-to-download-and-display-an-image-from-an-url-in-r
		download.file(target, image_loc, mode = "wb")

#Twitter
#========================================

	#https://rtweet.info/
	library(rtweet)

	#Handshake
	token <- create_token(
 		app = "everycard",
  		consumer_key = ~~~,
 		consumer_secret = ~~~
 		access_token = ~~~,
 		access_secret = ~~~)

	#Send tweet
	post_tweet(paste(ref_set[index], " no. ", cal_number[index], sep = ""), media = image_loc)


	


	

	
		
