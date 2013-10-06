#assume there is an object
conversation = []

# also assume there is jquery

$(document).ready -> buidpage()

buidpage = () -> 

#	bindClickEvents()
	transition()
	setAndBindPageSizes()


transition = () -> 

	$("#firstButton").delay(2000)
					 .fadeTo(200, 0)
					 .delay(200)
					 .fadeTo(0, 0, askWhichFriend)
###	$(".welcome").removeClass("initial")
				 .addClass("move")
				 .delay(1800)
				 .addClass("second")
###

askWhichFriend = () -> 

	$("#firstButton").text("Please select a conversation...")
					 .delay(1000)
					 .fadeTo(300, 1)
					 .delay(2000)

	$.get("/allFriends", buildFriends)


	$(".ninja").removeClass("hidden")	

	buildFriends = (Friends) ->

		console.log Friends

		build = (friend) -> 

			$friend = $("<div/>", class: "friend", id: "#{friend.name}")
			$pic = $("<img/>", class: "friendPIC", src: "#{friends.pic_square}")
			$name = $("<div/>", class: "friendNAME", text: "#{friend.name}")
			$mostRecent = $("<div/>", class: "FmostRECENT", text: "#{friend.mostRecent}")
			$friend.append($pic).append($name).append($mostRecent)

		for friend in Friends
			$(".FRIENDS").append( build(friend) )


	return null
	
	

buidConversation = () ->

	$convo = $(".CONVO")

	for message in conversation
		$convo.append build(message)


	build = (message) -> 

		$m = $("<div/>", id: "#{message.id}", class: "#{message.direction}", text: "#{message.text}")



setAndBindPageSizes = () -> 

	setSizes = () -> 
		w = $(window).width()
		h = $(window).height()
		$(".ninja").height(9 * h / 10)
		


	$(window).bind 'resize', -> 
		setSizes()

	setSizes()





















