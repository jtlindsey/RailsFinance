jQuery(function(){

$(document).on('page:change', function() {
  // var getFieldCount = function() {
  //   var accountType = $('#account_type').val();
  //   return $('.field.' + accountType).size();
  // };

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

  if ($('#new_account').size() > 0) {
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

    $("#account_type").prepend("<option value='' selected='selected'>Please Select</option>");
  }

});



});
