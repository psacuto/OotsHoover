Dir::foreach("images") do |f|
  puts f
  if f =~ /\d{4}_.*/ or f == "." or f == ".."
    puts "next"
    $stdout.flush
    next
  end
  
  newf = f.gsub(/\d+_/) { |n| sprintf("%04d_", n.to_i) }
  
  puts "----->" + newf
  
  File::rename("images/" + f, "images/" + newf)
  
  end