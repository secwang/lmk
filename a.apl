⎕IO←0
display←{ ⎕IO ⎕ML←0 ⋄ ⍺←1 ⋄ chars←⍺⊃'..''''|-' '┌┐└┘│─' ⋄ tl tr bl br vt hz←chars ⋄ box←{ vrt hrz←(¯1+⍴⍵)⍴¨vt hz ⋄ top←(hz,'⊖→')[¯1↑⍺],hrz ⋄ bot←(⊃⍺),hrz ⋄ rgt←tr,vt,vrt,br ⋄ lax←(vt,'⌽↓')[¯1↓1↓⍺],¨⊂vrt ⋄ lft←⍉tl,(↑lax),bl ⋄ lft,(top⍪⍵⍪bot),rgt } ⋄ deco←{⍺←type open ⍵ ⋄ ⍺,axes ⍵} ⋄ axes←{(-2⌈⍴⍴⍵)↑1+×⍴⍵} ⋄ open←{(1⌈⍴⍵)⍴⍵} ⋄ trim←{(~1 1⍷∧⌿⍵=' ')/⍵} ⋄ type←{{(1=⍴⍵)⊃'+'⍵}∪,char¨⍵} ⋄ char←{⍬≡⍴⍵:hz ⋄ (⊃⍵∊'¯',⎕D)⊃'#~'}∘⍕ ⋄ line←{(6≠10|⎕DR' '⍵)⊃' -'}⋄ { 0=≡⍵:' '⍪(open ⎕FMT ⍵)⍪line ⍵ ⋄ 1 ⍬≡(≡⍵)(⍴⍵):'∇' 0 0 box ⎕FMT ⍵ ⋄ 1=≡⍵:(deco ⍵)box open ⎕FMT open ⍵ ⋄ ('∊'deco ⍵)box trim ⎕FMT ∇¨open ⍵ }⍵ }
pp←{⍵⊣⎕←#.display ⍵}


step  ← 6  
sl ← (step×-1) (step×-÷2) 0 (step×÷2)  step 
⍝ 0     1       2        3     4    5 
⍝(-- -6)(-6 -3)( -3 0) (0-3)  (3- 6) (6-++)
⍝ a -> b 两个概念,上涨, 价格比较 . 上涨意味着, a 比b小,
⍝ c > mk[1]  3 > c d mk[1]
⍝ c < mk[1]  3 < c d mk[1]

di←{+/⍵>sl}

mk← 0×⍳6


ps ← {
    a b c  ←  ⍵
    fm ← {⍺⊣mk[⍵]←b}
    d←{ di (⍺-⍵)}

    (a=2) ∧ (0=c d b) ∧ (mk[4] = 0): 4 fm 2
    (a=2) ∧ (0=c d b) ∧ (mk[4] ≠ 0) ∧ ( (c d mk[4]) < 3 ):  4 fm 2
    (a=2) ∧ (0=c d b) ∧ (mk[4] ≠ 0) ∧ ( (c d mk[4]) ≥ 3):  5 fm 2
    (a=2): 2

    (a=1) ∧ (mk[2]≠0) ∧ (( c d mk[2]) ≥ 3 ) : 2
    (a=1) ∧ (mk[1]≠0) ∧ ((c d mk[1]) ≥ 4): 2 
    (a=1) ∧ (5 =c d b) ∧ (mk[2]=0): 2 
    (a=1) ∧ (0=c d b) ∧ (mk[4] = 0) :  4 fm 1
    (a=1) ∧ (0=c d b) ∧ (mk[3] ≠ 0) ∧ ((c d mk[3]) < 3 )  :  3 fm 1
    (a=1) ∧ (0=c d b) ∧ (mk[4] ≠ 0) ∧ ((c d mk[4]) < 3 ):  4 fm 1
    (a=1) ∧ (0=c d b) ∧ (mk[4] ≠ 0) ∧ ((c d mk[4]) ≥ 3 ) :  5 
    (a=1): 1


    (a=0) ∧ (mk[2]≠0) ∧ ((c d mk[2]) ≥ 4) : 2 
    (a=0) ∧ (mk[1]≠0) ∧ ((c d mk[1]) ≥ 3): 1
    (a=0) ∧ (0=c d b) ∧ (mk[4] = 0) :  4 
    (a=0) ∧ (0=c d b) ∧ (mk[3] ≠ 0) ∧ ((c d mk[3]) < 3 ) :  3 
    (a=0) ∧ (0=c d b) ∧ (mk[4] ≠ 0) ∧ ((c d mk[4]) < 3 ) :  4 
    (a=0) ∧ (0=c d b) ∧ (mk[4] ≠ 0) ∧ ((c d mk[4]) ≥ 3 ) :  5 
    (a=0): 0

    (a=3) ∧ (5 =c d b) ∧ (mk[1] = 0): 1 fm 3
    (a=3) ∧ (5=c d b) ∧ (mk[1] ≠ 0) ∧ ((c d mk[1]) ≥ 3 ) :  1 fm 3
    (a=3) ∧ (5=c d b) ∧ (mk[1] ≠ 0) ∧ ((c d mk[1]) < 3 ) :  0 fm 3
    (a=3):3 

    
    (a=4) ∧ (mk[3]≠0) ∧ (( c d mk[3]) < 3 ) : 3
    (a=4) ∧ (mk[4]≠0) ∧ (( c d mk[4]) ≤1 ) : 3
    (a=4) ∧ (0=c d b) ∧ (mk[2]=0): 3 
    (a=4) ∧ (5=c d b) ∧ (mk[1] = 0) :  1 fm 4
    (a=4) ∧ (5=c d b) ∧ (mk[2] ≠ 0) ∧ ((c d mk[2]) ≥ 3 ) :  2 fm 4
    (a=4) ∧ (5=c d b) ∧ (mk[1] ≠ 0) ∧ ((c d mk[1]) ≥ 3 ) :  1 fm 4
    (a=4) ∧ (5=c d b) ∧ (mk[1] ≠ 0) ∧ ((c d mk[1]) < 3 )  :  0 
    (a=4): 4



    (a=5) ∧ (mk[3]≠0) ∧ (( c d mk[3]) ≤ 1 ) : 3 
    (a=5) ∧ (mk[4]≠0) ∧ (( c d mk[4]) < 3 ) : 4 
    (a=5) ∧ (5=c d b) ∧ (mk[1] = 0) :  1 
    (a=5) ∧ (5=c d b) ∧ (mk[2] ≠ 0) ∧ ((c d mk[2]) ≥ 3 )  : 2
    (a=5) ∧ (5=c d b) ∧ (mk[1] ≠ 0) ∧ ((c d mk[1]) ≥ 3 ) :  1
    (a=5) ∧ (5=c d b) ∧ (mk[1] ≠ 0) ∧ ((c d mk[1]) < 3 ) :  0
    (a=5): 5
    
}

s ← {
    1=⍴⍵: ⍺
    nv ← ps pp (¯1↑⍺) (1↑⍵) (¯1↑2↑⍵)
    (⍺,nv)∇1↓⍵
}



step ←6
sl ← sl ← (step×-1) (step×-÷2) 0 (step×÷2)  step 

mk← 0 62.125 0 48.5 0 0

3 3 3 3 3 3 3 3 ≡pp 3 s 47 44.75 44 43.625 39.625 39 38 43.5

2 2 2 2 2 4  ≡ pp 2 s 43.5 46.5 47.25 47.5 49 43

mk←  0 49 0 38 0 0

4 4 4 4 0 0 0 1 2 2 ≡ pp 4 s 41.375 40.125 39.875 39.25 45.975 46.5 48.5 51.25 53.75 54.875

2 2 2 2 4 4 2 2 ≡pp 2 s 56.875 58.375 60.875 61.75 55.625 55.5 62.375 63.25

step ←5.1
sl ← sl ← (step×-1) (step×-÷2) 0 (step×÷2)  step 


mk←  0 0 63.25 0 55.5 0
2 5 5 1 1 5 4 3 1 1 3 3 3 0 1 1 1 2 2 2	 ≡ pp 2 s 63.25 56.625 56.5 61.625 61.875 56.125 54.25 52 57.625 58 51.875 51.125 50.875 57.125 59.125 60.125 60.375 62 63 64.25
 
mk ← 0 0 71.25 0 61 0
1 1 1 1 5 5 3 3 3 3 1 1 1 ≡ pp 1 s 66.875 67.125 67.75 70 62.85 62 57.875 56.5 55.625 53.25 59.5 60 60.625
 

mk ← 0 50 0 44.375 0 0
4 3 0 0 0 1 1 ≡ pp 4 s 44.625 43.25 48.75 49 49.375 50.25 50.875
 

