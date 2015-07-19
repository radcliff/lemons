# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready () ->


  # $('form#item > *').click(function(event){alert("form clicked!")});

  $submit = $('#submit')
  $submit.click ->  # submit item form by clicking button
    $(this).removeClass('success').addClass('secondary') # make button look disabled

    session = Cookies.get('_lolsesh')

    if session
      submitItem(session)
    else
      $('#authModal').foundation('reveal', 'open')

  submitItem = (userId) ->
    # $submit.off('click')  # remove handler from submit button

    item = {}  # create an empty item object
    item['user_id'] = userId

    itemAttributes = $('form#item').serializeArray()  # pull all the attributes from form

    $.each itemAttributes, (index, element) ->
      element.value = parseInt(element.value) if element.name == 'quantity'  # quantity is an integer

      item[element.name] = element.value  # set attributes on item

    $.ajax(
      url: 'api/items'
      type: 'POST'
      dataType: 'json'
      data: item
    )
      .done (data) ->
        $('form#item')[0].reset()  # clear item form
        $submit.removeClass('secondary').addClass('success') # make button look enabled
        showSuccessAlert(data)

      .fail (error) ->
        console.log error.statusText

  showSuccessAlert = (item) ->
    window.scrollTo(0, 0)  # scroll to top of window

    source = $("#success-alert-template").html()
    template = Handlebars.compile(source)

    $(template item.item).hide().appendTo('.title').fadeIn(500)
      .delay(10000).fadeOut(500)


  $('#logIn').click () ->  # submit auth form by clicking button
    $('form.login').submit()

  $('form.login').submit (event) ->  # whenever the form is submitted
    event.preventDefault()
    logIn()

  logIn = () ->  # make ajax call for login
    $emailField = $('.login input[type=email]')
    $passwordField = $('.login input[type=password]')

    session =
      session:
        email: $emailField.val()
        password: $passwordField.val()

    $.post('api/sessions', session)  # login !
      .done (data) ->
        userId = createSession(data.session.id)  # store session cookie

        $emailField.val('')
        $passwordField.val('')

        $('#authModal').foundation('reveal', 'close')
        submitItem(userId)

      .fail (error) ->
        console.log error.statusText

  createSession = (id) ->  # create session cookie
    Cookies.set('_lolsesh', id, { expires: 7 })
    Cookies.get('_lolsesh')
