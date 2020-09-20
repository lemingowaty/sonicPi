use_random_seed 62
mldmain1 = scale( :e1, :minor_pentatonic, num_octaves:1 ).pick(4)
mldmain2 = scale( :a2, :harmonic_major, num_octaves:1 ).pick(4)

live_loop :mld6 do
  use_synth :tb303
  
  nt = chord( ( scale( mldmain1.look , :minor_pentatonic)).choose, :major )
  
  use_random_seed 66.66
  
  4.times do |l1|
    
    play mldmain1.tick, pan:-0.25, slide:0.025, sustain:0.2, slide_sustain:0.2, amp:0.5 do |s|
      nt2 = chord( ( scale( mldmain2.tick-(l1*2) , :major)).choose, :major )
      with_fx :flanger, depth:4 , phase:2, smooth_down:0.5, delay:1, invert_flange:1,amp:1.2 do
        2.times do |n|
          ntb = chord(nt2.look, :major, num_octaves:2)
          density 2 do |j|
            density 4 do
              synth  :pluck, note: ntb.tick, amp:0.75, release:0.5, attack:0, sustain:1
              sleep 1
            end
            density 2 do
              synth :pluck, note: ntb.tick, amp:1.25, release:0.25, attack:0, sustain:0.25
              s.control note: ntb.look - 12, slide_decay:0.5, release:1 , slide_release:0.5, slide:0.5, slide_sustain:1, sustain:0.5
              sleep 1
            end
            s.control note: nt2.look - 12, release:0.5
            sleep 1
          end
          sleep 1
        end
        
      end
      sleep 1
    end
    sleep 1
  end
end

live_loop :drum6, sync: "/live_loop/mld6" do
  density 4 do
    sample :drum_cymbal_closed, amp:0.5
    sample :bd_sone, amp:2
    sleep 0.5
    sample :bd_sone, amp:2
    sleep 1
    density 2 do |d|
      sample :glitch_perc3, amp:1, beat_stretch:d+2
      sample  :sn_dolf, amp:d+1 if d==1
      sleep 1
    end
    sleep 0.5
    sample :drum_cymbal_closed, amp:0.5
    sleep 1
  end
end
