// $(document).on('page:change', function() {
//   //TODO Move the following two buttons into the HTML ERB template directly inside div.actions
//   $('#new_account').append('<input type="button" value="Previous" id="prev" style="display: none;" />')
//   $('#new_account').append('<input type="button" value="Next" id="next" />')

//   if ($('#edit_account').size() > 0) {
//     var account_fields = JSON.parse($('#account_fields').val());
//     var showCorrectFieldsPerAccountType = function() {
//       $('.field').hide();
//       var fields = account_fields[$('#account_type').val()];
//       for (field of fields) {
//         $('#account_' + field).closest('.field').show();
//       }
//     };
//     $('#account_type').change(showCorrectFieldsPerAccountType);
//     showCorrectFieldsPerAccountType();
//   }

//   $('#new_account input[type=submit]').hide()
//   if (($('#new_account').size() > 0)) {
//     var account_fields = JSON.parse($('#account_fields').val());
//     $('.field').hide();
//     $('.field:nth-of-type(1)').show();

//     var getVisibleIndex = function() {
//       var visibleIndex = -1; 
//       $('.field').filter(function(i) { 
//         return ($(this).is(':visible')) ? (visibleIndex = i) && true : false;
//       }); 
//       return visibleIndex;
//     };

//     $('#next').click(function() { 
//         var visibleIndex = getVisibleIndex();
//         var fieldCount = $('.field').size(); 
//         // + 1 for designer indexing 
//         $('.field:nth-of-type(' + (visibleIndex + 1) + ')').hide({
//           complete: function() {
//             // + 1 for designer indexing and + 1 for the next element
//             $('.field:nth-of-type(' + (visibleIndex + 1 + 1) + ')').show({
//               complete: function() {
//                 var visibleIndex = getVisibleIndex();
//                 if (visibleIndex == fieldCount - 1) {
//                   $('#next').hide();
//                   $('#new_account input[type=submit]').show();
//                 }
//                 if (visibleIndex > 0) {
//                   $('#prev').show();
//                 }
//               }
//             });          
//           }
//         });

//       }
//     );  
//     $('#prev').click(function() { 
//         var visibleIndex = getVisibleIndex();
//         var fieldCount = $('.field').size(); 
//         // + 1 for CSS indexing (1-based)
//         $('.field:nth-of-type(' + (visibleIndex + 1) + ')').hide({
//           complete: function() {
//             // + 1 for CSS indexing and - 1 for the previous element
//             $('.field:nth-of-type(' + (visibleIndex + 1 - 1) + ')').show({
//               complete: function() {
//                 var visibleIndex = getVisibleIndex();
//                 if (visibleIndex == 0) {
//                   $('#prev').hide();
//                 }
//                 var maxIndex = fieldCount - 1
//                 if (visibleIndex < maxIndex) {
//                   $('#next').show();
//                   $('#new_account input[type=submit]').hide();
//                 }
//               }
//             });          
//           }
//         });

//       }
//     );  
//   }
// });
