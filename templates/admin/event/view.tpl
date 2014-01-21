{* purpose of this template: events view view in admin area *}
{include file='admin/header.tpl'}
<div class="weekly-event weekly-view">
    {gt text='Event list' assign='templateTitle'}
    {pagesetvar name='title' value=$templateTitle}
    <div class="z-admin-content-pagetitle">
        {icon type='view' size='small' alt=$templateTitle}
        <h3>{$templateTitle}</h3>
    </div>

    <p class="z-informationmsg">the name of the event</p>

    {if $canBeCreated}
        {checkpermissionblock component='Weekly:Event:' instance='::' level='ACCESS_EDIT'}
            {gt text='Create event' assign='createTitle'}
            <a href="{modurl modname='Weekly' type='admin' func='edit' ot='event'}" title="{$createTitle}" class="z-icon-es-add">{$createTitle}</a>
        {/checkpermissionblock}
    {/if}
    {assign var='own' value=0}
    {if isset($showOwnEntries) && $showOwnEntries eq 1}
        {assign var='own' value=1}
    {/if}
    {assign var='all' value=0}
    {if isset($showAllEntries) && $showAllEntries eq 1}
        {gt text='Back to paginated view' assign='linkTitle'}
        <a href="{modurl modname='Weekly' type='admin' func='view' ot='event'}" title="{$linkTitle}" class="z-icon-es-view">
            {$linkTitle}
        </a>
        {assign var='all' value=1}
    {else}
        {gt text='Show all entries' assign='linkTitle'}
        <a href="{modurl modname='Weekly' type='admin' func='view' ot='event' all=1}" title="{$linkTitle}" class="z-icon-es-view">{$linkTitle}</a>
    {/if}

    {include file='admin/event/view_quickNav.tpl' all=$all own=$own workflowStateFilter=false}{* see template file for available options *}

    <form action="{modurl modname='Weekly' type='admin' func='handleSelectedEntries'}" method="post" id="eventsViewForm" class="z-form">
        <div>
            <input type="hidden" name="csrftoken" value="{insert name='csrftoken'}" />
            <input type="hidden" name="ot" value="event" />
            <table class="z-datatable">
                <colgroup>
                    <col id="cSelect" />
                    <col id="cEventBegin" />
                    <col id="cEventName" />
                    <col id="cEventDay" />
                    <col id="cEventBeginText" />
                    <col id="cEventDuration" />
                    <col id="cEventMessage" />
                    <col id="cEventText" />
                    <col id="cMaxParticipants" />
                    <col id="cCurrentParticipants" />
                    <col id="cActive" />
                    <col id="cKind" />
                    <col id="cLocation" />
                    <col id="cLeader" />
                    <col id="cOrganisator" />
                    <col id="cItemActions" />
                </colgroup>
                <thead>
                <tr>
                    <th id="hSelect" scope="col" align="center" valign="middle">
                        <input type="checkbox" id="toggleEvents" />
                    </th>
                    <th id="hEventBegin" scope="col" class="z-left">
                        {sortlink __linktext='Event begin' currentsort=$sort modname='Weekly' type='admin' func='view' ot='event' sort='eventBegin' sortdir=$sdir all=$all own=$own kind=$kind location=$location leader=$leader organisator=$organisator workflowState=$workflowState eventDay=$eventDay searchterm=$searchterm pageSize=$pageSize active=$active}
                    </th>
                    <th id="hEventName" scope="col" class="z-left">
                        {sortlink __linktext='Event name' currentsort=$sort modname='Weekly' type='admin' func='view' ot='event' sort='eventName' sortdir=$sdir all=$all own=$own kind=$kind location=$location leader=$leader organisator=$organisator workflowState=$workflowState eventDay=$eventDay searchterm=$searchterm pageSize=$pageSize active=$active}
                    </th>
                    <th id="hEventDay" scope="col" class="z-left">
                        {sortlink __linktext='Event day' currentsort=$sort modname='Weekly' type='admin' func='view' ot='event' sort='eventDay' sortdir=$sdir all=$all own=$own kind=$kind location=$location leader=$leader organisator=$organisator workflowState=$workflowState eventDay=$eventDay searchterm=$searchterm pageSize=$pageSize active=$active}
                    </th>
                    <th id="hEventBeginText" scope="col" class="z-left">
                        {sortlink __linktext='Event begin text' currentsort=$sort modname='Weekly' type='admin' func='view' ot='event' sort='eventBeginText' sortdir=$sdir all=$all own=$own kind=$kind location=$location leader=$leader organisator=$organisator workflowState=$workflowState eventDay=$eventDay searchterm=$searchterm pageSize=$pageSize active=$active}
                    </th>
                    <th id="hEventDuration" scope="col" class="z-right">
                        {sortlink __linktext='Event duration' currentsort=$sort modname='Weekly' type='admin' func='view' ot='event' sort='eventDuration' sortdir=$sdir all=$all own=$own kind=$kind location=$location leader=$leader organisator=$organisator workflowState=$workflowState eventDay=$eventDay searchterm=$searchterm pageSize=$pageSize active=$active}
                    </th>
                    <th id="hEventMessage" scope="col" class="z-left">
                        {sortlink __linktext='Event message' currentsort=$sort modname='Weekly' type='admin' func='view' ot='event' sort='eventMessage' sortdir=$sdir all=$all own=$own kind=$kind location=$location leader=$leader organisator=$organisator workflowState=$workflowState eventDay=$eventDay searchterm=$searchterm pageSize=$pageSize active=$active}
                    </th>
                    <th id="hEventText" scope="col" class="z-left">
                        {sortlink __linktext='Event text' currentsort=$sort modname='Weekly' type='admin' func='view' ot='event' sort='eventText' sortdir=$sdir all=$all own=$own kind=$kind location=$location leader=$leader organisator=$organisator workflowState=$workflowState eventDay=$eventDay searchterm=$searchterm pageSize=$pageSize active=$active}
                    </th>
                    <th id="hMaxParticipants" scope="col" class="z-right">
                        {sortlink __linktext='Max participants' currentsort=$sort modname='Weekly' type='admin' func='view' ot='event' sort='maxParticipants' sortdir=$sdir all=$all own=$own kind=$kind location=$location leader=$leader organisator=$organisator workflowState=$workflowState eventDay=$eventDay searchterm=$searchterm pageSize=$pageSize active=$active}
                    </th>
                    <th id="hCurrentParticipants" scope="col" class="z-right">
                        {sortlink __linktext='Current participants' currentsort=$sort modname='Weekly' type='admin' func='view' ot='event' sort='currentParticipants' sortdir=$sdir all=$all own=$own kind=$kind location=$location leader=$leader organisator=$organisator workflowState=$workflowState eventDay=$eventDay searchterm=$searchterm pageSize=$pageSize active=$active}
                    </th>
                    <th id="hActive" scope="col" class="z-center">
                        {sortlink __linktext='Active' currentsort=$sort modname='Weekly' type='admin' func='view' ot='event' sort='active' sortdir=$sdir all=$all own=$own kind=$kind location=$location leader=$leader organisator=$organisator workflowState=$workflowState eventDay=$eventDay searchterm=$searchterm pageSize=$pageSize active=$active}
                    </th>
                    <th id="hKind" scope="col" class="z-left">
                        {sortlink __linktext='Kind' currentsort=$sort modname='Weekly' type='admin' func='view' ot='event' sort='kind' sortdir=$sdir all=$all own=$own kind=$kind location=$location leader=$leader organisator=$organisator workflowState=$workflowState eventDay=$eventDay searchterm=$searchterm pageSize=$pageSize active=$active}
                    </th>
                    <th id="hLocation" scope="col" class="z-left">
                        {sortlink __linktext='Location' currentsort=$sort modname='Weekly' type='admin' func='view' ot='event' sort='location' sortdir=$sdir all=$all own=$own kind=$kind location=$location leader=$leader organisator=$organisator workflowState=$workflowState eventDay=$eventDay searchterm=$searchterm pageSize=$pageSize active=$active}
                    </th>
                    <th id="hLeader" scope="col" class="z-left">
                        {sortlink __linktext='Leader' currentsort=$sort modname='Weekly' type='admin' func='view' ot='event' sort='leader' sortdir=$sdir all=$all own=$own kind=$kind location=$location leader=$leader organisator=$organisator workflowState=$workflowState eventDay=$eventDay searchterm=$searchterm pageSize=$pageSize active=$active}
                    </th>
                    <th id="hOrganisator" scope="col" class="z-left">
                        {sortlink __linktext='Organisator' currentsort=$sort modname='Weekly' type='admin' func='view' ot='event' sort='organisator' sortdir=$sdir all=$all own=$own kind=$kind location=$location leader=$leader organisator=$organisator workflowState=$workflowState eventDay=$eventDay searchterm=$searchterm pageSize=$pageSize active=$active}
                    </th>
                    <th id="hItemActions" scope="col" class="z-right z-order-unsorted">{gt text='Actions'}</th>
                </tr>
                </thead>
                <tbody>
            
            {foreach item='event' from=$items}
                <tr class="{cycle values='z-odd, z-even'}">
                    <td headers="hselect" align="center" valign="top">
                        <input type="checkbox" name="items[]" value="{$event.id}" class="events-checkbox" />
                    </td>
                    <td headers="hEventBegin" class="z-left">
                        {$event.eventBegin|dateformat:'datetimebrief'}
                    </td>
                    <td headers="hEventName" class="z-left">
                        {$event.eventName}
                    </td>
                    <td headers="hEventDay" class="z-left">
                        {$event.eventDay|weeklyGetListEntry:'event':'eventDay'|safetext}
                    </td>
                    <td headers="hEventBeginText" class="z-left">
                        {$event.eventBeginText}
                    </td>
                    <td headers="hEventDuration" class="z-right">
                        {$event.eventDuration}
                    </td>
                    <td headers="hEventMessage" class="z-left">
                        {$event.eventMessage}
                    </td>
                    <td headers="hEventText" class="z-left">
                        {$event.eventText}
                    </td>
                    <td headers="hMaxParticipants" class="z-right">
                        {$event.maxParticipants}
                    </td>
                    <td headers="hCurrentParticipants" class="z-right">
                        {$event.currentParticipants}
                    </td>
                    <td headers="hActive" class="z-center">
                        {$event.active|yesno:true}
                    </td>
                    <td headers="hKind" class="z-left">
                        {if isset($event.Kind) && $event.Kind ne null}
                            <a href="{modurl modname='Weekly' type='admin' func='display' ot='kind' id=$event.Kind.id}">{strip}
                              {$event.Kind->getTitleFromDisplayPattern()|default:""}
                            {/strip}</a>
                            <a id="kindItem{$event.id}_rel_{$event.Kind.id}Display" href="{modurl modname='Weekly' type='admin' func='display' ot='kind' id=$event.Kind.id theme='Printer'}" title="{gt text='Open quick view window'}" class="z-hide">{icon type='view' size='extrasmall' __alt='Quick view'}</a>
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
                    </td>
                    <td headers="hLocation" class="z-left">
                        {if isset($event.Location) && $event.Location ne null}
                            <a href="{modurl modname='Weekly' type='admin' func='display' ot='location' id=$event.Location.id}">{strip}
                              {$event.Location->getTitleFromDisplayPattern()|default:""}
                            {/strip}</a>
                            <a id="locationItem{$event.id}_rel_{$event.Location.id}Display" href="{modurl modname='Weekly' type='admin' func='display' ot='location' id=$event.Location.id theme='Printer'}" title="{gt text='Open quick view window'}" class="z-hide">{icon type='view' size='extrasmall' __alt='Quick view'}</a>
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
                    </td>
                    <td headers="hLeader" class="z-left">
                        {if isset($event.Leader) && $event.Leader ne null}
                            <a href="{modurl modname='Weekly' type='admin' func='display' ot='leader' id=$event.Leader.id}">{strip}
                              {$event.Leader->getTitleFromDisplayPattern()|default:""}
                            {/strip}</a>
                            <a id="leaderItem{$event.id}_rel_{$event.Leader.id}Display" href="{modurl modname='Weekly' type='admin' func='display' ot='leader' id=$event.Leader.id theme='Printer'}" title="{gt text='Open quick view window'}" class="z-hide">{icon type='view' size='extrasmall' __alt='Quick view'}</a>
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
                    </td>
                    <td headers="hOrganisator" class="z-left">
                        {if isset($event.Organisator) && $event.Organisator ne null}
                            <a href="{modurl modname='Weekly' type='admin' func='display' ot='organisator' id=$event.Organisator.id}">{strip}
                              {$event.Organisator->getTitleFromDisplayPattern()|default:""}
                            {/strip}</a>
                            <a id="organisatorItem{$event.id}_rel_{$event.Organisator.id}Display" href="{modurl modname='Weekly' type='admin' func='display' ot='organisator' id=$event.Organisator.id theme='Printer'}" title="{gt text='Open quick view window'}" class="z-hide">{icon type='view' size='extrasmall' __alt='Quick view'}</a>
                            <script type="text/javascript">
                            /* <![CDATA[ */
                                document.observe('dom:loaded', function() {
                                    weeklyInitInlineWindow($('organisatorItem{{$event.id}}_rel_{{$event.Organisator.id}}Display'), '{{$event.Organisator->getTitleFromDisplayPattern()|replace:"'":""}}');
                                });
                            /* ]]> */
                            </script>
                        {else}
                            {gt text='Not set.'}
                        {/if}
                    </td>
                    <td id="itemActions{$event.id}" headers="hItemActions" class="z-right z-nowrap z-w02">
                        {if count($event._actions) gt 0}
                            {foreach item='option' from=$event._actions}
                                <a href="{$option.url.type|weeklyActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}"{if $option.icon eq 'preview'} target="_blank"{/if}>{icon type=$option.icon size='extrasmall' alt=$option.linkText|safetext}</a>
                            {/foreach}
                            {icon id="itemActions`$event.id`Trigger" type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}
                            <script type="text/javascript">
                            /* <![CDATA[ */
                                document.observe('dom:loaded', function() {
                                    weeklyInitItemActions('event', 'view', 'itemActions{{$event.id}}');
                                });
                            /* ]]> */
                            </script>
                        {/if}
                    </td>
                </tr>
            {foreachelse}
                <tr class="z-admintableempty">
                  <td class="z-left" colspan="16">
                {gt text='No events found.'}
                  </td>
                </tr>
            {/foreach}
            
                </tbody>
            </table>
            
            {if !isset($showAllEntries) || $showAllEntries ne 1}
                {pager rowcount=$pager.numitems limit=$pager.itemsperpage display='page' modname='Weekly' type='admin' func='view' ot='event'}
            {/if}
            <fieldset>
                <label for="weeklyAction">{gt text='With selected events'}</label>
                <select id="weeklyAction" name="action">
                    <option value="">{gt text='Choose action'}</option>
                    <option value="delete" title="{gt text='Delete content permanently.'}">{gt text='Delete'}</option>
                </select>
                <input type="submit" value="{gt text='Submit'}" />
            </fieldset>
        </div>
    </form>

</div>
{include file='admin/footer.tpl'}

<script type="text/javascript">
/* <![CDATA[ */
    document.observe('dom:loaded', function() {
    {{* init the "toggle all" functionality *}}
    if ($('toggleEvents') != undefined) {
        $('toggleEvents').observe('click', function (e) {
            Zikula.toggleInput('eventsViewForm');
            e.stop()
        });
    }
    });
/* ]]> */
</script>
