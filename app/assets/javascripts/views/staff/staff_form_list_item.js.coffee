class Spbec.Views.StaffFormListItem extends Backbone.View
  template: JST['staff/form_list_item']
  tagName: 'li'
  className: 'media'
  events: {
  'click .action-close' : 'removeStaffMember'
  }

  removeStaffMember: (e) ->
    e.preventDefault()

    if @model.get('id') isnt undefined
      @collection.get(@model)._destroy = true
      @collection.trigger('change')
    else
      @collection.remove(@model)

  render: ->
    $(@el).html(@template(member: @model))
    return this

