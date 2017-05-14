
require "json"


def to_keys(val : String)
  match = val.match(/^(?<main>[^\[\.]+)(\[(?<i>[^\]]+)\])?$/)
  return nil unless match
  if match["i"]?
    return {match[1], match[3]}
  end

  return match["main"]
end # === def to_keys


if ARGV.size != 2
  puts "!!! Only 2 arguments allowed: #{ARGV.inspect}"
  exit 2
end

raw = ARGV.first
target = ARGV.last

json = JSON.parse_raw(raw)

def to_i(raw : String)
  unless raw =~ /^[0-9]{1,3}$/
    raise Exception.new("Invalid index for array: #{raw.inspect}")
  end
  raw.to_i
end # === def to_i

def get_index(v : Array, raw_i : String)
  v[to_i(raw_i)]
end # === def get_index

def get_index(v, raw_i)
  raise Exception.new("Not an array: #{v.inspect} (key: #{raw_i.inspect}")
end

def get_key(v : Hash, raw_key : String)
  # raw_key = a | b[c] | c[1]

  key = to_keys(raw_key)
  case key
  when Tuple(String, String)
    v = get_key(v, key.first)
    get_index(v, key.last)
  when String
    unless v.has_key?(key)
      raise Exception.new("Key not found: #{key.inspect} in #{v.inspect}")
    end
    v[key]
  else
    raise Exception.new("Unknown index for array: #{raw_key}")
  end

end # def get_key

def get_key(v, k)
  raise Exception.new("Not a Hash: #{v.inspect} (key: #{k.inspect}")
end # === def get_key

def get(v : Hash, k : String)
  get_key(v, k)
end # === def get

def get(v : Array, k : String)
  get_index(v, k)
end # === def get

def get(v, k)
  raise Exception.new("!!! Not an Array or Hash: #{v.inspect} (key: #{k.inspect})")
end # === def get

current = json
target.split(".").each do |k|
  current = get(current, k)
end # === each

puts current
