class ApplicationController < ActionController::Base

  private

  def storefront
    @storefront ||= ShopifyAPI::Clients::Graphql::Storefront.new(
      ENV["PUBLIC_STORE_DOMAIN"] || "mock.shop",
      ENV["PUBLIC_STOREFRONT_API_TOKEN"] || "",
    )
  end
end
