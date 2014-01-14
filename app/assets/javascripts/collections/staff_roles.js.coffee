class Spbec.Collections.StaffRoles extends Backbone.Collection
  model: Spbec.Models.StaffRole
  url: Routes.staff_roles_path(format: 'json')