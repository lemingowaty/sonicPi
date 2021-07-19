use_bpm 90
live_loop :bdmel, cue: :hh9 do
  pshift = ring 0, 0, 4, 6
  2.times do |mx|
    
    4.times do |x|
      dens = mx==0&&x==0 ? 2 : 1
      pshift.tick
      density dens do
        sample :bd_808, window_size:(0.125/(x+1))/2 , pitch: pshift.look+12+mx, beat_stretch: 0.25/(mx+1), amp:1.5
        sleep 1
      end
    end
    in_thread do
      
      
      density 2 do
        4.times do
          
          pshift.tick
          puts pshift.look
          sample :bd_808, window_size:(0.125/4)/2 , pitch: pshift.look+7+mx, beat_stretch:0.45, amp:1.5
          sleep 1
        end
      end
    end
  end
end

live_loop :hh9 , sync:"/live_loop/bdmel" do
  4.times do |t|
    density (t%2)+1 do
      sample :drum_cymbal_closed, amp:0.2
      sleep 1
    end
  end
  4.times do |t|
    density 4 do |st|
      sample :drum_cymbal_closed, on: st!=3, amp:0.2
      sleep 1
    end
  end
end

live_loop :bd9 , sync: :hh9 do
  panring = ring 0.75 , -0.75
  2.times do |mt|
    
    density 2 do |d|
      sample :drum_tom_lo_hard, amp: 0.25*(d+1) , pan: panring.tick
      sleep 1
    end
    sleep 3
    density 2 do |d|
      sample :drum_tom_lo_hard, amp: 0.25*(d+1) , pan: panring.tick
      sleep 1
    end
    tom_ring = ring :drum_tom_lo_hard, :drum_tom_lo_soft
    density 4 do |d|
      sample tom_ring.tick, amp: 0.25*(d+1), on: d%2==0 , pan: panring.tick
      sleep 1
    end
    sleep 2
  end
  2.times do |mt|
    
    density 2 do |d|
      sample :drum_tom_lo_hard, amp: 0.25*(d+1) , pan: panring.tick
      sleep 1
      
      sleep 3
      density 2 do |d|
        sample :drum_tom_lo_hard, amp: 0.25*(d+1) , pan: panring.tick
        sleep 1
      end
      tom_ring = ring :drum_tom_lo_hard, :drum_tom_lo_soft
      density 4 do |d|
        sample tom_ring.tick, amp: 0.25*(d+1), on: d%2==0 , pan: panring.tick
        sleep 1
      end
      sleep 2
    end
  end
end

live_loop :sn9, sync: "/live_loop/hh9" do
  4.times do |mt|
    density ((mt+1)%4==0 ? 2 : 1) do |t|
      sample :bd_tek, pitch:t*7
      sleep 1
    end
    sample :sn_dolf, amp: 0.25
    sleep 1
  end
end
