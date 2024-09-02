class NotificationService
  def self.send_alert_notification(alert, current_price)
    message = "ALERT TRIGGERED: User #{alert.email}'s alert for #{alert.coin} has been triggered. " \
              "Target price: $#{alert.target_price}, Current price: $#{current_price}"

    puts "\n#{message}\n"
    Rails.logger.info(message)  # This will log the message to your Rails log file as well
  end
end
