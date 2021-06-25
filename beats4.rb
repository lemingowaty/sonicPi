use_bpm 58
define :p_beat do |bt = 0, t = 1, dns = 2, xbpm = 2|
  bdh = :drum_bass_hard
  bds = :drum_bass_soft
  snh = :drum_snare_hard
  sns = :drum_snare_soft
  with_bpm_mul xbpm do
    t.times do
      case bt
      when 0
        density dns do |d|
          d = d%2
          2.times do |i|
            case i
            when 0
              sample bdh
              sleep 2
              sample snh
              sleep 2
            when 1
              sample bds
              sleep 1
              sample bds
              sleep 1
              sample snh
              sleep 1
              sample bds
              sleep 1
            end
          end
        end
      when 1
        density 2 do |d|
          2.times do |i|
            sample bdh
            sleep 1
            sample bds
            sleep 1
            
            sample snh
            sleep 0.5
            sample sns
            sleep 1
            sample ( i==0 ? bds : sns )
            sleep 0.5
          end
        end
      when 2
        density 2 do |d|
          d = d%2
          2.times do |i|
            
            sample bds
            sleep 1
            
            sample bdh
            sleep 1
            
            sample snh
            sleep 0.5
            sample sns
            sleep 0.5
            
            sample bds
            sleep 0.5
            sample ( i==0 ? sns : snh )
            sleep 0.5
            
          end
        end
      when 3
        density dns do |d|
          2.times do |i|
            
            sample bds
            sleep 1
            
            
            sample bdh
            sleep 0.5
            sample ( i==0 ? sns : bds )
            sleep 0.5
            
            sample snh
            sleep 1
            
            sample ( i!=0 ? bds  : sns )
            sleep 1
          end
        end
      end
    end
  end
end

live_loop :beats4 do
  4.times do |x|
    t = 2
    d = x>=2 ? 2 : 4
    p_beat x, t, d
  end
end