live_loop :hh do
  
  i = 0
  2.times do |x|
    puts beat+1
    density 2 do |y|
      in_thread do
        density 2 do
          2.times do
            sample :drum_cymbal_closed
            sleep 1
          end
        end
      end
      z = (y+x)==2 ? 2 : 1
      puts beat+1
      sample :bd_sone
      density z*2 do |n|
        sample :bd_boom, beat_stretch:( (x+y+1)+(z*2/ (n+1) ) )*(z/(n+0.5)/(n+1))
        sleep 1
      end
      density z do
        sample :sn_dolf
        sleep 1
      end
    end
  end
end
