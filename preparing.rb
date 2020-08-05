use_debug false

define :drumy do
  i = 0
  density 4 do
    ##| with_fx :flanger, pre_mix:0.1, mix:1 do
    i = i == 4 ? 0 : i
    puts "#{$pertakt} / #{i}"
    if factor?(i,2)
      2.times do |x|
        x = x%2==0 ? 1 : -1
        sample :bd_fat , amp:4 , beat_stretch:1+(x*0.5), pan:-0.6*x
        sleep 1
      end
    else
      sample :bd_fat , amp:4, beat_stretch:0.75, pan:0
      sleep 2
    end
    sample :sn_dolf , beat_stretch:1, rate:-1, start:0.2, finish:0.5, pan:0.5
    sleep 1
    sample :bd_fat, amp:4
    sleep 1
    i+=1
    ##| end
  end
end

$pertakt = 0
live_loop :perk, sync: :bass do
  puts $pertakt
  drumy
  $pertakt = ($pertakt+1)==16 ? 0 : $pertakt+1
end

live_loop :bass , cue: :perk do
  a,b,c,d = 0
  2.times do
    2.times do |m|
      2.times do |n|
        n = n+1
        with_fx :flanger , delay:0.25 , invert_flange:0, invert_wave:1, depth:32 do
          a = synth :sine , note: :e1, attack:0.25,decay:0.25, sustain:0.25, release:0.25, slide:8, slide_attack:0.25, sustain_level:1,amp:2 do |x|
            density 2 do |y|
              b = synth :tri, note: :e1+3, attack:0.125 , decay:0.125,sustain:0.25 ,release:0.25 , cutoff:40, amp:2 do
                sleep 0.5
                c = synth :square, note: (m+y==1 ? :e1+13 : :e1+15), attack:0.25 , release:0.25, amp:0.5
                sleep 0.5
                d = synth :saw, note: (m+n%2!=1 ? :e1+7+m : :e1+6+(m+n%2+m)) , attack:0,decay:0.250,release:0.125, release:0, amp:0.2
              end
              sleep 1
            end
            
          end
          
        end
        sleep 0.85
        [a,b,c,d].each { |x| x.control slide:0.5, note: :e1 }
        sleep 1-0.85
      end
    end
  end
end