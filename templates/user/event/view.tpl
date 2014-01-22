{* purpose of this template: events view view in user area *}
{include file='user/header.tpl'}
<div class="weekly-event weekly-view">
    {gt text='Event list' assign='templateTitle'}
    {pagesetvar name='title' value=$templateTitle}
    <h2>{$templateTitle}</h2>

    <p class="z-informationmsg">the name of the event</p>

    {if $canBeCreated}
        {checkpermissionblock component='Weekly:Event:' instance='::' level='ACCESS_EDIT'}
            {gt text='Create event' assign='createTitle'}
            <a href="{modurl modname='Weekly' type='user' func='edit' ot='event'}" title="{$createTitle}" class="z-icon-es-add">{$createTitle}</a>
        {/checkpermissionblock}
    {/if}
    {assign var='own' value=0}
    {if isset($showOwnEntries) && $showOwnEntries eq 1}
        {assign var='own' value=1}
    {/if}
    {assign var='all' value=0}
    {if isset($showAllEntries) && $showAllEntries eq 1}
        {gt text='Back to paginated view' assign='linkTitle'}
        <a href="{modurl modname='Weekly' type='user' func='view' ot='event'}" title="{$linkTitle}" class="z-icon-es-view">
            {$linkTitle}
        </a>
        {assign var='all' value=1}
    {else}
        {gt text='Show all entries' assign='linkTitle'}
        <a href="{modurl modname='Weekly' type='user' func='view' ot='event' all=1}" title="{$linkTitle}" class="z-icon-es-view">{$linkTitle}</a>
    {/if}

    {include file='user/event/view_quickNav.tpl' all=$all own=$own workflowStateFilter=false sorting=false pageSizeSelector=false searchFilter=false activeFilter=false}{* see template file for available options *}

    <table class="z-datatable">
        <colgroup>
            <col id="cEventBegin" />
            <col id="cEventName" />
			<col id="cEventMessage" />
        </colgroup>
        <thead>
        <tr>
            <th id="hEventBegin" scope="col" class="z-left">
                {sortlink __linktext='Event begin' currentsort=$sort modname='Weekly' type='user' func='view' ot='event' sort='eventBegin' sortdir=$sdir all=$all own=$own kind=$kind location=$location leader=$leader organisator=$organisator workflowState=$workflowState eventDay=$eventDay searchterm=$searchterm pageSize=$pageSize active=$active}
            </th>
            <th id="hEventName" scope="col" class="z-left">
                {sortlink __linktext='Event name' currentsort=$sort modname='Weekly' type='user' func='view' ot='event' sort='eventName' sortdir=$sdir all=$all own=$own kind=$kind location=$location leader=$leader organisator=$organisator workflowState=$workflowState eventDay=$eventDay searchterm=$searchterm pageSize=$pageSize active=$active}
            </th>

            <th id="hEventMessage" scope="col" class="z-left">
                {sortlink __linktext='Event message' currentsort=$sort modname='Weekly' type='user' func='view' ot='event' sort='eventMessage' sortdir=$sdir all=$all own=$own kind=$kind location=$location leader=$leader organisator=$organisator workflowState=$workflowState eventDay=$eventDay searchterm=$searchterm pageSize=$pageSize active=$active}
            </th>

        </tr>
        </thead>
        <tbody>
    
    {foreach item='event' from=$items}
        <tr class="{cycle values='z-odd, z-even'}">
            <td headers="hEventBegin" class="z-left">
                <span class="z-normal">{$event.eventBegin|dateformat:'%A'}</span></br>
				<span class="z-bold">{$event.eventBegin|dateformat:'%H:%M'} {gt text='time'}</span></br>
				<span class="z-sub">{$event.eventDuration} {gt text='minutes'}</span>
            </td>
            <td headers="hEventName" class="z-left">
				{if $modvars.Weekly.showKind || $modvars.Weekly.showLocation}
					<span class="z-sub">
					{if $modvars.Weekly.showKind}
						{if isset($event.Kind) && $event.Kind ne null && $modvars.Weekly.showKind}
							<a href="{modurl modname='Weekly' type='user' func='display' ot='kind' id=$event.Kind.id}">{strip}
							  {$event.Kind->getTitleFromDisplayPattern()|default:""}
							{/strip}</a>
							<script type="text/javascript">
							/* <![CDATA[ */
								document.observe('dom:loaded', function() {
									weeklyInitInlineWindow($('kindItem{{$event.id}}_rel_{{$event.Kind.id}}Display'), '{{$event.Kind->getTitleFromDisplayPattern()|replace:"'":""}}');
								});
							/* ]]> */
							</script>
						{else}
							{gt text='Not set.'}
						{/if}
						{if $modvars.Weekly.showLocation}
							,
						{/if}
					{/if}
					{if $modvars.Weekly.showLocation}
						{if isset($event.Location) && $event.Location ne null}
							<a href="{modurl modname='Weekly' type='user' func='display' ot='location' id=$event.Location.id}">{strip}
							  {$event.Location->getTitleFromDisplayPattern()|default:""}
							{/strip}</a>
							<script type="text/javascript">
							/* <![CDATA[ */
								document.observe('dom:loaded', function() {
									weeklyInitInlineWindow($('locationItem{{$event.id}}_rel_{{$event.Location.id}}Display'), '{{$event.Location->getTitleFromDisplayPattern()|replace:"'":""}}');
								});
							/* ]]> */
							</script>
						{else}
							{gt text='Not set.'}
						{/if}
					{/if}
					</span></br>
				{/if}	
					
				<a class="z-bold" href="{modurl modname='Weekly' type='user' func='display' ot='event' id=$event.id}" title="{gt text='View detail page'}">{$event.eventName}</a></br>
				
				{if $modvars.Weekly.showLeader}
					<span class="z-sub">
					{if isset($event.Leader) && $event.Leader ne null}
						<a href="{modurl modname='Weekly' type='user' func='display' ot='leader' id=$event.Leader.id}">{strip}
						  {$event.Leader->getTitleFromDisplayPattern()|default:""}
						{/strip}</a>
						<script type="text/javascript">
						/* <![CDATA[ */
							document.observe('dom:loaded', function() {
								weeklyInitInlineWindow($('leaderItem{{$event.id}}_rel_{{$event.Leader.id}}Display'), '{{$event.Leader->getTitleFromDisplayPattern()|replace:"'":""}}');
							});
						/* ]]> */
						</script>
					{else}
						{gt text='Not set.'}
					{/if}
					</span>
				{/if}
				
            </td>
            <td headers="hEventMessage" class="z-left z-middle">
                {if ($event.eventMessage)}
				<span class="z-warningmsg">{$event.eventMessage}</span>
				{/if}
            </td>

        </tr>
    {foreachelse}
        <tr class="z-datatableempty">
          <td class="z-left" colspan="15">
        {gt text='No events found.'}
          </td>
        </tr>
    {/foreach}
    
        </tbody>
    </table>
    
    {if !isset($showAllEntries) || $showAllEntries ne 1}
        {pager rowcount=$pager.numitems limit=$pager.itemsperpage display='page' modname='Weekly' type='user' func='view' ot='event'}
    {/if}

    
    {notifydisplayhooks eventname='weekly.ui_hooks.events.display_view' urlobject=$currentUrlObject assign='hooks'}
    {foreach key='providerArea' item='hook' from=$hooks}
        {$hook}
    {/foreach}
</div>
{include file='user/footer.tpl'}
