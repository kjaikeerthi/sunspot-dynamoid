require 'sunspot'
require 'dynamoid'
require 'sunspot/rails'

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
        @instance.hash_key
      end

      def is_range?
        !(@instance.range_key.nil?)
      end

      def range_key
        @instance.range_key
      end

      def range_value
        @instance.range_value
      end
    end

    class DataAccessor < Sunspot::Adapters::DataAccessor
      def load(id)
        @clazz.find(id, options)
      end

      def load_all(ids)
        Array(@clazz.find(ids))
      end

    end
  end
end
