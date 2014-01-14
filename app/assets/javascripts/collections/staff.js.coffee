class Spbec.Collections.Staff extends Backbone.QueryCollection
  model: Spbec.Models.StaffMember
  comparator: 'staff_role_id'
