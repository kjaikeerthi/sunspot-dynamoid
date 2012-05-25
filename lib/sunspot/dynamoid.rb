require 'sunspot'
require 'dynamoid'
require 'sunspot/rails'
require 'sunspot/keygen'

# == Examples:
#
# class Post
#   include Dynamoid::Document
#   field :title
# 
#   include Sunspot::Dynamoid
#   searchable do
#     text :title
#   end
# end
#

module Sunspot
  module Dynamoid
    def self.included(base)
      base.class_eval do
        extend Sunspot::Rails::Searchable::ActsAsMethods
        Sunspot::Adapters::DataAccessor.register(DataAccessor, base)
        Sunspot::Adapters::InstanceAdapter.register(InstanceAdapter, base)
      end
    end

    class InstanceAdapter < Sunspot::Adapters::InstanceAdapter
      def id
        range_value = nil
        if is_range?
          range_value = @instance.send :dump_field, @instance.read_attribute(@instance.range_key), @instance.class.attributes[@instance.range_key]
        end
        generate_key(range_value)
      end

      def is_range?
        !(@instance.range_key.nil?)
      end

      def generate_key(range_value)
        range_value_type = range_value.class.to_s
        "hk#{@instance.hash_key.to_s.size} #{@instance.hash_key.class.to_s.length}#{@instance.hash_key.class.to_s} rk#{range_value.to_s.size} #{range_value_type.length}#{range_value_type} #{@instance.hash_key} #{range_value}"
      end

    end

    class DataAccessor < Sunspot::Adapters::DataAccessor
      def load(id)
        k = Keygen.new(id)
        if k.range_key.nil?
          @clazz.find(k.hash_key)
        else
          @clazz.find_by_id(k.hash_key, {range_key: k.range_key})
        end
      end

      def load_all(ids)
        key_ids = Keygen.process(ids)
        binding.pry
        if @clazz.range_key.nil?
          key_ids.flatten!.compact!
        end
        binding.pry
        Array(@clazz.find_all(ids))
      end

    end
  end
end
