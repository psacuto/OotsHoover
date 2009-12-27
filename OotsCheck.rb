nums = Array::new
Dir::foreach("images") do |file|
  if !(file =~ /(\d{4})_.*/)
    puts "next"
    next
  end
  
  num = $1
  puts file, num.to_i
  
  nums << num.to_i
  
end

(1..368).each do |num|
  if !nums.index(num)
    puts "#{num} missing"
    end
  end
