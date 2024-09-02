class Alert < ApplicationRecord
  belongs_to :user

  STATUSES = %w[created triggered deleted].freeze

  after_initialize :set_default_status, if: :new_record?

  validates :status, inclusion: { in: STATUSES }

  scope :created, -> { where(status: 'created') }
  scope :triggered, -> { where(status: 'triggered') }

  private
    def set_default_status
      self.status ||= 'created'
    end
end
