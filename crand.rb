live_loop :hh, sync: "/live_loop/git9" do
  with_fx :reverb do
    in_thread do
      16.times do
        density 8 do
          sample :drum_cymbal_closed, amp:0.5
          sleep 1
        end
      end
    end
    4.times do
      density 8 do |n|
        d = 1
        if (n%2==1)
          d = 2
        end
        density d do
          sample :bd_sone, amp:1.5
          sleep 2
        end
        ##| sample :bd_sone, amp:2
        ##| sleep 1
        sample :drum_snare_hard
        sleep 1
        sample :bd_sone, amp:2
        sleep 1
      end
    end
  end
end



live_loop :git9 do
  2.times do
    
    density 2 do |z|
      ##| nt = scale(:c2, :octatonic, num_scales:1).tick
      use_random_seed 666+z
      ##| z = z * (z%2==0 ? 1 : -1 )
      density 16 do
        ##| synth :tri ,note:(nt+z), release:4, amp:6, cutoff:80
        nt = scale(:c2, :octatonic, num_scales:1).choose
        with_fx :bitcrusher , bits:8  do |y|
          synth :blade, note: nt, attack: 1 ,decay: 1, sustain:1,decay_level: 0 ,attack_level:1,  sustain:0.875, release:2.5, slide:0.25, attack:0,amp:1.5 do |x|
            2.times do
              density 4 do
                synth :blade, sustain:1, note: nt+3,  release:1.5
                sleep 0.25
                x.control note: nt+2, slide_decay:0.5
                sleep 0.25
                x.control note: nt
                synth :blade, sustain:1, note: nt+2-3
                y.control bits:3
                sleep 0.25
                x.control note: nt-3
                sleep 0.25
                x.control note: nt+3
                
              end
              
            end
          end
          sleep 4
        end
        
      end
    end
    
    
  end
end