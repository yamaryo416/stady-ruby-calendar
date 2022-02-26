require 'date'
require 'optparse'

# optionの入力があったかどうかの変数
params = { is_input: false }

opt = OptionParser.new
opt.on('-m') { |v| params[:is_input] = v }
opt.parse!(ARGV)

# 入力値を数値にして、格納
inputMonth = ARGV[0].to_i

# 入力があり、その値が適切でない場合はエラー
if params[:is_input] && !inputMonth.between?(1, 12)
  raise "cal: #{inputMonth} is neither a month number (1..12) nor a name"
end


year = Date.today.year
# 入力があった場合は入力値の月を、ない場合は今月
mon = params[:is_input] ? inputMonth : Date.today.mon
head = "#{mon}月 #{year}"
firstday_wday = Date.new(year, mon, 1).wday
lastday_date = Date.new(year, mon, -1).day
week = %w(日 月 火 水 木 金 土)

puts head.center(20)
puts week.join(" ")
print " " * 3 * firstday_wday

wday = firstday_wday
(1..lastday_date).each do |date|
  print date.to_s.rjust(2) + " "
  wday = wday + 1
  # 土曜日までの日付が埋まったら、改行を入れる
  if wday % 7 == 0
    print "\n"
  end
end
# 最終日が土曜日にこなかった場合、改行が入らないため、改行を入れる
if wday % 7 != 0
  print "\n"
end
