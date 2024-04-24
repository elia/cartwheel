logger = Logger.new(Rails.root.join('log/storefront.log'))
HTTParty::Basement.logger logger, :error, :logstash

module GraphqlQueryLogger
  def query(query:, **kw)
    short_query = query.gsub(/^\s*#.*$/, ' ').gsub(/\n\s*/, ' ').strip
    Rails.benchmark "  Querying the StorefrontAPI #{short_query}" do
      super(query: query, **kw)
    end
  end

  ShopifyAPI::Clients::Graphql::Storefront.prepend self
end
