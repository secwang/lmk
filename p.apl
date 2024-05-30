#!/usr/bin/env dyalogscript ENABLE_CEF=0
)load a.dws
⎕IO← 0

_ name start scale  ← 2⎕NQ#'GetCommandLineArgs'
start ← ⍎start
scale ← ⍎scale

job ← {

m←⎕CSV ⍺ '' 4 1
da ← ⊃m[0]
c← da[;1]
mk←0∧⍳6
sc← c × ⍵ 
⍝sc ← 6 × c 
t←start s sc

tc ← ⍉(⊃¨2 (⍴c) ) ⍴  ( c,t)

gc ← {a b←⍵⋄  ( a@b ) 0 × ⍳6 }¨⊂[1]tc

r ←  (∊( 6÷⍨⍴∊gc ) 6) ⍴ ∊ gc
⍝ur← da[;0],r

tm←↑{'-'(≠⊆⊢)⍵ }¨da[;0]


ur←tm[;0 1 2],r
ur
}

 
r ← name job scale
⎕←r
