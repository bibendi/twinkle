# frozen_string_literal: true
class ApplicationFinder
  def self.collections(memoize: false)
    include Findit::Collections

    set_callback(:find, :around, :memoize) if memoize
  end

  private

  def memoize
    @data ||= RequestStore.fetch(cache_key) { yield }
  end
end
