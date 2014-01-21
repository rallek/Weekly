{* Purpose of this template: Display events within an external context *}
<dl>
    {foreach item='event' from=$items}
        <dt>{$event->getTitleFromDisplayPattern()}</dt>
        {if $event.eventText}
            <dd>{$event.eventText|truncate:200:"..."}</dd>
        {/if}
        <dd><a href="{modurl modname='Weekly' type='user' func='display' ot=$objectType id=$event.id}">{gt text='Read more'}</a>
        </dd>
    {foreachelse}
        <dt>{gt text='No entries found.'}</dt>
    {/foreach}
</dl>
