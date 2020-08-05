define :basik1 do | n=10 , sus = 1.0|
  ##| puts n.class
  use_synth :tri
  use_synth_defaults sustain: (sus/2),
    env_curve:4,
    ##| decay: (sus/2),
    ##| decay_level:0.8 ,
    attack:0,
    attack_level:0,
    pitch:0,
    release: sus,
    amp: ( n.class==SonicPi::Core::RingVector ? 1.5 : 0.75),
    detune:0.125
  a = play [*n , n-4 , n+3]
  return a
end
bd1 = ->{sample :bd_tek, beat_stretch:2, amp:1, decay_level:2}
define :rytm do
  ##| puts beat
  x = 4.0
  y = 4.0
  slp = x/y
  in_thread do
    4.times do
      density 4 do | a |
        sample :drum_cymbal_closed, amp:(a==0 ? 0.8 : 0.5)
        sleep 1
      end
    end
  end
  density (x/y)*2 do |d1i|
    ##| puts beat
    d1 = d1i%2+1
    a = bd1.()
    density d1 do
      sample :bd_sone
      sleep 1.0
    end
    ##| puts beat
    sample :bd_sone
    sleep 1.0
    ##| sample :bd_sone
    density d1 do |d2|
      ##| puts beat
      bs = 1.75
      sample :sn_generic,
        attack:1.0/(d1i+4),
        release:0.5/d1+d2,
        sustain_level:2,
        decay:1.0/(d1*2),
        beat_stretch:bs/d1,
        amp:1*(d2+d1)
      sleep 1
    end
    sleep (1)
    ##| puts beat
  end
end
okt1 = scale( :A3 , :ionian )
puts okt1.length
live_loop :m1 , sync: :rhtm do
  2.times do |loop1|
    ##| puts beat
    density 2 do |x|
      basik1 chord(okt1[0],:minor), 1+x*0.125
      sleep 1
    end
    basik1 okt1[8], 1
    sleep 1
    2.times do |n|
      basik1 okt1[(8+(n))], 0.25
      sleep 0.25
    end
    basik1 okt1[10] , 0.5
    sleep 0.5
    density loop1+2 do |x|
      x += x%2+x*2
      puts x
      a = basik1 okt1[9+x]-x*2, 0.5
      sleep 0.5
    end
    basik1 chord(okt1[0]-5,:m), 0.5
    sleep 0.25
    basik1 okt1[4], 0.25
    sleep 0.25
    ##| a.control do |x, y, z|
    ##|   puts "----",x,y,z,"----"
    ##|   play 55
    ##|   play 58
    ##|   sleep 0.5
  end #loop1
end
live_loop :rhtm do
  rytm
end