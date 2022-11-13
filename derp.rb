masterbpm = 60
use_bpm 60
live_loop :hihat1 do
  2.times do
    density 4 do |x|
      sample :drum_cymbal_closed, finish: 0.325, start: 0.125, on: x!=0
      sleep 1
    end
  end
  2.times do
    density 4 do |x|
      sample :drum_cymbal_closed, finish: 0.325, start: 0.125, on: x!=3
      sleep 1
    end
  end
end
live_loop :justbd, sync: :hihat1 do
  density 2 do
    2.times do
      sample :bd_haus, amp: 1, beat_stretch: 1
      sleep 1
      sample :bd_haus, amp: 1, beat_stretch: 0.75
      sleep 0.25
      sample :bd_haus, amp: 1, beat_stretch: 1.25
      sleep 0.75
    end
    density 2 do
      2.times do
        sample :bd_haus, amp: 1
        sleep 0.5
        sample :bd_haus, amp: 1, beat_stretch: 1.25
        sleep 0.5
        sample :bd_haus, amp: 1, beat_stretch: 0.75
        sleep 1
      end
    end
  end
end
live_loop :bassline1 do
  with_synth_defaults amp:2 do
    with_bpm_mul 1 do
      2.times do |x|
        in_thread do
          2.times do
            with_synth :fm do
              density 2 do
                play :e2-2, attack: 0.25, release: 0.25, amp: 1
                sleep 0.5
                play :e1+5, release:1, decay: 0.5
                sleep 0.5
                density 4 do
                  play :e2+5, attack: 0.125, release: 0.5, decay: 0.375, amp:1
                  sleep 1
                  play :d2, amp: 1
                end
              end
            end
          end
        end
        density 2 do
          with_synth :dsaw do
            play [ :e1+15, :e1 ], release: 1, amp: 3
            sleep 0.5
            play :a1, release: 1, amp: 1
            sleep 0.5
            play :e1+7 , release: 1, amp: 1
            sleep 0.5
            play :d1, release: 1, amp: 1
            sleep 0.5
          end
        end
      end
    end
  end
end
live_loop :harddrum , sync: :hihat1 do
  ##| sync :hihat1
  with_bpm_mul 1 do
    2.times do |x|
      pair = (x+1)%2
      panx = pair==0 ? -0.75 : 0.75
      sample :drum_bass_hard, beat_stretch: 1, amp: 4, pan: panx
      3.times do |y|
        pairy = (y+1)%2
        pany = pairy==1 ? 0.9 : -0.9
        sample :drum_bass_hard, beat_stretch: 0.5, amp: 2, pan: pany
        sleep 0.5
      end
      
      sample :drum_bass_hard, beat_stretch: 0.25, amp: 2, pan: -0.8
      sleep 0.25
      sample :drum_bass_hard, beat_stretch: 0.25, amp: 2, pan: 0.8
      sleep 0.25
    end
  end
  2.times do
    with_bpm_mul 2 do
      2.times do |x|
        x = (x+1)%2
        x = x==0 ? -0.75 : 0.75
        sample :drum_bass_hard, beat_stretch: 1, amp: 4, pan: x
        3.times do |y|
          y = (y+1)%2
          y = y==1 ? 0.9 : -0.9
          sample :drum_bass_hard, beat_stretch: 0.5, amp: 2, pan: y
          sleep 0.5
        end
        
        sample :drum_bass_hard, beat_stretch: 0.25, amp: 2, pan: -0.8
        sleep 0.25
        sample :drum_bass_hard, beat_stretch: 0.25, amp: 2, pan: 0.8
        sleep 0.25
      end
    end
  end
end
