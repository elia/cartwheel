class ProductsController < ApplicationController
  def index
    @products = extract_nodes storefront.query query: <<~GRAPHQL
      #graphql
      {
        # https://shopify.dev/docs/api/storefront/2024-04/queries/products
        products(first: 12) {
          edges {
            node {
              id
              title
              handle
              description

              # https://shopify.dev/docs/api/storefront/2024-04/objects/Image
              featuredImage { url altText }
            }
          }
        }
      }
    GRAPHQL
  end

  private

  def extract_nodes(graphql_response)
    graphql_response.body.dig('data', 'products', 'edges')&.map do
      OpenStruct.new _1['node']
    end
  end
end
