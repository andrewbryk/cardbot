#Pokemon Card Poster
#========================================

	#Automatic scheduling:
	#https://stackoverflow.com/questions/2793389/scheduling-r-script

#Local
#========================================

	#Set metadata
	#====================

		#List of English sets
		setlist <- read.csv("C:/Users/abryk/Desktop/Hobby/PTCG/cardbot/setlist.csv")

		#Format set names
		set_name <- as.character(setlist[, 1])
		ref_name <- set_name #For the tweet
		set_name <- tolower(set_name)
		set_name <- gsub(x = set_name, pattern = " ", replacement = "")

		#Format set numbers
		unique_cards <- as.numeric(setlist[, 2]) #Total number of cards in set
		official_cards <- as.numeric(setlist[, 4]) #Revealed number of cards
		numbered_cards <- as.numeric(setlist[, 3]) #Cards using X/Y scheme

		#Make dummy list of HX card numbers
		HX <- paste("H", 1:50, sep = "")

	#Stretch metadata for each card
	#====================

		#Generic function to repeat elements
		fx_name <- function(i, target) { rep(target[i], unique_cards[i]) }

		#Set names
		set_url <- unlist(lapply(1:length(set_name), fx_name, target = set_name))
		set_ref <- unlist(lapply(1:length(set_name), fx_name, target = ref_name))

		#Set totals
		card_official <- unlist(lapply(1:length(set_name), fx_name, target = official_cards))
	
		#Card numbers for URL
		fx_number <- function(i) { 

			if(numbered_cards[i] == numbered_cards[i]) { 1:numbered_cards[i] } else { #Broken in order to avoid hitting cross-set numbering
				c(1:numbered_cards[i], tolower(HX[1:(unique_cards[i] - numbered_cards[i])])) }

		}


		card_url <- unlist(lapply(1:length(set_name), fx_number))

		#Card numbers for post
		card_tweet <- card_url
		tmp_logic <- substr(card_tweet, start = 1, stop = 1) == "h"
		card_tweet[tmp_logic] <- "unsequenced"
		card_tweet[!tmp_logic] <- paste(card_tweet[!tmp_logic], card_official[!tmp_logic], sep = "/")

	#Set the project clock
	#====================

		#Get today's date
		today <- as.Date(substr(Sys.time(), start = 1, stop = 10))

		#Get today's card number (across sets)
		project_start <- as.Date("2018-10-02")
		index <- today - project_start + 1		

	#Get today's card
	#====================

		#Make URL & target directory
		target <- paste("https://www.serebii.net/card/", set_url[index], "/", card_url[index], ".jpg", sep = "")
		image_loc <- "C:/Users/abryk/Desktop/Hobby/PTCG/cardbot/tmp.png"

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
  		consumer_key = "~~~",
 		consumer_secret = "~~~",
 		access_token = "~~~",
 		access_secret = "~~~")

	#Send tweet
	post_tweet(paste(ref_set[index], " no. ", card_tweet[index], sep = ""), media = image_loc)


	


	

	
		
