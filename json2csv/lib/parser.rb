class Parser
  def initialize(object)
    @object_flattened = flatten(object)
  end

  def get_keys
    remove_duplicates(sanitized_keys)
  end

  def get_values
    values = group_values_by_key
    values = array_stringifier(values).values
  end

  private

  def array_stringifier(values)
    new_hash = {}
    values.each do |key, value|
      new_hash[key] = value.join(',')
    end
    new_hash
  end

  def group_values_by_key
    new_hash = {}
    keys = get_keys
    keys.each do |key|
      reg = Regexp.new("^#{key}")
      values = @object_flattened.select { |k, v| !reg.match(k).nil? }.values
      new_hash[key] = values
    end
    new_hash
  end

  def remove_array_numbers(str)
    arr = str.split('.')
    arr = arr.delete_if{ |key| is_number?(key) }
    arr.join('.')
  end

  def remove_duplicates(arr)
    arr.uniq!
    new_array = []
    arr.each do |k|
      reg = Regexp.new("^#{k}.")
      new_array << k unless arr.select{ |v| !reg.match(v).nil? }.count > 1
    end
    new_array
  end

  def sanitized_keys
    keys_without_numbers = []
    @object_flattened.keys.each do |key|
      keys_without_numbers << remove_array_numbers(key)
    end
    keys_without_numbers
  end

  def is_number?(object)
    true if Float(object) rescue false
  end

  def flatten(object, prefix = nil)
    res = {}

    object.each_with_index do |elem, i|
      if elem.is_a?(Array)
        k, v = elem
      else
        k, v = i, elem
      end

      key = prefix ? "#{prefix}.#{k}" : k

      if v.is_a? Enumerable
        res.merge!(flatten(v, key))
      else
        res[key] = v
      end
    end

    res
  end
end
