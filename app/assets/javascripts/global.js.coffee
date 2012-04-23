$ ->
  $(".close").click ->
    $('.alert').slideUp 'slow'

  setTimeout "$('.alert').slideUp('slow')", 5000	