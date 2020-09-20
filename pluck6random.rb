use_random_seed 62
mldmain1 = scale( :e1, :minor_pentatonic, num_octaves:1 ).pick(4)
mldmain2 = scale( :a1, :harmonic_major, num_octaves:1 ).pick(4)

live_loop :mld6 do
  use_synth :tb303
  
  nt = chord( ( scale( mldmain1.look , :minor_pentatonic)).choose, :major )
  
  use_random_seed 66.66
  4.times do |l1|
    play mldmain1.tick do |s|
      nt2 = chord( ( scale( mldmain2.tick-(l1*2) , :major)).choose, :major )
      
      2.times do |n|
        ntb = chord(nt2.look, :major, num_octaves:2)
        density 2 do |j|
          density 4 do
            synth  :pluck, note: ntb.tick, amp:0.75, release:0.5, attack:0, sustain:1
            sleep 1
          end
          density 2 do
            synth :pluck, note: ntb.tick, amp:1.25, release:0.25, attack:0, sustain:0.25
            s.control note: ntb.look, slide_decay:0.5, release:1 , slide_release:0.5, slide:0.5, slide_sustain:1, sustain:0.5
            sleep 1
          end
          s.control note: nt2.look
          sleep 1
        end
        sleep 1
      end
      sleep 1
    end
    sleep 1
  end
end

live_loop :drum6 do
  density 4 do
    ##| sample :drum_cymbal_closed, amp:0.5
    sample :bd_sone, amp:0.5
    sleep 1
    density 2 do
      sample :drum_cymbal_closed, amp:0.5
      sleep 1
      sample :sn_zome, amp:0.5
    end
    sleep 1
    sample :drum_cymbal_closed, amp:0.5
    sleep 1
  end
end