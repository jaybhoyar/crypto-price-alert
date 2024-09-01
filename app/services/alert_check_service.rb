# app/services/alert_service.rb
class AlertCheckService
  def self.check_alerts(current_price)
    triggered_alerts = Alert.created.where('target_price <= ?', current_price)

    triggered_alerts.each do |alert|
      alert.update(status: 'triggered')
      NotificationService.send_alert_notification(alert, current_price)
    end
  end
end
