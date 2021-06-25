use_bpm 120
def p_mld1 ( key = :a3 , snth0 = :pluck , snth1 = :pluck, p=0)
  sc = scale key, :minor_pentatonic
  x = 0
  in_thread do
    
    2.times do |x|
      with_synth snth0 do
        x = x+(x*2)
        play sc[x] , release: 2, pitch:p
        sleep 1
      end
      
      with_synth snth1 do
        play sc[x] , release:0.5
        sleep 0.5
        play sc[x+1] , release:1
        sleep 0.5
      end
      
      2.times do |s|
        snth = s == 0 ? snth0 : snth1
        with_synth snth do
          snd = play sc[x+2], slide:1, attack:0, decay:0.25, sustain:0.25, release:( s ? 0.5 : 1 )
          snd.control note: sc[x+2]+5
          sleep 0.5
          snd.control note: sc[x+2], slide:0.5
          sleep 0.5
        end
      end
    end
  end
end
for x in synth_names
  puts x
end
live_loop :bt do
  d = [4,3,2,1]
  
  16.times do |h|
    
    if (h+1)%4==0
      sample :ambi_lunar_land
    end
    if !((h+1)%2) then sample :drum_tom_hi_soft ; end
    density (h<=7 ? 1 : 1) do |l|
      for i in d
        puts i
        
        sample :drum_bass_hard, amp:2
        ##| sample :drum_bass_hard, amp:4
        sleep 0.25
        if l%2 then sample :drum_tom_lo_hard , amp:(((0.25)+h+1/0.25)*0.25)/4 ; end
        sleep 0.25
        in_thread do
          if l%2 then sample :drum_tom_lo_hard ; end
          density (i==1 ? 1 : i/2) do |j|
            
            sample :sn_generic, amp:(((0.25)+j+1/0.25)*0.25)/4
            sleep 0.125
            
            sleep 0.125
          end
        end
        
        sleep 0.5
      end
    end
  end
  
end

live_loop :loop8 do
  msc = scale :a1, :minor_pentatonic, num_octaves:1
  2.times do
    2.times do
      p_mld1 msc[0] , :pluck , :piano, -12
      sleep 0.5
      p_mld1 msc[6] , :piano , :pluck
      sleep 7.5
    end
  end
  2.times do
    density 2 do
      4.times do
        time = 0
        p_mld1 msc[-1] , :pluck , :piano
        for x in 1..2
          with_synth :supersaw do
            sleep 0.5 ; time+=0.5
            play msc[-1+x]
            
          end
        end
        sleep 0.5 ; time+=0.5
        p_mld1 msc[-7] , :piano , :pluck
        for x in 1..2
          with_synth :dpulse do
            sleep 0.5 ; time+=0.5
            play msc[-7-x], release: 0.25
            
          end
        end
        2.times do
          sleep 0.5 ; time+=0.5
          with_synth :dpulse do
            play msc[-7]
          end
          
        end
        sleep 0.5 ; time+=0.5;
      end
    end
  end
end







