ShopifyApp.configure do |config|
  config.application_name = "My Shopify App"
  config.api_key = "39bf3276a42977acd720798ebfc17809"
  config.secret = "c3d91fda446c565877bf988a15485d5f"
  config.scope = "read_orders,read_products,read_customers"
  config.embedded_app = true
  config.webhooks = [
    {topic: 'customers/create', address: 'https://f94b86dc.ngrok.io/webhooks/customers_create', format: 'json'},
    {topic: 'products/create', address: 'https://f94b86dc.ngrok.io/webhooks/product_create', format: 'json'},
    {topic: 'carts/update', address: 'https://f94b86dc.ngrok.io/webhooks/carts_update', format: 'json'}
  ]
end
