class Keygen
  attr_accessor :hash_key, :range_key

  def self.process(keys)
    @key_comb = []
    keys.each do |key|
      kg = self.new(key)
      @key_comb << [kg.hash_key, kg.range_key]
    end
    @key_comb
  end

  def initialize(str)
    @str = str
    @str_arr = str.split(" ")
  end

  def hash_key
    type_cast(@str[hash_key_index..(hash_key_index + hash_key_length - 1)], hash_key_type)
  end

  def hash_key_type
    type_str = @str_arr[1]
    unless type_str[1].to_i > 0
      return type_str[1..(type_str[0].to_i)]
    end
    nil
  end

  def hash_key_length
    hash_key_string = @str_arr[0]
    if hash_key_string[0..1] == "hk"
      return hash_key_string[2..-1].to_i
    end
    nil
  end

  def hash_key_index
    @str_arr[0].length + @str_arr[1].length + @str_arr[2].length + @str_arr[3].length + 4
  end

  def range_key
    type_cast(@str[range_key_index..(range_key_index + range_key_length - 1)], range_key_type)
  end

  def range_key_type
    type_str = @str_arr[3]
    unless type_str[1].to_i > 0
      return type_str[1..(type_str[0].to_i)]
    end
    nil
  end

  def range_key_length
    range_string = @str_arr[2]
    if range_string[0..1] == "rk"
      return range_string[2..-1].to_i
    end
    nil
  end

  def range_key_index
    hash_key_index + hash_key_length + 1
  end

  def type_cast(value, datatype)
    case(datatype)
    when "String"
      return value.to_s
    when "Fixnum"
      return value.to_i
    when "Float"
      return value.to_f
    end
  end

end
