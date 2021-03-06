#assume there is an object
conversation = []
links = []

# also assume there is jquery

$(document).ready -> buidpage()

buidpage = () -> 

	bindClickEvents()
	transition()
	setAndBindPageSizes(8)


transition = () -> 

	$("#firstButton").delay(2000)
					 .fadeTo(200, 0)
					 .delay(200)
					 .fadeTo(0, 0, askWhichFriend)


askWhichFriend = () -> 

	$("#firstButton").text("Please select a conversation...")
					 .delay(1000)
					 .fadeTo(300, 1)
					 .delay(2000)	

	buildFriends = (Friends) ->

		build = (thread) -> 

			$thread = $("<div/>", class: "friend", id: "#{thread.thread_id}")
			$mostRecent = $("<div/>", class: "FmostRECENT", text: "#{thread.snippet}")
			$name = $("<div/>", class: "friendNAME", text: "")

			getUserInfo = (friend) -> 

				if $name.text() is "" 
					$name.text("#{friend.name}")
					$thread.append($("<img/>", class: "friendPIC", src: "#{friend.pic_square}"))
				else $name.text( $name.text() + " & #{friend.name}")
				$thread.append($name).append($mostRecent)						

			for recipient, i in thread.recipients when "#{recipient}" isnt "#{thread.viewer_id}"
				$.get("/userInfo", {uid : recipient}, getUserInfo)

			$thread.click -> buildConversation(thread.thread_id, thread.viewer_id)

			return $thread	


		for friend in Friends
			$(".FRIENDS").append( build(friend))

	$.get("/allThreads", buildFriends)

	$(".ninja").removeClass("hidden")
	$(".FRIENDS").hide().delay(800).fadeIn(200)
		

buildConversation = (id, me) ->

	$convo = $(".CONVO")
	$("#firstButton").fadeTo(200, 0)
	$(".FRIENDS").fadeOut(200).addClass("hidden")
	$(".welcome").addClass("moveDown").delay(600).fadeOut(400)
#	$(".viewButton").hide().removeClass("hidden").delay(1000).fadeIn(200)
	$(".logo").hide().removeClass("hidden").delay(1000).fadeIn(200, -> 
		setAndBindPageSizes(10) )

	buildMessages = (conversation) -> 

		build = (message) -> 

			str = "#{message.body}"
			for link in message.links
				str = str.replace( "#{link}" , "<a href=\"#{link}\">#{link}</a>" )
			
			$m = $("<div/>", class:"message", text: "").html(str)

			if "#{message.author_id}" is "#{me}" then $m.addClass("to")
			else $m.addClass("from")

			links.push(message.links)

			return $m

		for message in conversation
			$convo.append build(message)
		$convo.append($("<div/>", class: "end", text: 'END'))

	$.get("/messagesInThread", {thread_id:id}, buildMessages)

	$(".CONVO").removeClass("hidden")

#	$(".viewButton").click -> linkView()


linkView =  () -> 

	build = (link) -> 

		$a = $("<div/>", class: "article")
		$img = $("<img/>", src: "article.image")
		$title = $("<div/>", class: "articleTitle", text: "#{artlce.title}")
		$text = $("<div/>", class: "articleText", text: "#{article.text}")
		$a.append($img).append($title).append($text)
		$(".linkPane").append($a)

	for link in links
		console.log link
		$.get("#{link}", build)

	


setAndBindPageSizes = (r) -> 

	setSizes = () -> 
		h = $(window).height()
		$(".ninja").height(r * h / 10)
		$(".linkPane").height(h)

	$(window).bind 'resize', -> 
		setSizes()

	setSizes()



bindClickEvents = () -> 

	$(".logo").click -> 
		$(".CONVO").children().remove()
		setAndBindPageSizes(8)
		$(".welcome").removeClass("moveDown").fadeIn(200)
		$(".logo, articleView").fadeOut(200)
		askWhichFriend()

	$(".articleView").click -> 
		$(".CONVO").children().remove()
		$(".logo").fadeOut(200)
		linkView()
















