{* purpose of this template: events view filter form in user area *}
{checkpermissionblock component='Weekly:Event:' instance='::' level='ACCESS_READ'}
{assign var='objectType' value='event'}
<form action="{$modvars.ZConfig.entrypoint|default:'index.php'}" method="get" id="weeklyEventQuickNavForm" class="weekly-quicknav">
    <fieldset>
        <h3>{gt text='Quick navigation'}</h3>
        <input type="hidden" name="module" value="{modgetinfo modname='Weekly' info='url'}" />
        <input type="hidden" name="type" value="user" />
        <input type="hidden" name="func" value="view" />
        <input type="hidden" name="ot" value="event" />
        <input type="hidden" name="all" value="{$all|default:0}" />
        <input type="hidden" name="own" value="{$own|default:0}" />
        {gt text='All' assign='lblDefault'}
        {if !isset($kindFilter) || $kindFilter eq true}
                <label for="kind">{gt text='Kind'}</label>
                {modapifunc modname='Weekly' type='selection' func='getEntities' ot='kind' useJoins=false assign='listEntries'}
                <select id="kind" name="kind">
                    <option value="">{$lblDefault}</option>
                {foreach item='option' from=$listEntries}
                    {assign var='entryId' value=$option.id}
                    <option value="{$entryId}"{if $entryId eq $kind} selected="selected"{/if}>{$option->getTitleFromDisplayPattern()}</option>
                {/foreach}
                </select>
        {/if}
        {if !isset($locationFilter) || $locationFilter eq true}
                <label for="location">{gt text='Locations'}</label>
                {modapifunc modname='Weekly' type='selection' func='getEntities' ot='location' useJoins=false assign='listEntries'}
                <select id="location" name="location">
                    <option value="">{$lblDefault}</option>
                {foreach item='option' from=$listEntries}
                    {assign var='entryId' value=$option.id}
                    <option value="{$entryId}"{if $entryId eq $location} selected="selected"{/if}>{$option->getTitleFromDisplayPattern()}</option>
                {/foreach}
                </select>
        {/if}
        {if !isset($leaderFilter) || $leaderFilter eq true}
                <label for="leader">{gt text='Leaders'}</label>
                {modapifunc modname='Weekly' type='selection' func='getEntities' ot='leader' useJoins=false assign='listEntries'}
                <select id="leader" name="leader">
                    <option value="">{$lblDefault}</option>
                {foreach item='option' from=$listEntries}
                    {assign var='entryId' value=$option.id}
                    <option value="{$entryId}"{if $entryId eq $leader} selected="selected"{/if}>{$option->getTitleFromDisplayPattern()}</option>
                {/foreach}
                </select>
        {/if}
        {if !isset($organisatorFilter) || $organisatorFilter eq true}
                <label for="organisator">{gt text='Organisators'}</label>
                {modapifunc modname='Weekly' type='selection' func='getEntities' ot='organisator' useJoins=false assign='listEntries'}
                <select id="organisator" name="organisator">
                    <option value="">{$lblDefault}</option>
                {foreach item='option' from=$listEntries}
                    {assign var='entryId' value=$option.id}
                    <option value="{$entryId}"{if $entryId eq $organisator} selected="selected"{/if}>{$option->getTitleFromDisplayPattern()}</option>
                {/foreach}
                </select>
        {/if}
        {if !isset($workflowStateFilter) || $workflowStateFilter eq true}
                <label for="workflowState">{gt text='Workflow state'}</label>
                <select id="workflowState" name="workflowState">
                    <option value="">{$lblDefault}</option>
                {foreach item='option' from=$workflowStateItems}
                <option value="{$option.value}"{if $option.title ne ''} title="{$option.title|safetext}"{/if}{if $option.value eq $workflowState} selected="selected"{/if}>{$option.text|safetext}</option>
                {/foreach}
                </select>
        {/if}
        {if !isset($eventDayFilter) || $eventDayFilter eq true}
                <label for="eventDay">{gt text='Event day'}</label>
                <select id="eventDay" name="eventDay">
                    <option value="">{$lblDefault}</option>
                {foreach item='option' from=$eventDayItems}
                <option value="{$option.value}"{if $option.title ne ''} title="{$option.title|safetext}"{/if}{if $option.value eq $eventDay} selected="selected"{/if}>{$option.text|safetext}</option>
                {/foreach}
                </select>
        {/if}

        {if !isset($searchFilter) || $searchFilter eq true}
                <label for="searchTerm">{gt text='Search'}</label>
                <input type="text" id="searchTerm" name="searchterm" value="{$searchterm}" />
        {/if}

        {if !isset($sorting) || $sorting eq true}
                <label for="sortBy">{gt text='Sort by'}</label>
                &nbsp;
                <select id="sortBy" name="sort">
                    <!-- <option value="id"{if $sort eq 'id'} selected="selected"{/if}>{gt text='Id'}</option>
                    <option value="workflowState"{if $sort eq 'workflowState'} selected="selected"{/if}>{gt text='Workflow state'}</option> -->
                    <option value="eventBegin"{if $sort eq 'eventBegin'} selected="selected"{/if}>{gt text='Event begin'}</option>
                    <option value="eventName"{if $sort eq 'eventName'} selected="selected"{/if}>{gt text='Event name'}</option>
                    <!-- <option value="eventDay"{if $sort eq 'eventDay'} selected="selected"{/if}>{gt text='Event day'}</option>
                    <option value="eventBeginText"{if $sort eq 'eventBeginText'} selected="selected"{/if}>{gt text='Event begin text'}</option>
                    <option value="eventDuration"{if $sort eq 'eventDuration'} selected="selected"{/if}>{gt text='Event duration'}</option>
                    <option value="eventMessage"{if $sort eq 'eventMessage'} selected="selected"{/if}>{gt text='Event message'}</option>
                    <option value="eventText"{if $sort eq 'eventText'} selected="selected"{/if}>{gt text='Event text'}</option>
                    <option value="maxParticipants"{if $sort eq 'maxParticipants'} selected="selected"{/if}>{gt text='Max participants'}</option>
                    <option value="currentParticipants"{if $sort eq 'currentParticipants'} selected="selected"{/if}>{gt text='Current participants'}</option>
                    <option value="active"{if $sort eq 'active'} selected="selected"{/if}>{gt text='Active'}</option>
                    <option value="createdDate"{if $sort eq 'createdDate'} selected="selected"{/if}>{gt text='Creation date'}</option>
                    <option value="createdUserId"{if $sort eq 'createdUserId'} selected="selected"{/if}>{gt text='Creator'}</option>
                    <option value="updatedDate"{if $sort eq 'updatedDate'} selected="selected"{/if}>{gt text='Update date'}</option> -->
                </select>
                <select id="sortDir" name="sortdir">
                    <option value="asc"{if $sdir eq 'asc'} selected="selected"{/if}>{gt text='ascending'}</option>
                    <option value="desc"{if $sdir eq 'desc'} selected="selected"{/if}>{gt text='descending'}</option>
                </select>
        {else}
            <input type="hidden" name="sort" value="{$sort}" />
            <input type="hidden" name="sdir" value="{if $sdir eq 'desc'}asc{else}desc{/if}" />
        {/if}
        {if !isset($pageSizeSelector) || $pageSizeSelector eq true}
                <label for="num">{gt text='Page size'}</label>
                <select id="num" name="num">
                    <option value="5"{if $pageSize eq 5} selected="selected"{/if}>5</option>
                    <option value="10"{if $pageSize eq 10} selected="selected"{/if}>10</option>
                    <option value="15"{if $pageSize eq 15} selected="selected"{/if}>15</option>
                    <option value="20"{if $pageSize eq 20} selected="selected"{/if}>20</option>
                    <option value="30"{if $pageSize eq 30} selected="selected"{/if}>30</option>
                    <option value="50"{if $pageSize eq 50} selected="selected"{/if}>50</option>
                    <option value="100"{if $pageSize eq 100} selected="selected"{/if}>100</option>
                </select>
        {/if}
<!--         {if !isset($activeFilter) || $activeFilter eq true}
                <label for="active">{gt text='Active'}</label>
                <select id="active" name="active">
                    <option value="">{$lblDefault}</option>
                {foreach item='option' from=$activeItems}
                    <option value="{$option.value}"{if $option.value eq $active} selected="selected"{/if}>{$option.text|safetext}</option>
                {/foreach}
                </select>
        {/if} -->
        <input type="submit" name="updateview" id="quicknavSubmit" value="{gt text='OK'}" />
    </fieldset>
</form>

<script type="text/javascript">
/* <![CDATA[ */
    document.observe('dom:loaded', function() {
        weeklyInitQuickNavigation('event', 'user');
        {{if isset($searchFilter) && $searchFilter eq false}}
            {{* we can hide the submit button if we have no quick search field *}}
            $('quicknavSubmit').addClassName('z-hide');
        {{/if}}
    });
/* ]]> */
</script>
{/checkpermissionblock}
