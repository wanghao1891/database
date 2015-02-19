#!/usr/bin/petite --script

(define search-text (cadr (command-line)))

(system (string-append 
	 "cd /root/workspace/parser/; petite --script html-parser.ss "
	 search-text))
