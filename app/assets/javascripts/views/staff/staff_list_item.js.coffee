class Spbec.Views.StaffListItem extends Backbone.View
  template: JST['staff/list_item']
  tagName: 'li'
  events: {
    'click .action-remove' : 'removeStaffMember'
  }

  removeStaffMember: (e) ->
    e.preventDefault()
    @model.url = "#{@model.url}/#{@model.id}" # don't why model doesn't copy url from collection like it said in documentation
    @model.destroy()

  render: ->
    $(@el).html(@template(member: @model))
    return this

