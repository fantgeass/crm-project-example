class StaffController < ResourceController
  respond_to :json
  layout 'tcps'

  belongs_to :tcp, :project, polymorphic: true

end
