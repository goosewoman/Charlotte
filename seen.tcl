bind join - * join
bind part - * part
bind nick - * nick
bind pub - 'seen seen
bind sign - * part
bind kick - * kick
bind rejn - * join
global dirname
set dirname "seen"

#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'
proc createfile { chan nick time} {
	global dirname
  set chan [string tolower $chan]
  set nick [string tolower $nick]

	if {[file exists $dirname] == 0} {
		file mkdir $dirname
	}
  	if {[file exists $dirname/$chan] == 0} {
		file mkdir $dirname/$chan
	}
	if {[file exists $dirname/$chan/${nick}.txt] == 0} {
		set crtdb [open $dirname/$chan/${nick}.txt a+]
		puts $crtdb "$time"
		close $crtdb
	}
}  
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    
proc readfile { rf } {
  global dirname  
  set fsize [file size $rf]
  set fp [open $rf r]
  set data [read $fp $fsize]
  close $fp
  return $data
}
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  
proc join { nick userhost handle chan } {
  global dirname
  set chan [string tolower $chan]
  set nick [string tolower $nick]
  set time "0"
  file delete $dirname/$chan/${nick}.txt
  createfile "$chan" "$nick" "$time"
}
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
proc nick { nick userhost handle chan newnick } {
global dirname
set chan [string tolower $chan]
set nick [string tolower $nick]
set time "0"
file delete $dirname/$chan/${nick}.txt
createfile "$chan" "$newnick" "$time"
}
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
proc part { nick userhost handle chan text} {
  global dirname
  set chan [string tolower $chan]
  set nick [string tolower $nick]
  set time [clock seconds]
  file delete $dirname/$chan/${nick}.txt
  createfile "$chan" "$nick" "$time"
}
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
proc kick { nick userhost handle chan target text} {
  global dirname
  set chan [string tolower $chan]
  set nick [string tolower $nick]
  set time [clock seconds]
  file delete $dirname/$chan/${target}.txt
  createfile "$chan" "$nick" "$time"
}
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
proc seen { nick userhost handle chan text } {
  global dirname
  set chan [string tolower $chan]
  set nick [string tolower $nick]
  set text [split $text { }]
  set player [lindex $text 0]
  set player [string tolower $player]
  #@@@@@@@@@@@@@@@@@@@@@@@@@@@@  
  if {[file exists $dirname/$chan/${player}.txt] == 1} {
    set time [readfile $dirname/$chan/${player}.txt]
    if {[expr $time > 0] == 1} {
    set currenttime [clock seconds]
    set timediff [expr $currenttime - $time]
    set weeks [expr ($timediff / 604800)]
    set days [expr ($timediff / 86400) - ($weeks * 7)]
    set hours [expr ($timediff / 3600) - ($weeks * 168) - ($days * 24) ]
    set minutes [expr ($timediff / 60) - ($weeks * 10080) - ($days * 1440) - ($hours * 60)] 
    set seconds [expr ($timediff) - ($weeks * 604800) - ($days * 86400) - ($hours * 3600) - ($minutes * 60)]
    #@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    if {[expr $weeks < 1] == 1} {
    set weeks {}
    } elseif {[expr $weeks == 1] == 1} {
    set weeks "$weeks week, "
    } elseif {[expr $weeks > 1] == 1} {
    set weeks "$weeks weeks, "
    }  
    if {[expr $days < 1] == 1} {
    set days {}
    } elseif {[expr $days == 1] == 1} {
    set days "$days day, "
    } elseif {[expr $days > 1] == 1} {
    set days "$days days, "
    } 
    if {[expr $hours < 1] == 1} {
    set hours {}
    } elseif {[expr $hours == 1] == 1} {
    set hours "$hours hour, "
    } elseif {[expr $hours > 1] == 1} {
    set hours "$hours hours, "
    } 
    if {[expr $minutes < 1] == 1} {
    set minutes {}
    } elseif {[expr $minutes == 1] == 1} {
    set minutes "$minutes minute and "
    } elseif {[expr $minutes  > 1] == 1} {
    set minutes "$minutes minutes and "
    } 
    set seconds "$seconds seconds"
    #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    
    putnotc $nick "$player hasn't been in $chan for $weeks$days$hours$minutes$seconds."
    }
    if {[expr $time > 0] == 0} {
    putnotc $nick "$player is online at $chan"
    }
  }
  if {[file exists $dirname/$chan/${player}.txt] == 0} {
  putnotc $nick "${player}'s seenfile does not exist. Possible reasons are: The player never joined the channel, the player has never left since the creation of this script or the player simply does not exist."
  } 
     
} 
putlog "kukelekuuk00's seen script loaded"