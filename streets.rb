use_bpm 45

x = live_loop :hhat0 do
  2.times do
    4.times do
      density 2 do |d|
        use_bpm_mul d+1
        4.times do |x|
          sample :drum_cymbal_closed, amp: (x%3==0 ? 1 : 0.5)
          sleep 1
        end
      end
    end
  end
end

##| sleep 4
live_loop :bd0 do
  
  with_synth :hoover do
    with_synth_defaults pitch:-12, amp:0.55 do
      m = play 60, release:2, decay:1.5, attack:0.25, sustain:1.75, env_curve:7, slide_attack:0.25, slide_sustain:0.25, slide_release:2, slide_decay:2, slide:0.25
      in_thread do
        sleep 2
        m.control( note: 60-6 )
      end
      density 2 do
        with_fx :bitcrusher , bits:4, mix:1, pre_amp:2, amp:1, cutoff:70 do
          sample :drum_bass_hard
          
          play 60, release:1.5, decay:0.5
        end
        sleep 2
        
        density 2 do |s|
          sample :drum_bass_hard
          play 62-(s*2), decay:0.25, release:0.25, cutoff:68
          sleep 0.5
        end
      end
      density 4 do |i|
        n = nil
        if i==3
          with_fx :bitcrusher , bits: 4, pre_amp:2, amp:0.5, cutoff:80 do
            n = play 63, decay:0.75, slide:0.25, cutoff:70
          end
        else
          with_fx :echo , mix:0.5, phase:0.25, decay:1 do
            density 2 do
              n = play 65, decay:1.5, slide:0.75, cutoff:80
            end
          end
        end
        
        density 2 do |x|
          sleep 1
          n.control note: 62-x, decay: 0.25, attack:0.25, pitch: ((x%2)+1)*-12
        end
        sample :drum_bass_hard
        sleep 0.5
      end
    end
  end
end


live_loop :sn0, cue: "/live_loop/hhat0" do
  with_sample_defaults amp:0.5 do
    density 2 do
      4.times do
        sleep 0.5
        sample :drum_snare_hard
        sleep 0.25
        sample :drum_snare_soft
        sleep 2.25
        sample :drum_snare_hard, amp:0.75
        sleep 0.5
        sample :drum_snare_soft
        sleep 0.5
      end
    end
  end
end
