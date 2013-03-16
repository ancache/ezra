$(document).ready ->
	Mousetrap.bind "ctrl+left", (e) ->
		seeker -1

	Mousetrap.bind "ctrl+right", (e) ->
		seeker 1

	Mousetrap.bind "ctrl+down", (e) ->
		setWindowBound $("#end-now")
		no

	Mousetrap.bind "ctrl+up", (e) ->
		setWindowBound $("#start-now")
		no

	Mousetrap.bind "ctrl+space", (e) ->
		#TODO: initial playing doesn't work.
		togglePlayer()
		no

	Mousetrap.bind "ctrl+enter", (e) ->
		$("#mark-hit").click()

	Mousetrap.bind "ctrl+1", (e) ->
		setStatus 1

	Mousetrap.bind "ctrl+2", (e) ->
		setStatus 0
	
	Mousetrap.bind "ctrl+3", (e) ->
		setStatus -1

	Mousetrap.bind "ctrl+4", (e) ->
		setStatus -2

	Mousetrap.bind "ctrl+0", (e) ->
		isChecked = $("#flag-checkbox").attr("checked")
		if isChecked
		  $("#flag-checkbox").attr "checked", no
		else
		  $("#flag-checkbox").attr "checked", yes
		$("#flag-checkbox").change()

	Mousetrap.bind "ctrl+s", (e) ->
		save()

	#Mousetrap.bind "ctrl+enter", (e) ->
		next()

	#Mousetrap.bind "ctrl+enter", (e) ->
		prev()