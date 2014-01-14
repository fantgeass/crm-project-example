class Spbec.Collections.AttachmentCategories extends Backbone.Collection
  model: Spbec.Models.AttachmentCategory
  url: Routes.attachment_categories_path(format: 'json')