
class BinanceWebsocketWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform
    BinanceWebsocketService.start
  rescue StandardError => e
    Rails.logger.error "BinanceWebsocketWorker error: #{e.message}"
    # Restart the worker after a short delay
    self.class.perform_in(5.seconds)
  end
end
