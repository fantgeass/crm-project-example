### SELECT2 ###
$.extend($.fn.select2.defaults,
  formatNoMatches: ->
    "Совпадений не найдено"
  formatInputTooShort: (input, min) ->
    n = min - input.length
    "Пожалуйста, введите еще " + n + " символ" + ((if n is 1 then "" else ((if (n > 1) and (n < 5) then "а" else "ов"))))
  formatInputTooLong: (input, max) ->
    n = input.length - max
    "Пожалуйста, введите на " + n + " символ" + ((if n is 1 then "" else ((if (n > 1) and (n < 5) then "а" else "ов")))) + " меньше"
  formatSelectionTooBig: (limit) ->
    "Вы можете выбрать не более " + limit + " элемент" + ((if limit is 1 then "а" else "ов"))
  formatLoadMore: (pageNumber) ->
    "Загрузка данных..."
  formatSearching: ->
    "Поиск..."
)

### RIVETS ####
rivets.configure adapter:
  subscribe: (obj, keypath, callback) ->
    obj.on "change:" + keypath, callback

  unsubscribe: (obj, keypath, callback) ->
    obj.off "change:" + keypath, callback

  read: (obj, keypath) ->
    obj.get keypath

  publish: (obj, keypath, value) ->
    obj.set keypath, value

rivets.formatters.collection = (collection) -> collection.models

### GLOBAL AJAX HANDLERS ###
$(document).ajaxStart( ->
  $('#loading').show()
)

$(document).ajaxComplete( ->
  $('#loading').hide()
)

### BOOTBOX ###
bootbox.backdrop(true)
bootbox.setLocale('ru')
bootbox.classes('modal-spbec')

jQuery(document).ready ($) ->

  ### DATEPICKERS ####
  $('#user_date_of_birth').datepicker(
    yearRange: "-100:+0"
    changeMonth: true
    changeYear: true
  )
  $('#layout-datepicker').datepicker(
    showWeek: true
  )

  $(".datepicker").datepicker()
  # http://stackoverflow.com/questions/7033420/jquery-date-picker-z-index-issue
  $('.datepicker').css('position', 'relative')
  $('.datepicker').css('z-index', '2')

