require 'csv'

infn=ARGV[0]
outfn=ARGV[1]

data=CSV.read(infn)

def ref_to_row_score(x)
  matched = x.match(/^([A-Z]+)([0-9]+)/i)
  if matched
    alpha, num = matched.captures
    score = "#{alpha}#{num.rjust(5,"0")}"
    return score
  else
    return "!#{x}"
  end
end

def ref_to_num(x)
  x.split("-").last.gsub(/[^0-9]/,'').to_i
end

data.each do |row|
  refs = row[0].split(" ").sort_by {|x| ref_to_num(x)}
  done = false
  while !done && refs.size>1 do
    i = 0
    loop do
      b = ref_to_num(refs[i+1])
      a = ref_to_num(refs[i])
      if b==a+1
        # merge with next
        refs[i] = [refs[i].split("-").first, refs[i+1]].join("-")
        refs.delete(refs[i+1])
        break
      end
      i += 1
      if i == refs.size-1
        done = true
        break
      end
    end
  end
  row[0] = refs.join(" ")
end

CSV.open(outfn, "w") do |out|
  data = data.sort_by {|y| ref_to_row_score(y[0]) }
  data.each do |row|
    out << row
  end
end
