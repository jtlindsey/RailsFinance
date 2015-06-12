$(document).on('page:change', function() {
  var getFieldCount = function() {
    var accountType = $('#account_type').val();
    return $('.field.' + accountType).size();
  };

  // Add classes to label each field under its account type for later easy grabbing in jQueries
  var accountFields = {}
  try {
    accountFields = JSON.parse($('#account_fields').val());
  } catch(jsonException) {
    //ignore errors without crashing
  }
  for (var accountType in accountFields) {
    var fields = accountFields[accountType];
    for (field of fields) {
      var field = $('#account_' + field).closest('.field');
      field.addClass(accountType);
    }
  }

  // TODO make sure switching type reorders fields also in the future
  if ($('#edit_account').size() > 0) {
    var showCorrectFieldsPerAccountType = function() {
      $('.field').hide();
      var accountType = $('#account_type').val();
      var fields = accountFields[accountType];
      for (field of fields) {
        var field = $('#account_' + field).closest('.field');
        field.show();
      }
    };
    $('#account_type').change(showCorrectFieldsPerAccountType);
    showCorrectFieldsPerAccountType();
  }

  $('#new_account input[type=submit]').hide();

  if (($('#new_account').size() > 0)) {
    var determineAvailableUserActionsAfterPerformingNext = function() {
      var newVisibleIndex = getVisibleIndex();
      var maxIndex = getFieldCount() - 1;
      if (newVisibleIndex == maxIndex) {
        $('#next').hide();
        $('#new_account input[type=submit]').show();
      }
      if (newVisibleIndex > 0) {
        $('#prev').show();
      }
    };

    var accountErrorsFields = [];
    try {
      var accountErrors = JSON.parse($('#account_errors').val());
      for(var field in accountErrors) accountErrorsFields.push(field);
    } catch(jsonException) {
      //ignore errors without crashing
    }

    $('.field').hide();
    var accountType = $('#account_type').val();      
    var firstFieldToShow = $('.field.' + accountType).first();
    if (accountErrorsFields.length > 0) {
      var firstErrorField = accountErrorsFields[0];
      firstFieldToShow = $('.field label[for=account_' + firstErrorField + ']').closest('.field');
    }
    firstFieldToShow.show({
      complete: determineAvailableUserActionsAfterPerformingNext
    });

    var getVisibleIndex = function() {
      var accountType = $('#account_type').val();
      var visibleIndex = -1;
      $('.field.' + accountType).filter(function(i) {
        return ($(this).is(':visible')) ? (visibleIndex = i) && true : false;
      });
      return visibleIndex;
    };

    // TODO Support ordered showing of fields
    $('#next').click(function() {
        var accountType = $('#account_type').val();
        var visibleIndex = getVisibleIndex();
        var fieldToHide = $('.field.'+accountType)[visibleIndex];
        $(fieldToHide).hide({
          complete: function() {
            var nextElementIndex = visibleIndex + 1;
            var fieldToShow = $('.field.'+accountType)[nextElementIndex];
            $(fieldToShow).show({
              complete: determineAvailableUserActionsAfterPerformingNext
            });
          }
        });

      }
    );

    var determineAvailableUserActionsAfterPerformingPrevious = function() {
      var visibleIndex = getVisibleIndex();
      if (visibleIndex == 0) {
        $('#prev').hide();
      }
      var maxIndex = getFieldCount() - 1;
      if (visibleIndex < maxIndex) {
        $('#next').show();
        $('#new_account input[type=submit]').hide();
      }
    };

    $('#prev').click(function() {
        var accountType = $('#account_type').val();
        var visibleIndex = getVisibleIndex();
        var fieldToHide = $('.field.'+accountType)[visibleIndex];
        $(fieldToHide).hide({
          complete: function() {
            var previousElementIndex = visibleIndex - 1;
            var fieldToShow = $('.field.'+accountType)[previousElementIndex];
            $(fieldToShow).show({
              complete: determineAvailableUserActionsAfterPerformingPrevious
            });
          }
        });

      }
    );
  }
});
