{* Purpose of this template: Display locations within an external context *}
<dl>
    {foreach item='location' from=$items}
        <dt>{$location->getTitleFromDisplayPattern()}</dt>
        {if $location.locationText}
            <dd>{$location.locationText|truncate:200:"..."}</dd>
        {/if}
        <dd><a href="{modurl modname='Weekly' type='user' func='display' ot=$objectType id=$location.id}">{gt text='Read more'}</a>
        </dd>
    {foreachelse}
        <dt>{gt text='No entries found.'}</dt>
    {/foreach}
</dl>
