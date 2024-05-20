⎕IO←0
display←{ ⎕IO ⎕ML←0 ⋄ ⍺←1 ⋄ chars←⍺⊃'..''''|-' '┌┐└┘│─' ⋄ tl tr bl br vt hz←chars ⋄ box←{ vrt hrz←(¯1+⍴⍵)⍴¨vt hz ⋄ top←(hz,'⊖→')[¯1↑⍺],hrz ⋄ bot←(⊃⍺),hrz ⋄ rgt←tr,vt,vrt,br ⋄ lax←(vt,'⌽↓')[¯1↓1↓⍺],¨⊂vrt ⋄ lft←⍉tl,(↑lax),bl ⋄ lft,(top⍪⍵⍪bot),rgt } ⋄ deco←{⍺←type open ⍵ ⋄ ⍺,axes ⍵} ⋄ axes←{(-2⌈⍴⍴⍵)↑1+×⍴⍵} ⋄ open←{(1⌈⍴⍵)⍴⍵} ⋄ trim←{(~1 1⍷∧⌿⍵=' ')/⍵} ⋄ type←{{(1=⍴⍵)⊃'+'⍵}∪,char¨⍵} ⋄ char←{⍬≡⍴⍵:hz ⋄ (⊃⍵∊'¯',⎕D)⊃'#~'}∘⍕ ⋄ line←{(6≠10|⎕DR' '⍵)⊃' -'}⋄ { 0=≡⍵:' '⍪(open ⎕FMT ⍵)⍪line ⍵ ⋄ 1 ⍬≡(≡⍵)(⍴⍵):'∇' 0 0 box ⎕FMT ⍵ ⋄ 1=≡⍵:(deco ⍵)box open ⎕FMT open ⍵ ⋄ ('∊'deco ⍵)box trim ⎕FMT ∇¨open ⍵ }⍵ }
pp←{⍵⊣⎕←#.display ⍵}


step  ← 6  
sl ← (step×-1) (step×-÷2) 0 (step×÷2)  step 
⍝ 0     1       2        3     4    5 
⍝(-- -6)(-6 -3)( -3 0) (0-3)  (3- 6) (6-++)
⍝ a -> b 两个概念,上涨, 价格比较 . 上涨意味着, a 比b小,
⍝ c > mk[1]  3 > c d mk[1]
⍝ c < mk[1]  3 ≥ c d mk[1]

di←{+/⍵>sl}

mk← 0×⍳6


ps ← {
    a b c  ← pp ⍵
    fm ← {⍺⊣mk[⍵]←b}
    d←{ di (⍺-⍵)}

    (a=2) ∧ (0=c d b): 4 fm 2
    (a=2): 2

    (a=1) ∧ (mk[2]≠0) ∧ (4 ≤ c d mk[2]): 2 fm 1 
    (a=1) ∧ (5 =c d b) ∧ (mk[2]=0): 2 fm 1
    (a=1) ∧ (0=c d b) ∧ (mk[4] = 0) :  4 fm 1
    (a=1) ∧ (0=c d b) ∧ (mk[3] ≠ 0) ∧ (2 ≤ c d mk[3]) :  3 fm 1
    (a=1) ∧ (0=c d b) ∧ (mk[4] ≠ 0) ∧ (3 < c d mk[4]) :  4 fm 1
    (a=1) ∧ (0=c d b) ∧ (mk[4] ≠ 0) ∧ (3 ≥ c d mk[4]) :  5 fm 1
    (a=1): 1


    (a=0) ∧ (mk[1]≠0) ∧ (3 ≥ c d mk[1]) : 1 fm 0
    (a=0) ∧ (0=c d b) ∧ (mk[4] = 0) :  4 fm 1
    (a=0) ∧ (0=c d b) ∧ (mk[3] ≠ 0) ∧ (2 ≤ c d mk[3]) :  3 fm 0
    (a=0) ∧ (0=c d b) ∧ (mk[4] ≠ 0) ∧ (3 > c d mk[4]) :  4 fm 0
    (a=0) ∧ (0=c d b) ∧ (mk[4] ≠ 0) ∧ (3 ≤ c d mk[4]) :  5 fm 0
    (a=0): 0

    (a=3) ∧ (5 =c d b): 1 fm 3
    (a=3):3 

    
    (a=4) ∧ (mk[3]≠0) ∧ (1 ≥ c d mk[3]): 3 fm 4
    (a=4) ∧ (0=c d b) ∧ (mk[2]=0): 3 fm 4
    (a=4) ∧ (5=c d b) ∧ (mk[1] = 0) :  1 fm 4
    (a=4) ∧ (5=c d b) ∧ (mk[2] ≠ 0) ∧ (4 ≥ c d mk[3]) :  2  fm 4
    (a=4) ∧ (5=c d b) ∧ (mk[1] ≠ 0) ∧ (3 < c d mk[1]) :  1 fm 4
    (a=4) ∧ (5=c d b) ∧ (mk[0] ≠ 0) ∧ (3 ≥ c d mk[1]) :  0 fm 4
    (a=4): 4



    (a=5) ∧ (m[4]≠0) ∧ (2 ≥ c d mk[4]) : 4 fm 5
    (a=5) ∧ (5=c d b) ∧ (mk[1] = 0) :  1 fm 5 
    (a=5) ∧ (5=c d b) ∧ (mk[3] ≠ 0) ∧ (4 ≥ c d mk[3]) :  2 fm 5
    (a=5) ∧ (5=c d b) ∧ (mk[1] ≠ 0) ∧ (3 < c d mk[4]) :  1 fm 5
    (a=5) ∧ (5=c d b) ∧ (mk[1] ≠ 0) ∧ (3 ≥ c d mk[4]) :  0 fm 5
    (a=5): 5
    
}

s ← {
    1=⍴⍵: ⍺
    nv ← ps (¯1↑⍺) (1↑⍵) (¯1↑2↑⍵)
    (⍺,nv)∇1↓⍵
}

d←{ di (⍺-⍵)}
45.975 d mk[1]
mk ← 41.375 40.125 39.875 39.25 45.975 46.5 48.5 51.25 53.75 54.875


4 s 41.375 40.125 39.875 39.25 45.975 46.5 48.5 51.25 53.75 54.875



