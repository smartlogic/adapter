require 'adapter'

module Adapter
  module Memory
    def read(key)
      decode(hash_client[key_for(key)])
    end

    def write(key, value)
      hash_client[key_for(key)] = encode(value)
    end

    def delete(key)
      read(key).tap { hash_client.delete(key_for(key)) }
    end

    def clear
      client.clear
    end

    def all_keys
      if @options[:hash]
        hash_client.keys
      else
        raise StandardError, "option :hash required for retrieving all keys"
      end
    end

    def hash_client
      if @options[:hash]
        client[@options[:hash]] ||= {}
      else
        client
      end
    end
  end
end

Adapter.define(:memory, Adapter::Memory)
