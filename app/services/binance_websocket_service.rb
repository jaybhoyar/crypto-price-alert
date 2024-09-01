# app/services/binance_websocket_service.rb
require 'faye/websocket'
require 'eventmachine'
require 'json'

class BinanceWebsocketService
  BINANCE_WEBSOCKET_URL = 'wss://stream.binance.com:9443/ws/btcusdt@avgPrice'

  def self.start
    EM.run {
      ws = Faye::WebSocket::Client.new(BINANCE_WEBSOCKET_URL)

      ws.on :message do |event|
        data = JSON.parse(event.data)
        price = data['w'].to_i.round
        AlertCheckService.check_alerts(price)
      end

      ws.on :close do |event|
        p [:close, event.code, event.reason]
        ws = nil
        EM.add_timer(5) { self.start } # Attempt to reconnect after 5 seconds
      end
    }
  end
end
