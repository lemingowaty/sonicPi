use_bpm 100
define :displusx do |base, plus, **more|
  
  bs = nil
  ##| with_fx :echo, mix:0.25, decay:1, phase:0.25 do
  
  with_fx :distortion, distort:0.25, mix:0.75 do
    bs = synth :dsaw, release: 0.375, decay:0.225 , note: base, pitch: -24, detune:0.25, attack:0.125, amp:1, env_curve:4
    
    ##| end
    puts "DisPlusx bs = " ++ String(base)
    ps = nil
    if plus > 0 then
      puts "ps = " + String(plus)
      with_fx :reverb, room:0.5, mix:0.5  do
        ps = synth :blade , pitch:-12, note: base+plus, duration: 1, attack:0.075/4, decay:0.75, release:0.5, **more
      end
    end
    if ps
      return bs, ps
    else
      return bs
    end
  end
end
live_loop :bline1 do
  2.times do
    density 2 do |d1|
      nt = d1==0 ? :a2 : :a3
      cue "/live_loop/lead1"
      puts displusx nt , 0
      sleep 2
      density (d1+1)  do
        puts displusx nt , 5
        sleep 1
      end
      density (d1==0 ? 2 : 1) do
        displusx nt, 7
        sleep 1
      end
    end
  end
end

live_loop :cykacz1, sync: "/live_loop/bline1" do
  in_thread do
    
    density 1 do |x|
      8.times do |y|
        density (y==0 ? 2 : 1) do |dx|
          bt_st = y == 0 ? 2 : 1
          with_fx :reverb, room:0.5, mix:0.25 do
            sample :drum_bass_hard, pitch:dx, beat_stretch: bt_st, norm:0
          end
          sleep 1
          
        end
      end
    end
  end
  density 4 do |x|
    
    8.times do |y|
      density 1 do
        sample :drum_cymbal_closed , amp: 0.25, on: y!=4&&y!=0
        sleep 1
      end
    end
  end
end

live_loop :lead1, sync: "/live_loop/bline1" do
  ##| density 2 do
  rpt = 2
  rpt.times do |y|
    synth :hoover, note: [:a2,:a2+7], decay:2, duration: 4, amp:0.75
    4.times do |tx|
      density (tx%2 == 0 ? 1 : 2)  do |dx|
        synth :hoover, note: :a3+(tx*dx), release: 2
        sleep 1
      end
      
      
      if (y+1) != (rpt)+1
        sleep 1
      else
        sync "/live_loop/bline1"
      end
    end
    ##| end
  end
  
  rpt.times do |y|
    synth :hoover, note: [:a2,:a2+7+y], decay:1, duration: 4, amp:0.75
    4.times do |tx|
      den = tx%2 == 0 ? 1 : 4
      density den  do |dx|
        synth :hoover, note: :a3+(tx*dx), release: den==1 ? 2 : 4
        sleep 1
      end
      
      
      if (y+1) != rpt+1
        sleep 1
      else
        synth :hoover, note: [:a2,:a2+7+y], attack: 1
        sync "/live_loop/bline1"
      end
    end
    ##| end
  end
end
