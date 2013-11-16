puts "--------------------"
puts "opening file: #{ARGV[0]}"
puts "--------------------"

f = File.open(ARGV[0])

# throw away the first line
f.readline
counter = 1

start_time = Time.now
checkpoint = Time.now

puts "starting at #{start_time}"

while !f.eof? do
  line = f.readline

  arr = line.split("|")
  uid = arr[0].gsub("-","")
  username = arr[2][1..-2]
  password = arr[3][1..-2].unpack("H*").first
  hint_string = arr[4][1..-1]
  password_hint = hint_string.empty? ? nil : hint_string
  begin
    User.create(
      uid: uid,
      username: username,
      password: password,
      password_hint: password_hint
    )

  rescue
    puts "ERROR"
    puts line
  end

  if counter % 1000 == 0
    puts "--------------------"
    puts "Processing line #{counter}"
    new_checkpoint = Time.now
    puts "#{new_checkpoint - checkpoint} seconds since 10k ago"
    puts "#{(new_checkpoint - start_time).to_i} seconds since start"
    checkpoint = new_checkpoint
    puts "--------------------"
  end

  counter = counter + 1

end

