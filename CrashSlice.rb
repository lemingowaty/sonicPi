use_bpm 80
define :hhtact1  do |samp: :drum_cymbal_closed , cond: (Array(4).fill(true)), amp: 0.35|
  4.times do |x|
    density 2 do
      sample samp, on: cond[x], amp: (x==0 ? 1 : amp)
      sleep 0.25
    end
  end
end
live_loop :drum8 do
  2.times do
    in_thread do
      
      4.times do |y|
        arr = Array(4)
        arr.fill(true,0,4)
        arr[y] = false
        density 1 do |d|
          if d==1 then arr=arr.reverse() end
          hhtact1 samp: :drum_cymbal_closed , cond: arr
        end
      end
    end
    4.times do |y|
      sample :drum_heavy_kick, amp:1.5
      sleep 0.25
      
      sample :drum_heavy_kick, on: y==3||y==1
      sleep 0.125
      sample :drum_snare_soft, on: y==3
      sleep 0.125
      
      sample :drum_snare_hard
      sleep 0.125
      sample :drum_bass_soft, on: y==2
      sleep 0.125
      
      sample :drum_snare_soft, on: y==3
      sleep 0.125
      sample :drum_snare_soft, on: y==0||y==1
      sample :drum_bass_soft, on: y==2
      sleep 0.125
    end
  end
end
live_loop :wubwub1 , sync: "/live_loop/drum8" do
  puts "wubstart"
  noteLen = 2
  puts noteLen
  use_synth :prophet
  2.times do |x|
    synth :blade, note: :d1, release: noteLen*2, amp:0.5
    play :d2+7, release: noteLen*2
    play :d3, amp:1, release: noteLen
    sleep noteLen
    play :d4, amp:1, release: noteLen
    sleep noteLen
    with_fx :bitcrusher, bits: 2 do
      with_fx :slicer , phase: 0.25 , pulse_width: 0.25/4 do
        synth :blade, note: :d1, release: noteLen, amp: 0.5, attack: noteLen
        synth :blade, note: :d2+7, release: noteLen, amp: 0.25, attack: noteLen
      end
    end
    density x+1 do |di|
      with_fx :slicer , phase: 0.25 , pulse_width: 0.125/2 do
        2.times do |i|
          play :d2 + i, amp: 2, release: noteLen
          sleep noteLen
        end
      end
    end
  end
  2.times do |x|
    synth :blade, note: :d1, release: noteLen*2
    play :d2+7, release: noteLen*2
    play :d3, amp:1, release: noteLen
    sleep noteLen
    play :d4, amp:1, release: noteLen
    sleep noteLen
    with_fx :bitcrusher, bits: 4 do
      with_fx :slicer , phase: 0.25 , pulse_width: 0.25/2 do
        synth :blade, note: :d3, release: noteLen*2, amp: 2
      end
    end
    2.times do |i|
      density x+1 do |di|
        
        play :d2 + i, amp: 2, release: noteLen
        sleep noteLen
      end
    end
  end
end
