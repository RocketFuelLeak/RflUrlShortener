errorMessage = 'Unable to shorten URL, make sure you are inputting a valid URL.'

showError = ->
    div = $('<div class="alert alert-danger">' + errorMessage + '</div>')
    $('#new_url .notice-container').append(div)

showSuccess = (data) ->
    url = data.goto_url
    div = $('<div class="alert alert-success"><strong>Success!</strong> Copy your shortened URL: </div>')
    input = $('<input class="form-control" type="text" readonly="readonly" value="' + url + '">')
    input.on 'focus', (e) ->
        $(this).select()
    div.append(input)
    $('#new_url .notice-container').append(div)
    $('#url_long').val('')
    input.select()

clearFormErrors = ->
    $('#new_url .notice-container').empty()

inProgress = false

$(document).on 'ready page:load', ->
    form = $('#new_url')
    form.on 'submit', (e) ->
        e.preventDefault()
        return if inProgress
        inProgress = true
        clearFormErrors()
        long = $('#url_long').val()
        button = $('#new_url input[name="commit"]')
        button.button 'loading'
        $.ajax(
            url: '/api/create'
            type: 'POST'
            #accepts: 'application/json'
            #contentType: 'application/json'
            data:
                url:
                    long: long
            success: showSuccess
            error: showError
        ).always ->
            button.button 'reset'
            inProgress = false
            return
