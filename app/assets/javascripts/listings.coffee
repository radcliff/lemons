# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready () ->


  $submit = $('#submit')
  $submit.click ->  # submit item form by clicking button
    $(this).removeClass('success').addClass('secondary') # make button look disabled

    session = Cookies.get('_lolsesh')

    if session
      submitItem(session)
    else
      $('#authModal').foundation('reveal', 'open')

  submitItem = (userId) ->
    item = {}  # create an empty item object
    item['user_id'] = userId

    itemAttributes = $('form#item').serializeArray()  # pull all the attributes from form

    $.each itemAttributes, (index, element) ->
      if element.name == 'quantity'
        element.value = parseInt(element.value)

      item[element.name] = element.value  # set attributes on item

    $.ajax(
      url: 'api/items'
      type: 'POST'
      dataType: 'json'
      data: item
    )
      .done (data) ->
        $submit.removeClass('secondary').addClass('success') # make button look enabled

        console.log data
      .fail (error) ->
        console.log error.statusText


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
        userId = createSession(data)  # store session cookie

        $emailField.val('')
        $passwordField.val('')

        $('#authModal').foundation('reveal', 'close')
        submitItem(userId)

      .fail (error) ->
        console.log error.statusText

  createSession = (session) ->  # create session cookie
    Cookies.set('_lolsesh', session.session.id, { expires: 7 })
    Cookies.get('_lolsesh')
