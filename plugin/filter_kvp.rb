require 'fluent/time'
require 'fluent/config/error'
require 'fluent/plugin/filter'
require 'logfmt'

module Fluent::Plugin
  class KVPFilter < Filter
    Fluent::Plugin.register_filter('kvp', self)

    config_param :parse_key,          :string, :default => 'message'
    config_param :fields_key,         :string, :default => nil
    config_param :pattern,            :string,
                 :default => %{([a-zA-Z_-]\\w*)=((['"]).*?(\\3)|[\\w.@$%/+-]*)}
    config_param :strict_key_value,   :bool, :default => false
    config_param :remove_parse_key,   :bool, :default => false
    config_param :unmatched_key,      :string, :default => nil

    def configure(conf)
      super
    end

    def compiled_pattern
      @compiled_pattern ||= Regexp.new(pattern)
    end

    def filter(tag, time, record)
      source = record[parse_key].to_s
      target = fields_key ? (record[fields_key] ||= {}) : record

      if strict_key_value
        # Use logfmt to parse it (key=value)
        parsed = Logfmt.parse(source)
        target.merge!(parsed)
      else
        unmatched = source
        source.scan(compiled_pattern) do |match|
          (key, value, begining_quote, ending_quote) = match
          next if key.nil?
          next if target.has_key?(key)
          value = value.to_s
          from_pos = begining_quote.to_s.length
          to_pos = value.length - ending_quote.to_s.length - 1
          target[key] = value[from_pos..to_pos]
          unless unmatched_key.nil?
            unmatched = unmatched.gsub("#{key}=#{value}", "")
          end
        end
        unless unmatched_key.nil?
          unmatched = unmatched.strip
          unless unmatched.empty?
            target[unmatched_key] = unmatched
          end
        end
      end

      if remove_parse_key
        record.delete parse_key
      end

      return record
    end
  end
end
