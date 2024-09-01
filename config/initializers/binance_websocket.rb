# config/initializers/binance_websocket.rb
require_relative '../../app/workers/binance_websocket_worker'
Rails.application.config.after_initialize do
  Thread.new do
    BinanceWebsocketWorker.perform_async
  end
end
