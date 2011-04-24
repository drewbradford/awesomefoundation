require 'date'
module Awesome
  class Month
    include Comparable
    attr_accessor :month

    class << self
      def parse str
        if str.split('-').size == 2
          # Old format
          str = "%s-01" % str
        end

        self.new(Date.parse(str))
      end

      def this_month
        self.new Date.today
      end
    end

    def initialize date = nil
      date ||= Date.today
      @month = Date.new(date.year, date.month, 1)
    end

    def succ
      Month.new(@month.to_time.advance(:months => 1).to_date)
    end
    alias :next :succ

    def prev
      Month.new(@month.to_time.advance(:months => -1).to_date)
    end

    def <=> other
      self.iso <=> other.iso
    end

    def iso
      self.month.strftime('%Y-%m-01')
    end

    def to_s
      @month.strftime('%b %Y')
    end

    def method_missing method, *args
      @month.send(method, *args)
    end
  end
end
