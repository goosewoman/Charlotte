bind pub - 'players ping_server
bind pub - 'motd motd_server
bind pub - 'shorten shortenurl
bind pub - 'unshorten unshortenurl
bind pub - 'isup isup_server
bind pub - 'help commandhelp
bind pub - 'server info_server
bind pub - 'ping info_server
bind pub - 'mcquery info_server
bind pub - 'query info_server
bind pub - 'ip ip
bind pub - 'funfact trivia
bind pub - 'upload upload
bind pub - 'reverse reverse
bind pub - 'atbash atbash
bind pub - 'ceasar ceasar
bind pub - '1337 1337
bind pub - 'image randomimage
bind pub - 'images randomimage
bind pub - 'fact facts
bind pub - 'calc calculator
bind pub - 'calculator calculator
bind pub - 'exp exp
bind pub - 'insult insult
bind pub - 'twitter twitter
bind pub - 'albhed albhed

package require http

setudef flag ecc

global dirname2
set dirname2 "imagealias"
global dirnamefact
set dirnamefact "facts"


#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
proc albhed { nick userhost handle chan text } {
set text [split $text { }]
set key [lindex $text 0]

	if { [string compare -nocase $key "from"] == 0} {
		set text [string trimleft $text "from "]
		set from [string map {C S G K O Y M L U O J V A E C S E I L C R H Y A H N Z J I U D T K G P B T D N R F W V F B P X Q Q X S M W Z c s g k o y m l u o j v a e c s e i l c r h y a h n z j i u d t k g p b t d n r f w v f b p x q q x s m w z} $text]
		putchan $chan "\002$from"
	}
	if { [string compare -nocase $key "to"] == 0} {
		set text [string trimleft $text "to "]
		set to [string map {A Y B P C L D T E A F V G K H R I E J Z K G L M M S N H O U P B Q X R N S C T D U I V J W f x q y o z w a y b p c l d t e a f v g k h r i e j z k g l m m s n h o u p b q x r n s c t d u i v j w f x q y o z w} $text]
		putchan $chan "\002$to"
	}
}
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
proc urldecode {content} {
	set escapes {
		&nbsp; \x20 &quot; \x22 &amp; \x26 &apos; \x27 &ndash; \x2D
		&lt; \x3C &gt; \x3E &tilde; \x7E &euro; \x80 &iexcl; \xA1
		&cent; \xA2 &pound; \xA3 &curren; \xA4 &yen; \xA5 &brvbar; \xA6
		&sect; \xA7 &uml; \xA8 &copy; \xA9 &ordf; \xAA &laquo; \xAB
		&not; \xAC &shy; \xAD &reg; \xAE &hibar; \xAF &deg; \xB0
		&plusmn; \xB1 &sup2; \xB2 &sup3; \xB3 &acute; \xB4 &micro; \xB5
		&para; \xB6 &middot; \xB7 &cedil; \xB8 &sup1; \xB9 &ordm; \xBA
		&raquo; \xBB &frac14; \xBC &frac12; \xBD &frac34; \xBE &iquest; \xBF
		&Agrave; \xC0 &Aacute; \xC1 &Acirc; \xC2 &Atilde; \xC3 &Auml; \xC4
		&Aring; \xC5 &AElig; \xC6 &Ccedil; \xC7 &Egrave; \xC8 &Eacute; \xC9
		&Ecirc; \xCA &Euml; \xCB &Igrave; \xCC &Iacute; \xCD &Icirc; \xCE
		&Iuml; \xCF &ETH; \xD0 &Ntilde; \xD1 &Ograve; \xD2 &Oacute; \xD3
		&Ocirc; \xD4 &Otilde; \xD5 &Ouml; \xD6 &times; \xD7 &Oslash; \xD8
		&Ugrave; \xD9 &Uacute; \xDA &Ucirc; \xDB &Uuml; \xDC &Yacute; \xDD
		&THORN; \xDE &szlig; \xDF &agrave; \xE0 &aacute; \xE1 &acirc; \xE2
		&atilde; \xE3 &auml; \xE4 &aring; \xE5 &aelig; \xE6 &ccedil; \xE7
		&egrave; \xE8 &eacute; \xE9 &ecirc; \xEA &euml; \xEB &igrave; \xEC
		&iacute; \xED &icirc; \xEE &iuml; \xEF &eth; \xF0 &ntilde; \xF1
		&ograve; \xF2 &oacute; \xF3 &ocirc; \xF4 &otilde; \xF5 &ouml; \xF6
		&divide; \xF7 &oslash; \xF8 &ugrave; \xF9 &uacute; \xFA &ucirc; \xFB
		&uuml; \xFC &yacute; \xFD &thorn; \xFE &yuml; \xFF
	};
	set content [string map $escapes $content];
	set content [string map [list "\]" "\\\]" "\[" "\\\[" "\$" "\\\$" "\\" "\\\\"] $content];
	regsub -all -- {&#([[:digit:]]{1,5});} $content {[format %c [string trimleft "\1" "0"]]} content;
	regsub -all -- {&#x([[:xdigit:]]{1,4});} $content {[format %c [scan "\1" %x]]} content;
	regsub -all -- {&#?[[:alnum:]]{2,7};} $content "?" content;
	while {[regsub -all -- {\ \ } $content " " content] > 0} { }
	return [subst $content];
}
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
proc twitter { user userhost handle chan text } {
set text [split $text { }]
set name [lindex $text 0]
set count [lindex $text 1]
if {[llength $text] == 0} {
set count 1
set name ecocitycraft
}
if {[llength $text] == 1} {
set count 1
}
set kuke "~cactusman@199-83-184-82.ip.net.exigo.com"
#if {[string equal $userhost $kuke] != 1} {
#  putnotc $user "You are not authorized to do this"
#  } else {
set twitter [exec python /home/bot/twitter.py $name $count]
set twitter [split $twitter "\n"]
set status [lindex $twitter 0]
set screenname [lindex $twitter 1]
set time [lindex $twitter 2]
set status [urldecode $status]
set time [split $time { }]
set day [lindex $time 0]
set month [lindex $time 1]
set date [lindex $time 2]
set clock [lindex $time 3]
set timezone [lindex $time 4]
set year [lindex $time 5]
set month [string map { Jan "1" Feb "2" Mar "3" Apr "4" May "5"  Jun "6" Jul "7" Aug "8" Sep "9" Nov "10" Oct "11" Dec "12" } $month]

putchan $chan "${screenname}: $status"
#}
}
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
proc calculator { user userhost handle chan text } {
set text [split $text { }]
set text [string map {{pi} {acos(-1)}} $text]

set output [expr $text]
putchan $chan "\00304Answer\003: $output"
}
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
proc exp { user userhost handle chan text } {
set text [split $text { }]
set type [lindex $text 0]
set level [lindex $text 1]
  if {[llength $text] == 0} {
  putchan $chan "http://www.radthorne.info/exp.php"
  } else {
    if {[string compare -nocase $type new] == 0} {
      if {[string is integer $level] == 1} {
			if {[expr $level < 17] == 1} {
			set meep [expr round(17*$level)]
			}
			if {[expr $level > 16] == 1 && [expr $level < 31] == 1} {
			set meep [expr round(272+(((1.5*(($level-16)*($level-16))))+((18.5*($level-16)))))]
			}
			if {[expr $level > 30] == 1} {
			set meep [expr round($level*17 + max($level-16.0) * max($level-15.0) * 1.5 + max($level-31.0) * max($level-30.0)*2)]
			}
		putchan $chan "You require $meep exp to reach level ${level}."
    }
	}
    if {[string compare -nocase $type old] == 0} {
      if {[string is integer $level] == 1} {
      set meep [expr round((1.75*($level*$level))+(5.00*$level))]
      putchan $chan "You require $meep exp to reach level ${level}."
      } else {
      putchan $chan "Level has to be an integer."
      }
    }
  }
}


#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
proc readfact { rf } {
global dirnamefact
set fsize [file size $rf]
set fp [open $rf r]
set data [read $fp $fsize]
set data [split $data "\n"]
set data [string trimright $data "\{\}"]
close $fp
return $data
}
proc writefact {fact} {
  global dirnamefact

if {[file exists $dirnamefact] == 0} {
		file mkdir $dirnamefact
	}
if {[file exists $dirnamefact/] == 0} {
		file mkdir $dirnamefact/
	}
  set allfacts [open $dirnamefact/allfacts.fact a+]
  set factss [readfact "$dirnamefact/allfacts.fact"]
  set length [llength $factss]
  set fact [string map { "\{" "" "\}" "" } $fact]
  puts $allfacts "$length: $fact"
  close $allfacts
}
proc facts { nick userhost handle chan text } {
global dirnamefact
set text [split $text { }]
set number [lindex $text 0]
if { [llength $text] == 0 } {
  set facts [readfact "$dirnamefact/allfacts.fact"]
  set facts [string trimright $facts " "]
  set length1 [string index [lindex $facts end] 0]
  set length2 [string index [lindex $facts end] 1]
  set length "$length1$length2"
  set output [lindex $facts [expr round(rand()*$length)]]
  set prefix1 [string index $output 0]
  set prefix2 [string index $output 1]
  set prefix "$prefix1$prefix2"
  set output [string trimleft $output "${prefix}: "]
  putchan $chan "\00304This is fact number ${prefix}\003: $output"
  }
if {[llength $text] == 1 && [string is integer $number] == 1} {
  set facts [readfact "$dirnamefact/allfacts.fact"]
  set facts [string trimright $facts " "]
  set length1 [string index [lindex $facts end] 0]
  set length2 [string index [lindex $facts end] 1]
  set length "$length1$length2"
  if {[expr $number > $length] == 1} {
    putnotc $nick "\002Number must be less than ${length}.\002"
    }
  if {[expr $number < $length+1] == 1} {
    set factnr [lindex $facts $number]
    set prefix1 [string index $factnr 0]
    set prefix2 [string index $factnr 1]
    set prefix "$prefix1$prefix2"
    set factnr [string trimleft $factnr "${prefix} : "]
    putchan $chan "\00304This is fact number ${number}\003: $factnr"
    }
  }
if {[string compare -nocase [lindex $text 0] new] == 0} {
  set fact [string trimleft $text "new "]
  set kuke "~cactusman@199-83-184-82.ip.net.exigo.com"
  set facts [readfact "$dirnamefact/allfacts.fact"]
  set facts [string trimright $facts " "]
  set length1 [string index [lindex $facts end] 0]
  set length2 [string index [lindex $facts end] 1]
  set length "$length1$length2"
  set length [expr $length+1]
    if {[string equal $userhost $kuke] == 1} {
    writefact "$fact"
    putnotc $nick "Added fact #$length to the database."
    } else {
    putnotc $nick "You are not authorized to create new facts."
    }
  }
}
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
proc createmap {alias map} {
  global dirname2

	if {[file exists $dirname2] == 0} {
		file mkdir $dirname2
	}
  	if {[file exists $dirname2/] == 0} {
		file mkdir $dirname2/
	}
	if {[file exists $dirname2/${alias}.tcl] == 0} {
		set crtdb [open $dirname2/${alias}.tcl a+]
		puts $crtdb "$map"
		close $crtdb
	}
}   
proc readmap { rf } {
  global dirname2
  set fsize [file size $rf]
  set fp [open $rf r]
  set data [read $fp $fsize]
  close $fp
  return $data
}
proc meepmeep { alias number } {
global dirname2
set alias [string tolower $alias]
file delete $dirname2/${alias}.tcl
createmap "$alias" "set meep \[string map -nocase {$alias $number} $alias\]"
}
proc imagemap { number } {
global dirname2
  if {[string is integer $number] == 0 && [string compare -nocase $number names] != 0 && [string compare -nocase $number  index] != 0 && [string compare -nocase $number amount] && [string compare -nocase $number last] != 0 && [file exists $dirname2/${number}.tcl] == 1}  {
  set meep [source $dirname2/${number}.tcl]
  return $meep
  } else {
  return $number
  }
}
proc randomimage { nick userhost handle chan text } {
global dirname2
set text [split $text { }]
set number [lindex $text 0]
set number [imagemap $number]
  if { [llength $text] == 0 } {
    set output [exec python /home/bot/images.py]
    set output [split $output { }]
    set url [lindex $output 0]
    set number [lindex $output 1]
    set url [string map {mc www} $url]
    putchan $chan "\0032This is image number $number\0030: $url"
  }
  if {[llength $text] == 1 && [string is integer $number] == 1} {
  set output [exec python /home/bot/length.py]
  set output [split $output { }]
    if {[expr $number > $output] == 1} {
    putnotc $nick "\002Number must be less than ${output}.\002"
    }
    if {[expr $number < $output+1] == 1} {
    set output [exec python /home/bot/images2.py $number]
    set output [split $output { }]
    set url [lindex $output 0]
    set url [string map {mc www} $url]
    putchan $chan "\0032This is image number $number\0030: $url"
    }
  }
  if {[string compare -nocase [lindex $text 0] names] == 0} {
  set tcl [glob -tails -directory $dirname2/ -nocomplain -type f *.tcl]
  set tcl [string map -nocase {{.tcl} {}} $tcl]
  set tcl [string tolower $tcl]
  putnotc $nick "\00304These are the aliases\003: ${tcl}."
  }
  if {[string compare -nocase [lindex $text 0] index] == 0} {
  putnotc $nick "http://images.radthorne.com/"
  }  
  if {[string compare -nocase [lindex $text 0] amount] == 0} {
  set output [exec python /home/bot/length.py]
  putnotc $nick "There are $output images in my gallery."
  }
  if {[string compare -nocase [lindex $text 0] alias] == 0} {
  set kuke "~cactusman@199-83-184-82.ip.net.exigo.com"
    if {[llength $text] == 3} {
      if {[string equal $userhost $kuke] == 1} {
      set alias [lindex $text 1]
      set number [lindex $text 2]
      meepmeep "$alias" "$number" 
      putnotc $nick "Created alias '$alias' for image #${number}."
      } else {
      putnotc $nick "You are not authorized to create aliases."
      }
    }
    if {[llength $text] == 2} {
    set alias [lindex $text 1]
    set number [imagemap $alias]
      if {[file exists $dirname2/${alias}.tcl] == 1} {
      putchan $chan "Alias '$alias' belongs to image number ${number}."
      } else {
      putnotc $nick "Alias '$alias' does not exist."
      }
    }
  }
  if {[string compare -nocase [lindex $text 0] delete] == 0} {
  set kuke "~cactusman@199-83-184-82.ip.net.exigo.com"
    if {[string equal $userhost $kuke] == 1} {
    set alias [lindex $text 1]
    set number [imagemap $alias]
      if {[file exists $dirname2/${alias}.tcl] == 1} {
      file delete $dirname2/${alias}.tcl
      putnotc $nick "Deleted alias '$alias' for Image #${number}."
      } else {
      putnotc $nick "alias '$alias' does not exist."
      }
    } else {
    putnotc $nick "You are not authorized to delete aliases."
    }
  }    
}
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
proc ping_server { nick userhost handle chan text } {
set text [split $text { }]
set host [lindex $text 0]
set port [lindex $text 1]
  if { [llength $text] == 1 } {
  set port 25565
  }
  if { ([llength $text] == 0 ) } {
  set host mc.ecocitycraft.com
  set port 25565
  }
  set output [exec python /home/bot/mcpy/ping_server.py $host $port]
  set output [split $output { }]
  set players [lindex $output 0]
  set max [lindex $output 1]
  putchan $chan "There are $players players online out of $max possible at $host with port ${port}."
}
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
proc motd_server { nick userhost handle chan text } {
set text [split $text { }]
set host [lindex $text 0]
set port [lindex $text 1]
    if { [llength $text] == 1 } {
    set port 25565
    }
    if { [channel get $chan ecc] && [llength $text] == 0 } {
    set host mc.ecocitycraft.com
    set port 25565
    }
    set motd [exec python /home/bot/mcpy/motd_server.py $host $port]
      putchan $chan "The MOTD of the MineCraft server $host with port $port is: $motd"
}
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
proc shortenurl { nick userhost handle chan text } {
set text [split $text { }]
set url [lindex $text 0]
set output [exec python /home/bot/googl.py $url]
putchan $chan "I've shortened the URL for you: $output"
}
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
proc unshortenurl { nick userhost handle chan text } {
set text [split $text { }]
set url [lindex $text 0]
set output [exec python /home/bot/ungoogl.py $url]
putchan $chan "I've unshortened the URL for you: $output"
}
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
proc atbash { nick userhost handle chan text } {
set text [split $text { }]
set atbash [string map -nocase {a z b y c x d w e v f u g t h s i r j q k p l o m n n m o l p k q j r i s h t g u f v e w d x c y b z a} $text]
putchan $chan "\002I have encrypted the text with the atbash cipher for you:\002 $atbash"
}
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
proc ceasar { nick userhost handle chan text } {
set text [split $text { }]
set key [lindex $text 0]
  if { [string compare -nocase $key 1] == 0} {
  set ceasar1 [string map -nocase { A b B c C d D e E f F g G h H i I j J k K l L m M n N o O p P q Q r R s S t T u U v V w W x X y Y z Z a} $text]
  set ceasar1 [string trimleft $ceasar1 "1 "]
  putchan $chan "\002I have encrypted the text with the ceasar's cipher for you:\002 $ceasar1"
  }
  if { [string compare -nocase $key 2] == 0} {
  set ceasar2 [string map -nocase { A c B d C e D f E g F h G i H j I k J l K m L n M o N p O q P r Q s R t S u T v U w V x W y X z Y a Z b} $text]
  set ceasar2 [string trimleft $ceasar2 "2 "]
  putchan $chan "\002I have encrypted the text with the ceasar's cipher for you:\002 $ceasar2"
  }
  if { [string compare -nocase $key 3] == 0} {
  set ceasar3 [string map -nocase { A d B e C f D g E h F i G j H k I l J m K n L o M p N q O r P s Q t R u S v T w U x V y W z X a Y b Z c} $text]
  set ceasar3 [string trimleft $ceasar3 "3 "]
  putchan $chan "\002I have encrypted the text with the ceasar's cipher for you:\002 $ceasar3"
  }
  if { [string compare -nocase $key 4] == 0} {
  set ceasar4 [string map -nocase { A f B g C h D i E j F k G l H m I n J o K p L q M r N s O t P u Q v R w S x T y U z V a W b X c Y d Z e} $text]
  set ceasar4 [string trimleft $ceasar4 "4 "]
  putchan $chan "\002I have encrypted the text with the ceasar's cipher for you:\002 $ceasar4"
  }
  if { [string compare -nocase $key 5] == 0} {
  set ceasar5 [string map -nocase { A g B h C i D j E k F l G m H n I o J p K q L r M s N t O u P v Q w R x S y T z U a V b W c X d Y e Z f} $text]
  set ceasar5 [string trimleft $ceasar5 "5 "]
  putchan $chan "\002I have encrypted the text with the ceasar's cipher for you:\002 $ceasar5"
  }
  if { [string compare -nocase $key 6] == 0} {
  set ceasar6 [string map -nocase { A h B i C j D k E l F m G n H o I p J q K r L s M t N u O v P w Q x R y S z T a U b V c W d X e Y f Z g} $text]
  set ceasar6 [string trimleft $ceasar6 "6 "]
  putchan $chan "\002I have encrypted the text with the ceasar's cipher for you:\002 $ceasar6"
  }
  if { [string compare -nocase $key 7] == 0} {
  set ceasar7 [string map -nocase { A i B j C k D l E m F n G o H p I q J r K s L t M u N v O w P x Q y R z S a T b U c V d W e X f Y g Z h} $text]
  set ceasar7 [string trimleft $ceasar7 "7 "]
  putchan $chan "\002I have encrypted the text with the ceasar's cipher for you:\002 $ceasar7"
  }
  if { [string compare -nocase $key 8] == 0} {
  set ceasar8 [string map -nocase { A j B k C l D m E n F o G p H q I r J s K t L u M v N w O x P y Q z R a S b T c U d V e W f X g Y h Z i} $text]
  set ceasar8 [string trimleft $ceasar8 "8 "]
  putchan $chan "\002I have encrypted the text with the ceasar's cipher for you:\002 $ceasar8"
  }
  if { [string compare -nocase $key 9] == 0} {
  set ceasar9 [string map -nocase { A k B l C m D n E o F p G q H r I s J t K u L v M w N x O y P z Q a R b S c T d U e V f W g X h Y i Z j} $text]
  set ceasar9 [string trimleft $ceasar9 "9 "]
  putchan $chan "\002I have encrypted the text with the ceasar's cipher for you:\002 $ceasar9"
  }
  if { [string compare -nocase $key 10] == 0} {
  set ceasar10 [string map -nocase { A l B m C n D o E p F q G r H s I t J u K v L w M x N y O z P a Q b R c S d T e U f V g W h X i Y j Z k} $text]
  set ceasar10 [string trimleft $ceasar10 "10 "]
  putchan $chan "\002I have encrypted the text with the ceasar's cipher for you:\002 $ceasar10"
  }
  if { [string compare -nocase $key 11] == 0} {
  set ceasar11 [string map -nocase { A m B n C o D p E q F r G s H t I u J v K w L x M y N z O a P b Q c R d S e T f U g V h W i X j Y k Z l} $text]
  set ceasar11 [string trimleft $ceasar11 "11 "]
  putchan $chan "\002I have encrypted the text with the ceasar's cipher for you:\002 $ceasar11"
  }
  if { [string compare -nocase $key 12] == 0} {
  set ceasar12 [string map -nocase { A n B o C p D q E r F s G t H u I v J w K x L y M z N a O b P c Q d R e S f T g U h V i W j X k Y l Z m} $text]
  set ceasar12 [string trimleft $ceasar12 "12 "]
  putchan $chan "\002I have encrypted the text with the ceasar's cipher for you:\002 $ceasar12"
  }
  if { [string compare -nocase $key 13] == 0} {
  set ceasar13 [string map -nocase { A o B p C q D r E s F t G u H v I w J x K y L z M a N b O c P d Q e R f S g T h U i V j W k X l Y m Z n} $text]
  set ceasar13 [string trimleft $ceasar13 "13 "]
  putchan $chan "\002I have encrypted the text with the ceasar's cipher for you:\002 $ceasar13"
  }
  if { [string compare -nocase $key 14] == 0} {
  set ceasar14 [string map -nocase { A p B q C r D s E t F u G v H w I x J y K z L a M b N c O d P e Q f R g S h T i U j V k W l X m Y n Z o} $text]
  set ceasar14 [string trimleft $ceasar14 "14 "]
  putchan $chan "\002I have encrypted the text with the ceasar's cipher for you:\002 $ceasar14"
  }
  if { [string compare -nocase $key 15] == 0} {
  set ceasar15 [string map -nocase { A q B r C s D t E u F v G w H x I y J z K a L b M c N d O e P f Q g R h S i T j U k V l W m X n Y o Z p} $text]
  set ceasar15 [string trimleft $ceasar15 "15 "]
  putchan $chan "\002I have encrypted the text with the ceasar's cipher for you:\002 $ceasar15"
  }
  if { [string compare -nocase $key 16] == 0} {
  set ceasar16 [string map -nocase { A r B s C t D u E v F w G x H y I z J a K b L c M d N e O f P g Q h R i S j T k U l V m W n X o Y p Z q} $text]
  set ceasar16 [string trimleft $ceasar16 "16 "]
  putchan $chan "\002I have encrypted the text with the ceasar's cipher for you:\002 $ceasar16"
  }
  if { [string compare -nocase $key 17] == 0} {
  set ceasar17 [string map -nocase { A s B t C u D v E w F x G y H z I a J b K c L d M e N f O g P h Q i R j S k T l U m V n W o X p Y q Z r} $text]
  set ceasar17 [string trimleft $ceasar17 "17 "]
  putchan $chan "\002I have encrypted the text with the ceasar's cipher for you:\002 $ceasar17"
  }
  if { [string compare -nocase $key 18] == 0} {
  set ceasar18 [string map -nocase { A t B u C v D w E x F y G z H a I b J c K d L e M f N g O h P i Q j R k S l T m U n V o W p X q Y r Z s} $text]
  set ceasar18 [string trimleft $ceasar18 "18 "]
  putchan $chan "\002I have encrypted the text with the ceasar's cipher for you:\002 $ceasar18"
  }
  if { [string compare -nocase $key 19] == 0} {
  set ceasar19 [string map -nocase { A u B v C w D x E y F z G a H b I c J d K e L f M g N h O i P j Q k R l S m T n U o V p W q X r Y s Z t} $text]
  set ceasar19 [string trimleft $ceasar19 "19 "]
  putchan $chan "\002I have encrypted the text with the ceasar's cipher for you:\002 $ceasar19"
  }
  if { [string compare -nocase $key 20] == 0} {
  set ceasar20 [string map -nocase { A v B w C x D y E z F a G b H c I d J e K f L g M h N i O j P k Q l R m S n T o U p V q W r X s Y t Z u} $text]
  set ceasar20 [string trimleft $ceasar20 "20 "]
  putchan $chan "\002I have encrypted the text with the ceasar's cipher for you:\002 $ceasar20"
  }
  if { [string compare -nocase $key 21] == 0} {
  set ceasar21 [string map -nocase { A w B x C y D z E a F b G c H d I e J f K g L h M i N j O k P l Q m R n S o T p U q V r W s X t Y u Z v} $text]
  set ceasar21 [string trimleft $ceasar21 "21 "]
  putchan $chan "\002I have encrypted the text with the ceasar's cipher for you:\002 $ceasar21"
  }
  if { [string compare -nocase $key 22] == 0} {
  set ceasar22 [string map -nocase { A x B y C z D z E b F c G d H e I f J g K h L i M j N k O l P m Q n R o S p T q U r V s W t X u Y v Z w} $text]
  set ceasar22 [string trimleft $ceasar22 "22 "]
  putchan $chan "\002I have encrypted the text with the ceasar's cipher for you:\002 $ceasar22"
  }
  if { [string compare -nocase $key 23] == 0} {
  set ceasar23 [string map -nocase { A y B z C a D b E c F d G e H f I g J h K i L j M k N l O m P n Q o R p S q T r U s V t W u X v Y w Z x} $text]
  set ceasar23 [string trimleft $ceasar23 "23 "]
  putchan $chan "\002I have encrypted the text with the ceasar's cipher for you:\002 $ceasar23"
  }
  if { [string compare -nocase $key 24] == 0} {
  set ceasar24 [string map -nocase { A z B a C b D c E d F e G f H g I h J i K j L k M l N m O n P o Q p R q S r T s U t V u W v X w Y x Z y} $text]
  set ceasar24 [string trimleft $ceasar24 "24 "]
  putchan $chan "\002I have encrypted the text with the ceasar's cipher for you:\002 $ceasar24"
  }
  if { [expr $key > 24] == 1 } {
  putchan $chan "Please provide a number below 25"
  }
}
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
proc 1337 { nick userhost handle chan text } {
set text [split $text { }]
set leet [string map -nocase " a 4 b 8 e 3 g 6 i ! l 1 o 0 r 2 s 5 t 7 z 2 4 a 8 b 3 e 6 g ! i 1 l 0 o 2 r 5 s 7 t 2 z" $text]
putchan $chan "\002I have made the text 1337 for you:\002 $leet" 
}
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
proc rndpassword len {
 set s "abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNOPQRSTUVWXYZ123456789123456789"
 for {set i 0} {$i <= $len} {incr i} {
    append p [string index $s [expr {int([string length $s]*rand())}]]
 }
 return $p
}
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
proc lowerthan {number} {
  if {[expr $number < 10] == 1} {
  set number "000$number"
  return $number
  }
  if {[expr $number < 100] == 1 && [expr $number < 10] == 0} {
  set number "00$number"
  return $number
  }
  if {[expr $number < 1000] == 1 && [expr $number < 100] == 0 && [expr $number < 10] == 0} {
  set number "0$number"
  return $number
  }
}
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
proc upload { nick userhost handle chan text } {
set text [split $text { }]
set url [lindex $text 0]
set ext [file extension $url]
set moop "http://images.radthorne.com/img"
set kuke "~cactusman@199-83-184-82.ip.net.exigo.com"
if {[string equal $userhost $kuke] == 1} {
  if { [llength $text] == 1 } {
    if {[string equal $ext .png] == 1 || [string equal $ext .gif] == 1 || [string equal $ext .jpg] == 1 || [string equal $ext .jpeg] == 1} {
		set meep [glob -nocomplain -directory /var/www/images/img *.*]
		set meep [split $meep { }]
		set meep [expr [llength $meep] + 1]
		
		set filename [file tail $url]
		set meep [lowerthan $meep]
		set name "Radthorne_${meep}$ext"
		set output [exec php /home/bot/uploadimage.php $url $name]
		putnotc $nick "uploaded $name to $moop/$name"
    } else {
		putnotc $nick "unsupported format. supported formats are: png, gif, jpg and jpeg."
    }
  }
}
if {[string equal $userhost $kuke] == 0} {
putnotc $nick "You are not authorized to upload images"
}
}
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
proc reverse { nick userhost handle chan text } {
set text [split $text { }]
set reverse [string reverse $text]
putchan $chan "\002I have reversed the text for you:\002 $reverse"
}
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
proc isup_server { nick userhost handle chan text } {
set text [split $text { }]
set host [lindex $text 0]
set port [lindex $text 1]

  if { [llength $text] == 1 } {
  set port 25565
  }
  if { [llength $text] == 0 } {
  set port 25565
  set host mc.ecocitycraft.com
  }
  set isup [exec python /home/bot/isup.py $host $port]
  putchan $chan "The server $host at port $port is ${isup}."
  
}
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
proc info_server { nick userhost handle chan text } {
set text [split $text { }]
set host [lindex $text 0]
set port [lindex $text 1]
  if { [llength $text] == 1 } {
  set port 25565
  }
  if { [llength $text] == 0 } {
  set host mc.ecocitycraft.com
  set port 25565
  }
  set isup [exec python /home/bot/mcpy/ping.py $host $port]
  set isup [string map -nocase {
  "\\xa70" "\00301"
  "\\xa71" "\00312"
  "\\xa72" "\00303"
  "\\xa73" "\00310"
  "\\xa74" "\00305"
  "\\xa75" "\00306"
  "\\xa76" "\00307"
  "\\xa77" "\00300"
  "\\xa78" "\00314"
  "\\xa79" "\00312"
  "\\xa7a" "\00309"
  "\\xa7b" "\00311"
  "\\xa7c" "\00304"
  "\\xa7d" "\00313"
  "\\xa7e" "\00308"
  "\\xa7f" "\00315"
  "', " "\003', "
  } $isup]
  putchan $chan "${isup}."
}
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
proc ip { nick userhost handle chan text } {
set text [split $text { }]
set url [lindex $text 0]
  if { ([llength $text] == 0 ) } {
  set url mc.ecocitycraft.com
  }
  set ip [exec python /home/bot/ip.py $url]
  putchan $chan "The IP of $url is $ip"
}
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
proc commandhelp { nick userhost handle chan text } {
global dirname
set text [split $text { }]
set arg1 [lindex $text 0]
  if { [llength $text] == 0 } {
    putnotc $nick "\00304use 'help <command> for detailed descriptions, this does not apply to channel specific commands."
    set cmd [glob -tails -directory $dirname/$chan -nocomplain -type f *.cmd]
    set proc [glob -tails -directory $dirname/$chan -nocomplain -type f *.proc]
    set cmd [lsort [string map {{.alias} {} {.cmd} {} {.proc} {}} $cmd]]
    set proc [lsort [string map {{.alias} {} {.cmd} {} {.proc} {}} $proc]]
    putnotc $nick "\00304Custom commands(${chan}):\003 $cmd"
    putnotc $nick "\00304Custom commands(global):\003 isup players motd shorten unshorten fact funfact atbash reverse ceasar ip image 1337"
  }
  if { [llength $text] == 1 } {
    if { [string compare -nocase $arg1 isup] == 0 } {
    putnotc $nick "Usage: 'isup \[address\] \[port\]"
    putnotc $nick "Shows whether the specified server is online or not."
    }
    if { [string compare -nocase $arg1 image] == 0 } {
    putnotc $nick "Usage: 'image 'image \[number|\"names\"|\"alias\"|\"index\"|\"amount\"|\"delete\"\] \[aliasname\] \[imagenumber\]"
    putnotc $nick "Shows a random image from my image library or shows a specific image with a number."
    }
    if { [string compare -nocase $arg1 players] == 0 } {
    putnotc $nick "Usage: 'ping \[address\] \[port\]"
    putnotc $nick "Shows the rawr query data of that server."
    }
    if { [string compare -nocase $arg1 shorten] == 0 } {
    putnotc $nick "Usage: 'shorten <url>"
    putnotc $nick "Shortens specified url with goo.gl."
    }
        if { [string compare -nocase $arg1 unshorten] == 0 } {
    putnotc $nick "Usage: 'unshorten <url>"
    putnotc $nick "UnShortens specified url."
    }
    if { [string compare -nocase $arg1 atbash] == 0 } {
    putnotc $nick "Usage: 'atbash <text>"
    putnotc $nick "Encrypts/decrypts text with the atbash cipher."
    }
        if { [string compare -nocase $arg1 ceasar] == 0 } {
    putnotc $nick "Usage: 'ceasar <key> <text>"
    putnotc $nick "Encrypts/decrypts text with the ceasars shift, the key is the number of shifts."
    putnotc $nick "Decrypt by subtracting the key from 24.   ex. key = 5 'ceasar 19 would decrypt it."
    }
    if { [string compare -nocase $arg1 reverse] == 0 } {
    putnotc $nick "Usage: 'reverse <text>"
    putnotc $nick "Reverses the text."
    }
    if { [string compare -nocase $arg1 ip] == 0 } {
    putnotc $nick "Usage: 'ip <url>"
    putnotc $nick "Shows the ip address of an url."
    }
    if { [string compare -nocase $arg1 funfact] == 0 } {
    putnotc $nick "Usage: 'funfact"
    putnotc $nick "Displays a random fact from www.randomfunfacts.com"
    }
        if { [string compare -nocase $arg1 fact] == 0 } {
    putnotc $nick "Usage: 'fact [number]"
    putnotc $nick "Displays a fact."
    }
    if { [string compare -nocase $arg1 1337] == 0 } {
    putnotc $nick "Usage: '1337 <text>"
    putnotc $nick "Translates text into leetspeak and back. (not a good translator though)"
    } 
  }
}
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
proc trivia { user userhost handle chan text } {
set trivia [exec python /home/bot/eggdrop/trivia.py]
putchan $chan "$trivia"
}
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
proc insult {user userhost handle chan text } {
set insult [exec python /home/kuke/eggdrop/insults.py]
set insult [split $insult {|}]
set insult [lindex $insult 0]
putchan $chan "$insult"
}
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
putlog "meepmeep!"