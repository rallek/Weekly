<script type="text/javascript">
/* <![CDATA[ */

function onDateTimeChange( event ) {
	var selectedDay = jQuery('#eventDay').val();
	var day = selectedDay.substr(0,10);
	var selectedTime = jQuery('#eventBeginText').val();
	var dayTimeResult = day + ' ' + selectedTime;
	jQuery('#eventBegin').val( dayTimeResult);
};

jQuery(document).ready(function() {
	jQuery('#eventDay').change(onDateTimeChange);
	jQuery('#eventBeginText').change(onDateTimeChange);
});

/* ]]> */
</script>