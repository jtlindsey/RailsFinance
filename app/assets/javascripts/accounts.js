$(document).on('page:change', function() {
  // TODO make sure switching type reorders fields also in the future
  if ($('#edit_account').size() > 0) {
    var account_fields = JSON.parse($('#account_fields').val());
    var showCorrectFieldsPerAccountType = function() {
      $('.field').hide();
      var fields = account_fields[$('#account_type').val()];
      for (field of fields) {
        $('#account_' + field).closest('.field').show();
      }
    };
    $('#account_type').change(showCorrectFieldsPerAccountType);
    showCorrectFieldsPerAccountType();
  }

  $('#new_account input[type=submit]').hide();
  if (($('#new_account').size() > 0)) {
    var account_fields = JSON.parse($('#account_fields').val());
    $('.field').hide();
    $('.field:nth-of-type(1)').show();

    var getVisibleIndex = function() {
      var visibleIndex = -1; 
      $('.field').filter(function(i) { 
        return ($(this).is(':visible')) ? (visibleIndex = i) && true : false;
      }); 
      return visibleIndex;
    };

    // var canDisplayElementWithIndex = function(elementIndex) {
    //   var type = $('#account_type').val();
    //   var fields = account_fields[type]
    //   var inputElement = $('.field:nth-of-type(' + elementIndex + ')').find('input,select');
    //   console.log(inputElement[0]);
    //   if (!inputElement) return false;
    //   var fieldName = inputElement.attr('id').replace('account_', '');
    //   return fields.indexOf(fieldName) > -1
    // }

    // var determineNextElementIndexPerAccountSubtypeFields = function(visibleIndex) {
    //   nextElementIndex = visibleIndex + 1;
    //   if (canDisplayElementWithIndex(nextElementIndex)) {
    //     return nextElementIndex;
    //   } else {
    //     if ((nextElementIndex+1) == $('.field').size()) {
    //       //TODO inspect completness of next line's code (perhaps consider returning -1)
    //       return -1; //stay on the same field
    //     } else {
    //       return determineNextElementIndexPerAccountSubtypeFields(nextElementIndex + 1)          
    //     }
    //   }
    // }

    // TODO Support ordered showing of fields
    $('#next').click(function() { 
        var visibleIndex = getVisibleIndex(); //0-based index
        var visibleCssIndex = getVisibleIndex() + 1; //1-based index
        var fieldCount = $('.field').size();

        // + 1 for designer indexing 
        $('.field:nth-of-type(' + visibleCssIndex + ')').hide({
          complete: function() {
            var nextElementIndex = visibleIndex + 1; //determineNextElementIndexPerAccountSubtypeFields(visibleIndex);
            var nextElementCssIndex = nextElementIndex + 1;
            // + 1 for designer indexing and + 1 for the next element
            $('.field:nth-of-type(' + nextElementCssIndex + ')').show({
              complete: function() {
                var newVisibleIndex = getVisibleIndex();
                var maxIndex = fieldCount - 1;
                //TODO inspect completness of next line's code
                // if ((newVisibleIndex == maxIndex) || (determineNextElementIndexPerAccountSubtypeFields(newVisibleIndex) == -1)) {
                if (newVisibleIndex == maxIndex) {
                  $('#next').hide();
                  $('#new_account input[type=submit]').show();
                }
                if (newVisibleIndex > 0) {
                  $('#prev').show();
                }
              }
            });          
          }
        });

      }
    );  
    $('#prev').click(function() { 
        var visibleIndex = getVisibleIndex();
        var fieldCount = $('.field').size(); 
        // + 1 for CSS indexing (1-based)
        $('.field:nth-of-type(' + (visibleIndex + 1) + ')').hide({
          complete: function() {
            // + 1 for CSS indexing and - 1 for the previous element
            $('.field:nth-of-type(' + (visibleIndex + 1 - 1) + ')').show({
              complete: function() {
                var visibleIndex = getVisibleIndex();
                if (visibleIndex == 0) {
                  $('#prev').hide();
                }
                var maxIndex = fieldCount - 1
                if (visibleIndex < maxIndex) {
                  $('#next').show();
                  $('#new_account input[type=submit]').hide();
                }
              }
            });          
          }
        });

      }
    );  
  }
});
