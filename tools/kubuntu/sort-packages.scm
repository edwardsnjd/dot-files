#!/usr/bin/env -S guile --no-auto-compile -e main -s
!#
(use-modules (ice-9 match)
             (ice-9 pretty-print))

(define (sort-manifest)
  (let loop ((expr (read)))
    (unless (eof-object? expr)
      (pretty-print
        (match expr
               ;; Sort the manifest packages
               (('specifications->manifest expr)
                  `(specifications->manifest
                     (list ,@(sort-list expr))))
               ;; Fallback: print other expressions as-is
               (_ expr)))
      (loop (read)))))

(define (sort-list expr)
  (let ((expr-vals
          (match expr
                 (('quote vals) vals)
                 (('quasiquote vals) vals)
                 (('list . vals) vals)
                 (_ (error "Unrecognized list expression:" expr)))))
    (sort expr-vals string<?)))

(define (main args) (sort-manifest))
