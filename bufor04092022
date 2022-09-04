
live_loop :lv5 do
  density 8 do
    slp = 4
    with_synth :dtri do
      with_synth_defaults env_curve:4, release: slp do
        play :c3
        sleep slp
        play_chord [:c3 -12, :c3+12]
        sleep slp/2
        play :c3
        sleep slp
        play :c3 -12
        sleep slp/2
      end
    end
  end
end
live_loop :syncloop, sync: :lv5 do
  sleep 2
end
live_loop :bdoop, sync: :lv5 do
  2.times do |x|
    sample :bd_mehackit
    density (x+1) do
      sample :bd_klub
      sleep 0.5
    end
  end
end
live_loop :hhat5, sync: :lv5 do
  
  4.times do |y|
    density 2 do
      6.times do
        sample :bd_pure
        sample :bd_tek, on: (y==2)
        2.times do |x|
          density (x+1) do |d|
            sleep 0.5
            sample :bd_zum
            sleep 0.5
          end
        end
        sample :elec_twip, beat_stretch: 2
      end
      sleep 1
    end
    sleep 2
  end
end

live_loop :snacc, sync: :hhat5 do
  density 2 do
    sleep 3
    sample :elec_twip
    sleep 1.5
    sample :elec_twip, beat_stretch: 2
    sleep 1.5
  end
end
live_loop :strongbd, sync: :syncloop do
  density 2 do
    4.times do |x|
      puts x
      y = ( (x%2)==1 ? 1 : 0.5 )
      puts y
      density (x==3? 2 : 1) do |dx|
        with_fx :ixi_techno, phase_offset: y*0.125 do
          sample :bd_zome, amp: 4, beat_stretch: y*1.25
        end
        sample :drum_tom_hi_hard, amp: 2, beat_stretch: 1.25*(dx+1)
        sleep 1.0
      end
    end
  end
end
live_loop :quicksnare, sync: :strongbd do
  density 4 do
    4.times do |i|
      sleep 3
      sample :sn_dolf
      sleep 1
    end
    4.times do
      
      sleep 2
      sample :sn_dolf
      sleep 1
      sample :sn_dolf, beat_stretch: 0.95
      sleep 4
      sample :sn_dolf, beat_stretch: 0.8
      sleep 1
    end
  end
end
