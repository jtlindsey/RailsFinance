// $(function() {
//   //TODO Move the following two buttons into the HTML ERB template directly inside div.actions
//   $('#new_account').append('<input type="button" value="Previous" id="prev" />')
//   $('#new_account').append('<input type="button" value="Next" id="next" />')
//   // notice, clicking new account doesn't show this new function, it's not loaded until the page is refressed
  
//   $('#new_account input[type=submit]').hide()
//   if (($('#new_account').size() > 0)) {
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
//         // + 1 for designer indexing 
//         $('.field:nth-of-type(' + (visibleIndex + 1) + ')').hide({
//           complete: function() {
//             var fieldCount = $('.field').size(); 
//             // + 1 for designer indexing and + 1 for the next element

//             //test $('#new_account input[type=status]'))
//             // (($('#new_account').size() > 0))    
//             if($('#new_account').is(':last4')) {
//               alert('im here')
//               // $('.field:nth-of-type(' + (visibleIndex + 3) + ')').show();
//             }
//             //end test

//             $('.field:nth-of-type(' + (visibleIndex + 1 + 1) + ')').show(); //removed for test         
//             if (visibleIndex == $('.field').size() - 2) {
//               $('#next').hide();
//               $('#new_account input[type=submit]').show();
//             }
//           }
//         });
//       }
//     );


// //adding functionality to prev button
//     // $('#prev').click(function() { 
//     //   // alert('im here')
//     //     var visibleIndex = getVisibleIndex();
//     //     // + 1 for designer indexing 
//     //     $('.field:nth-of-type(' + (visibleIndex + 1) + ')').hide({
//     //       complete: function() {
//     //         var fieldCount = $('.field').size(); 
//     //         // + 1 for designer indexing and + 1 for the next element
//     //         $('.field:nth-of-type(' + (visibleIndex) + ')').show();          
//     //         if (visibleIndex == $('.field').size() - 2) {
//     //           $('#next').hide();
//     //           $('#new_account input[type=submit]').show();
//     //         }
//     //       }
//     //     });
//     //   }
//     // );

//   }
// });
