#!/usr/bin/env dyalogscript ENABLE_CEF=0

⎕IO ← 0
_ n   ← 2⎕NQ#'GetCommandLineArgs'


c h ← ⎕CSV n '' 4 1

tm←{ a←⍵⋄m← (((⍴⍵)÷7)) , 7⋄m  ⍴ a } ∊ {∊20 ¯1 ⎕DT ⍵ }¨c[;0]


ca←0, ({⊂{⍵-⍺}/⍵}⌺2) c[;1]



r←(tm[;0 1 2],c[;1] ),ca

m← r ⎕CSV ''
nn← '.'(≠⊆⊢)n
nnn ← (⊃nn[0]),'fmt','.',(⊃nn[1])

m ⎕NPUT nnn






