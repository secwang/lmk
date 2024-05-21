)load a.dws
⎕IO← 0

m←⎕CSV 'BINANCE_BTCUSDT, 1D.csv' '' 4 1
da ← ⊃m[0]
c← da[;1]
mk←0∧⍳6
m0←⌈/c
m1←⌊/c
sc← {30 + 200×(⍵-m1)÷(m0+m1) }¨c
t←4 s sc

tc ← ⍉(⊃¨2 (⍴c) ) ⍴  ( c,t)

gc ← {a b←⍵⋄  ( a@b ) 0 × ⍳6 }¨⊂[1]tc

r ←  (∊( 6÷⍨⍴∊gc ) 6) ⍴ ∊ gc
ur← da[;0],r


tm←{ a←⍵⋄m← (((⍴⍵)÷7)) , 7⋄m  ⍴ a } ∊ {∊20 ¯1 ⎕DT ⍵ }¨da[;0]
ur←tm[;0 1 2],r



