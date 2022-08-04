use_bpm 66
live_loop :hhat6 do
  ##| with_fx :normaliser do
  hhring = ring :drum_cymbal_open, :drum_cymbal_closed, :drum_snare_soft , :drum_cymbal_closed,
    :drum_cymbal_closed, :drum_cymbal_closed, :drum_snare_soft , :drum_cymbal_closed
  denring = ring 1,2
  density denring.tick do
    4.times do
      density 2 do
        4.times do |x|
          hhring.tick
          with_swing 0 do
            density (x%2)+1 do
              sample hhring.look, amp: 0.35
              sleep 1
            end
          end
        end
      end
    end
  end
  ##| end
end

live_loop :bd6 do
  sync "/live_loop/hhat6"
  density 2 do
    4.times do
      4.times do
        2.times do |x|
          sample :bd_ada, beat_stretch: 4
          sleep 0.25
        end
        sleep 0.5
      end
    end
  end
end
live_loop :mel6 do
  use_transpose 24
  denring = ring 1, 2, 1, 2
  melring = ring [:b1, :b0 ],  [ :g1+7, :g0  ]
  use_synth :dtri
  nt = melring.tick
  in_thread do
    density 8 do
      with_fx :flanger, phase: 0.5, phase_offset: 0.25, amp: 0.75, mix: 1 do
        s = synth :dark_ambience , note: [:b1,:g1] , attack: 0.25, decay: 1 ,sustain:2 , release: 1, amp:2, detune1: 0.9, detune2: 0.75, amp_slide: 1.5, pitch: -24
        s.control  ({ notes: [:b4,:g4], pitch:-8 })
        sleep 2
        s.control ({ note: :g4 , pitch:-5})
        sleep 2
      end
    end
  end
  use_transpose 24
  density denring.look do |x|
    ##| with_swing 0 do
    synth :fm, note: nt[1], divisor: 4, cutoff: 100, attack: 0.25 , decay: 2, release: 1.75, amp: 2
    with_fx :krush, gain: 0.7, amp: 2 do
      play nt, release: 4, attack: 0.125, amp: 1, pitch: -12
      
    end
    
    sleep 2
    ##| end
    density denring.look do
      play nt[0]-2, attack: 1, release: 4, decay: 0.5 , cutoff: 60, on: x==1, amp: 2
      sleep 1
      synth :fm, note: nt[1], divisor: 2, cutoff: 130, decay: 0, release: 1, amp: 2, pitch: -12
      sleep 1
    end
  end
end

live_loop :strongbass, sync: "/live_loop/hhat6" do
  sample :drum_bass_hard
  2.times do
    density 1 do
      sleep 0.25
      density 1 do
        sample :drum_bass_hard
        sleep 0.25
      end
      density 1 do
        sample :sn_zome
        sleep 0.5
      end
      sample :sn_zome, beat_stretch: 1, amp: 0.5
    end
  end
  sleep 0.25
  density 2 do
    sample :drum_bass_hard
    sleep 0.25
  end
  density 1 do
    sample :sn_zome
    sleep 0.5
  end
  sample :sn_zome, beat_stretch: 1, amp: 0.5
end
