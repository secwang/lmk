#!/usr/bin/env dyalogscript ENABLE_CEF=0

⎕IO ← 0
_ n   ← 2⎕NQ#'GetCommandLineArgs'

c h ← ⎕CSV n '' 4 1
tm←↑{'-'(≠⊆⊢)⍵ }¨c[;0]

ca←0, ({⊂{⍵-⍺}/⍵}⌺2) c[;1]
caf← 100÷⍨⌊(100×ca)

r←(tm[;0 1 2],c[;1] ),caf

m← r ⎕CSV ''
nn← '.'(≠⊆⊢)n
nnn ← 'fmt',(⊃nn[0]),'.',(⊃nn[1])

m ⎕NPUT nnn 1
