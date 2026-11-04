\version "2.26.0"
\pointAndClickOff
% Frederic Chopin: Nocturne in E-flat major, Op. 9 No. 2.
% Based on the user's MusicXML and matching four-page PDF (MuseScore 2.1.0).
% The approved A3 / 17 pt title, margins, fonts and piano-staff style are retained.
% XML measure labels retain the source's pickup 0 and measures 1--37.
% At XML33/34 the source actually supplies three quarters per measure;
% the hidden 6/4 is retained with an explicit measureLength, without added rests.
% Three damaged MusicXML trill spanners (XML7/15/23) are restored from the PDF.
% Playback metronomes absent from the PDF are preserved in an invisible track.
% Contour repairs keep the original musical events and all slur endpoints.
% Parenthesized pedal reminders on XML34/35 follow the reference PDF.
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
#(set-global-staff-size 17)
#(ly:set-option 'midi-extension "mid")
\paper {
  #(set-paper-size "a3")
  page-count = 2
  top-margin = 12\mm
  bottom-margin = 12\mm
  left-margin = 15\mm
  right-margin = 15\mm
  indent = 12\mm
  short-indent = 2.4\mm
  ragged-last = ##f
  ragged-last-bottom = ##f
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
  markup-system-spacing = #'((basic-distance . 8) (minimum-distance . 6) (padding . 2) (stretchability . 0))
  top-system-spacing = #'((basic-distance . 6) (minimum-distance . 4) (padding . 1))
  system-system-spacing = #'((basic-distance . 16) (minimum-distance . 10) (padding . 2) (stretchability . 20))
}
\layout {
  \context { \Staff
    printKeyCancellation = ##f
    pedalSustainStyle = #'text
    \override SustainPedalLineSpanner.staff-padding = #2
  }
  \context { \Score
    autoBeaming = ##f
  }
  \context { \PianoStaff
    \override StaffGrouper.staff-staff-spacing = #'((basic-distance . 12) (minimum-distance . 10) (padding . 2) (stretchability . 0))
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

% All music is contained in this file; no external includes are required.
\score {
  \new PianoStaff <<
    \set PianoStaff.instrumentName = "Piano"
    \context Staff = "1" <<
      \mergeDifferentlyDottedOn
      \mergeDifferentlyHeadedOn
      \new Voice = "rightMain" { \PartPOneVoiceOne }
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
