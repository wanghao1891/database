#!/usr/bin/petite --script

(load "base.ss")

(define name "article")

(create-db name '(id name path create-time update-time))
