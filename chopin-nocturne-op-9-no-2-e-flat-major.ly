\version "2.26.0"
\pointAndClickOff
% Frederic Chopin: Nocturne in E-flat major, Op. 9 No. 2.
% This A4 reflow uses the supplied self-contained LY as its musical authority.
% Spacious A4 print layout; original title, music and playback tracks are retained.
% XML measure labels retain the source's pickup 0 and measures 1--37.
% At XML33/34 the source actually supplies three quarters per measure;
% the hidden 6/4 is retained with an explicit measureLength, without added rests.
% Historical source repair: XML7/15/23 trill spans were restored from its PDF.
% Original playback metronomes remain in the unchanged invisible tempo track.
% Current layout changes preserve all submitted music and original slur endpoints.
% The original parenthesized pedal reminders on XML34/35 remain unchanged.
% Earlier MusicXML/PDF references describe source history, not new cross-checks.
D = \tweak Stem.direction #DOWN \etc
U = \tweak Stem.direction #UP \etc
% The PDF places z between f and p; playback retains the source fp event.
fzp = \tweak text "fzp" \fp

\header {
  title = \markup \override #'(font-name . "Times New Roman, Liberation Serif, C059")
    \center-column {
      \abs-fontsize #24 "Nocturne in E♭ Major"
    }
  subtitle = \markup \override #'(font-name . "Times New Roman, Liberation Serif, C059")
    \abs-fontsize #14 "Op. 9 No. 2"
  composer = \markup \override #'(font-name . "Times New Roman, Liberation Serif, C059")
    \abs-fontsize #11.5 "Frédéric François Chopin"
  composerDates = \markup \override #'(font-name . "Times New Roman, Liberation Serif, C059")
    \abs-fontsize #11.5 "(1810 – 1849)"
  pdftitle = "Nocturne in E-flat major, Op. 9 No. 2"
  midititle = "Nocturne in E-flat major, Op. 9 No. 2"
  tagline = ##f
}
#(set-global-staff-size 19.5)
#(ly:set-option 'midi-extension "mid")
\paper {
  #(set-paper-size "a4")
  page-breaking = #ly:optimal-breaking
  max-systems-per-page = #4
  top-margin = 20\mm
  bottom-margin = 22\mm
  left-margin = 20\mm
  right-margin = 20\mm
  indent = 14\mm
  short-indent = 2.4\mm
  ragged-right = ##f
  ragged-last = ##f
  ragged-bottom = ##f
  ragged-last-bottom = ##t
  print-first-page-number = ##f
  bookTitleMarkup = \markup \column {
    \fill-line { \fromproperty #'header:title }
    \vspace #0.8
    \overlay {
      \fill-line { \fromproperty #'header:subtitle }
      \fill-line { "" \fromproperty #'header:composer }
    }
    \vspace #0.7
    \fill-line { "" \fromproperty #'header:composerDates }
  }
  oddHeaderMarkup = ##f
  evenHeaderMarkup = ##f
  oddFooterMarkup = \markup \fill-line { "" \if \should-print-page-number \abs-fontsize #9 \fromproperty #'page:page-number-string }
  evenFooterMarkup = \markup \fill-line { \if \should-print-page-number \abs-fontsize #9 \fromproperty #'page:page-number-string "" }
  markup-system-spacing = #'((basic-distance . 12) (minimum-distance . 8) (padding . 4) (stretchability . 0))
  top-system-spacing = #'((basic-distance . 6) (minimum-distance . 4) (padding . 1))
  system-system-spacing = #'((basic-distance . 22) (minimum-distance . 16) (padding . 4) (stretchability . 10))
  last-bottom-spacing = #'((basic-distance . 6) (minimum-distance . 4) (padding . 2))
}
% Four finite optical corrections identified in the actual A4 PDF ink.
% Select real source voices/times/pitches.  All source events, original
% bounds, note columns, head memberships and native stencils are retained.
#(define nocturne-aFour-optics-proof-path #f)
#(define (Nocturne_four_optics_engraver context)
   (let ((keys (make-hash-table 1400)) (slurs '()) (pending '())
         (seen (make-hash-table 100)) (hits (make-hash-table 7))
         (curve-rows
          '(("m4-break" 24 ("rightMain|24|0|0,6,-1/2")
             ("rightMain|49/2|0|1,4,0") 2 0
             ((0 . 0) (0 . 0) (-1/8 . 0) (-1/4 . 0)))
            ("m12-natural" 70 ("rightMain|70|0|0,3,1/2" "rightMain|70|0|0,6,0")
             ("rightMain|72|0|0,5,-1/2" "rightMain|72|0|1,1,0") 1 0
             ((0 . 0) (0 . -3/8) (0 . 0) (0 . 0)))))
         (grace-rows
          '(("m22-grace" 259/2 -1/2 (1 4 0) -1/4)
            ("m27-grace" 161 -1/4 (1 2 -1/2) -1/4))))
     (define (proof kind key data)
       (when nocturne-aFour-optics-proof-path
         (let ((port (open-file nocturne-aFour-optics-proof-path "a")))
           (format port "~a\t~a\t~s\n" kind key data) (close-port port))))
     (define (claim key)
       (when (hash-ref hits key #f) (ly:error "Duplicate nocturne optical target: ~a" key))
       (hash-set! hits key #t))
     (define (array g prop)
       (let ((v (ly:grob-object g prop)))
         (if (ly:grob-array? v) (ly:grob-array->list v) '())))
     (define (pitch-key h)
       (let ((p (ly:event-property (ly:grob-property h 'cause) 'pitch)))
         (list (ly:pitch-octave p) (ly:pitch-notename p) (ly:pitch-alteration p))))
     (define (bound-keys col)
       (sort (map (lambda (h) (or (hashq-ref keys h #f)
                                  (ly:error "Missing nocturne source head identity")))
                  (array col 'note-heads)) string<?))
     (define (pieces g)
       (let* ((o (ly:grob-original g)) (p (ly:spanner-broken-into o)))
         (if (pair? p) p (list o))))
     (make-engraver
       (acknowledgers
         ((note-head-interface e h source)
          (let* ((c (ly:translator-context source)) (m (ly:context-current-moment c))
                 (p (pitch-key h)))
            (hashq-set! keys h (format #f "~a|~a|~a|~a,~a,~a" (ly:context-id c)
                                (* 4 (ly:moment-main m)) (* 4 (ly:moment-grace m))
                                (car p) (cadr p) (caddr p)))))
         ((slur-interface e g source)
          (let* ((c (ly:translator-context source)) (m (ly:context-current-moment c)))
            (when (and (eq? (grob::name g) 'Slur) (equal? (ly:context-id c) "rightMain")
                       (zero? (ly:moment-grace m)) (not (hashq-ref seen g #f)))
              (for-each (lambda (row)
                          (when (= (* 4 (ly:moment-main m)) (cadr row))
                            (hashq-set! seen g #t) (set! slurs (cons (cons g row) slurs))))
                        curve-rows))))
         ((note-column-interface e col source)
          (let* ((c (ly:translator-context source)) (m (ly:context-current-moment c)))
            (when (and (equal? (ly:context-id c) "rightMain") (not (hashq-ref seen col #f)))
              (for-each (lambda (row)
                          (when (and (= (* 4 (ly:moment-main m)) (cadr row))
                                     (= (* 4 (ly:moment-grace m)) (caddr row)))
                            (hashq-set! seen col #t) (set! pending (cons (cons col row) pending))))
                        grace-rows)))))
       ((stop-translation-timestep e)
        (for-each
         (lambda (entry)
           (let* ((col (car entry)) (r (cdr entry)) (key (car r))
                  (heads (array col 'note-heads)) (pitches (map pitch-key heads))
                  (stem (ly:grob-object col 'stem)) (xp (ly:grob-parent col X))
                  (yp (ly:grob-parent col Y)) (causes (map (lambda (h) (ly:grob-property h 'cause)) heads))
                  (hx (map (lambda (h) (ly:grob-parent h X)) heads))
                  (hy (map (lambda (h) (ly:grob-parent h Y)) heads)))
             (unless (equal? pitches (list (list-ref r 3)))
               (ly:error "Unexpected grace-column source pitch: ~a" key))
             (claim key)
             ; Do not let horizontal spacing absorb this optical offset.
             (let ((previous-after (ly:grob-property-data col 'after-line-breaking))
                   (placed #f))
               (ly:grob-set-property! col 'after-line-breaking
                 (lambda (g)
                   (when (procedure? previous-after) (previous-after g))
                   (unless placed
                     (set! placed #t)
                     (let* ((ref (ly:grob-parent g X))
                            (before (ly:grob-relative-coordinate g ref X))
                            (dx (list-ref r 4)))
                       (ly:grob-translate-axis! g dx X)
                       (let ((actual (- (ly:grob-relative-coordinate g ref X) before)))
                         (unless (< (abs (- actual dx)) 0.00001)
                           (ly:error "Late grace-column shift differed: ~a" key))
                         (proof "column-after-spacing" key (list dx actual #t))))))))
             (unless (and (eq? xp (ly:grob-parent col X)) (eq? yp (ly:grob-parent col Y))
                          (eq? stem (ly:grob-object col 'stem)) (equal? heads (array col 'note-heads))
                          (equal? causes (map (lambda (h) (ly:grob-property h 'cause)) heads))
                          (equal? hx (map (lambda (h) (ly:grob-parent h X)) heads))
                          (equal? hy (map (lambda (h) (ly:grob-parent h Y)) heads)))
               (ly:error "Grace-column optical translation changed native ownership: ~a" key))
             (proof "column-selection" key (list (cadr r) (caddr r) pitches (list-ref r 4) #t))))
         pending)
        (set! pending '()))
       ((finalize e)
        (for-each
         (lambda (entry)
           (let* ((slur (car entry)) (r (cdr entry)) (key (car r))
                  (left (ly:spanner-bound slur LEFT)) (right (ly:spanner-bound slur RIGHT))
                  (cols (array slur 'note-columns)) (cause (ly:grob-property slur 'cause))
                  (stencil (ly:grob-property-data slur 'stencil))
                  (old (ly:grob-property-data slur 'control-points))
                  (after (ly:grob-property-data slur 'after-line-breaking))
                  (expected (list-ref r 4)) (index (list-ref r 5)) (delta (list-ref r 6)))
             (unless (and (equal? (bound-keys left) (list-ref r 2))
                          (equal? (bound-keys right) (list-ref r 3)) (procedure? old))
               (ly:error "Nocturne Slur original endpoints/native stencil callback differ: ~a" key))
             (claim key)
             (ly:grob-set-property! slur 'control-points
               (lambda (g)
                 (let* ((native (old g)) (ps (pieces g)) (n (length ps))
                        (idx (list-index (lambda (piece) (eq? piece g)) ps)))
                   (unless (and (list? native) (= (length native) 4) (every number-pair? native))
                     (ly:error "Invalid native Slur controls: ~a" key))
                   (if (and (eq? g (ly:grob-original g)) (= n 1) (> expected 1)) native
                       (begin
                         (unless (and idx (= n expected))
                           (ly:error "Nocturne Slur fragment layout changed: ~a" key))
                         (let* ((space (ly:staff-symbol-staff-space g))
                                (result (if (= index idx)
                                     (map (lambda (p d) (cons (+ (car p) (* space (car d)))
                                                              (+ (cdr p) (* space (cdr d))))) native delta)
                                     native)))
                           (proof "controls" key (list idx n delta native result)) result))))))
             (ly:grob-set-property! slur 'after-line-breaking
               (lambda (g) (when (procedure? after) (after g))
                 (unless (= (length (pieces g)) expected)
                   (ly:error "Rendered nocturne Slur fragment count changed: ~a" key))))
             (unless (and (eq? left (ly:spanner-bound slur LEFT)) (eq? right (ly:spanner-bound slur RIGHT))
                          (equal? cols (array slur 'note-columns)) (eq? cause (ly:grob-property slur 'cause))
                          (eq? stencil (ly:grob-property-data slur 'stencil)))
               (ly:error "Nocturne Slur association or native stencil changed: ~a" key))
             (proof "source-selection" key (list (bound-keys left) (bound-keys right) expected index #t))))
         slurs)
        (for-each (lambda (r) (unless (hash-ref hits (car r) #f)
                                (ly:error "Nocturne optical target missing: ~a" (car r))))
                  (append curve-rows grace-rows))))))

% Three finite changes to the printed X position of complete existing grobs.
% Fields: native grob name, source Voice, source Staff, main/grace quarters,
% expected literal source marking, added X in staff spaces.
#(define nocturne-aFour-mark-shifts
   '((Fingering "rightMain" "1" 259/2 -1/2 "2" -1/4)
     (DynamicText "rightMain" "1" 401/2 0 "pp" 3/8)
     (DynamicText "rightMain" "1" 413/2 0 "ppp" 3/8)))
#(define (nocturne-aFour-mark-staff ctx)
   (cond ((not (ly:context? ctx)) "")
         ((eq? (ly:context-name ctx) 'Staff) (ly:context-id ctx))
         (else (nocturne-aFour-mark-staff (ly:context-parent ctx)))))
#(define (nocturne-aFour-mark-label g)
   (let loop ((event (ly:grob-property g 'cause #f)) (depth 0))
     (cond
       ((and (ly:grob? event) (< depth 8))
        (loop (ly:grob-property event 'cause #f) (+ depth 1)))
       ((not (ly:stream-event? event)) #f)
       ((eq? (grob::name g) 'Fingering)
        (let ((digit (ly:event-property event 'digit #f)))
          (and digit (format #f "~a" digit))))
       (else (ly:event-property event 'text #f)))))
#(define (Nocturne_aFour_mark_clearance_engraver context)
   (let ((matched (make-hash-table 5)) (seen (make-hash-table 200)))
     (make-engraver
       (acknowledgers
         ((grob-interface engraver g source-engraver)
          (when (and (memq (grob::name g) '(Fingering DynamicText))
                     (not (hashq-ref seen g #f)))
            (hashq-set! seen g #t)
            (let* ((ctx (ly:translator-context source-engraver))
                   (m (ly:context-current-moment ctx)))
              (for-each
                (lambda (r)
                  (when (and (eq? (grob::name g) (list-ref r 0))
                             (string=? (ly:context-id ctx) (list-ref r 1))
                             (string=? (nocturne-aFour-mark-staff ctx) (list-ref r 2))
                             (= (* 4 (ly:moment-main m)) (list-ref r 3))
                             (= (* 4 (ly:moment-grace m)) (list-ref r 4))
                             (equal? (nocturne-aFour-mark-label g) (list-ref r 5)))
                    (when (hashq-ref matched r #f)
                      (ly:error "Duplicate Nocturne marking clearance target: ~s" r))
                    (hashq-set! matched r g)))
                nocturne-aFour-mark-shifts)))))
       ((finalize engraver)
        (for-each
          (lambda (r)
            (let ((g (hashq-ref matched r #f)))
              (unless (ly:grob? g)
                (ly:error "Missing Nocturne marking clearance target: ~s" r))
              (let ((old (ly:grob-property g 'extra-offset '(0 . 0)))
                    (xp (ly:grob-parent g X)) (yp (ly:grob-parent g Y))
                    (cause (ly:grob-property g 'cause #f))
                    (text (ly:grob-property-data g 'text))
                    (stencil (ly:grob-property-data g 'stencil)))
                (unless (number-pair? old)
                  (ly:error "Invalid original marking offset: ~s" r))
                (ly:grob-set-property! g 'extra-offset
                  (cons (+ (car old) (list-ref r 6)) (cdr old)))
                (unless (and (eq? xp (ly:grob-parent g X))
                             (eq? yp (ly:grob-parent g Y))
                             (eq? cause (ly:grob-property g 'cause #f))
                             (equal? text (ly:grob-property-data g 'text))
                             (eq? stencil (ly:grob-property-data g 'stencil)))
                  (ly:error "Nocturne marking ownership changed: ~s" r)))))
          nocturne-aFour-mark-shifts)))))

\layout {
  \context { \Staff
    printKeyCancellation = ##f
    pedalSustainStyle = #'text
    \override SustainPedalLineSpanner.staff-padding = #2
  }
  \context { \Score
    \consists #Nocturne_four_optics_engraver
    \consists #Nocturne_aFour_mark_clearance_engraver
    autoBeaming = ##f
    \override SpacingSpanner.base-shortest-duration = #(ly:make-moment 1/16)
    \override SpacingSpanner.shortest-duration-space = #2.2
    \override SpacingSpanner.spacing-increment = #1.3
  }
  \context { \PianoStaff
    \override StaffGrouper.staff-staff-spacing = #'((basic-distance . 14) (minimum-distance . 12) (padding . 3) (stretchability . 2))
  }
}

PartPOneVoiceOne = {
  % XML measure 0 (pickup)
  \clef "treble" \time 12/8 \key es \major \partial 8 \once \override DynamicText.stencil = ##f \D bes'8 -2 ^\markup
  \fontsize #0.753 \bold Andante -\tweak extra-offset #'(7.5 . 0) _\markup \fontsize #-0.001 \italic
  "espress. dolce" _\p |
  % XML measure 1
  \D g''4. ~ -5 ( \D g''8 [ \D f''8 -3 \D g''8 ] \D f''4.
  \D es''4 ) \D bes'8 ( | % End XML measure 1
  % XML measure 2
  \D g''4 _\<
  \once \override Fingering.text = \markup \concat {
    "1" \hspace #0.08 "4" \hspace #0.08
    "3" \hspace #0.08 "2" \hspace #0.08 "1"
  }
  \D c''!8 -14321 ^\turn \D c'''4 \D g''8 \! \D bes''4. \D as''4 \D
  g''8 ) | % End XML measure 2
  % XML measure 3
  \break
  \D f''4. -14 \D g''4 ( \D d''8 ) \D es''4. \D c''4. -2 | % End XML measure 3
  % XML measure 4
  \D bes'8 ( [ \D d'''8 ) \D c'''8 ( ] \D bes''16 [ \D as''16 \D g''16 \D as''16
  -4 ) \D c''16 ( \D d''16 ] \D es''4. ) r4 \D bes'8 ( | % End XML measure 4
  % XML measure 5
  \D g''4. ) _\p \D f''16 [ \D g''16 \D f''16 -3 ^\prall \D e''16 \D f''16 \D
  g''16 ] \D f''8 \D es''4 ~ -> \D es''16 [ \D f''16 \D es''16 ^\prall \D d''16
  \D es''16 -3 \D f''16 ] | % End XML measure 5
  % XML measure 6
  \D g''16 [ _\markup \italic "cresc." _\< \D b'16 \D c''16 \D des''16 -3 ( \D
  c''16 ) \D f''16 -3 ( ] \D e''16 ) [ \D as''16 -3 ( \D g''16 ) \D des'''!16 -4
  ( \D c'''16 \D g''16 ] \D bes''4. -4 ) \! _\> \D as''4 \! \D g''8 | % End XML measure 6
  % XML measure 7
  \break
  \D f''4. -132 \startTrillSpan \grace { \U e''16 \stopTrillSpan [ \U f''16 ] }
  \D g''8 -. [ \D g''8 -5 ( \D d''8 -2 ) ] \D es''4. -3 ( \D c''4. ) | % End XML measure 7
  % XML measure 8
  \D bes'8 ( [ \D d'''8 ) \D c'''8 ( -. ] \D bes''16 -. [ \D as''16 -. \D g''16
  -. \D as''16 -3 -. \slashedGrace { \U as''8 -4 \=2( } \D c''16 \=2) \D d''16 )
  ] \D es''4. ~ \D es''8 [ \D d''8 \D es''8 ] | % End XML measure 8
  % XML measure 9
  \break
  \D f''4. _\p \D g''4 ( -> \D f''8 ) \D f''4. -3 ( _\pp \D c''4. ) | % End XML measure 9
  % XML measure 10

  
  \D es''8 -3 ( -. [ _\markup \italic simile ^\markup \fontsize #-0.001 \italic
  "poco rit." \D es''8 -2 -. \D es''8 -1 -. ] \D es''8 -3 ) [ \D d''16 ( \D es''16
  \D f''16. \D es''32 ] \D es''4. -4 ) \D bes'4. | % End XML measure 10
  % XML measure 11
  \D bes''4. -4 ^\markup \fontsize #-0.001 \italic "a tempo" _\f \D a''4 -5 \D
  g''8 \D <a'! f'' -5>4. \D <bes' d'' -4>4. | % End XML measure 11
  % XML measure 12
  \break
  \D <g' es''>4. \D <a' d'' -5>8 ( -. [ \D <a' c''>8 -. \D <a' d''>8 -. ] \U <f'
    bes'>8 ) [ \U <fis' b' -4>8 ( _\markup \italic "poco rallent." _\< \U <e'
    b'>8 ] \U <e' bes' c''>8 [ \U <f' a'! c'' -4>8 \U <as' d''>8 ) ] <>\! | % End XML measure 12
  % XML measure 13
  \grace { \U g'16 ( [ _\fzp ^\markup \italic "a tempo"  \U bes'16 ) \U es''16
    ] } \D g''4 \U a'16 ( [ \U bes'16 ] \D ces''16 -> [ \D bes'16 \D cis''16 \D
  d''16 -1 \D g''16. -5 -> \D f''32 ) ] \D f''4 -3 \D es''8 ~ \D es''16 [ \D f''16
  \D es''16 ^\prall \D d''16 \D es''16 \D f''16 ] | % End XML measure 13
  % XML measure 14
  \break
  \D g''16 [ _\< \D b'16 \D c''16 \D des''16 ( \D c''16 ) \D f''16 ( ] \D e''16
  ) [ \! _\markup \italic "cresc." \D as''16 ( \D g''16 ) \D des'''!16 ( \D c'''16
  \D g''16 ] \D bes''4. ) \D as''4 _\> \D g''8 <>\! | % End XML measure 14
  % XML measure 15
  \D f''4. \startTrillSpan _\p \grace { \U e''16 \stopTrillSpan [ \U f''16 ] }
  \D g''8 -. [ \D g''8 ( \D d''8 ) ] \D es''4. _\< \D c''4. <>\! | % End XML measure 15
  % XML measure 16
  \break
  \override Fingering.avoid-slur = #'outside
  \override Fingering.slur-padding = #0.4
  \D bes'8 ( [ \D d'''8 )
  \shape #'((0 . 1.0) (0 . 1.0) (0 . 1.0) (0 . 1.0)) Slur
  \D des'''8 ( ] \D c'''32 -5 [ \D b''32 -4 \D bes''32
  -3 \D a''32 -1 \D as''32 -4 \D f''32 -3 \D d''32 -2 \D ces''32 ) -> \D bes'32
  -2 \D d''32 -3 \tweak TupletBracket.stencil ##f \tuplet 3/2 {
    \D g''32 \D f''32 \D es''32 -3 ] }
  \D es''4. ~ -2 \D es''8 [ \D d''8 \D es''8 -3 ] | % End XML measure 16
  \revert Fingering.avoid-slur
  \revert Fingering.slur-padding
  % XML measure 17
  \D f''4. ( \D g''4 \D f''8 ) \D f''4. ( \D c''4. ) | % End XML measure 17
  % XML measure 18
  \break
  \tweak TupletBracket.stencil ##f \tuplet 4/3 {
    \D es''8 ( [ \D es''8 \D es''8 \D es''8 ] }
  \D es''8 [ \D d''16 \D es''16 \D f''16. \D es''32 ] \D es''4. ) \D bes'4. _\<
  <>\! | % End XML measure 18
  % XML measure 19
  \D bes''4. ( _\f \D a''4 ) \D g''8 \D <a'! f''>4. _\> \D <bes' d''>4. <>\! | % End XML measure 19
  % XML measure 20
  \pageBreak

  
  \D <g' es''>4. \D <a' d''>8 ( -. [ \D <a' c''>8 -. \D <a' d''>8 ) -. ] \U <f'
    bes'>8 ( [ _\< \U <fis' b'>8 _\markup \italic "poco rallent." \U <e' b'>8 ]
  \U <e' bes' c''>8 [ \U <f' a'! c''>8 \U <as' d''>8 ) ] <>\! | % End XML measure 20
  % XML measure 21
  \grace { \U g'16 ( [ _\fzp ^\markup \italic "a tempo"  \U bes'16 ) \U es''16
    ] } \D g''4 \U a'16 ( [ \U bes'16 ] \D ces''16 -> [ \D bes'16 \D cis''16 \D
  d''16 \D g''16. -> \D f''32 ) ] \D f''4 _\> \D es''8 ( \! \D es''16 ) [ _\< \D
  f''16 \D es''16 ^\trill \D d''16 \D es''16 \D f''16 ( ] <>\! | % End XML measure 21
  % XML measure 22
  \break
  \D g''16 ) [ \D b'16 \D c''16 \D des''16 ( \D c''16 ) \D f''16 ( ] \D e''16 )
  [ _\< \D as''16 ( \D g''16 ) \D des'''!16 ( \D c'''16 \D g''16 ] \slashedGrace
  { \U g''8 -2 } \D bes''4. ) \D as''4 \D g''8 <>\! | % End XML measure 22
  % XML measure 23
  \D f''4. -132 \startTrillSpan \grace { \U e''8 \stopTrillSpan [ \U f''8 ] } \D
  g''8 -! [ \D g''8 ( \D d''8 ) ] \D es''4. \D c''4. | % End XML measure 23
  % XML measure 24
  \break
  \D bes'16 ( [ \D d'''8 \D cis'''16 \D c'''16 -5 \D b''16 ] \D bes''16 [ \D a''16
  -1 ) \D as''16 -4 -! \tuplet 3/2 {
    \D a'32 ( \D bes'32 \D c''32 }
  \D cis''32 \D d''32 -1 \tuplet 3/2 {
    \D g''32 -5 \D f''32 \D es''32 ) ] }
  \D es''2. | % End XML measure 24
  % XML measure 25
  \D es''4. _\p \D f''8 ( [ \D es''8 \D f''8 ] \D g''2. ) | % End XML measure 25
  % XML measure 26
  \D es''4. ~ ( _\pp \D es''16 [ \D f''16 \D es''16 \D f''16 \D es''16 \D f''16
  ] \D g''4 -5 ) _\markup \italic "poco rubato" \D es''8 ( ^\turn \D es'''8 -5 )
  [ \D d'''8 -4 \D c'''8 -1 ] | % End XML measure 26
  % XML measure 27
  \D bes''4 -4
  \once \override Fingering.avoid-slur = #'outside
  \once \override Fingering.slur-padding = #0.4
  \shape #'((0 . 0.6) (0 . 1.0) (0 . 1.0) (0 . 1.0)) Slur
  \D a''8 -5 ( \D as''8 ) [ \D c''8 \D d''8 ] \D es''8 [ \D f''16
  \D es''16 ^\prall \D d''16 \D es''16 ] \grace { \U es''16 _\markup \italic
    "dolciss." } \D g'''8 [
  \shape #'(((0 . 0) (0 . 0) (0 . 0) (0 . 0))
             ((0 . 1.1) (0 . 1.1) (0 . 1.1) (0 . 1.1))) Slur
  \D f'''16 -4 ( -. \D es'''16 -3 -. \D d'''16 -2 -.
  \D c'''16 -1 -. ] | % End XML measure 27
  % XML measure 28
  \break
  \override Fingering.avoid-slur = #'outside
  \override Fingering.slur-padding = #0.4
  \D ces'''8 -3 [ \D bes''8 -4 \D beses''8 -3 ) ] \D beses''16 -3 ( [ \D as''16
  ) \D as''16 -3 ( \D g''16 ) \D g''16. -4 ( \D f''32 ) ] \D es''2. -3 -> | % End XML measure 28
  \revert Fingering.avoid-slur
  \revert Fingering.slur-padding
  % XML measure 29
  \D es''4. ~ _\p \tuplet 8/6 {
    \D es''16 [ \D f''16 ( \D es''16 \D f''16 \D es''16 ) \D f''16 ( _\< \D es''16
    ) \D f''16 ] }
  \D es''2. \! | % End XML measure 29
  % XML measure 30
  \break

  
  \D es''8 -3 -! [ _\f _\markup \italic "con forza" \D as'16 ( \D bes'16 -3 \D
  as'16 ^\trill \D g'16 ] \D as'16 [ \D ces''16 -1 \D es''16 -2 \D as''16 -3 \D
  es'''16 ) ] r32 \once \override Stem.length = #13 \D f'''32 -3 ( \D g'''8 [ \D es'''8 ) ] \ottava #1 \D <es'''
    es''''>4 _\> \D <d''' d''''>8 [ \! \D <c''' c''''!>8 ] ^\markup \fontsize
  #-0.001 \italic stretto | % End XML measure 30
  % XML measure 31
  \D <ces''' ces''''>8 [ \D <bes'' bes'''>8 \D <beses'' beses'''!>8 ] \D <as''!
    as'''!>8 [ \D <g''! g'''!>8 \D <d'' d'''>8 ] \U <es'' es'''>8 \D <es'''
    es''''>4. -> \D <f'' f'''>8 [ \D <c''' c''''!>8 ] | % End XML measure 31
  % XML measure 32
  \break
  \D <ces''' ces''''>2. ^^ _\ff \D <bes'' bes'''>2. ^\fermata ^^ | % End XML measure 32
  % XML measure 33
  \once \omit Staff.TimeSignature \time 6/4 \set Timing.measureLength = #3/4 \D ces''''32 -3 [ _\markup \bold
  \italic "Senza tempo" \D bes'''32 -2 \D c''''32 -4 \D a'''32 -1 ] \D ces''''32
  [ _\< \D bes'''32 \D c''''32 \D a'''32 ] \D ces''''32 [ \D bes'''32 \D c''''32
  \D a'''32 ] \D ces''''32 [ \D bes'''32 \D c''''32 \D a'''32 ] \D ces''''32 [
  \D bes'''32 \D c''''32 \D a'''32 ] \D ces''''32 [ \D bes'''32 \D c''''32 \D
  a'''32 ] <>\!  | % End XML measure 33
  % XML measure 34
  \break
  \D ces''''32 [ \D bes'''32 \D c''''32 \D a'''32 ] \D ces''''32 [ \D bes'''32
  \D c''''32 \D a'''32 ] \D ces''''32 [ \D bes'''32 \D c''''32 \D a'''32 ] \D
  ces''''32 [ \D bes'''32 \D c''''32 \D a'''32 ] \D ces''''32 [ _\> \D bes'''32
  \D c''''32 \D a'''32 ] \D ces''''32 [ \D bes'''32 \D c''''32 \D a'''32 ] \!
   | % End XML measure 34
  % XML measure 35
  \break
  \time 2/4 \D ces''''32 [ \D bes'''32 \D d''''32 \D c''''32 ] \D bes'''32 [
  _\markup \bold \italic "rallent. smorz." \D a'''32 \D as'''32 \D g'''32 ] \U
  f'''32 ( [ \U d'''32 \U es'''32 \U c'''32 ] \U bes''32 [ \U as''32 \U c''32 \U
  d''32 ) ] \ottava #0 | % End XML measure 35
  % XML measure 36
  \once \omit Staff.TimeSignature \time 12/8 \D <g' es''>8 ( [ _\pp ^\markup
  \italic "a tempo" \D bes'8 \D g''8 ] \D <g' es''>8 [ \D bes'8 \D g''8 ] \D <g'
    es''>8 [ \D bes'8 \D g''8 ] \D <g' es''>8 [ \D bes'8 \D g''8 ) ] | % End XML measure 36
  % XML measure 37
  \D <g' es''>4. _\ppp \D <g'' es'''>4. \U <g es'>2. ^\fermata \bar "|."
}

PartPOneVoiceFive = {
  % XML measure 0 (pickup)
  \clef "bass" \time 12/8 \key es \major \partial 8 r8 |
  % XML measure 1
   \D es,8 -. [  \D <g es' -2>8
  \=2( \D <bes es' g'>8 \=2) ]  \D es8 -. [  \D <as d'>8
  \=2( \D <ces' d' as'>8 \=2) ]  \D es,8 -. [  \D <g
    es'>8 \=2( \D <bes es' g'>8 \=2) ]  \D d,8 -. [  \D
  <g es'>8 \=2( \D <bes es' g'>8 \=2) ]  | % End XML measure 1
  % XML measure 2
  \D c,8 [ _\markup \italic "Ped. simile" \D <g e'>8 \D <bes e' g'>8 ] \D c8 [
  \D <g e'>8 \D <c' e' bes'>8 ] \D f,8 [ \D <f des'>8 \D <bes des' e'>8 ] \D f,8
  [ \D <f c'>8 \D <as c' f'>8 ] | % End XML measure 2
  % XML measure 3
  \D bes,8 [ \D <f d'>8 \D <bes d' as'>8 ] \D b,8 [ \D <g f'>8 \D <d' f' g'>8 ]
  \D c8 [ \D <g es'>8 \D <c' es' g'>8 ] \D a,8 [ \D <ges es'>8 \D <c' es' ges'!>8
  ] | % End XML measure 3
  % XML measure 4
  \D bes,8 [ \D <f es'>8 \D <bes es' as'>8 ] \D bes,,8 [ \D <f d'>8 \D <bes as'>8
  ] \D es,8 [ \D <g es'>8 \D <bes es' g'>8 ] \D es8 [ \D <g es'>8 \D <bes es'
    g'>8 ] | % End XML measure 4
  % XML measure 5
  \D es8 [ \D <g es'>8 \D <bes es' g'>8 ] \D es8 [ \D <as d'>8 \D <ces' d' as'>8
  ] \D es8 [ \D <g es'>8 \D <bes es' g'>8 ] \D d8 [ \D <g es'>8 \D <bes es' g'>8
  ] | % End XML measure 5
  % XML measure 6
  \D c8 [ \D <g e'>8 \D <bes e' g'>8 ] \D c8 [ \D <g e'>8 \D <c' e' bes'>8 ] \D
  f,8 [ \D <f des'>8 \D <bes des' e'>8 ] \D f,8 [ \D <f c'>8 \D <as c' f'>8 ] | % End XML measure 6
  % XML measure 7
  \D bes,8 [ \D <f d'>8 \D <bes d' as'>8 ] \D b,8 [ \D <g f'>8 \D <d' f' g'>8 ]
  \D c8 [ \D <g es'>8 \D <c' es' g'>8 ] \D a,8 [ \D <ges es'>8 \D <c' es' ges'!>8
  ] | % End XML measure 7
  % XML measure 8
  \D bes,8 [ \D <f es'>8 \D <bes es' as'>8 ] \D bes,,8 [ \D <f d'>8 \D <bes as'>8
  ] \D es,8 [ \D <g es'>8 \D <bes es' g'>8 ] \D es8 [ \D <g es'>8 \D <bes es'
    g'>8 ] | % End XML measure 8
  % XML measure 9
  \D bes,8 [ \D <f d'>8 ( \D <bes d' f'>8 ) ] \D bes,8 [ \D <f d'>8 ( \D <bes d'
    f'>8 ) ] \D a,8 [ \D <f c'>8 ( \D <c' f'>8 ) ] \D a,8 [ \D <f c'>8 ( \D <c'
    f'>8 ) ] | % End XML measure 9
  % XML measure 10

  
  \D as,!8 [ \D <es c'>8 \D <as c' es'>8 ] \D as,,8 [ \D <es ces'>8 \D <as ces'
    es'>8 ] \D es,8 [ \D <g es'>8 ( \D <bes es' g'>8 ) ] \D es8 [ \D <g es'>8 (
  \D <bes es' g'>8 ) ] | % End XML measure 10
  % XML measure 11
  \D e,8 [ \D <e! des'>8 \D <bes des' g'>8 ] \D e,8 [ \D <e c'>8 \D <bes c' g'>8
  ] \D f,8 [ \D <f es'>8 \D <c' es' a'>8 ] \D g,8 [ \D <g d'>8 \D <bes d' bes'>8
  ] | % End XML measure 11
  % XML measure 12
  \D c,8 [ \D <g es'>8 \D <c' es' g'>8 ] \D f,8 [ \D <f es'>8 \D <c' es' f'>8 ]
  \D <bes d'>8 [ \D <a dis'>8 \D gis8 ] \D g8 [ \D <f c' es'!>8 \D <bes f'>8 ] | % End XML measure 12
  % XML measure 13
  \D es,8 [ \D <g es'>8 \D <bes es' g'>8 ] \D es8 [ \D <as d'>8 \D <bes d' as'>8
  ] \D es8 [ \D <g es'>8 \D <bes es' g'>8 ] \D d8 [ \D <g es'>8 \D <bes es' g'>8
  ] | % End XML measure 13
  % XML measure 14
  \D c8 [ \D <g e'>8 \D <bes e' g'>8 ] \D c8 [ \D <g e'>8 \D <c' e' bes'>8 ] \D
  f,8 [ \D <f des'>8 \D <bes des' e'>8 ] \D f,8 [ \D <f c'>8 \D <as c' f'>8 ] | % End XML measure 14
  % XML measure 15
  \D bes,8 [ \D <f d'>8 \D <bes d' as'>8 ] \D b,8 [ \D <g f'>8 \D <d' f' g'>8 ]
  \D c8 [ \D <g es'>8 \D <c' es' g'>8 ] \D a,8 [ \D <ges es'>8 \D <c' es' ges'!>8
  ] | % End XML measure 15
  % XML measure 16
  \D bes,8 [ \D <f es'>8 \D <bes es' as'>8 ] \D bes,,8 [ \D <f d'>8 \D <bes d'
    as'>8 ] \D es,8 [ \D <g es'>8 \D <bes es' g'>8 ] \D es8 [ \D <g es'>8 \D
  <bes es' g'>8 ] | % End XML measure 16
  % XML measure 17
  \D bes,8 [ \D <f d'>8 \D <bes d' f'>8 ] \D bes,8 [ \D <f d'>8 \D <bes d' f'>8
  ] \D a,8 [ \D <f c'>8 \D <c' f'>8 ] \D a,8 [ \D <f c'>8 \D <c' f'>8 ] | % End XML measure 17
  % XML measure 18
  \D as,8 [ \D <es c'>8 \D <as c' es'>8 ] \D as,,8 [ \D <es ces'>8 \D <as ces'
    es'>8 ] \D <es, es>8 [ \D <g es'>8 \D <bes es' g'>8 ] \D <es, es>8 [ \D <g
    es'>8 \D <bes es' g'>8 ] | % End XML measure 18
  % XML measure 19
  \D e,8 [ \D <e! des'>8 \D <bes des' g'>8 ] \D e,8 [ \D <e c'>8 \D <bes c' g'>8
  ] \D f,8 [ \D <f es'>8 \D <c' es' a'>8 ] \D g,8 [ \D <g d'>8 \D <bes d' bes'>8
  ] | % End XML measure 19
  % XML measure 20

  
  \D c,8 [ \D <g es'>8 \D <c' es' g'>8 ] \D f,8 [ \D <f es'>8 \D <c' es' f'>8 ]
  \D <bes d'>8 [ \D <a dis'>8 \D gis8 ] \D g8 [ \D <f c' es'!>8 \D <bes f'>8 ] | % End XML measure 20
  % XML measure 21
  \D es,8 -. [ \D <g es'>8 \D <bes es' g'>8 ] \D es8 -. [ \D <as d'>8 \D <bes d'
    as'>8 ] \D es8 -. [ \D <g es'>8 \D <bes es' g'>8 ] \D d8 [ \D <g es'>8 \D
  <bes es' g'>8 ] | % End XML measure 21
  % XML measure 22
  \D c8 -. [ \D <g e'>8 \D <bes e' g'>8 ] \D c8 -. [ \D <g e'>8 \D <c' e' bes'>8
  ] \D f,8 [ \D <f des'>8 \D <bes des' e'>8 ] \D f,8 [ \D <f c'>8 \D <as c' f'>8
  ] | % End XML measure 22
  % XML measure 23
  \D bes,8 [ \D <f d'>8 \D <bes d' as'>8 ] \D b,8 [ \D <g f'>8 \D <d' f' g'>8 ]
  \D c8 [ \D <g es'>8 \D <c' es' g'>8 ] \D a,8 [ \D <ges es'>8 \D <c' es' ges'!>8
  ] | % End XML measure 23
  % XML measure 24
  \D bes,8 [ \D <f es'>8 \D <bes es' as'>8 ] \D bes,,8 [ \D <f d'>8 \D <bes d'
    as'>8 ] \D es,8 [ \D <g es'>8 \D <bes es' g'>8 ] \D es8 [ \D <g es'>8 \D
  <bes es' g'>8 ] | % End XML measure 24
  % XML measure 25
  \D es,8 [ \D <as ces' es'>8 \D <ces' es' as'>8 ] \D es8 [ \D <as ces' es'>8 \D
  <ces' es' as'>8 ] \D es,8 [ \D <g es'>8 \D <bes es' g'>8 ] \D es8 [ \D <g es'>8
  \D <bes es' g'>8 ] | % End XML measure 25
  % XML measure 26
  \D es,8 [ \D <as ces' es'>8 \D <ces' es' as'>8 ] \D es8 [ \D <as ces' es'>8 \D
  <ces' es' as'>8 ] \D es,8 [ \D <g bes es'>8 \D <bes es' g'>8 ] \D es8 [ \D <g
    es'>8 \D <bes es' g'>8 ] | % End XML measure 26
  % XML measure 27
  \D es8 [ \D <f d'>8 \D <bes as'>8 ] \D es8 [ \D <f d'>8 \D <bes as'>8 ] \D es8
  [ \D <g es'>8 \D <bes g'>8 ] \D a,8 [ \D <f es'>8 \D <c' es' f'>8 ] | % End XML measure 27
  % XML measure 28
  \D bes,8 [ \D <f es'>8 \D <bes es' as'>8 ] \D bes,,8 [ \D <f d'>8 \D <bes d'
    as'>8 ] \D es,8 [ \D <g es'>8 \D <bes es' g'>8 ] \D es8 [ \D <g es'>8 \D
  <bes es' g'>8 ] | % End XML measure 28
  % XML measure 29
  \D as,,8 [ \D <es as ces' -1>8 \D <as ces' es' -2>8 ] \D <ces' es' as'>8 [ \D
  <as ces' es'>8 \D <es as ces'! -1>8 ] \D es,8 [ \D <g es'>8 \D <bes es' g'>8 ]
  \D es8 [ \D <g es'>8 \D <bes es' g'>8 ] | % End XML measure 29
  % XML measure 30

  
  \U as,,8 [ \U <es as>8 \U <as ces' es'>8 ] \D <ces' es' as'>8 [ \D <as ces'
    es'>8 \D <es as ces'>8 ] \D es,8 [ \D <g es'>8 \D <bes es' g'>8 ] \D a,8 [
  \D <g es'>8 \D <c' es' f'>8 ] | % End XML measure 30
  % XML measure 31
  \D bes,8 [ \D <f bes es'>8 \D <bes es' as'>8 ] \D b,8 [ \D <g f'>8 \D <d' f'
    g'>8 ] \D c8 [ \D <g es'>8 \D <c' g'>8 ] \D a,8 [ \D <f c' es'>8 \D <c' es'
    f'>8 ] | % End XML measure 31
  % XML measure 32
  \tuplet 8/6 {
    \U bes,,8 [  \U bes,8 \U f8 \U as8 ] \D d'8 [ \D bes8 \D f'8 \D
    as'8 ] }
  \D d''2. ^\fermata | % End XML measure 32
  % XML measure 33
  \once \omit Staff.TimeSignature \time 6/4 \set Timing.measureLength = #3/4 R1*3/4  | % End XML measure 33
  % XML measure 34
  R1*3/4  | % End XML measure 34
  % XML measure 35
  \time 2/4 R2 | % End XML measure 35
  % XML measure 36
  \once \omit Staff.TimeSignature \time 12/8 \U es,8 ( [   \U bes8 \U bes,8 ] \D es8 [ \D bes8 \D bes,8 ) ] \U es,8 ( [ \U
  bes8 \U bes,8 ] \D es8 [ \D bes8 \D bes,8 ] | % End XML measure 36
  % XML measure 37
  \D <es bes>4. ) \D <es' bes' -2>4. \U <es, bes,>2. ^\fermata 
  \bar "|."
}


playbackTempo = {
  \set Score.tempoWholesPerMinute = #(/ 60 4) s1*1/8 | % XML measure 0
  s1*3/2 | % XML measure 1
  s1*3/2 | % XML measure 2
  s1*3/2 | % XML measure 3
  s1*3/2 | % XML measure 4
  s1*3/2 | % XML measure 5
  s1*3/2 | % XML measure 6
  s1*3/2 | % XML measure 7
  s1*3/2 | % XML measure 8
  s1*3/2 | % XML measure 9
  s1*3/2 | % XML measure 10
  s1*3/2 | % XML measure 11
  s1*3/2 | % XML measure 12
  s1*3/2 | % XML measure 13
  s1*3/2 | % XML measure 14
  s1*3/2 | % XML measure 15
  s1*3/2 | % XML measure 16
  s1*3/2 | % XML measure 17
  s1*3/2 | % XML measure 18
  s1*3/2 | % XML measure 19
  s1*3/2 | % XML measure 20
  s1*3/2 | % XML measure 21
  s1*3/2 | % XML measure 22
  s1*3/2 | % XML measure 23
  s1*3/2 | % XML measure 24
  s1*3/2 | % XML measure 25
  s1*3/2 | % XML measure 26
  s1*3/2 | % XML measure 27
  s1*3/2 | % XML measure 28
  s1*3/2 | % XML measure 29
  s1*3/2 | % XML measure 30
  s1*3/2 | % XML measure 31
  s1*3/2 | % XML measure 32
  \set Score.tempoWholesPerMinute = #(/ 35 4) s1*1/8 \set Score.tempoWholesPerMinute = #(/ 40 4) s1*1/8 \set Score.tempoWholesPerMinute = #(/ 60 4) s1*1/4 \set Score.tempoWholesPerMinute = #(/ 350001 20000) s1*1/4 | % XML measure 33
  s1*1/8 \set Score.tempoWholesPerMinute = #(/ 399999 20000) s1*5/8 | % XML measure 34
  \set Score.tempoWholesPerMinute = #(/ 50 4) s1*1/4 \set Score.tempoWholesPerMinute = #(/ 35 4) s1*1/8 \set Score.tempoWholesPerMinute = #(/ 20 4) s1*1/8 | % XML measure 35
  \set Score.tempoWholesPerMinute = #(/ 60 4) s1*3/2 | % XML measure 36
  s1*3/2 | % XML measure 37
}

pedalLayout = {
  \override TextScript.staff-padding = #2
  s1*1/8 | % XML measure 0
  <>_\markup \concat { \musicglyph "pedal.Ped" \hspace #0.08 \musicglyph "pedal.." } s1*3/8 <>_\markup \concat { \musicglyph "pedal.Ped" \hspace #0.08 \musicglyph "pedal.." } s1*3/8 <>_\markup \concat { \musicglyph "pedal.Ped" \hspace #0.08 \musicglyph "pedal.." } s1*3/8 <>_\markup \concat { \musicglyph "pedal.Ped" \hspace #0.08 \musicglyph "pedal.." } s1*3/8 | % XML measure 1
  s1*3/2 | % XML measure 2
  s1*3/2 | % XML measure 3
  s1*3/2 | % XML measure 4
  s1*3/2 | % XML measure 5
  s1*3/2 | % XML measure 6
  s1*3/2 | % XML measure 7
  s1*3/2 | % XML measure 8
  s1*3/2 | % XML measure 9
  s1*3/2 | % XML measure 10
  s1*3/2 | % XML measure 11
  s1*3/2 | % XML measure 12
  s1*3/2 | % XML measure 13
  s1*3/2 | % XML measure 14
  s1*3/2 | % XML measure 15
  s1*3/2 | % XML measure 16
  s1*3/2 | % XML measure 17
  s1*3/2 | % XML measure 18
  s1*3/2 | % XML measure 19
  s1*3/2 | % XML measure 20
  s1*3/2 | % XML measure 21
  s1*3/2 | % XML measure 22
  s1*3/2 | % XML measure 23
  s1*3/2 | % XML measure 24
  s1*3/2 | % XML measure 25
  s1*3/2 | % XML measure 26
  s1*3/2 | % XML measure 27
  s1*3/2 | % XML measure 28
  s1*3/2 | % XML measure 29
  s1*3/2 | % XML measure 30
  s1*3/2 | % XML measure 31
  <>_\markup \concat { \musicglyph "pedal.Ped" \hspace #0.08 \musicglyph "pedal.." } s1*3/2 | % XML measure 32
  s1*3/4 | % XML measure 33
  <>_\markup \concat { "(" \hspace #0.15 \concat { \musicglyph "pedal.Ped" \hspace #0.08 \musicglyph "pedal.." } \hspace #0.15 ")" } s1*3/4 | % XML measure 34
  <>_\markup \concat { "(" \hspace #0.15 \concat { \musicglyph "pedal.Ped" \hspace #0.08 \musicglyph "pedal.." } \hspace #0.15 ")" } s1*1/2 <>_\markup \musicglyph "pedal.*" | % XML measure 35
  <>_\markup \concat { \musicglyph "pedal.Ped" \hspace #0.08 \musicglyph "pedal.." } s1*3/2 | % XML measure 36
  s1*3/2 <>_\markup \musicglyph "pedal.*" | % XML measure 37
}

pedalMidi = {
  s1*1/8 | % XML measure 0
  <> \sustainOn s1*3/8 <> \sustainOff \sustainOn s1*3/8 <> \sustainOff \sustainOn s1*3/8 <> \sustainOff \sustainOn s1*3/8 <> \sustainOff | % XML measure 1
  s1*3/2 | % XML measure 2
  s1*3/2 | % XML measure 3
  s1*3/2 | % XML measure 4
  s1*3/2 | % XML measure 5
  s1*3/2 | % XML measure 6
  s1*3/2 | % XML measure 7
  s1*3/2 | % XML measure 8
  s1*3/2 | % XML measure 9
  s1*3/2 | % XML measure 10
  s1*3/2 | % XML measure 11
  s1*3/2 | % XML measure 12
  s1*3/2 | % XML measure 13
  s1*3/2 | % XML measure 14
  s1*3/2 | % XML measure 15
  s1*3/2 | % XML measure 16
  s1*3/2 | % XML measure 17
  s1*3/2 | % XML measure 18
  s1*3/2 | % XML measure 19
  s1*3/2 | % XML measure 20
  s1*3/2 | % XML measure 21
  s1*3/2 | % XML measure 22
  s1*3/2 | % XML measure 23
  s1*3/2 | % XML measure 24
  s1*3/2 | % XML measure 25
  s1*3/2 | % XML measure 26
  s1*3/2 | % XML measure 27
  s1*3/2 | % XML measure 28
  s1*3/2 | % XML measure 29
  s1*3/2 | % XML measure 30
  s1*3/2 | % XML measure 31
  <> \sustainOn s1*3/2 | % XML measure 32
  s1*3/4 | % XML measure 33
  s1*3/4 | % XML measure 34
  s1*1/2 | % XML measure 35
  s1*1/8 <> \sustainOff s1*11/8 | % XML measure 36
  s1*3/2 | % XML measure 37
}

% Print-only copy: remove obsolete forced line/page breaks, preserving
% all music variables and the MIDI score exactly as submitted.
#(define (nocturne-aFour-print music)
   (music-filter
     (lambda (m)
       (not (memq (ly:music-property m 'name)
                  '(LineBreakEvent PageBreakEvent))))
     (ly:music-deep-copy music)))

% This zero-sound layout track keeps the source XML27/28 slur's original
% two-piece graphical shape and gives the dense XML30 and XML33 runs their
% own systems. Other line/page breaks are chosen by the native layout engine.
aFourLayout = {
  s1*1/8 | % XML measure 0
  s1*3/2 | % XML measure 1
  s1*3/2 | % XML measure 2
  s1*3/2 | % XML measure 3
  s1*3/2 | % XML measure 4
  s1*3/2 | % XML measure 5
  s1*3/2 | % XML measure 6
  s1*3/2 | % XML measure 7
  s1*3/2 | % XML measure 8
  s1*3/2 | % XML measure 9
  s1*3/2 | % XML measure 10
  s1*3/2 | % XML measure 11
  s1*3/2 | % XML measure 12
  s1*3/2 | % XML measure 13
  s1*3/2 | % XML measure 14
  s1*3/2 | % XML measure 15
  s1*3/2 | % XML measure 16
  s1*3/2 | % XML measure 17
  s1*3/2 | % XML measure 18
  s1*3/2 | % XML measure 19
  s1*3/2 | % XML measure 20
  s1*3/2 | % XML measure 21
  s1*3/2 | % XML measure 22
  s1*3/2 | % XML measure 23
  s1*3/2 | % XML measure 24
  s1*3/2 | % XML measure 25
  s1*3/2 | % XML measure 26
  s1*3/2 | % XML measure 27
  \break
  s1*3/2 | % XML measure 28
  s1*3/2 | % XML measure 29
  s1*3/2 | % XML measure 30
  \break
  s1*3/2 | % XML measure 31
  s1*3/2 | % XML measure 32
  \break
  s1*3/4 | % XML measure 33
  s1*3/4 | % XML measure 34
  s1*1/2 | % XML measure 35
  s1*3/2 | % XML measure 36
  s1*3/2 | % XML measure 37
}

% All music is contained in this file; no external includes are required.
\score {
  \new PianoStaff <<
    \set PianoStaff.instrumentName = "Piano"
    \context Staff = "1" <<
      \mergeDifferentlyDottedOn
      \mergeDifferentlyHeadedOn
      \new Voice = "rightMain" { \applyMusic #nocturne-aFour-print \PartPOneVoiceOne }
      \new NullVoice = "aFourLayout" { \aFourLayout }
    >>
    \context Staff = "2" <<
      \mergeDifferentlyDottedOn
      \mergeDifferentlyHeadedOn
      \new Voice = "leftMain" { \PartPOneVoiceFive }
      \new Voice = "printedPedal" { \pedalLayout }
    >>
  >>
  \layout { }
}

% Exact source tempos and written note durations; no articulate.ly transform.
\score {
  \new PianoStaff <<
    \new Devnull { \playbackTempo }
    \context Staff = "1" <<
      \set Staff.midiInstrument = "acoustic grand"
      \new Voice { \PartPOneVoiceOne }
    >>
    \context Staff = "2" <<
      \set Staff.midiInstrument = "acoustic grand"
      \new Voice { \PartPOneVoiceFive }
      \new Voice { \pedalMidi }
    >>
  >>
  \midi { \tempo 4 = 60 }
}
