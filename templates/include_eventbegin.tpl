<script type="text/javascript">
/* <![CDATA[ */

function onDateTimeChange( event ) {
	var selectedDay = jQuery('#eventDay').val();
	var day = selectedDay.substr(0,10);
	var selectedTime = jQuery('#eventBeginText').val();
	var dayTimeResult = day + ' ' + selectedTime;
	console.log('var day: ', day);
	jQuery('#eventBegin').val( dayTimeResult);
	console.log( 'eventBegin.value: ',$(eventBegin).value );  
};

jQuery(document).ready(function() {
	console.log( 'ready!' );
	jQuery('#eventDay').change(onDateTimeChange);
	jQuery('#eventBeginText').change(onDateTimeChange);
});

/* ]]> */
</script>