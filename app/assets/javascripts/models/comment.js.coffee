class Spbec.Models.Comment extends  Backbone.RelationalModel
  defaults:
    parent_id: null
    body: ''


  urlRoot: '/comments'
  relations: [
    type: Backbone.HasMany
    key: 'attachments'
    relatedModel: 'Spbec.Models.Attachment'
    collectionType: 'Spbec.Collections.Attachments'
    keySource: 'attachment_ids'
    includeInJSON: Backbone.Model.prototype.idAttribute
    reverseRelation:
      key: 'comment'
      includeInJson: 'id'
  ]

Spbec.Models.Comment.setup()