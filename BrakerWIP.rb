live_loop :bline1 do
  in_thread do
    density 4 do |x|
      sync :test2
      density ((x+1)%2)+1 do
        sample :drum_cymbal_closed, amp:0.75
        sleep 1
      end
    end
  end
  density 2 do
    
    4.times do |y|
      if y==0
        y = 1
      else
        if y==3
          break
        end
      end
      density 2 do
        cue :test2
        synth :fm , note: :a2+(y+2),  env_curve: 1, release: (1.0/((y+2)/2)), amp:1.25
        sleep 1
      end
    end
    cue :test2
    density 4 do |dy|
      synth :fm , note: (:a2-(((dy+1)%2)*7))+dy , env_curve:4
      sleep 1
    end
  end
end

live_loop :bdrum1, sync: "/live_loop/bline1" do
  density 2 do
    loopnum = 8
    loopnum.times do |y|
      sample :drum_bass_hard, amp:0.75
      if y == loopnum-1
        sync "/live_loop/bline1"
      else
        sleep 1
        
        
      end
    end
  end
end

live_loop :sn1 do
  sync "/live_loop/bline1"
  density 1 do |dy|
    sample :sn_dolf, amp:0.5
    sleep 1
    density 2 do
      sample :sn_dolf, amp:0.75
      sleep 1
    end
    sleep 2
    density 2 do |y|
      
      sample :sn_dub, pitch: -12
      sleep 1
      sample :sn_dolf , on: y==0, amp: 0.5
    end
    sample :sn_dolf
    sleep 1
    sample :sn_dub, pitch: -7
    sample :sn_dolf, amp:0.5
    if dy==0
      sleep 1
    end
  end
end

