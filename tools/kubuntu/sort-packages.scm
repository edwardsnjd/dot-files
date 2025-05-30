#!/usr/bin/env -S guile --no-auto-compile -e main -s
!#
(use-modules (ice-9 match)
             (ice-9 pretty-print)
             (srfi srfi-1))

(define (sort-manifest in-port out-port)
  (let loop ((expr (read in-port)))
    (unless (eof-object? expr)
      (match expr
        ;; Match (specifications->manifest (list ...))
        (('specifications->manifest ('list . packages))
         (let ((sorted (sort packages string<?)))
           (pretty-print `(specifications->manifest
                            (list ,@sorted))
                         out-port)))
        ;; Fallback: print other expressions as-is
        (_ (pretty-print expr out-port)))
      (loop (read in-port)))))

(define (main args)
  (sort-manifest (current-input-port) (current-output-port)))
