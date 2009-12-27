if Dir::entries(".").rindex("images") == nil
  Dir::mkdir("images")
end

puts "Starting hoovering of 'www.giantitp.com' comics..."

require 'net/http'
nums = Array::new
max = 0
Net::HTTP::start("www.giantitp.com") do |cnx|

  response, comics_data = cnx.get("/comics/oots.html")
    comics_data.scan(%r{<P class="ComicList">(\d+) <A href="(/comics/oots\d+.html)">([^\"]+)</A>}m) do |t| 
    #A-Za-z0-9 &,.!'\-:\?\(\)#\/
    i = t[0].to_i
    nums << i
    max = (i > max ? i : max)
    url = t[1]
    title = t[2]

    title.gsub!(/[ &,.!'\-:\?\(\)#\/]/, '_')
    title.squeeze!('_')
    title.chomp!('_')
    img_name = sprintf("%04d_%s.gif", i, title)
    if File::exists?("images/" + img_name) 
      puts "File #{img_name} already exists, skipping..."
      next 
    end
    puts "Creating #{img_name}..."
    answer, data = cnx.get(url)
    data =~ /<TD align="center"><IMG src="(\/comics\/images\/([A-Za-z0-9]+.gif))"><\/TD>/
    response, data = cnx.get($1)
    File::open("images/" + img_name, "wb") do |f|
      f << data
    end
    puts "#{img_name} created..."
    $stdout.flush

  end
end

puts "End of hoovering..."
puts "Checking missing files..."
(1..max).each do |num|
  if !nums.index(num)
    puts "File nÃƒâ€šÃ‚Â°#{num} missing"
    end
  end
puts "End of checking..."