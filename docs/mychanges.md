# My changes from the original generated files by webgen

## user/event/edit.tpl and admin/event/edit.tpl
add following in the beginning:
````
{pageaddvar name='javascript' value='jquery'}
{include file='include_eventbegin.tpl'}
````

hide ``eventbegin`` by using ``z-hide``

encapsulate the different fields by using modvars:
````
		{if $modvars.Weekly.allowDeactivating}
		...
		{/if}
````
use the following variables:
* showManager
* showComanager
* showKind
* showLocation
* showParticipants
* allowDeactivating

## day calculation

create a file named **include_eventbegin.tpl** with the following content:
````
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
````

## user/event/view_quicknav.tpl

make the access level ACCESS_READ

reduce the selection to 
* eventName
* eventBegin

## Weekly\lib\Weekly\Entity\Repository\Event.php

``protected $defaultSortingField = 'eventBegin';`` <-change

## view.tpl
extend the include:
````
{include file='user/event/view_quickNav.tpl' all=$all own=$own workflowStateFilter=false sorting=false pageSizeSelector=false searchFilter=false activeFilter=false}
 ````
 
reduce the table to 
 * EventBegin
 * EventName
 * EventMessage
 
formatting of date: 
 
 ````
<span class="z-normal">{$event.eventBegin|dateformat:'%A'}</span></br>
<span class="z-bold">{$event.eventBegin|dateformat:'%H:%M'} {gt text='time'}</span></br>
<span class="z-sub">{$event.eventDuration} {gt text='minutes'}</span>
````
				
sorting the table for nicer view. Use z-sub, z-normal and z-bold in span for nicer look

