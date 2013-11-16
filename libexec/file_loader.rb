puts "--------------------"
puts "opening file: #{ARGV[0]}"
puts "--------------------"

f = File.open(ARGV[0])

# throw away the first line
f.readline
counter = 1

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
  puts "Processing line #{counter}" if counter % 10000 == 0
  counter = counter + 1

end

